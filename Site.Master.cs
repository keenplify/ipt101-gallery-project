using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project
{
    public partial class SiteMaster : MasterPage
    {
        protected Dictionary<string, object> user;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin(false);
            errorLbl.Text = "";

            if (user == null) return;

            if (!IsPostBack)
            {
                changeFirstNameTbx.Text = user["firstName"].ToString();
                changeMiddleNameTbx.Text = user["middleName"].ToString();
                changeLastNameTbx.Text = user["lastName"].ToString();
                changeBirthdayTbx.Text = DateTime.Parse(user["birthday"].ToString()).ToString("yyyy-MM-dd");
            }
        }

        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            Helpers.User.Logout();
            Response.Redirect(Request.RawUrl, true);
        }

        protected void SubmitSearchPnl_Click(object sender, EventArgs e)
        {
            Response.Redirect("Search?keyword=" + SearchTbx.Text);
        }

        protected void ChangePasswordBtn_Click(object sender, EventArgs e)
        {
            if (PasswordTbx.Text != ConfirmPasswordTbx.Text) errorLbl.Text += "Password is not the same!\n";
            if (PasswordTbx.Text.Length == 0) errorLbl.Text += "Password is required! \n";
            if (ConfirmPasswordTbx.Text.Length == 0) errorLbl.Text += "Confirm Password is required! \n";

            if (errorLbl.Text.Length > 0) return;

            using (var connection = Helpers.Database.Connect())
            {
                var cmd = new SqlCommand("UPDATE users_tbl SET password_hash=@password WHERE user_guid=@userGuid", connection);
                cmd.Parameters.AddWithValue("@password", BCrypt.Net.BCrypt.HashPassword(PasswordTbx.Text, 10));
                cmd.Parameters.AddWithValue("@userGuid", user["user_guid"]);

                cmd.ExecuteNonQuery();

                Helpers.User.Logout();
                Response.Redirect(Request.RawUrl, true);
            }
        }

        protected void ChangeUserInfoBtn_Click(object sender, EventArgs e)
        {
            if (changeFirstNameTbx.Text.Length == 0 ) errorLbl.Text += "First Name is required! \n";
            if (changeMiddleNameTbx.Text.Length == 0) errorLbl.Text += "Middle Name is required! \n";
            if (changeLastNameTbx.Text.Length == 0) errorLbl.Text += "Last Name is required! \n";
            if (changeBirthdayTbx.Text.Length == 0) errorLbl.Text += "Birthday is required! \n";

            if (errorLbl.Text.Length > 0) return;

            using (var connection = Helpers.Database.Connect())
            {
                var cmd = new SqlCommand("UPDATE users_tbl SET firstName=@firstName, middleName=@middleName, lastName=@lastName, birthday=@birthday WHERE user_guid=@userGuid", connection);
                cmd.Parameters.AddWithValue("@firstName", changeFirstNameTbx.Text);
                cmd.Parameters.AddWithValue("@middleName", changeMiddleNameTbx.Text);
                cmd.Parameters.AddWithValue("@lastName", changeLastNameTbx.Text);
                cmd.Parameters.AddWithValue("@birthday", DateTime.Parse(changeBirthdayTbx.Text));


                cmd.Parameters.AddWithValue("@userGuid", user["user_guid"]);

                cmd.ExecuteNonQuery();

                Response.Redirect(Request.RawUrl, true);
            }
        }

        protected void ChangeAvatarBtn_Click(object sender, EventArgs e)
        {
            if (!ChangeAvatarUpl.HasFile) errorLbl.Text = "Avatar image is required";

            if (errorLbl.Text.Length > 0) return;

            // Save to uploads folder
            string fileName = DateTimeOffset.Now.ToUnixTimeSeconds() + $"-{user["user_guid"]}-avatar" + System.IO.Path.GetExtension(ChangeAvatarUpl.FileName);

            try
            {
                ChangeAvatarUpl.SaveAs(Server.MapPath("~/Uploads/" + fileName));
            }
            catch
            {
                throw;
            }

            using (var connection = Helpers.Database.Connect())
            {
                var cmd = new SqlCommand("UPDATE users_tbl SET avatar_location=@location WHERE user_guid=@userGuid", connection);
                cmd.Parameters.AddWithValue("@location", "/Uploads/" + fileName);
                cmd.Parameters.AddWithValue("@userGuid", user["user_guid"]);

                cmd.ExecuteNonQuery();

                Response.Redirect(Request.RawUrl, true);
            }
        }
    }
}