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
        public int ID_Departamento { get; set;}
        public string Estado_Civil { get; set;}
        public bool Estado { get; set;}
        public DateTime Fecha_Registro { get; set;}

        public Empleado(int iD_Empleado, string nombre, string apellido, string cedula, string telefono,string sexo, string direccion, string fecha_Nacimiento, int iD_Departamento, string estado_Civil, bool estado, DateTime fecha_Registro)
        {
            ID_Empleado = iD_Empleado;
            Nombre = nombre;
            Apellido = apellido;
            Cedula = cedula;
            Telefono = telefono;
            Sexo = sexo;
            Direccion = direccion;
            Fecha_Nacimiento = fecha_Nacimiento;
            ID_Departamento = iD_Departamento;
            Estado_Civil = estado_Civil;
            Estado = estado;
            Fecha_Registro = fecha_Registro;
        }

        Empleado()
        {

        }
    }
}
