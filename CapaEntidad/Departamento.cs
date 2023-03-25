using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Departamento
    {
        public int ID_Departamento { get; set; }
        public string Nombre { get; set;}
        public string Descripcion { get; set;}
        public bool Estado { get; set; }
        public string Fecha_Registro { get; set; }

    }
}
