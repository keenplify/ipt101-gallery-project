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
    public partial class ArtworkViewer : Page
    {
        protected Dictionary<string, object> user;
        protected Dictionary<string, object> artwork;
        protected bool isOwnArtwork = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            if (Request.QueryString["artwork_guid"] == null) return;

            var cmd = new SqlCommand("SELECT * FROM artworks_tbl LEFT JOIN users_tbl ON artworks_tbl.created_by=users_tbl.user_guid WHERE artwork_guid=@artwork_guid", Helpers.Database.Connect());
            cmd.Parameters.AddWithValue("@artwork_guid", Request.QueryString["artwork_guid"]);

            var reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                //Convert reader to dictionary
                artwork = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    artwork.Add(reader.GetName(lp), reader.GetValue(lp));
                }
            }

            if (artwork["user_guid"].ToString() == user["user_guid"].ToString()) isOwnArtwork = true;
        }

    }
}