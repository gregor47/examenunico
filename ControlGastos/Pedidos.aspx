<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pedidos.aspx.cs" Inherits="ExamenUnico.Pedidos" MasterPageFile="~/Site1.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  
    <%--<script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
    <script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/TableExport/5.2.0/js/tableexport.js"></script>
    
    <h2>Nuevo Pedido</h2>
    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cerrar Sesion" OnClick="CerrarSesion"/>
    <hr />
    <h5>Agregar Productos</h5>
    <h6>Id Pedido: <asp:Label id="idpedidomostrar" Text="0" runat="server"/></h6>
    <br />

    <div class="input-group mb-3">
        <div class="input-group-prepend">
            <span class="input-group-text">Producto </span>
            <asp:DropDownList OnSelectedIndexChanged="DropDownList_SelectedIndexChanged" ID="DropDownList" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="nombre" DataValueField="id_producto" CssClass="form-control">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="SELECT DISTINCT id_producto, nombre FROM Productos"></asp:SqlDataSource>
            <span class="input-group-text">Stock</span>
            <asp:TextBox ID="stocktxt" Enabled="false" runat="server"></asp:TextBox>
            <span class="input-group-text">Cantidad </span>
            <input type="number" id="num_producto" runat="server" class="form-control" placeholder="Cantidad" required min="1" />
            <asp:Button runat="server" ID="btnAgregar" Text="Agregar" CssClass="btn btn-success" OnClick="AgregarProductos" />
            <%--<asp:Button ID="Button3" runat="server" CssClass="btn btn-success" Text="Agregar" OnClick="Button3_Click" />--%>
            
            
        </div>
    </div>
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered table-hover">
        <Columns>
            <asp:BoundField DataField="id_producto" HeaderText="id_producto" SortExpression="id_producto" />
            <asp:BoundField DataField="nombre_producto" HeaderText="nombre_producto" SortExpression="nombre_producto" />
            <asp:BoundField DataField="Column1" HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
        </Columns>
    </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="select b.id_producto,b.nombre_producto,sum(cantidad) from Pedidos a inner join DetallePedido b on a.id_pedido = b.id_pedido where  (b.id_usuario = @id_usuario) and (b.id_pedido=@idpedido) and a.estado = '0' group by id_producto,nombre_producto">
            <SelectParameters>
                <asp:CookieParameter CookieName="idUser" Name="id_usuario" Type="Empty"  />
                <asp:CookieParameter CookieName="idPedido" Name="idpedido" />
            </SelectParameters>
    </asp:SqlDataSource>
    
        <script>

            $(document).ready(function () {
                $('#<%=GridView1.ClientID%>').DataTable();
            });

    </script>
</asp:Content>

