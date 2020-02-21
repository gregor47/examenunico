using System;
using System.Collections.Generic;
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
            Validacion(Usuario.ToString(), Contrasena.Value.ToString());
        }
        public void Validacion(String usuario, string contraseña)
        {
            HttpCookie cookie = new HttpCookie("Login");
            cookie["UserName"] = usuario;
            

        }
    }
}