<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EstadoOrden.aspx.cs" Inherits="ExamenUnico.EstadoOrden" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  
    <%--<script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
    <script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/TableExport/5.2.0/js/tableexport.js"></script>
    
    <h2>Estado de Orden</h2>
    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cerrar Sesion" OnClick="CerrarSesion" CausesValidation="false" UseSubmitBehavior="false"/>
    <hr />

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="SELECT [id_cuenta], [tarjeta] FROM [Cuentas] WHERE ([id_usuario] = @id_usuario)">
        <SelectParameters>
            <asp:CookieParameter CookieName="IdUser" Name="id_usuario" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered table-hover" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="id_gestion" HeaderText="id_gestion" SortExpression="id_gestion" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="descripcion" HeaderText="descripcion" SortExpression="descripcion" />
            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
            <asp:BoundField DataField="cobrado_descriptcion" HeaderText="cobrado_descriptcion" SortExpression="cobrado_descriptcion" />
        </Columns>
    </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="SELECT a.id_gestion, a.descripcion, SUM(c.Precio * b.cantidad) AS Total, a.cobrado_descriptcion FROM PedidosMaster AS a INNER JOIN DetallePedido AS b ON a.id_gestion = b.master INNER JOIN Productos AS c ON b.id_producto = c.id_producto WHERE (b.id_usuario = @id_usuario) and (a.cobrado_descriptcion IS NOT NULL) GROUP BY a.id_gestion, a.descripcion, a.cobrado_descriptcion">
            <SelectParameters>
                <asp:CookieParameter CookieName="idUser" Name="id_usuario" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <script>

            $(document).ready(function () {
                $('#<%=GridView1.ClientID%>').DataTable();
            });

    </script>
</asp:Content>
