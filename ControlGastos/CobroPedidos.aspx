<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CobroPedidos.aspx.cs" Inherits="ExamenUnico.CobroPedidos" MasterPageFile="~/Site2.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  
    <%--<script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
    <script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/TableExport/5.2.0/js/tableexport.js"></script>
    
    <h2>Agregar Productos</h2>
    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cerrar Sesion" OnClick="CerrarSesion" CausesValidation="false" UseSubmitBehavior="false"/>
    <hr />
    <br />
    <asp:Button runat="server" CssClass="btn btn-success mb-1" Text="Cobrar Ordenes en Espera" OnClick="Button3_Click" />
    
    <hr />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered table-hover" >
        <Columns>
            <asp:BoundField DataField="id_gestion" HeaderText="id_gestion" SortExpression="id_gestion" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="descripcion" HeaderText="descripcion" SortExpression="descripcion" />
            <asp:BoundField DataField="cobrado_descriptcion" HeaderText="cobrado_descriptcion" SortExpression="cobrado_descriptcion" />
        </Columns>
    </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="SELECT [id_gestion], [descripcion], [cobrado_descriptcion] FROM [PedidosMaster] WHERE ([estado] = @estado)">
            <SelectParameters>
                <asp:Parameter DefaultValue="true" Name="estado" Type="Boolean" />
            </SelectParameters>
    </asp:SqlDataSource>
    
        <script>

            $(document).ready(function () {
                $('#<%=GridView1.ClientID%>').DataTable();
            });

    </script>
</asp:Content>
