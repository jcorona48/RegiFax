using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    
       public class Producto
        {
            public int ID_Producto { get; set; }
            public string Codigo { get; set; }
            public string Nombre { get; set; }
            public int Cantidad { get; set; }
            public decimal Precio { get; set; }
            public Categoria oCategoria { get; set; }
            public bool Estado { get; set; }
            public string Fecha_Registro { get; set; }

        }
    
}
