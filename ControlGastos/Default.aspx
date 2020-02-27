<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ExamenUnico.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  
    <%--<script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
    <script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/TableExport/5.2.0/js/tableexport.js"></script>
    
    <h2>Historial de Pedidos</h2>
    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cerrar Sesion" OnClick="CerrarSesion"/>
    <hr />
    <br />
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered table-hover">
        <Columns>
            <asp:BoundField DataField="id_pedido" HeaderText="id_pedido" SortExpression="id_pedido" />
            <asp:BoundField DataField="descripcion" HeaderText="descripcion" SortExpression="descripcion" />
        </Columns>
    </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="SELECT [id_pedido], [descripcion] FROM [Pedidos] WHERE (([id_usuario] = @id_usuario) AND ([estado] = @estado))">
            <SelectParameters>
                <asp:CookieParameter CookieName="idUser" Name="id_usuario" Type="Int32" />
                <asp:Parameter DefaultValue="true" Name="estado" Type="Boolean" />
            </SelectParameters>
    </asp:SqlDataSource>
    
        <script>

            $(document).ready(function () {
                $('#<%=GridView1.ClientID%>').DataTable();
            });

    </script>
</asp:Content>
