using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Microsoft.Data.SqlClient;
using System.Diagnostics;

namespace ipt101_gallery_project
{
    public partial class AddArtworkFromCommission : Page
    {
        protected Dictionary<string, object> user;
        protected Dictionary<string, object> commission;

        protected List<Dictionary<string, object>> packages = new List<Dictionary<string, object>>();
        protected string error = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            if (Request.QueryString["commission_guid"] == null)
            {
                Response.Redirect("~/Commission");
                return;
            }

            // Get artist data
            SqlConnection connection = Helpers.Database.Connect();

            SqlCommand cmd = new SqlCommand("SELECT * FROM commissions_tbl WHERE commission_guid=@commissionGuid", connection);
            cmd.Parameters.AddWithValue("@commissionGuid", Request.QueryString["commission_guid"]);
            SqlDataReader reader = cmd.ExecuteReader();

            //Check if any user has found, if not throw error.
            if (reader.HasRows != true)
            {
                Response.Redirect("~/Commission");
                return;
            };

            reader.Read();

            //Convert reader to dictionary
            commission = new Dictionary<string, object>();
            for (int lp = 0; lp < reader.FieldCount; lp++)
            {
                commission.Add(reader.GetName(lp), reader.GetValue(lp));
            }

            connection.Close();
        }

        protected void AddArtworkBtn_Click(object sender, EventArgs e)
        {
            if (TitleTbx.Text.Length == 0) error += "Artwork Title is required to add an artwork!\n";
            if (DescriptionTbx.Text.Length == 0) error += "Artwork Description is required to add an artwork!\n";
            if (MediumTbx.Text.Length == 0) error += "Artwork Medium is required to add an artwork!\n";
            if (DimensionsTbx.Text.Length == 0) error += "Artwork Dimensions is required to add an artwork!\n";
            if (!ImageUpl.HasFile) error += "Artwork Image is required to add an artwork!\n";

            if (error.Length > 0) return;

            // Save to uploads folder
            string fileName = DateTimeOffset.Now.ToUnixTimeSeconds() + $"-{TitleTbx.Text}-commission" + System.IO.Path.GetExtension(ImageUpl.FileName);

            try
            {
                ImageUpl.SaveAs(Server.MapPath("~/Uploads/" + fileName));
            }
            catch
            {
                throw;
            }

            using (var connection = Helpers.Database.Connect())
            {
                var transaction = connection.BeginTransaction();
                // Proceed to sql
                try
                {
                    string artworkGuid = Guid.NewGuid().ToString();

                    SqlCommand cmd = new SqlCommand("INSERT INTO artworks_tbl (artwork_guid, title, description, medium, dimensions, image_location, created_by, commissioned_by, visibility) VALUES (@artwork_guid, @title, @description, @medium, @dimensions, @image_location, @created_by, @commissionedBy, @visibility)", connection, transaction);
                    cmd.Parameters.AddWithValue("@artwork_guid", artworkGuid);
                    cmd.Parameters.AddWithValue("@title", TitleTbx.Text);
                    cmd.Parameters.AddWithValue("@description", DescriptionTbx.Text);
                    cmd.Parameters.AddWithValue("@medium", MediumTbx.Text);
                    cmd.Parameters.AddWithValue("@dimensions", DimensionsTbx.Text);
                    cmd.Parameters.AddWithValue("@created_by", user["user_guid"].ToString());
                    cmd.Parameters.AddWithValue("@image_location", "/Uploads/" + fileName);
                    cmd.Parameters.AddWithValue("@commissionedBy", commission["created_by"]);
                    cmd.Parameters.AddWithValue("@visibility", commission["visibility"]);

                    cmd.ExecuteNonQuery();

                    SqlCommand updateCommissionCmd = new SqlCommand("UPDATE commissions_tbl SET artwork_guid=@artworkGuid, status='FINISHED' WHERE commission_guid=@commissionGuid", connection, transaction);
                    updateCommissionCmd.Parameters.AddWithValue("@artworkGuid", artworkGuid);
                    updateCommissionCmd.Parameters.AddWithValue("@commissionGuid", commission["commission_guid"]);

                    updateCommissionCmd.ExecuteNonQuery();
                }
                catch
                {
                    transaction.Rollback();
                    throw;
                }
                finally
                {
                    transaction.Commit();
                    Response.Redirect("~/Commission");
                }
            }
        }
    }
}