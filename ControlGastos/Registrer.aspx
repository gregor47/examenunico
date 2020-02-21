<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registrer.aspx.cs" Inherits="ExamenUnico.Registrer" %>

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
    <!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>


    <form class="form-signin" runat="server">
        <img class="mb-4 rounded-circle" src="img/LogoApp.png" alt="The Creator" width="72" height="72">
        <h1 class="h3 mb-3 font-weight-normal">Registro</h1>
        <label for="user" class="sr-only">Usuario</label>
        <input type="text" id="user" runat="server" class="form-control mb-2" placeholder="Usuario" required autofocus>
        <label for="contraseña" class="sr-only">Contraseña</label>
        <input type="password" id="contrasena" runat="server" class="form-control mb-2" placeholder="Password" required>
        <label for="contraseña" class="sr-only">Repetir Contraseña</label>
        <input type="password" id="Password1" runat="server" class="form-control mb-2" placeholder="Repita la Contraseña" required>
        <label for="email" class="sr-only">Correo Electronico</label>
        <input type="email" id="email" runat="server" class="form-control mb-2" placeholder="Correo Electronico" required autofocus>
        <label for="direccion" class="sr-only">Direccion</label>
        <input type="text" id="direccion" runat="server" class="form-control mb-2" placeholder="Direccion" required autofocus>
        <label for="telefono" class="sr-only">Telefono</label>
        <input type="number" id="telefono" runat="server" class="form-control mb-2" placeholder="Telefono" required autofocus>
        
        <div class="checkbox mb-3">
            <label>
                <input type="checkbox" value="remember-me">
                Remember me
       
            </label>
        </div>
        <button type="button" class="btn btn-lg btn-primary btn-block" data-toggle="modal" data-target="#exampleModalCenter">
             Registrarse
        </button>
        <p class="mt-5 mb-3 text-muted">Examen Unico© Universidad Autonoma - 2020</p>
    </form>

    <script type="text/javascript">

        $('#myModal').on('shown.bs.modal', function () {
            //$('#myInput').trigger('focus')
        })
    </script>

</body>
</html>
