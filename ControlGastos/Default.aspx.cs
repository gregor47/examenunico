using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExamenUnico
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String username ="", perfil, nombre;
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
        protected void CerrarSesion(object sender, EventArgs e)
        {
            if (Request.Cookies["Sesion"] != null) 
            { 
                Response.Cookies["Sesion"].Expires = DateTime.Now.AddDays(-1); 
            }
            Response.Redirect("Login.aspx");
        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            refrescarTabla();
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

        //protected void exportar_Click(object sender, EventArgs e)
        //{
        //    Response.Clear();
        //    Response.Buffer = true;
        //    Response.AddHeader("content-disposition", "attachment;filename=GridViewExporttoExcel.xls");
        //    Response.Charset = "";
        //    Response.ContentType = "application/vnd.ms-excel";
        //    using (StringWriter sw = new StringWriter())
        //    {
        //        HtmlTextWriter hw = new HtmlTextWriter(sw);

        //        GridView1.AllowPaging = false;

        //        GridView1.RenderControl(hw);


        //        string style = @"<style> .textmode { } </style>";
        //        Response.Write(style);
        //        Response.Output.Write(sw.ToString());
        //        Response.Flush();
        //        Response.End();

        //    }
        //}

        //public override void VerifyRenderingInServerForm(Control control)
        //{
        //    //verificamos que el control está renderizado
        //}
    }
}