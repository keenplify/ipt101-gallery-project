using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ipt101_gallery_project
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            try
            {
                Dictionary<string, object> user = Helpers.User.Login(LoginUsername.Text, LoginPassword.Text);
                Response.Redirect("/");
            }
            catch (InvalidOperationException error)
            {
                lblLoginError.Text = error.Message;
            }
        }

        protected void RegisterBtn_Click(object sender, EventArgs e)
        {
            try
            {
                Helpers.User.Register(regFirstName.Text, regLastName.Text, regLastName.Text, regBirthday.Text, regEmail.Text, regPass.Text);
                Response.Redirect("/");
            }
            catch (InvalidOperationException error)
            {
                lblLoginError.Text = error.Message;
            }
        }
    }
}