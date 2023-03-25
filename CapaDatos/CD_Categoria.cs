using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    public class CD_Categoria
    {
        public bool Insertar(Categoria objCategoria, out string Mensaje)
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
                SqlCommand micomando = new SqlCommand("SP_REGISTRARCATEGORIA", sqlCon);
                sqlCon.Open(); //Abro la conexión
                               //indico que se ejecutara un procedimiento almacenado
                micomando.CommandType = CommandType.StoredProcedure;
                micomando.Parameters.AddWithValue("@Nombre", objCategoria.Nombre);               
                micomando.Parameters.AddWithValue("@Fecha_Registro", objCategoria.Fecha_Registro);              
                micomando.Parameters.AddWithValue("@Estado", objCategoria.Estado);
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

        public bool Actualizar(Categoria objCategoria, out string Mensaje)
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
                SqlCommand micomando = new SqlCommand("SP_EDITARCATEGORIA", sqlCon);
                sqlCon.Open(); //Abro la conexión
                               //indico que se ejecutara un procedimiento almacenado
                micomando.CommandType = CommandType.StoredProcedure;
                micomando.Parameters.AddWithValue("@ID_Categoria", objCategoria.ID_Categoria);
                micomando.Parameters.AddWithValue("@Nombre", objCategoria.Nombre);
                micomando.Parameters.AddWithValue("@Fecha_Registro", objCategoria.Fecha_Registro);
                micomando.Parameters.AddWithValue("@Estado", objCategoria.Estado);
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
        public List<Categoria> CategoriaConsultar(string miparametro)
        {
            List<Categoria> Lista = new List<Categoria>(); //Se Crea DataTable que tomará los datos de los Suplidores
            SqlDataReader leerDatos; //Creamos el DataReader
            try
            {
                SqlCommand sqlCmd = new SqlCommand(); //Establecer el comando
                sqlCmd.Connection = new Conexion().dbconexion; //Conexión que va a usar el comando
                sqlCmd.Connection.Open(); //Se abre la conexión
                sqlCmd.CommandText = "SP_ConsultarCategoria"; //Nombre del Proc. Almacenado a usar
                sqlCmd.CommandType = CommandType.StoredProcedure; //Se trata de un proc. almacenado
                sqlCmd.Parameters.AddWithValue("@valor", miparametro); //Se pasa el valor a buscar
                using (leerDatos = sqlCmd.ExecuteReader()) //Llenamos el SqlDataReader con los datos resultantes
                {
                    while (leerDatos.Read())
                    {
                        Lista.Add(new Categoria //Se cargan los registros devueltos a la lista
                        {
                            ID_Categoria = Convert.ToInt32(leerDatos["ID_Categoria"]),
                            Nombre = leerDatos["Nombre"].ToString(),
                            Fecha_Registro = leerDatos["Fecha_Registro"].ToString(),
                            Estado = Convert.ToBoolean(leerDatos["Estado"])
                            
                        });
                    }
                }
                sqlCmd.Connection.Close(); //Se cierra la conexión
            }
            catch (Exception ex)
            {
                Lista = new List<Categoria>(); //Si ocurre algun error se envia una lista vacia
            }
            return Lista; ////Se retorna la lista segun lo ocurrido arriba
        } //Fin del método MostrarConFiltro

    }
}
