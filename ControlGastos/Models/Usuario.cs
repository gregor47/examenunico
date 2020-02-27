using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamenUnico.Models
{
    public class Usuario
    {
        public string idusuario { get; set; }
        public string email { get; set; }
        public string direccion { get; set; }
        public string telefono { get; set; }
        public bool perfil { get; set; }
        public string nombreCompleto { get; set; }
        public string username { get; set; }
        public string nombre { get; set; }
        public string apellido { get; set; }
        public string contrasena { get; set; }
    }
}