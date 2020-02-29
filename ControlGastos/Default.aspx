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
    
    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cerrar Sesion" OnClick="CerrarSesion" CausesValidation="false" UseSubmitBehavior="false"/>
    <hr />
    <br />
    <p><b>Agregar Orden</b></p>
    <div class="row">
        <div class="col-md-4">
    <input type="text" runat="server" placeholder="Nombre Orden" class="form-control mb-2" id="nombOrden" required/>
    <asp:Button runat="server" CssClass="btn btn-success mb-2" Text="Agregar Orden" ValidationGroup="holi" OnClick="Button3_Click" />
            </div>
        </div>
    <div class="row">
        <div class="col-md-4">
            <p><b>Elegir Orden</b></p>
    <asp:DropDownList runat="server" ID="dropdescripcion" DataSourceID="SqlDataSource2" CssClass="form-control mb-2" DataTextField="descripcion" DataValueField="id_gestion"></asp:DropDownList>
        </div>
    </div>
    
    <hr />

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="SELECT [id_gestion], [descripcion] FROM [PedidosMaster] WHERE (([estado] IS NULL) AND ([id_user] = @id_user))">
        <SelectParameters>
            <asp:CookieParameter CookieName="IdUser" Name="id_user" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered table-hover" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="id_pedido" HeaderText="id_pedido" SortExpression="id_pedido" />
            <asp:BoundField DataField="descripcion" HeaderText="descripcion" SortExpression="descripcion" />
            <asp:CommandField HeaderText="Agregar a Orden" ShowSelectButton="True" />
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
