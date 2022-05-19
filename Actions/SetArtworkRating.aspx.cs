using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Data.SqlClient;
namespace ipt101_gallery_project.Actions
{
    public partial class SetArtworkRating : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var user = Helpers.User.AutoLogin();

            if (Request.QueryString["artwork_guid"] == null || Request.QueryString["rating"] == null || Request.QueryString["rating"] == "undefined") Response.Redirect("~/Commission");

            var conn = Helpers.Database.Connect();
            var updateStatusCmd = new SqlCommand("UPDATE artworks_tbl SET rating=@rating WHERE artwork_guid=@artworkGuid", conn);
            updateStatusCmd.Parameters.AddWithValue("@artworkGuid", Request.QueryString["artwork_guid"]);
            updateStatusCmd.Parameters.AddWithValue("@rating", Request.QueryString["rating"]);
            updateStatusCmd.ExecuteNonQuery();

            Response.Redirect("~/Commission");
        }
    }
}