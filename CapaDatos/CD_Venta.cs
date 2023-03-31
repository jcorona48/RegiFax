using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    public class CD_Venta
    {
        public bool Insertar(VentaCabecera objVentaCabecera, DataTable Venta_Detalle,  out string Mensaje)
        {
            bool respuesta = false;
            Mensaje = string.Empty;
            //creamos un nuevo objeto de tipo SqlConnection
            SqlConnection sqlCon = new SqlConnection();
            //trataremos de hacer algunas operaciones con la tabla
            try
            {
                //asignamos a sqlCon la conexión con las base de datos a traves de la clase que creamos
                sqlCon.ConnectionString = Conexion.conexion;
                //Escribo el nombre del procedimiento almacenado que utilizaré, en este caso SuplidorInsertar
                SqlCommand micomando = new SqlCommand("SP_REGISTRARVenta", sqlCon);
                sqlCon.Open(); //Abro la conexión
                               //indico que se ejecutara un procedimiento almacenado
                micomando.CommandType = CommandType.StoredProcedure;
                micomando.Parameters.AddWithValue("@@Codigo_Factura", objVentaCabecera.Codigo_Factura);
                micomando.Parameters.AddWithValue("@ID_Empleado", objVentaCabecera.oEmpleado.ID_Empleado);
                micomando.Parameters.AddWithValue("@Cedula", objVentaCabecera.oCliente.ID_Cliente);
                micomando.Parameters.AddWithValue("@Precio_Bruto", objVentaCabecera.Precio_Bruto);
                micomando.Parameters.AddWithValue("@Descuento", objVentaCabecera.Descuento);
                micomando.Parameters.AddWithValue("@ITBIS", objVentaCabecera.ITBIS);
                micomando.Parameters.AddWithValue("@Precio_Neto", objVentaCabecera.Precio_Neto);
                micomando.Parameters.AddWithValue("@Venta_Detalle", Venta_Detalle);

                micomando.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                micomando.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                /*Ejecuto la instrucción. Si se devuelve el valor 1 significa que todo funcionó correctamente de lo
                 * contrario se devuelve el mensaje indicando que fue incorrecto.
                */
                respuesta = Convert.ToBoolean(micomando.Parameters["Resultado"].Value);
                Mensaje = micomando.Parameters["Mensaje"].Value.ToString();
            }
            catch (Exception ex) //Si ocurre algún error se captura y se muestra el mensaje
            {
                respuesta = false;

                Mensaje = ex.Message;
            }
            finally
            { //Luego de realizar el proceso de forma correcta o no

                if (sqlCon.State == ConnectionState.Open)
                    sqlCon.Close();
            }
            //Devuelvo el mensaje correspondiente de acuerdo a lo que haya resultado del comando
            return respuesta;
        }

        public bool Actualizar(VentaCabecera objVentaCabecera, out string Mensaje)
        {
            bool respuesta = false;
            Mensaje = string.Empty;
            //creamos un nuevo objeto de tipo SqlConnection
            SqlConnection sqlCon = new SqlConnection();
            //trataremos de hacer algunas operaciones con la tabla
            try
            {
                //asignamos a sqlCon la conexión con las base de datos a traves de la clase que creamos
                sqlCon.ConnectionString = Conexion.conexion;
                //Escribo el nombre del procedimiento almacenado que utilizaré, en este caso SuplidorInsertar
                SqlCommand micomando = new SqlCommand("SP_ELIMINARVenta", sqlCon);
                sqlCon.Open(); //Abro la conexión
                               //indico que se ejecutara un procedimiento almacenado
                micomando.CommandType = CommandType.StoredProcedure;
                micomando.Parameters.AddWithValue("@ID_Venta", objVentaCabecera.ID_Venta);
                micomando.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                micomando.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                /*Ejecuto la instrucción. Si se devuelve el valor 1 significa que todo funcionó correctamente de lo
                 * contrario se devuelve el mensaje indicando que fue incorrecto.
                */
                respuesta = Convert.ToBoolean(micomando.Parameters["Resultado"].Value);
                Mensaje = micomando.Parameters["Mensaje"].Value.ToString();
            }
            catch (Exception ex) //Si ocurre algún error se captura y se muestra el mensaje
            {
                respuesta = false;

                Mensaje = ex.Message;
            }
            finally
            { //Luego de realizar el proceso de forma correcta o no

                if (sqlCon.State == ConnectionState.Open)
                    sqlCon.Close();
            }
            //Devuelvo el mensaje correspondiente de acuerdo a lo que haya resultado del comando
            return respuesta;
        }

        //Método para consultar datos filtrados de la tabla. Se recibe el valor del parámetro
        public List<VentaCabecera> VentaCabeceraConsultar(string FechaInicio, string FechaFin, int ID_Empleado)
        {
            List<VentaCabecera> Lista = new List<VentaCabecera>(); //Se Crea DataTable que tomará los datos de los Suplidores
            SqlDataReader leerDatos; //Creamos el DataReader
            try
            {
                SqlCommand sqlCmd = new SqlCommand(); //Establecer el comando
                sqlCmd.Connection = new Conexion().dbconexion; //Conexión que va a usar el comando
                sqlCmd.Connection.Open(); //Se abre la conexión
                sqlCmd.CommandText = "SP_ReporteVentas"; //Nombre del Proc. Almacenado a usar
                sqlCmd.CommandType = CommandType.StoredProcedure; //Se trata de un proc. almacenado
                sqlCmd.Parameters.AddWithValue("@FechaInicio", FechaInicio); //Se pasa el valor a buscar
                sqlCmd.Parameters.AddWithValue("@FechaFin", FechaFin); //Se pasa el valor a buscar
                sqlCmd.Parameters.AddWithValue("@@ID_Empleado", ID_Empleado); //Se pasa el valor a buscar
                using (leerDatos = sqlCmd.ExecuteReader()) //Llenamos el SqlDataReader con los datos resultantes
                {
                    while (leerDatos.Read())
                    {
                        Lista.Add(new VentaCabecera //Se cargan los registros devueltos a la lista
                        {
                            ID_Venta = Convert.ToInt32(leerDatos["ID_VentaCabecera"]),
                            Fecha_Registro = leerDatos["Fecha_Registro"].ToString(),
                            Codigo_Factura = Convert.ToInt32(leerDatos["Codigo_Factura"]),
                            oEmpleado = new Empleado() { Nombre = leerDatos["NombreEmp"].ToString(), Apellido = leerDatos["ApellidoEmp"].ToString() },
                            oCliente = new Cliente() { Nombre = leerDatos["NombreCli"].ToString(), Apellido = leerDatos["ApellidoCli"].ToString(), Cedula = leerDatos["CedulaCli"].ToString() },
                            Precio_Bruto = Convert.ToDecimal(leerDatos["Precio_Bruto"]),
                            ITBIS = Convert.ToDecimal(leerDatos["ITBIS"]),
                            Precio_Neto = Convert.ToDecimal(leerDatos["Precio_Neto"]),

                        });
                    }
                }
                sqlCmd.Connection.Close(); //Se cierra la conexión
            }
            catch (Exception ex)
            {
                Lista = new List<VentaCabecera>(); //Si ocurre algun error se envia una lista vacia
            }
            return Lista; ////Se retorna la lista segun lo ocurrido arriba
        } //Fin del método MostrarConFiltro

        public List<VentaDetalle> ListarTopVentas(string FechaInicio, string FechaFin, int ID_Empleado)
        {
            List<VentaDetalle> Lista = new List<VentaDetalle>(); //Se Crea DataTable que tomará los datos de los Suplidores
            SqlDataReader leerDatos; //Creamos el DataReader
            try
            {
                SqlCommand sqlCmd = new SqlCommand(); //Establecer el comando
                sqlCmd.Connection = new Conexion().dbconexion; //Conexión que va a usar el comando
                sqlCmd.Connection.Open(); //Se abre la conexión
                sqlCmd.CommandText = "SP_ReporteVentasTopProducto"; //Nombre del Proc. Almacenado a usar
                sqlCmd.CommandType = CommandType.StoredProcedure; //Se trata de un proc. almacenado
                sqlCmd.Parameters.AddWithValue("@FechaInicio", FechaInicio); //Se pasa el valor a buscar
                sqlCmd.Parameters.AddWithValue("@FechaFin", FechaFin); //Se pasa el valor a buscar
                sqlCmd.Parameters.AddWithValue("@@ID_Empleado", ID_Empleado); //Se pasa el valor a buscar
                using (leerDatos = sqlCmd.ExecuteReader()) //Llenamos el SqlDataReader con los datos resultantes
                {
                    while (leerDatos.Read())
                    {
                        Lista.Add(new VentaDetalle //Se cargan los registros devueltos a la lista
                        {
                            oProducto = new Producto() { 
                                Codigo = leerDatos["Codigo"].ToString(),
                                Nombre = leerDatos["Nombre"].ToString(), 
                                Cantidad = Convert.ToInt32(leerDatos["Total_Vendido"]),
                                oCategoria =  new Categoria() {Nombre = leerDatos["Categoria"].ToString() }
                            }

                        });
                    }
                }
                sqlCmd.Connection.Close(); //Se cierra la conexión
            }
            catch (Exception ex)
            {
                Lista = new List<VentaDetalle>(); //Si ocurre algun error se envia una lista vacia
            }
            return Lista; ////Se retorna la lista segun lo ocurrido arriba
        } //Fin del método MostrarConFiltro
    }
}
