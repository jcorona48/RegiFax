using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CN_Categoria
    {


        private CD_Categoria objCategoria = new CD_Categoria();

        public List<Categoria> ConsultarCategoria(string parametro)
        {
            return objCategoria.CategoriaConsultar(parametro);
        }
        public bool Insertar(Categoria oCategoria, out string Mensaje)
        {
            Mensaje = string.Empty;

            if(oCategoria.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }




            return objCategoria.Insertar(oCategoria, out Mensaje);
        }
        public bool Actualizar(Categoria oCategoria, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oCategoria.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }

            return objCategoria.Actualizar(oCategoria, out Mensaje);
        }



    }
}
