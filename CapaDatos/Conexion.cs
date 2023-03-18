using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// Librerias para la conexion SQL
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;


namespace CapaDatos
{
    public class Conexion
    {
        public static string conexion = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\RegiFax\CapaDatos\DB_RegiFax.mdf;Integrated Security=True";
        SqlConnection dbconexion = new SqlConnection(conexion);
    }
}
