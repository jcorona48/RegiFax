using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CN_Rol
    {
        private CD_Rol objRol = new CD_Rol();

        public List<Rol> ConsultarRol(string parametro)
        {
            return objRol.RolConsultar(parametro);
        }
        public bool Insertar(Rol oRol, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oRol.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }




            return objRol.Insertar(oRol, out Mensaje);
        }
        public bool Actualizar(Rol oRol, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oRol.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }

            return objRol.Actualizar(oRol, out Mensaje);
        }

    }
}
