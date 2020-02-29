<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarProductos.aspx.cs" Inherits="ExamenUnico.AgregarProductos" MasterPageFile="~/Site2.Master" %>

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
    <p><b>Agregar Productos</b></p>
    <div class="row">
        <div class="col-md-4">
    <input type="text" runat="server" placeholder="Nombre Producto" class="form-control mb-1" id="nombProducto" required/>
    <input type="number" runat="server" placeholder="Cantidad Stock" class="form-control mb-1" id="stock" min="100" required/>
    <input type="number" runat="server" placeholder="Precio Producto" class="form-control mb-1" id="precioproduct" min="1000" required/>
    <asp:Button runat="server" CssClass="btn btn-success mb-1" Text="Añadir Producto" OnClick="Button3_Click" />
            </div>
        </div>
    
    <hr />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered table-hover" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="id_producto" HeaderText="id_producto" SortExpression="id_producto" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="nombre" HeaderText="nombre" SortExpression="nombre" />
            <asp:BoundField DataField="Precio" HeaderText="Precio" SortExpression="Precio" />
            <asp:BoundField DataField="stock" HeaderText="stock" SortExpression="stock" />
        </Columns>
    </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="SELECT [id_producto], [nombre], [Precio], [stock] FROM [Productos]">
    </asp:SqlDataSource>
    
        <script>

            $(document).ready(function () {
                $('#<%=GridView1.ClientID%>').DataTable();
            });

    </script>
</asp:Content>
