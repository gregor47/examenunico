<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ExamenUnico.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Iniciar Sesion</h1>
            <asp:TextBox ID="Usuario" runat="server"></asp:TextBox>
            <input id="Contrasena" runat="server" type="password" />
            <asp:Button ID="LogInApp" runat="server" Text="Iniciar Sesion" OnClick="LogInApp_Click" />
        </div>
    </form>
</body>
</html>
