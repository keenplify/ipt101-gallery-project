using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project.Helpers
{
    public class User
    {
        public static Dictionary<string, object> Login (string username, string password)
        {
            SqlConnection connection = Database.Connect();

            string query = $"SELECT * FROM users_tbl WHERE username='{username}'";

            SqlCommand cmd = new SqlCommand(query, connection);
            SqlDataReader reader = cmd.ExecuteReader();

            //Check if any user has found, if not throw error.
            if (reader.HasRows != true) throw new InvalidOperationException("No user found");

            reader.Read();

            //Convert reader to dictionary
            Dictionary<string, object> user = new Dictionary<string, object>();
            for (int lp = 0; lp < reader.FieldCount; lp++)
            {
                user.Add(reader.GetName(lp), reader.GetValue(lp));
            }

            if (BCrypt.Net.BCrypt.Verify(password, user["password_hash"].ToString()))
            {
                Dictionary<string, string> userdata = new Dictionary<string, string> {
                    {"username", username}, {"password", password}
                };
                Cookie.StoreInCookieDictionary("user", null, userdata, null);
            } else
            {
                throw new InvalidOperationException("Wrong password");
            }

            return user;
        }

        public static void Register(string firstName, string middleName, string lastName, string birthday, string email, string username, string password)
        {
            SqlConnection connection = Database.Connect();

            string query = "INSERT INTO users_tbl (" +
                "firstName," +
                "middleName," +
                "lastName," +
                "birthday," +
                "email," +
                "username," +
                "password_hash," +
                "user_type" +
                ") VALUES (" +
                "@firstName ," +
                "@middleName ," +
                "@lastName ," +
                "@birthday ," +
                "@email ," +
                "@username ," +
                "@password_hash, " +
                "'USER'" +
                ")";
            
            SqlCommand cmd = new SqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@firstName", firstName);
            cmd.Parameters.AddWithValue("@middleName", middleName);
            cmd.Parameters.AddWithValue("@lastName", lastName);
            cmd.Parameters.AddWithValue("@birthday", birthday);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@password_hash", BCrypt.Net.BCrypt.HashPassword(password, 10));

            cmd.ExecuteNonQuery();
        }

        public static Dictionary<string, object> AutoLogin(bool redirect=true)
        {
            if (!Cookie.CookieExist("user", "username") || !Cookie.CookieExist("user", "password"))
            {
                Logout();
                if (redirect) HttpContext.Current.Response.Redirect("/");
                return null;
            }
            try
            {
                var user = Login(Cookie.GetFromCookie("user", "username"), Cookie.GetFromCookie("user", "password"));
                return user;
            }
            catch(Exception)
            {
                Logout();
                if (redirect) HttpContext.Current.Response.Redirect("/");
                return null;
            }
        }

        public static void LoginRedirect()
        {
            Dictionary<string, object> user = AutoLogin();
            
            if (user == null)
            {
                Logout();
            }
        }

        public static void LoginWithRedirect()
        {
            Dictionary<string, object> user = AutoLogin();

            if (user["user_type"].ToString() == "ADMIN")
            {
                HttpContext.Current.Response.Redirect("~/adminDashboard");
            }
            else
            {
                HttpContext.Current.Response.Redirect("~/userDashboard");
            }
        }

        public static void Logout()
        {
            Cookie.RemoveCookie("user", "username", null);
            Cookie.RemoveCookie("user", "password", null);
        }
    }
}