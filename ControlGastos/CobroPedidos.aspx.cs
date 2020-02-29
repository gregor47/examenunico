using ExamenUnico.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExamenUnico
{
    public partial class CobroPedidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            refrescarTabla();
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

                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            try
            {
                string idgestion;
                int monto;
                List<CobroModel> cobro = new List<CobroModel>();
                CobroModel model;
                List<Cuentas> cuentas = new List<Cuentas>();
                Cuentas cuenta;
                string sql = "select a.id_pedido, sum(c.Precio*b.cantidad)as Total,id_gestion  from PedidosMaster a  ";
                sql += "inner join DetallePedido b on a.id_gestion = b.master ";
                sql += "inner join Productos c on b.id_producto = c.id_producto where a.estado = 1 and a.cobrado IS NULL ";
                sql += "group by a.id_pedido,id_gestion";
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        model = new CobroModel();
                        idgestion = reader.GetInt32(0).ToString();
                        monto = reader.GetInt32(1);
                        model.idGestion = idgestion;
                        model.disponible = monto;
                        model.idgestiontabla = reader.GetInt32(2).ToString();
                        cobro.Add(model);
                    }
                }
                reader.Close();
                sql = "select id_cuenta,disponible from cuentas";
                cmd.CommandText = sql;
                reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        cuenta = new Cuentas();
                        cuenta.idcuenta =reader.GetInt64(0);
                        cuenta.monto = reader.GetInt64(1);
                        cuentas.Add(cuenta);
                    }
                }
                reader.Close();


                foreach (CobroModel item in cobro)
                {
                    foreach (Cuentas cuent in cuentas)
                    {
                        if(item.idGestion == cuent.idcuenta.ToString())
                        {
                            if(cuent.monto-item.disponible >= 0)
                            {
                                try
                                {
                                    sql = String.Format("update cuentas set disponible = disponible - '{0}' where id_cuenta = '{1}' ", item.disponible, item.idGestion);
                                    cmd.CommandText = sql;
                                    cmd.Connection = connection;
                                    cmd.ExecuteNonQuery();
                                    sql = String.Format("update Pedidosmaster set cobrado_descriptcion = '{0}',cobrado=1 where id_gestion = '{1}'", "ACEPTADO", item.idgestiontabla);
                                    cmd.CommandText = sql;
                                    cmd.ExecuteNonQuery();
                                    refrescarTabla();
                                }
                                catch (Exception)
                                {

                                    throw;
                                }
                            }
                            else
                            {
                                try
                                {
                                    sql = String.Format("update Pedidosmaster set cobrado_descriptcion = '{0}',cobrado=0 where id_gestion = '{1}'","RECHAZADO POR FALTA DE RECURSOS",item.idgestiontabla );
                                    cmd.CommandText = sql;
                                    cmd.Connection = connection;
                                    cmd.ExecuteNonQuery();
                                    refrescarTabla();
                                }
                                catch (Exception)
                                {

                                    throw;
                                }
                            }
                        }
                        }
                    
                }
                
                refrescarTabla();
                connection.Close();
            }
            catch (Exception)
            {

                throw;
            }
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

        protected void CerrarSesion(object sender, EventArgs e)
        {
            if (Request.Cookies["Sesion"] != null)
            {
                Response.Cookies["Sesion"].Expires = DateTime.Now.AddDays(-1);
            }
            Response.Redirect("Login.aspx");
        }
    }
}