using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CN_Producto
    {
        private CD_Producto objProducto = new CD_Producto();
        public List<Producto> ConsultarProducto(string parametro)
        {
            return objProducto.ProductoConsultar(parametro);
        }
        public bool Insertar(Producto oProducto, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oProducto.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }

            if (oProducto.Cantidad < 0)
            {
                Mensaje = "Por favor, digite una cantidad razonable";
                return false;
            }

            if (oProducto.Precio <= 0)
            {
                Mensaje = "Por favor, digite un precio";
                return false;
            }

            if (oProducto.oCategoria.ID_Categoria == 0)
            {
                Mensaje = "Por favor, digite el id de la ctegoria";
                return false;
            }






            return objProducto.Insertar(oProducto, out Mensaje);
        }
        public bool Actualizar(Producto oProducto, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oProducto.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }

            if (oProducto.Cantidad < 0)
            {
                Mensaje = "Por favor, digite una cantidad razonable";
                return false;
            }

            
            if (oProducto.Precio <= 0)
            {
                Mensaje = "Por favor, digite un precio";
                return false;
            }

            if (oProducto.oCategoria.ID_Categoria == 0)
            {
                Mensaje = "Por favor, digite el id de la ctegoria";
                return false;
            }


            return objProducto.Actualizar(oProducto, out Mensaje);
        }
    }
}
