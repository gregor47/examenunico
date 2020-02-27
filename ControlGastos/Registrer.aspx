<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registrer.aspx.cs" Inherits="ExamenUnico.Registrer" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Signin Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <!-- Custom styles for this template -->
    <link href="css/login.css" rel="stylesheet" />
</head>

<body class="text-center">
    <!-- Button trigger modal -->
    <div class="container-fluid">
        <form class="form-signin" runat="server">
<!-- Modal -->
<div class="modal fade" id="MiModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" runat="server">
        <div class="modal-dialog modal-dialog-centered " style="max-width: 1000px; margin: 1.75rem auto;" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel" runat="server">Confirmacion</h5>
                </div>
                <div class="modal-body">

                    <div id="descripcionError" class="container">
                        <p class="h5" id="descripcion" runat="server">¿Esta seguro de que desea registrar un nuevo usuario con estos datos?</p>
                        <p id="linklog" runat="server"><a href="Login.aspx">Iniciar Sesion</a></p>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" id="btnsalir" data-dismiss="modal" class="btn btn-danger" value="Salir"/>
                    <%--<button type="button" class="btn btn-danger" data-dismiss="modal" runat="server" id="btnsalir">Salir</button>--%>
                    <asp:Button ID="Btnguardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="Guardar"  />
                </div>
            </div>
        </div>
    </div>


        <img class="mb-4 rounded-circle" src="img/pedidosyalogo.png" alt="The Creator" width="100" height="100">
        <h1 class="h1 mb-3 font-weight-normal">Registro</h1>
        <label for="user" class="sr-only">Usuario</label>
        <input type="text" id="user" runat="server" class="form-control mb-2" placeholder="Usuario" required autofocus maxlength="10">
        <label for="nombre" class="sr-only">Nombre</label>
        <input type="text" id="nombre" runat="server" class="form-control mb-2" placeholder="Nombre" required maxlength="30">
        <label for="apellido" class="sr-only">Apellido</label>
        <input type="text" id="apellido" runat="server" class="form-control mb-2" placeholder="Apellido" required maxlength="30">
        <label for="contraseña" class="sr-only">Contraseña</label>
        <input type="text" id="contrasena" runat="server" class="key form-control mb-2" placeholder="Password" minlength="5" required autocomplete="off">
        <label for="contraseña" class="sr-only">Repetir Contraseña</label>
        <input type="text" id="contrasena2" runat="server" class="key form-control mb-2" placeholder="Repita la Contraseña" required autocomplete="off">
        <label for="email" class="sr-only">Correo Electronico</label>
        <input type="email" id="email" runat="server" class="form-control mb-2" placeholder="Correo Electronico" required>
        <label for="direccion" class="sr-only">Direccion</label>
        <input type="text" id="direccion" runat="server" class="form-control mb-2" placeholder="Direccion" required>
        <label for="telefono" class="sr-only">Telefono</label>
        <input type="number" id="telefono" runat="server" class="form-control mb-2" placeholder="Telefono" required min="1000000000" max="9999999999">
        
        <div class="checkbox mb-2">
            <label runat="server" id="descripcionval" class="text-danger"></label>
        </div>
        <asp:Button runat="server" CssClass="btn btn-lg btn-primary btn-block mb-2" Text="Registrarse" data-toggle="modal" data-target="#MiModal" />
        <a href="Login.aspx">¿Ya tienes una cuenta? Inicia Sesión</a>
        <p class="mt-5 mb-3 text-muted">Examen Unico© Universidad Autonoma - 2020</p>
    </form>
</div>

    <script type="text/javascript">
        $(document).ready(function () {
            MostrarModal();
        });
        
        function MostrarModal() {
            $('#MiModal').modal('show');
        }
    </script>

</body>
</html>
