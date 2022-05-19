using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project.Admin
{
    public partial class ToggleActiveStatus : System.Web.UI.Page
    {
        protected Dictionary<string, object> user;
        protected string user_guid;

        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            if (Request.QueryString["user_guid"] != null)
            {
                user_guid = Request.QueryString["user_guid"];

                var connection = Helpers.Database.Connect();
                string query = $"UPDATE users_tbl SET is_active  = (1 ^ is_active) WHERE user_guid=@userGuid";
                var cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@userGuid", user_guid);

                cmd.ExecuteNonQuery();
            }

            Response.Redirect("../AdminUsersList", true);

        }
    }
}