using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace ipt101_gallery_project
{
    public partial class AddWallet : Page
    {
        protected Dictionary<string, object> user;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();
        }

        protected void OneHundredCashInBtn_Click(object sender, EventArgs e)
        {
            Helpers.Paymongo.CreateTransaction(10000, PaymentMethods.Text, (string)user["user_guid"]);
        }

        protected void TwoHundredCashInBtn_Click(object sender, EventArgs e)
        {
            Helpers.Paymongo.CreateTransaction(20000, PaymentMethods.Text, (string)user["user_guid"]);
        }

        protected void ThreeHundredCashInBtn_Click(object sender, EventArgs e)
        {
            Helpers.Paymongo.CreateTransaction(30000, PaymentMethods.Text, (string)user["user_guid"]);
        }

        protected void FiveHundredCashInBtn_Click(object sender, EventArgs e)
        {
            Helpers.Paymongo.CreateTransaction(50000, PaymentMethods.Text, (string)user["user_guid"]);
        }

        protected void OneThousandCashInBtn_Click(object sender, EventArgs e)
        {
            Helpers.Paymongo.CreateTransaction(100000, PaymentMethods.Text, (string)user["user_guid"]);
        }

        protected void CustomCashInBtn_Click(object sender, EventArgs e)
        {
            int amount = ((int)((double)Double.Parse(CustomCashInTbx.Text) * 100));
            System.Diagnostics.Debug.Write(PaymentMethods.Text);
            Helpers.Paymongo.CreateTransaction(amount, PaymentMethods.Text, (string)user["user_guid"]);
        }
    }
}