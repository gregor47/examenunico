using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExamenUnico
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CerrarSesion(object sender, EventArgs e)
        {
            if (Request.Cookies["Sesion"] != null)
            {
                Response.Cookies["Sesion"].Expires = DateTime.Now.AddDays(-1);
            }
            Response.Redirect("Login.aspx");
        }
        [WebMethod]
        public void CerrarSesion(double Valor1, double Valor2)
        {
            for (int i = 0; i < Request.Cookies.Count; i++)
            {
                var cookie = new HttpCookie(Request.Cookies[i].Name);
                cookie.Expires = DateTime.Now.AddDays(-1);
                cookie.Value = string.Empty;
                Response.Cookies.Add(cookie);
            }
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

}
}