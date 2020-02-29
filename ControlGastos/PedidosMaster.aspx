<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PedidosMaster.aspx.cs" Inherits="ExamenUnico.PedidosMaster" MasterPageFile="~/Site1.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  
    <%--<script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
    <script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/TableExport/5.2.0/js/tableexport.js"></script>
    
    <h2>Ordenar Pedidos</h2>
    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cerrar Sesion" OnClick="CerrarSesion" CausesValidation="false" UseSubmitBehavior="false"/>
    <hr />
    <br />
    <p><b>Agregar Tarjetas</b></p>
    <div class="row">
        <div class="col-md-4">
    <input type="number" runat="server" placeholder="Numero Tarjeta" class="form-control mb-1" id="numTarjeta" min="1000000000000000" max="9999999999999999" required/>
    <input type="number" runat="server" placeholder="Monto Tarjeta" class="form-control mb-1" id="monto" min="100000" required/>
    <asp:Button runat="server" CssClass="btn btn-success mb-1" Text="Añadir Tarjeta" OnClick="Button3_Click" />
            </div>
        </div>
    <p><b>Elegir Tarjetas</b></p>
    <div class="row">
        <div class="col-md-4">
            <asp:DropDownList runat="server" ID="dropdescripcion" DataSourceID="SqlDataSource2" CssClass="form-control mb-2" DataTextField="tarjeta" DataValueField="id_cuenta"></asp:DropDownList>
        </div>
    </div>
    
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
            <asp:CommandField ShowSelectButton="True" />
        </Columns>
    </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="SELECT [id_gestion], [descripcion] FROM [PedidosMaster] WHERE (([id_user] = @id_user) AND ([estado] = @estado))">
            <SelectParameters>
                <asp:CookieParameter CookieName="IdUser" Name="id_user" Type="Int32" />
                <asp:Parameter DefaultValue="false" Name="estado" Type="Boolean" />
            </SelectParameters>
    </asp:SqlDataSource>
    
        <script>

            $(document).ready(function () {
                $('#<%=GridView1.ClientID%>').DataTable();
            });

    </script>
</asp:Content>