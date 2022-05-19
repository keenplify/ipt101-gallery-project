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
    public partial class Message : Page
    {
        protected Dictionary<string, object> user;
        protected Dictionary<string, object> to;
        protected List<Dictionary<string, object>> messages = new List<Dictionary<string, object>>();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            if (Request.QueryString["to_guid"] == null) return;

            using (var conn = Helpers.Database.Connect())
            {
                var toCmd = new SqlCommand("SELECT * FROM users_tbl WHERE user_guid=@userGuid", conn);
                toCmd.Parameters.AddWithValue("@userGuid", Request.QueryString["to_guid"]);
                var toReader = toCmd.ExecuteReader();
                while (toReader.Read())
                {
                    to = new Dictionary<string, object>();
                    //Convert reader to dictionary
                    for (int lp = 0; lp < toReader.FieldCount; lp++)
                    {
                        to.Add(toReader.GetName(lp), toReader.GetValue(lp));
                    }
                }
            }

            if (to == null) return;

            using (var conn = Helpers.Database.Connect())
            {
                var messagesCmd = new SqlCommand("SELECT * FROM messages_tbl WHERE (created_by=@createdBy AND to_guid=@toGuid) OR (to_guid=@createdBy AND created_by=@toGuid) ORDER BY created_at ASC", conn);
                messagesCmd.Parameters.AddWithValue("@createdBy", user["user_guid"]);
                messagesCmd.Parameters.AddWithValue("@toGuid", to["user_guid"]);

                var messagesReader = messagesCmd.ExecuteReader();
                while (messagesReader.Read())
                {
                    var message = new Dictionary<string, object>();
                    //Convert reader to dictionary
                    for (int lp = 0; lp < messagesReader.FieldCount; lp++)
                    {
                        message.Add(messagesReader.GetName(lp), messagesReader.GetValue(lp));
                    }
                    messages.Add(message);
                }
            }
        }

        protected void SendMessageBtn_Click(object sender, EventArgs e)
        {
            using (var connection = Helpers.Database.Connect())
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO messages_tbl (text, created_by, to_guid) VALUES (@text, @createdBy, @toGuid)", connection);
                cmd.Parameters.AddWithValue("@text", MessageTbx.Text);
                cmd.Parameters.AddWithValue("@createdBy", user["user_guid"]);
                cmd.Parameters.AddWithValue("@toGuid", to["user_guid"]);

                cmd.ExecuteNonQuery();
            }

            Response.Redirect(Request.RawUrl, true);

        }
    }
}