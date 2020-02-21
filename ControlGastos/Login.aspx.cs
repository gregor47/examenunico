using ExamenUnico.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExamenUnico
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LogInApp_Click(object sender, EventArgs e)
        {
            bool validacion = Validacion(Usuario.Value, Contrasena.Value);
            if (validacion)
            {
                //correcto
                Response.Redirect("Default.aspx");
            }
            else
            {
                //manda mensaje de usuario invalido
                Response.Write("Usuario o contraseña Invalida");
            }
        }
        public bool Validacion(String usuario, string contraseña)
        {
            try
            {
                string sql = "select top(1) * from usuarios where username = '" + usuario + "' and contrasena = '" + contraseña + "'";
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
                Usuario user = new Usuario();
                user.idusuario = row["id_usuario"].ToString().Trim();
                user.telefono = row["telefono"].ToString().Trim();
                user.email = row["email"].ToString().Trim();
                user.direccion = row["direccion"].ToString().Trim();
                user.username = row["username"].ToString().Trim();
                user.nombreCompleto = row["nombre"].ToString().Trim() + " " + row["apellido"].ToString().Trim();
                user.perfil = row["perfil"].ToString() == "True";

                HttpCookie cookie = new HttpCookie("Sesion");
                cookie["UserName"] = user.idusuario;
                cookie["Nombre"] = user.nombreCompleto;
                cookie["Perfil"] = user.perfil.ToString();
                Response.Cookies.Add(cookie);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                return false;
            }
            
            return true;

        }

        protected void Registrer_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registrer.aspx");
        }
    }
}