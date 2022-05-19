using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project
{
    public partial class Search : Page
    {
        protected string keyword;
        protected List<Dictionary<string, object>> users = new List<Dictionary<string, object>>();
        protected List<Dictionary<string, object>> artworks = new List<Dictionary<string, object>>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["keyword"] == null)
            {
                Response.Redirect("/");
                return;
            }
            
            keyword = Request.QueryString["keyword"].ToLower();

            using (var connection = Helpers.Database.Connect())
            {
                var cmd = new SqlCommand("SELECT * FROM users_tbl WHERE " +
                    "LOWER(firstName) LIKE @keyword OR " +
                    "LOWER(middleName) LIKE @keyword OR " +
                    "LOWER(lastName) LIKE @keyword OR " +
                    "LOWER(lastName) LIKE @keyword OR " +
                    "LOWER(lastName) LIKE @keyword OR " +
                    "LOWER(CONCAT(firstName, ' ', middleName, ' ', lastName)) LIKE @keyword OR " +
                    "LOWER(CONCAT(firstName, ' ', lastName)) LIKE @keyword", connection);

                cmd.Parameters.AddWithValue("@keyword", '%' + keyword + '%');

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    //Convert reader to dictionary
                    Dictionary<string, object> _user = new Dictionary<string, object>();
                    for (int lp = 0; lp < reader.FieldCount; lp++)
                    {
                        _user.Add(reader.GetName(lp), reader.GetValue(lp));
                    }
                    users.Add(_user);
                }
            }

            using (var connection = Helpers.Database.Connect())
            {
                var cmd = new SqlCommand("SELECT * FROM artworks_tbl WHERE (" +
                    "LOWER(description) LIKE @keyword OR " +
                    "LOWER(medium) LIKE @keyword OR " +
                    "LOWER(dimensions) LIKE @keyword OR " +
                    "LOWER(title) LIKE @keyword" +
                    ") AND visibility='PUBLIC'", connection);
                cmd.Parameters.AddWithValue("@keyword", '%' + keyword + '%');

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    //Convert reader to dictionary
                    Dictionary<string, object> artwork = new Dictionary<string, object>();
                    for (int lp = 0; lp < reader.FieldCount; lp++)
                    {
                        artwork.Add(reader.GetName(lp), reader.GetValue(lp));
                    }
                    artworks.Add(artwork);
                }
            }
        }
    }
}