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
    <h2>Mis servicios</h2>
    <hr />
    <h5>Agregar servicio</h5>
    <br />

    <div class="input-group mb-3">
        <div class="input-group-prepend">
            <span class="input-group-text">Nombre </span>
            <input id="nombre" type="text" placeholder="Nombre Servicio" runat="server" />
            <span class="input-group-text">Coste</span>
            <input id="coste" type="text" placeholder="Valor del servicio" runat="server" />
            <asp:Button ID="Button3" runat="server" CssClass="btn btn-success" Text="Agregar" OnClick="Button3_Click" />
            
            
        </div>
    </div>
    <asp:Button runat="server" id="exportar" text="exportar a excel" OnClick="exportar_Click"/>
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered table-hover">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="Nombre_Servicio" HeaderText="Nombre_Servicio" SortExpression="Nombre_Servicio" />
            <asp:BoundField DataField="Coste_Servicio" HeaderText="Coste_Servicio" SortExpression="Coste_Servicio" />
        </Columns>
    </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataBaseConnection %>" SelectCommand="SELECT [id], [Nombre_Servicio], [Coste_Servicio] FROM [tbl_servicios]"></asp:SqlDataSource>
    
        <script>

            $(document).ready(function () {
                $('#<%=GridView1.ClientID%>').DataTable();
            });

    </script>
</asp:Content>
