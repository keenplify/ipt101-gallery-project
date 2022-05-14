using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project.Admin
{
    public partial class ToggleDoneStatus : System.Web.UI.Page
    {
        protected Dictionary<string, object> user;
        protected string cashout_guid;

        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            if (Request.QueryString["cashout_guid"] != null)
            {
                cashout_guid = Request.QueryString["cashout_guid"];


                var connection = Helpers.Database.Connect();
                string query = $"UPDATE cashouts_tbl " +
                    $"SET is_done = 1 - is_done " +
                    $"WHERE cashout_guid='{cashout_guid}'";
                var cmd = new SqlCommand(query, connection);

                cmd.ExecuteNonQuery();
            }

            Response.Redirect("../AdminCashouts", true);

        }
    }
}