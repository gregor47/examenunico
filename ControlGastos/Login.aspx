<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ExamenUnico.Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Signin Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <!-- Custom styles for this template -->
    <link href="css/login.css" rel="stylesheet" />
</head>

<body class="text-center">
    <form class="form-signin" runat="server">
        <img class="mb-4 rounded-circle" src="img/LogoApp.png" alt="The Creator" width="72" height="72">
        <h1 class="h3 mb-3 font-weight-normal">Iniciar Sesion</h1>
        <label for="inputEmail" class="sr-only">Usuario</label>
        <input type="text" id="Usuario" runat="server" class="form-control" placeholder="Usuario" required autofocus>
        <label for="inputPassword" class="sr-only">Contraseña</label>
        <input type="password" id="Contrasena" runat="server" class="form-control" placeholder="Contraseña" required>
        <div class="checkbox mb-3">
            <label>
                <input type="checkbox" value="remember-me" runat="server">
                Recordarme
       
            </label>
        </div>
        <asp:Button ID="LogInApp" runat="server" CssClass="btn btn-lg btn-primary btn-block" Text="Iniciar Sesion" OnClick="LogInApp_Click" />
        <a ID="Registrer" class="btn btn-lg btn-primary btn-block" href="Registrer.aspx" >Registrarse</a>
    </form>
</body>
</html>
