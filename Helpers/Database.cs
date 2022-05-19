using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project.Helpers
{
    public class Database
    {
        public static string ConnectString = $"Data Source={Connection.HOSTNAME};" +
                $"Initial Catalog={Connection.DATABASE};" +
                $"Persist Security Info=True;" +
                $"TrustServerCertificate=True;" +
                $"User ID={Connection.USERNAME};" +
                $"Password={Connection.PASSWORD}";
        public static SqlConnection Connect()
        {

            SqlConnection connection = new SqlConnection(ConnectString);

            if (connection.State == System.Data.ConnectionState.Open)
            {
                connection.Close();
            }
            connection.Open();
            return connection;
        }
    }
}