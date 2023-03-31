using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CN_Departamento
    {
        private CD_Departamento objDepartamento = new CD_Departamento();

        public List<Departamento> ConsultarDepartamento(string parametro)
        {
            return objDepartamento.DepartamentoConsultar(parametro);
        }
        public bool Insertar(Departamento oDepartamento, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oDepartamento.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }




            return objDepartamento.Insertar(oDepartamento, out Mensaje);
        }
        public bool Actualizar(Departamento oDepartamento, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (oDepartamento.Nombre == "")
            {
                Mensaje = "Por favor, digite el nombre.";
                return false;
            }

            return objDepartamento.Actualizar(oDepartamento, out Mensaje);
        }
    }
}
