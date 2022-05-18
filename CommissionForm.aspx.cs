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
    public partial class CommissionForm : Page
    {
        protected Dictionary<string, object> user;
        protected Dictionary<string, object> artist;
        protected List<Dictionary<string, object>> packages = new List<Dictionary<string, object>>();
        protected string error = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            if (Request.QueryString["artist_guid"] == null) return;

            // Get artist data
            SqlConnection connection = Helpers.Database.Connect();

            string query = $"SELECT * FROM users_tbl WHERE user_guid='{Request.QueryString["artist_guid"]}'";

            SqlCommand cmd = new SqlCommand(query, connection);
            SqlDataReader reader = cmd.ExecuteReader();

            //Check if any user has found, if not throw error.
            if (reader.HasRows != true) return;

            reader.Read();

            //Convert reader to dictionary
            artist = new Dictionary<string, object>();
            for (int lp = 0; lp < reader.FieldCount; lp++)
            {
                artist.Add(reader.GetName(lp), reader.GetValue(lp));
            }

            connection.Close();

            // Get Packages of Artist
            var packageCmd = new SqlCommand("SELECT * FROM packages_tbl WHERE created_by=@createdBy", Helpers.Database.Connect());
            packageCmd.Parameters.AddWithValue("@createdBy", Request.QueryString["artist_guid"]);

            var packageReader = packageCmd.ExecuteReader();

            while (packageReader.Read())
            {
                //Convert reader to dictionary
                var package = new Dictionary<string, object>();
                for (int lp = 0; lp < packageReader.FieldCount; lp++)
                {
                    package.Add(packageReader.GetName(lp), packageReader.GetValue(lp));
                }
                packages.Add(package);

                PackagesList.Items.Add(new ListItem() { 
                    Text = $"{package["title"]} - ₱{(double)((int)package["price"] / 100)}" , 
                    Value = package["package_guid"].ToString()
                });
            }

            //Set minimum for deadline
            DeadlineTbx.Attributes.Add("min", DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
        }

        protected void SubmitCommissionBtn_Click(object sender, EventArgs e)
        {
            if (PackagesList.Text.Length == 0) error += "Package is required!";
            if (TitleTbx.Text.Length == 0) error += "Title is required!";
            if (DescriptionTbx.Text.Length == 0) error += "Description is required!";
            if (!refImage.HasFile) error += "Reference image is required!";


            if (error.Length > 0) return;

            // Save to uploads folder
            string fileName = DateTimeOffset.Now.ToUnixTimeSeconds() + $"-{TitleTbx.Text}-ref" + System.IO.Path.GetExtension(refImage.FileName);

            try
            {
                refImage.SaveAs(Server.MapPath("~/Uploads/" + fileName));
            }
            catch
            {
                throw;
            }

            // Proceed to sql
            try
            {
                SqlConnection connection = Helpers.Database.Connect();

                SqlCommand cmd = new SqlCommand((
                    DeadlineTbx.Text.Length > 0 ?
                        "INSERT INTO commissions_tbl (created_by, artist_guid, title, package_guid, description, reference_image_location, visibility, deadline) VALUES (@createdBy, @artistGuid, @title, @packageGuid, @description, @referenceImageLocation, @visibility, @deadline)" : //Has deadline
                        "INSERT INTO commissions_tbl (created_by, artist_guid, title, package_guid, description, reference_image_location, visibility) VALUES (@createdBy, @artistGuid, @title, @packageGuid, @description, @referenceImageLocation, @visibility)" //Without deadline
                    ), connection);
                cmd.Parameters.AddWithValue("@title", TitleTbx.Text);
                cmd.Parameters.AddWithValue("@description", DescriptionTbx.Text);
                cmd.Parameters.AddWithValue("@packageGuid", PackagesList.Text);
                cmd.Parameters.AddWithValue("@referenceImageLocation", "/Uploads/" + fileName);
                cmd.Parameters.AddWithValue("@visibility", Visibility.Text);
                cmd.Parameters.AddWithValue("@createdBy", user["user_guid"].ToString());
                cmd.Parameters.AddWithValue("@artistGuid", artist["user_guid"].ToString());
                if (DeadlineTbx.Text.Length > 0) cmd.Parameters.AddWithValue("@deadline", DeadlineTbx.Text);

                cmd.ExecuteNonQuery();

            }
            catch
            {
                throw;
            }

            // Redirect
            Response.Redirect("MyCommission");
        }
    }
}