using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Data.SqlClient;

namespace ipt101_gallery_project
{
    public partial class PaymongoPayment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["status"]) && !String.IsNullOrEmpty(Request.QueryString["paymentGuid"]))
            {

                // SELECT PAYMENT ROW
                SqlConnection payment_connection = Helpers.Database.Connect();

                string payment_query = $"SELECT * FROM paymongo_payments_tbl WHERE guid='{Request.QueryString["paymentGuid"]}'";
            System.Diagnostics.Debug.WriteLine(payment_query);

                SqlCommand payment_cmd = new SqlCommand(payment_query, payment_connection);
                var payment_reader = payment_cmd.ExecuteReader();

                payment_reader.Read();

                //Convert reader to dictionary
                Dictionary<string, object> payment = new Dictionary<string, object>();
                for (int lp = 0; lp < payment_reader.FieldCount; lp++)
                {
                    payment.Add(payment_reader.GetName(lp), payment_reader.GetValue(lp));
                }

                // UPDATE PAYMENTS TBL
                SqlConnection _connection = Helpers.Database.Connect();

                string _query = $"UPDATE paymongo_payments_tbl SET " +
                    $"is_success=1 " +
                    $"WHERE guid='{Request.QueryString["paymentGuid"]}'";
                SqlCommand _cmd = new SqlCommand(_query, _connection);

                _cmd.ExecuteNonQuery();


                
                // UPDATE USER
                SqlConnection user_connection = Helpers.Database.Connect();

                string user_query = $"UPDATE users_tbl SET " +
                    $"wallet=wallet + {(decimal)((int)payment["amount"])} " +
                    $"WHERE user_guid='{payment["created_by"]}'";
                SqlCommand user_cmd = new SqlCommand(user_query, user_connection);

                user_cmd.ExecuteNonQuery();

            }

            Response.Redirect("~/");
        }
    }
}