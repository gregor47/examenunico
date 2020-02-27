using ExamenUnico.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExamenUnico
{
    public partial class Registrer : System.Web.UI.Page
    {
        Usuario usuario = new Usuario();
        protected void Page_Load(object sender, EventArgs e)
        {
            MiModal.Visible = false;
            linklog.Visible = false;
            if (IsPostBack)
            {
                JObject response = ValidarCampos();
                string valor = response.GetValue("Codigo").ToString();
                if (response.GetValue("Codigo").ToString().Equals("02"))
                {
                    string error = response.GetValue("Descripcion").ToString();
                    exampleModalLabel.InnerText = "Error";
                    descripcionval.InnerText = error;
                    contrasena.Focus();
                }
                else
                {
                    descripcionval.InnerText = "";
                    descripcion.InnerText = "¿Esta seguro de que desea registrar un nuevo usuario con estos datos?";
                    exampleModalLabel.InnerText = "Confirmar";
                    MiModal.Visible = true;
                }
            }
        }

        public JObject ValidarCampos()
        {
            
            JObject respuesta = new JObject();
            try
            {
                if (contrasena.Value == contrasena2.Value)
                {
                    usuario.username = user.Value;
                    usuario.nombre = nombre.Value;
                    usuario.apellido = apellido.Value;
                    usuario.contrasena = contrasena.Value;
                    usuario.email = email.Value;
                    usuario.direccion = direccion.Value;
                    usuario.telefono = telefono.Value;
                    respuesta.Add("Codigo", "01");
                    respuesta.Add("Descripcion", "OK");
                    respuesta.Add("Usuario", JsonConvert.SerializeObject(usuario));
                }
                else
                {
                    respuesta.Add("Codigo", "02");
                    respuesta.Add("Descripcion", "Contraseñas ingresadas no coiniciden");
                }
            }
            catch (Exception ex)
            {
                respuesta.Add("Codigo", "02");
                respuesta.Add("Descripcion", "Ha ocurrido un error al validar los campos");
            }
            return respuesta;
        }
        protected void Guardar(object sender, EventArgs e)
        {
            
            bool exitoso = false;
            Usuario userr = new Usuario();
            userr.username = user.Value;
            userr.nombre = nombre.Value;
            userr.apellido = apellido.Value;
            userr.contrasena = contrasena.Value;
            userr.email = email.Value;
            userr.direccion = direccion.Value;
            userr.telefono = telefono.Value;

            int comprobar = UsuarioExiste(userr.username,userr.email);
            if(comprobar == 0)
            {
            string connStr = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
            string sql = "INSERT INTO Usuarios([username],[contrasena],[email],[direccion],[telefono],[perfil],[nombre],[apellido])" +
                "VALUES('"+userr.username+"','"+ userr.contrasena+ "','"+ userr.email+ "','"+ userr.direccion+ "','"+ userr.telefono+ 
                "','0','"+ userr.nombre+ "','"+ userr.apellido+ "')";
             ;
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand();
            try
            {
                conn.Open();
                cmd.Connection = conn;
                cmd.CommandText = sql;
                cmd.ExecuteNonQuery();
                exitoso = true;
                conn.Close();
                }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                string error = ex.Message.ToString(); 
                
                exampleModalLabel.InnerText = "Error";
                descripcion.InnerText ="Detalles del error: "+ error;
            }
            }else if(comprobar == 1)
            {
                exampleModalLabel.InnerText = "Error";
                descripcion.InnerText = "Este usuario ya se encuentra registrado";
            }
            else if(comprobar == 2)
            {
                exampleModalLabel.InnerText = "Error";
                descripcion.InnerText = "Email ya registrado";
            }
            else if(comprobar == 3)
            {
                exampleModalLabel.InnerText = "Error";
                descripcion.InnerText = "Ha ocurrido un error, intente nuevamente";
            }
            if (exitoso)
            {
                exampleModalLabel.InnerText = "Exitoso";
                descripcion.InnerText = "Se ha registrado Correctamente";
                linklog.Visible = true;
            }
            
        }

        public int UsuarioExiste(String usuario, string email)
        {
            try
            {
                string sql = "select top(1) * from usuarios where username = '" + usuario + "'";
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                SqlDataReader dataReader = cmd.ExecuteReader();
                if (dataReader.HasRows)
                {
                    //Existe Usuario registrado
                    return 1;
                }
                dataReader.Close();
                sql = "select top(1) * from usuarios where email = '" + email + "'";
                cmd.CommandText = sql;
                dataReader = cmd.ExecuteReader();
                if (dataReader.HasRows)
                {
                    //Existe email registrado
                    return 2;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                //Retorna error
                return 3;
            }
            //No existe usuario registrado 
            return 0;
        }
    }
}