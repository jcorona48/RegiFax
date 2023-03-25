using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Cliente
    {
        public int ID_Cliente { get; set; }
        public string Nombre { get; set;}
        public string Apellido { get; set;}
        public string Cedula { get; set;}
        public string Sexo { get; set;}
        public string Telefono { get; set;}
        public string Direccion { get; set;}
        public string Fecha_Nacimiento { get; set;}
        public string Estado_Civil { get; set;}
        public bool Estado { get; set;}
        public string Fecha_Registro { get; set;}

        public Cliente(int iD_Cliente, string nombre, string apellido, string cedula, string sexo, string telefono, string direccion, string fecha_Nacimiento,  string estado_Civil, bool estado, string fecha_Registro)
        {
            ID_Cliente = iD_Cliente;
            Nombre = nombre;
            Apellido = apellido;
            Cedula = cedula;
            Sexo = sexo;
            Telefono = telefono;
            Direccion = direccion;
            Fecha_Nacimiento = fecha_Nacimiento;
            Estado_Civil = estado_Civil;
            Estado = estado;
            Fecha_Registro = fecha_Registro;
        }

        public Cliente()
        {

        }
    }
}
