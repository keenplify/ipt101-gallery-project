using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace ipt101_gallery_project
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Pay_Click(object sender, EventArgs e)
        {

            var user = Helpers.User.AutoLogin();
            Helpers.Paymongo.CreateTransaction(50050, "gcash", (string)user["user_guid"]);
        }
    }
}