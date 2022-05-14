using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project.Actions
{
    public partial class DeletePackage : Page
    {
        protected Dictionary<string, object> user;
        protected Dictionary<string, object> package;
        protected string package_guid;

        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            if (Request.QueryString["package_guid"] != null)
            {
                package_guid = Request.QueryString["package_guid"];


                var connection = Helpers.Database.Connect();
                string query = $"DELETE FROM packages_tbl " +
                    $"WHERE package_guid='{package_guid}'";
                var cmd = new SqlCommand(query, connection);

                cmd.ExecuteNonQuery();
            }

            Response.Redirect("../RViewer", true);
        }
    }
}