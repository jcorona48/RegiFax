using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class VentaCabecera
    {
        public int ID_Venta { get; set; }
        public int Codigo_Factura { get; set; }
        public Empleado oEmpleado { get; set; }
        public Cliente oCliente { get; set; }
        public decimal Precio_Bruto { get; set; }
        public decimal Descuento { get; set; }
        public decimal ITBIS { get; set; }
        public decimal Precio_Neto { get; set; }
        public List<VentaDetalle> oVentaDetalle { get; set; }
        public bool Estado { get; set; }
        public string Fecha_Registro { get; set; }
    }
}
