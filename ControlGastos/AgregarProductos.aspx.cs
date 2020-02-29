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
    public partial class AgregarProductos : System.Web.UI.Page
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
            string nombreprodc = nombProducto.Value;
            string cantidad = stock.Value;
            string precio = precioproduct.Value;
            try
            {
                string sql = "insert into productos (nombre,stock,precio) values ('" +nombreprodc+ "','" + cantidad + "', '"+precio+"')";
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                cmd.ExecuteNonQuery();
                refrescarTabla();
                nombProducto.Value = "";
                stock.Value = "";
                precioproduct.Value = "";
                connection.Close();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

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