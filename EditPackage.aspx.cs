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
    public partial class EditPackage : Page
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
                var query = new SqlCommand("SELECT * FROM packages_tbl WHERE package_guid=@guid", connection);
                query.Parameters.AddWithValue("@guid", package_guid);

                var reader = query.ExecuteReader();

                while (reader.Read())
                {
                    package = new Dictionary<string, object>();
                    for (int lp = 0; lp < reader.FieldCount; lp++)
                    {
                        package.Add(reader.GetName(lp), reader.GetValue(lp));
                    }

                    if (!IsPostBack)
                    {
                        PackageTitleTbx.Text = package["title"].ToString();
                        PriceTbx.Text = (float.Parse(((int)package["price"] / 100).ToString())).ToString();
                        DescriptionTbx.Text = package["description"].ToString();
                    }
                }
            }
        }

        protected void EditPackageBtn_Click(object sender, EventArgs e)
        {
            var connection = Helpers.Database.Connect();
            var qstring = "UPDATE packages_tbl SET " +
                "title=@title, " +
                "price=@price, " +
                "description=@description ";

            string location = "";

            if (ImageUpl.HasFile)
            {
                // Save to uploads folder
                location = DateTimeOffset.Now.ToUnixTimeSeconds() + $"-{PackageTitleTbx.Text}-package" + System.IO.Path.GetExtension(ImageUpl.FileName);

                try
                {
                    ImageUpl.SaveAs(Server.MapPath("~/Uploads/" + location));
                }
                catch
                {
                    throw;
                }

                qstring += ", image_location=@location ";
            }

            qstring += " WHERE package_guid=@packageGuid";

            var query = new SqlCommand(qstring, connection);
            query.Parameters.AddWithValue("@title", PackageTitleTbx.Text);
            query.Parameters.AddWithValue("@price", int.Parse(PriceTbx.Text) * 100);
            query.Parameters.AddWithValue("@description", DescriptionTbx.Text);
            query.Parameters.AddWithValue("@packageGuid", package_guid);

            if (ImageUpl.HasFile)
            {
                query.Parameters.AddWithValue("@location", "/Uploads/" + location);
            }

            query.ExecuteNonQuery();

            Response.Redirect("~/RViewer");
        }
    }
}