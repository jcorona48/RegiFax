using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Empleado
    {
        public int ID_Empleado { get; set; }
        public string Nombre { get; set;}
        public string Apellido { get; set;}
        public string Cedula { get; set;}
        public string Sexo { get; set; }
        public string Telefono { get; set;}
        public string Direccion { get; set;}
        public string Fecha_Nacimiento { get; set;}
        public Departamento oDepartamento { get; set;} // A las claves foraneas creale este campo. Aqui deberia ir ID_Departamento pero mejor el objeto para asi poder guardar mas informacion
        public string Estado_Civil { get; set;}
        public bool Estado { get; set;}
        public string Fecha_Registro { get; set;}


    }
}
