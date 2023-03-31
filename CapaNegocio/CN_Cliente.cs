using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CN_Cliente
    {

        private CD_Cliente objCliente = new CD_Cliente();

        public List<Cliente> ConsultarCliente(string parametro)
        {
            return objCliente.ClienteConsultar(parametro);
        }
        public bool Insertar(Cliente oCliente, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oCliente.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }

            if (oCliente.Apellido == "")
            {
                Mensaje = "Por favor, digite el apellido.";
                return false;
            }

            if (oCliente.Cedula == "")
            {
                Mensaje = "Por favor, digite la cedula.";
                return false;
            }

            if (oCliente.Sexo == "")
            {
                Mensaje = "Por favor, digite el sexo.";
                return false;
            }





            return objCliente.Insertar(oCliente, out Mensaje);
        }
        public bool Actualizar(Cliente oCliente, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oCliente.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }

            if (oCliente.Apellido == "")
            {
                Mensaje = "Por favor, digite el apellido.";
                return false;
            }

            if (oCliente.Cedula == "")
            {
                Mensaje = "Por favor, digite la cedula.";
                return false;
            }

            if (oCliente.Sexo == "")
            {
                Mensaje = "Por favor, digite el sexo.";
                return false;
            }



            return objCliente.Actualizar(oCliente, out Mensaje);
        }
    }
}
