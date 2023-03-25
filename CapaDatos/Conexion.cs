using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// Librerias para la conexion SQL
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
// URL BASE en DIsco C:\RegiFax\CapaDatos\DB_RegiFax.mdf;Integrated Security=True
// URL De Joan --- Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Programas en C#\RegiFax\CapaDatos\DB_RegiFax.mdf";Integrated Security=True
namespace CapaDatos 
{
    public class Conexion
    {
        public static string conexion = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\RegiFax\CapaDatos\DB_RegiFax.mdf;Integrated Security=True";
        public SqlConnection dbconexion = new SqlConnection(conexion);
    }
}
