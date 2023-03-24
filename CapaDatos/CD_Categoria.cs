using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    public class CD_Categoria
    {
        public List<Categoria> Listar()
        {
            List<Categoria> lista = new List<Categoria>();

            using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
            {
                try
                {
                    StringBuilder query = new StringBuilder();
                    query.AppendLine("select ID_Categoria,Descripcion,Estado from T_Categoria");



                    SqlCommand cmd = new SqlCommand(query.ToString(), oconexion);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(new Categoria()
                            {
                                ID_Categoria = Convert.ToInt32(dr["ID_Categoria"]),
                                Descripcion = dr["Descripcion"].ToString(),
                                Estado = Convert.ToBoolean(dr["Estado"]),



                            });
                        }
                    }
                }
                catch (Exception ex)
                {
                    lista = new List<Categoria>();

                }


            }

            return lista;

        }



        public int Registrar(Categoria obj, out string Mensaje)
        {
            int ID_Categoria_Generado = 0;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
                {



                    SqlCommand cmd = new SqlCommand("SP_REGISTRARCATEGORIA", oconexion);
                    cmd.Parameters.AddWithValue("Descripcion", obj.Descripcion);
                    cmd.Parameters.AddWithValue("Estado", obj.Estado);
                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;

                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();


                    cmd.ExecuteNonQuery();
                    ID_Categoria_Generado = Convert.ToInt32(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();

                }

            }
            catch (Exception ex)
            {
                ID_Categoria_Generado = 0;

                Mensaje = ex.Message;
            }
            return ID_Categoria_Generado;

        }






        public bool Editar(Categoria obj, out string Mensaje)
        {
            bool respuesta = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
                {

                    SqlCommand cmd = new SqlCommand("SP_EDITARCATEGORIA", oconexion);
                    cmd.Parameters.AddWithValue("ID_Categoria", obj.ID_Categoria);
                    cmd.Parameters.AddWithValue("Descripcion", obj.Descripcion);
                    cmd.Parameters.AddWithValue("Estado", obj.Estado);
                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;

                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();


                    cmd.ExecuteNonQuery();
                    respuesta = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();

                }

            }
            catch (Exception ex)
            {
                respuesta = false;

                Mensaje = ex.Message;
            }
            return respuesta;

        }



        public bool Eliminar(Categoria obj, out string Mensaje)
        {
            bool respuesta = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
                {

                    SqlCommand cmd = new SqlCommand("SP_ELIMINARCATEGORIA", oconexion);
                    cmd.Parameters.AddWithValue("ID_Categoria", obj.ID_Categoria);

                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;

                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();


                    cmd.ExecuteNonQuery();
                    respuesta = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();

                }

            }
            catch (Exception ex)
            {
                respuesta = false;

                Mensaje = ex.Message;
            }
            return respuesta;

        }


    }
}
