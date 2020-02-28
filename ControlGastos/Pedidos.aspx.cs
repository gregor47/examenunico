using ExamenUnico.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExamenUnico
{
    public partial class Pedidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getpedido();
            llenarcampos();
            String username = "", perfil, nombre;
            try
            {
                username = Request.Cookies["Sesion"].Values.Get("UserName");
                perfil = Request.Cookies["Sesion"].Values.Get("perfil");
                nombre = Request.Cookies["Sesion"].Values.Get("nombre");
            }
            catch (Exception ex)
            {
                //si entra es porque no hay sesion activa
            }

            if (!String.IsNullOrEmpty(username))
            {
                
                refrescarTabla();
                if (!IsPostBack)
                {
                    string idped="";
                    try
                    {
                        idped = Request.Cookies["idPedido"].Value;
                    }
                    catch (Exception)
                    {
                    }
                    if(String.IsNullOrEmpty(idped))
                    {
                        HttpCookie cookie = new HttpCookie("idPedido");
                        cookie.Value = getpedido().ToString();
                        Response.Cookies.Add(cookie);
                    }
                    else
                    {
                        if (!idped.Equals(idpedidomostrar.Text))
                        {
                            HttpCookie cookie = new HttpCookie("idPedido");
                            cookie.Value = getpedido().ToString();
                            Response.Cookies.Add(cookie);
                        }
                    }
                    refrescarTabla();
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }
        protected void CerrarSesion(object sender, EventArgs e)
        {
            if (Request.Cookies["Sesion"] != null)
            {
                Response.Cookies["Sesion"].Expires = DateTime.Now.AddDays(-1);
            }
            Response.Redirect("Login.aspx");
        }

        public void refrescarTabla()
        {
            GridView1.DataBind();
            if (GridView1.Rows.Count != 0)
            {
                GridView1.UseAccessibleHeader = true;
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }
        public void llenarcampos()
        {
            string maxi = "20";
            num_producto.Attributes.Add("max", maxi);
            int buscar = getpedido();
            string sql = String.Format("select sum(cantidad) as cantidad from DetallePedido where id_pedido = '{0}' group by id_pedido",buscar);
            string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
            SqlConnection connection = new SqlConnection(ConnString);
            connection.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = sql;
            cmd.Connection = connection;
            SqlDataReader dataReader = cmd.ExecuteReader();
            DataRow row;
            if (dataReader.HasRows)
            {
                DataTable table = new DataTable();
                table.Load(dataReader);
                
                row = table.Rows[0];
                string max = (20 - Convert.ToInt32(row["cantidad"].ToString().Trim())).ToString();
                num_producto.Attributes.Add("max", max);
            }
            else
            {
                string max = "20";
                num_producto.Attributes.Add("max", max);
            }
            dataReader.Close();
            //num_producto.Attributes.Add("max", row["stock"].ToString().Trim());


            sql = String.Format("select stock from productos where id_producto = '{0}'", 1);
            
            cmd.CommandText = sql;
            SqlDataReader dataReader2 = cmd.ExecuteReader();
            DataTable table2 = new DataTable();
            table2.Load(dataReader2);
            dataReader2.Close();
            DataRow row2 = table2.Rows[0];
            stocktxt.Text = row2["stock"].ToString().Trim();
            connection.Close();

            //if (row2["cantidad"].ToString().Equals("20"))
            //{
            //    num_producto.Attributes.Add("min", "0");
            //}
        }

        protected void AgregarProductos(object sender, EventArgs e)
        {
            string id_usuario = Request.Cookies["Sesion"].Values.Get("UserName");
            string id_producto = DropDownList.SelectedValue;
            string nombre_producto = DropDownList.SelectedItem.Text;
            string cantidad = num_producto.Value;
            int id_pedido = getpedido();
            string sql = String.Format("insert into DetallePedido(id_producto,id_usuario,id_pedido,nombre_producto,cantidad) values('{0}','{1}','{2}','{3}','{4}')", id_producto, id_usuario, id_pedido, nombre_producto, cantidad);
            string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
            SqlConnection connection = new SqlConnection(ConnString);
            connection.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = sql;
            cmd.Connection = connection;
            cmd.ExecuteNonQuery();
            sql = String.Format("update productos set stock=stock-{0} where id_producto={1}",cantidad, id_producto);
            cmd.CommandText = sql;
            cmd.ExecuteNonQuery();
            refrescarTabla();
            llenarcampos();
        }

        private int getpedido()
        {
            int id_pedido = 0;
            try
            {
                string id_usuario;
                bool pedidoCerrado = verificarPedido();
                string sql = "";
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                SqlCommand cmd = new SqlCommand();
                connection.Open();
                cmd.Connection = connection;
                id_usuario = Request.Cookies["Sesion"].Values.Get("UserName");
                sql = String.Format("select max(id_pedido)'idmax' from pedidos where id_usuario = '{0}' and estado = 0", id_usuario);
                if (pedidoCerrado)
                {
                    sql = String.Format("insert into pedidos (id_usuario,estado) values({0},'0')", id_usuario);
                    cmd.CommandText = sql;
                    cmd.ExecuteNonQuery();
                    sql = "select max(id_pedido)'idmax' from pedidos";
                }
                cmd.CommandText = sql;
                SqlDataReader dataReader = cmd.ExecuteReader();
                DataTable table = new DataTable();
                table.Load(dataReader);
                connection.Close();
                DataRow row = table.Rows[0];
                id_pedido = int.Parse(row["idmax"].ToString().Trim());
            }
            catch (Exception ex)
            {
                throw;
            }

            idpedidomostrar.Text = id_pedido.ToString();
            return id_pedido;
        }
        public bool verificarPedido()
        {
            bool respuesta= true;
            try
            {
                string id_usuario = Request.Cookies["Sesion"].Values.Get("UserName");
                string buscar = DropDownList.SelectedValue;
                string sql = String.Format("select * from pedidos where id_usuario = '{0}' and estado = '0'",id_usuario);
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                SqlDataReader dataReader = cmd.ExecuteReader();
                if (dataReader.Read()) { respuesta = false; }
                connection.Close();
            }
            catch (Exception ex)
            {

                throw;
            }
            return respuesta;
        }
        protected void RealizarPedido(object sender, EventArgs e)
        {
            try
            {
                
                string buscar = getpedido().ToString();
                string sql = "update pedidos set estado = 1 where id_pedido = '" + buscar + "'";
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                cmd.ExecuteNonQuery();
                connection.Close();
            }
            catch (Exception)
            {

                throw;
            }
            Response.Redirect("Default.aspx");
        }
        protected void DropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string buscar = DropDownList.SelectedValue;
                string sql = "select stock from productos where id_producto = '" + buscar + "'";
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                SqlDataReader dataReader = cmd.ExecuteReader();
                DataTable table = new DataTable();
                table.Load(dataReader);
                connection.Close();
                DataRow row = table.Rows[0];
                stocktxt.Text = row["stock"].ToString().Trim();
                //num_producto.Attributes.Add("max", row["stock"].ToString().Trim());
            }
            catch (Exception ex)
            {

                throw;
            }
            
        }

        //public void RegistrarPedido(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string username = Request.Cookies["Sesion"].Values.Get("UserName");
        //        string sql = "select * from pedidos where id_usuario = '" + username + "' and estado = '0'";
        //        sql = "insert into pedidos(id_usuario,estado) values('"+username+"',0)";
        //        string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
        //        SqlConnection connection = new SqlConnection(ConnString);
        //        connection.Open();
        //        SqlCommand cmd = new SqlCommand();
        //        cmd.CommandText = sql;
        //        cmd.Connection = connection;
        //        SqlDataReader dataReader = cmd.ExecuteReader();
        //        DataTable table = new DataTable();
        //        table.Load(dataReader);
        //        connection.Close();
        //        DataRow row = table.Rows[0];
        //        Usuario user = new Usuario();
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine(ex.ToString());
        //    }

        //}
    }
}