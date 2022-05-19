using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Data.SqlClient;
namespace ipt101_gallery_project.Actions
{
    public partial class changeCommissionStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var user = Helpers.User.AutoLogin();

            if (Request.QueryString["commission_guid"] == null || Request.QueryString["status"] == null || Request.QueryString["status"] == "undefined") Response.Redirect("~/Commission");

            var conn = Helpers.Database.Connect();
            var updateStatusCmd = new SqlCommand("UPDATE commissions_tbl SET status=@status WHERE commission_guid=@commissionGuid", conn);
            updateStatusCmd.Parameters.AddWithValue("@commissionGuid", Request.QueryString["commission_guid"]);
            updateStatusCmd.Parameters.AddWithValue("@status", Request.QueryString["status"]);
            updateStatusCmd.ExecuteNonQuery();

            Response.Redirect("~/Commission");
        }
    }
}