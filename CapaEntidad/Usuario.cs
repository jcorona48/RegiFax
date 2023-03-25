using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Usuario
    {
        public int ID_Usuario { get; set; }
        public string User { get; set; }
        public string Pass { get; set; }
        public Empleado oEmpleado { get; set; }
        public Rol oRol { get; set; }
        public bool Estado { get; set; }
        public string Fecha_Registro { get; set; }

    }
}
