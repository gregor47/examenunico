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
    public partial class PedidosMaster : System.Web.UI.Page
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
            string montoTar = monto.Value;
            string Tarjeta = numTarjeta.Value;
            string iduser = Request.Cookies["IdUser"].Value;
            try
            {
                string sql = "insert into cuentas (tarjeta,id_usuario,disponible) values ('" + Tarjeta + "','" + iduser + "', '"+montoTar+"')";
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                cmd.ExecuteNonQuery();
                refrescarTabla();
                dropdescripcion.DataBind();
                monto.Value = "";
                numTarjeta.Value = "";
                dropdescripcion.DataBind();
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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string card = dropdescripcion.SelectedValue;
            string id = GridView1.Rows[GridView1.SelectedIndex].Cells[0].Text.ToString();
            try
            {
                string sql = String.Format("update PedidosMaster set id_pedido = '{0}',estado=1,cobrado_descriptcion='En Espera' where id_gestion = '{1}'", card,id);
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                cmd.ExecuteNonQuery();
                refrescarTabla();
                monto.Value = "";
                numTarjeta.Value = "";
                dropdescripcion.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}