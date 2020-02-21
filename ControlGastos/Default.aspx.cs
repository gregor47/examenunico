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
            refrescarTabla();
            if (!IsPostBack){
                
            }
            
        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            string nombre_servicio = nombre.Value;
            string coste_servicio = coste.Value;
            string connString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
            SqlConnection con = new SqlConnection(connString);
            string sql = "insert into tbl_servicios (Nombre_Servicio,Coste_Servicio,Servicio_User) values ('"+nombre_servicio+"','"+coste_servicio+"',1);";
            SqlCommand cmd = new SqlCommand();
            con.Open();
            cmd.CommandText = sql;
            cmd.Connection = con;
            cmd.ExecuteNonQuery();
            con.Close();
            nombre.Value = "";
            coste.Value = "";
            refrescarTabla();
        }

        public void refrescarTabla()
        {
            GridView1.DataBind();
            GridView1.UseAccessibleHeader = true;
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void exportar_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=GridViewExporttoExcel.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                GridView1.AllowPaging = false;

                GridView1.RenderControl(hw);


                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();

            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            //verificamos que el control está renderizado
        }
    }
}