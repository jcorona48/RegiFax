using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    internal class CN_Usuario
    {
        private CD_Usuario objUsuario = new CD_Usuario();

        public List<Usuario> ConsultarUsuario(string parametro)
        {
            return objUsuario.UsuarioConsultar(parametro);
        }
        public bool Insertar(Usuario oUsuario, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oUsuario.User == "")
            {
                Mensaje = "Por favor, digite el nombre de usuario.";
                return false;
            }

            if (oUsuario.Pass == "")
            {
                Mensaje = "Por favor, digite una contraseña.";
                return false;
            }

            if (oUsuario.oEmpleado.ID_Empleado == 0)
            {
                Mensaje = "Por favor, digite el ID del empleado";
                return false;
            }

            if (oUsuario.oRol.ID_Rol == 0)
            {
                Mensaje = "Por favor, digite el ID del rol.";
                return false;
            }


            return objUsuario.Insertar(oUsuario, out Mensaje);
        }
        public bool Actualizar(Usuario oUsuario, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oUsuario.User == "")
            {
                Mensaje = "Por favor, digite el nombre de usuario.";
                return false;
            }

            if (oUsuario.Pass == "")
            {
                Mensaje = "Por favor, digite una contraseña.";
                return false;
            }

            if (oUsuario.oEmpleado.ID_Empleado == 0)
            {
                Mensaje = "Por favor, digite el ID del empleado";
                return false;
            }

            if (oUsuario.oRol.ID_Rol == 0)
            {
                Mensaje = "Por favor, digite el ID del rol.";
                return false;
            }


            return objUsuario.Actualizar(oUsuario, out Mensaje);
        }
    }
}
