﻿using System;
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
            string nombre = nombOrden.Value;
            string iduser = Request.Cookies["IdUser"].Value;
            try
            {
                string sql = "insert into pedidosmaster (descripcion,id_user) values ('"+nombre+"','"+iduser+"')";
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                cmd.ExecuteNonQuery();
                refrescarTabla();
                dropdescripcion.DataBind();
                nombOrden.Value = "";
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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = GridView1.Rows[GridView1.SelectedIndex].Cells[0].Text.ToString();
            string drop = dropdescripcion.SelectedValue;
            try
            {
                if (!String.IsNullOrEmpty(drop)) { 
                string sql = "update pedidos set estado=null where id_pedido='"+id+"'";
                string ConnString = ConfigurationManager.ConnectionStrings["DataBaseConnection"].ToString();
                SqlConnection connection = new SqlConnection(ConnString);
                connection.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sql;
                cmd.Connection = connection;
                cmd.ExecuteNonQuery();
                sql = "update pedidosmaster set estado=0 where id_gestion='"+drop+"'";
                cmd.CommandText = sql;
                cmd.ExecuteNonQuery();
                sql = "update DetallePedido set master = '"+drop+"' where id_pedido = '"+id+"'";
                cmd.CommandText = sql;
                cmd.ExecuteNonQuery();
                connection.Close();
                refrescarTabla();
                }
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}