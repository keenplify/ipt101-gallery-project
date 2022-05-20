using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Diagnostics;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project
{
    public partial class Profile : Page
    {
        protected Dictionary<string, object> user; // Logged in user
        protected Dictionary<string, object> _user; // User on profile
        protected List<Dictionary<string, object>> artworks = new List<Dictionary<string, object>>();
        protected List<Dictionary<string, object>> packages = new List<Dictionary<string, object>>();
        protected bool isSameUser = false;
        protected string error = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            if (Request.QueryString["user_guid"] == user["user_guid"].ToString() || Request.QueryString["user_guid"] == null)
            {
                _user = user;
                isSameUser = true;
            } else
            {
                using (var connection = Helpers.Database.Connect())
                {
                    string query = $"SELECT * FROM users_tbl WHERE user_guid='{Request.QueryString["user_guid"]}'";

                    SqlCommand cmd = new SqlCommand(query, connection);
                    SqlDataReader reader = cmd.ExecuteReader();

                    //Check if any user has found, if not throw error.
                    if (reader.HasRows != true) return;

                    reader.Read();

                    //Convert reader to dictionary
                    _user = new Dictionary<string, object>();
                    for (int lp = 0; lp < reader.FieldCount; lp++)
                    {
                        _user.Add(reader.GetName(lp), reader.GetValue(lp));
                    }
                }
            }

            using (var connection = Helpers.Database.Connect())
            {
                // Get Packages of Artist
                var packageCmd = new SqlCommand("SELECT * FROM packages_tbl WHERE created_by=@createdBy", connection);
                packageCmd.Parameters.AddWithValue("@createdBy", user["user_guid"]);

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
                }
            }

            Page.Title = $"{_user["firstName"]} {_user["lastName"]}'s Profile";

            // Get all artwork of user
            var artworkCmd = new SqlCommand("SELECT * FROM artworks_tbl WHERE created_by=@createdBy", Helpers.Database.Connect());
            artworkCmd.Parameters.AddWithValue("@createdBy", _user["user_guid"].ToString());

            var artworkReader = artworkCmd.ExecuteReader();

            while (artworkReader.Read())
            {
                var artwork = new Dictionary<string, object>();
                for (int lp = 0; lp < artworkReader.FieldCount; lp++)
                {
                    artwork.Add(artworkReader.GetName(lp), artworkReader.GetValue(lp));
                }

                artworks.Add(artwork);
            }
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
            string fileName = DateTimeOffset.Now.ToUnixTimeSeconds() + $"-{TitleTbx.Text}" + System.IO.Path.GetExtension(ImageUpl.FileName);

            try
            {
                ImageUpl.SaveAs(Server.MapPath("~/Uploads/" + fileName));
            } catch
            {
                throw;
            }

            // Proceed to sql
            try
            {
                SqlConnection connection = Helpers.Database.Connect();

                SqlCommand cmd = new SqlCommand("INSERT INTO artworks_tbl (title, description, medium, dimensions, image_location, created_by) VALUES (@title, @description, @medium, @dimensions, @image_location, @created_by)", connection);
                cmd.Parameters.AddWithValue("@title", TitleTbx.Text);
                cmd.Parameters.AddWithValue("@description", DescriptionTbx.Text);
                cmd.Parameters.AddWithValue("@medium", MediumTbx.Text);
                cmd.Parameters.AddWithValue("@dimensions", DimensionsTbx.Text);
                cmd.Parameters.AddWithValue("@created_by", user["user_guid"].ToString());
                cmd.Parameters.AddWithValue("@image_location", "/Uploads/" + fileName);
                cmd.ExecuteNonQuery();

            } catch
            {
                throw;
            }
            Response.Redirect(Request.RawUrl, true);
        }
    }
}