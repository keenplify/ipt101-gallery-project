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
    public partial class AdminCashouts : Page
    {
        protected Dictionary<string, object> user;
        protected List<Dictionary<string, object>> cashouts = new List<Dictionary<string, object>>();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            var connection = Helpers.Database.Connect();
            string query = $"SELECT * FROM cashouts_tbl WHERE user_guid='{user["user_guid"]}'";
            var cmd = new SqlCommand(query, connection);
            
            var reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                //Convert reader to dictionary
                Dictionary<string, object> cashout = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    cashout.Add(reader.GetName(lp), reader.GetValue(lp));
                }
                cashouts.Add(cashout);
            }
        }
    }
}