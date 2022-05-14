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
    public partial class RViewer : Page
    {
        protected Dictionary<string, object> user;
        protected List<Dictionary<string, object>> packages = new List<Dictionary<string, object>>();

        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();


            var connection = Helpers.Database.Connect();
            var query = new SqlCommand("SELECT * FROM packages_tbl WHERE created_by=@createdBy", connection);
            query.Parameters.AddWithValue("@createdBy", user["user_guid"]);

            var reader = query.ExecuteReader();

            while (reader.Read())
            {
                //Convert reader to dictionary
                Dictionary<string, object> package = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    package.Add(reader.GetName(lp), reader.GetValue(lp));
                }
                packages.Add(package);
            }

        }

        protected void AddPackageBtn_Click(object sender, EventArgs e)
        {
            if (
                PriceTbx.Text.Length <= 0 ||
                PackageTitleTbx.Text.Length <= 0 ||
                DescriptionTbx.Text.Length <= 0 ||
                !ImageUpl.HasFile
            ) return;

            string path = HttpContext.Current.ApplicationInstance.Server.MapPath("~/user_uploads/");
            string fn = DateTime.Now.ToFileTime().ToString() + "-" + System.IO.Path.GetFileName(ImageUpl.PostedFile.FileName);
            string location = path + fn;
            ImageUpl.SaveAs(location);

            var connection = Helpers.Database.Connect();
            var query = "INSERT INTO packages_tbl (" +
                "price," +
                "title," +
                "description," +
                "created_by," +
                "image_location" +
                ") VALUES (" +
                $"'{int.Parse((float.Parse(PriceTbx.Text) * 100).ToString()) }'," +
                $"'{PackageTitleTbx.Text}'," +
                $"'{DescriptionTbx.Text}'," +
                $"'{user["user_guid"]}'," +
                $"'{Uri.EscapeUriString("/user_uploads/" + fn)}'" +
                ")";
            var cmd = new SqlCommand(query, connection);

            cmd.ExecuteNonQuery();

            Response.Redirect(Request.RawUrl);
        }


    }
}