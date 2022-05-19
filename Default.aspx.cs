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
    public partial class _Default : Page
    {
        protected List<Dictionary<string, object>> artworks = new List<Dictionary<string, object>>();

        protected void Page_Load(object sender, EventArgs e)
        {
            var artworkCmd = new SqlCommand("SELECT TOP 16 * FROM artworks_tbl LEFT JOIN users_tbl ON artworks_tbl.created_by=users_tbl.user_guid WHERE visibility='PUBLIC' ORDER BY created_at DESC", Helpers.Database.Connect());

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
    }
}