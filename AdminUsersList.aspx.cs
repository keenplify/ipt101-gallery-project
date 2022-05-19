using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project
{
    public partial class AdminUsersList : Page
    {
        protected Dictionary<string, object> user;
        protected List<Dictionary<string, object>> users = new List<Dictionary<string, object>>();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            var connection = Helpers.Database.Connect();
            string query = $"SELECT * FROM users_tbl WHERE user_guid!=@adminUserGuid";

            var cmd = new SqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@adminUserGuid", user["user_guid"]);
            
            var reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                //Convert reader to dictionary
                Dictionary<string, object> _user = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    _user.Add(reader.GetName(lp), reader.GetValue(lp));
                }
                users.Add(_user);
            }
        }
    }
}