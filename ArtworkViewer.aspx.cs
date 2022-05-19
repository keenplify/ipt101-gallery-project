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
        protected List<Dictionary<string, object>> artworks = new List<Dictionary<string, object>>();
        protected List<Dictionary<string, object>> comments = new List<Dictionary<string, object>>();

        protected bool isOwnArtwork = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin(false);

            if (Request.QueryString["artwork_guid"] == null) return;

            var cmd = new SqlCommand("SELECT * FROM artworks_tbl " +
                "LEFT JOIN users_tbl ON artworks_tbl.created_by=users_tbl.user_guid " +
                "LEFT JOIN (SELECT user_guid AS c_guid, firstName AS c_firstName, lastName AS c_lastName FROM users_tbl) client ON artworks_tbl.commissioned_by=client.c_guid " +
                "WHERE artwork_guid=@artwork_guid", Helpers.Database.Connect());
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

            // Fillup reccommended
            var artworkCmd = new SqlCommand("SELECT TOP 16 * FROM artworks_tbl LEFT JOIN users_tbl ON artworks_tbl.created_by=users_tbl.user_guid WHERE visibility='PUBLIC' AND created_by=@createdBy ORDER BY created_at DESC", Helpers.Database.Connect());
            artworkCmd.Parameters.AddWithValue("@createdBy", artwork["created_by"].ToString());

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

            // FIllup comments
            var commentsCmd = new SqlCommand("SELECT TOP 16 * FROM artwork_comments_tbl LEFT JOIN users_tbl ON artwork_comments_tbl.created_by=users_tbl.user_guid WHERE artwork_guid=@artworkGuid ORDER BY created_at DESC", Helpers.Database.Connect());
            commentsCmd.Parameters.AddWithValue("@artworkGuid", artwork["artwork_guid"].ToString());

            var commentsReader = commentsCmd.ExecuteReader();
            while (commentsReader.Read())
            {
                var comment = new Dictionary<string, object>();
                for (int lp = 0; lp < commentsReader.FieldCount; lp++)
                {
                    comment.Add(commentsReader.GetName(lp), commentsReader.GetValue(lp));
                }

                comments.Add(comment);
            }

            // Do user specific tasks
            if (user == null) return;
            if (artwork["user_guid"].ToString() == user["user_guid"].ToString()) isOwnArtwork = true;
        }

        protected void AddCommentBtn_Click(object sender, EventArgs e)
        {
            var cmd = new SqlCommand("INSERT INTO artwork_comments_tbl (text, created_by, artwork_guid) VALUES (@text, @createdBy, @artworkGuid)", Helpers.Database.Connect());
            cmd.Parameters.AddWithValue("@text", CommentTbx.Text);
            cmd.Parameters.AddWithValue("@createdBy", user["user_guid"]);
            cmd.Parameters.AddWithValue("@artworkGuid", artwork["artwork_guid"]);

            cmd.ExecuteNonQuery();

            Response.Redirect(Request.RawUrl, true);
        }
    }
}