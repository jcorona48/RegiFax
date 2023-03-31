using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    internal class CN_Empleado
    {
        private CD_Empleado objEmpleado = new CD_Empleado();


        public List<Empleado> ConsultarEmpleado( string parametro)
        {
            return objEmpleado.EmpleadoConsultar(parametro);
        }
        public bool Insertar(Empleado oEmpleado, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oEmpleado.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }
            if (oEmpleado.Cedula == "")
            {
                Mensaje = "Por favor, digite la cdula.";
                return false;
            }
            if (oEmpleado.oDepartamento.ID_Departamento == 0)
            {
                Mensaje = "Por favor, digite el ID del departamento.";
                return false;
            }

            return objEmpleado.Insertar(oEmpleado, out Mensaje);
        }
        public bool Actualizar(Empleado oEmpleado, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oEmpleado.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }
            if (oEmpleado.Cedula == "")
            {
                Mensaje = "Por favor, digite la cdula.";
                return false;
            }
            if (oEmpleado.oDepartamento.ID_Departamento == 0)
            {
                Mensaje = "Por favor, digite el ID del departamento.";
                return false;
            }


            return objEmpleado.Actualizar(oEmpleado, out Mensaje);
        }
    }
}
