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
    public partial class AddWallet : Page
    {
        protected Dictionary<string, object> user;
        protected List<Dictionary<string, object>> cashouts = new List<Dictionary<string, object>>();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            CashOutAmountTbx.Attributes["max"] = ((double)((int)user["wallet"]) / 100).ToString();

            var connection = Helpers.Database.Connect();
            string query = $"SELECT * FROM cashouts_tbl WHERE user_guid='{user["user_guid"]}'";
            var cmd = new SqlCommand(query, connection);
            
            var reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                //Convert reader to dictionary
                Dictionary<string, object> cashout = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    cashout.Add(reader.GetName(lp), reader.GetValue(lp));
                }
                cashouts.Add(cashout);
            }
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
            Helpers.Paymongo.CreateTransaction(amount, PaymentMethods.Text, (string)user["user_guid"]);
        }
        protected void CashOutBtn_Click(object sender, EventArgs e)
        {
            if (CashOutAccountNameTbx.Text.Length <= 0)
            {
                CashOutErr.Text = "Account name is required!";
                return;
            }

            if (CashOutAccountNumberTbx.Text.Length <= 0)
            {
                CashOutErr.Text = "Account number is required!";
                return;
            }

            if (CashOutTypeRbl.Text.Length <= 0)
            {
                CashOutErr.Text = "Cashout type is required!";
                return;
            }

            if (CashOutAmountTbx.Text.Length <= 0)
            {
                CashOutErr.Text = "Cashout amount is required!";
                return;
            }


            var connection = Helpers.Database.Connect();
            int amountInput = int.Parse(CashOutAmountTbx.Text);
            int amount = (int)((amountInput - (double)(amountInput * 0.02)) * 100);
            string query = $"INSERT INTO cashouts_tbl (" +
                $"phone_number," +
                $"account_name," +
                $"type," +
                $"amount," +
                $"user_guid" +
                $") VALUES (" +
                $"'{CashOutAccountNumberTbx.Text}'," +
                $"'{CashOutAccountNameTbx.Text}'," +
                $"'{CashOutTypeRbl.Text}'," +
                $"'{amount}'," +
                $"'{user["user_guid"]}'" +
                $")";
            var cmd = new SqlCommand(query, connection);

            cmd.ExecuteNonQuery();

            connection.Close();

            var connection2 = Helpers.Database.Connect();

            string query2 = $"UPDATE users_tbl " +
                $"SET wallet=wallet-{amountInput * 100} " +
                $"WHERE user_guid='{user["user_guid"]}'";
            var cmd2 = new SqlCommand(query2, connection2);

            cmd2.ExecuteNonQuery();

            user = Helpers.User.AutoLogin();
            Response.Redirect(Request.Url.ToString(), true);
        }
    }
}