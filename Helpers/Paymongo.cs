using System;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using System.Web;
using System.Net.Http;
using Newtonsoft.Json;
using System.Text;
using System.Threading.Tasks;
using RestSharp;
using System.Net;
using Microsoft.Data.SqlClient;


namespace ipt101_gallery_project.Helpers
{
    public class Paymongo
    {
        public static string API_URL = "https://api.paymongo.com/v1";
        public static string PUBLIC_KEY = "pk_test_ZcejTevLg2PTxctmgGDL5jwD";
        public static string SECRET_KEY = "sk_test_9WQaf5ZzCGo4Ptps3UiTLm3G";
        public static string SK_BASE64 = Strings.Base64Encode(SECRET_KEY);
        public static RestClient client = new RestClient($"{API_URL}");

        public static Guid CreatePaymongoPayments(string created_by)
        {
            var payment_Guid = Guid.NewGuid();

            SqlConnection connection = Database.Connect();
            string query = $"INSERT INTO paymongo_payments_tbl" +
                $"(" +
                $"guid," +
                $"created_by" +
                $") VALUES (" +
                $"'{payment_Guid}'," +
                $"'{created_by}'" +
                $")";

            SqlCommand cmd = new SqlCommand(query, connection);
            cmd.ExecuteNonQuery();

            return payment_Guid;
        }

        // This currently only support paymaya payment intent. Unfinished.
        public static async void CreateTransactionPaymentIntent(int amount, string created_by)
        {
            // var payment_Guid = CreatePaymongoPayments(created_by);

            var host = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);
            var paymentIntentBody = new
            {
                data = new
                {
                    attributes = new
                    {
                        amount,
                        currency = "PHP",
                        payment_method_allowed = new string[]{
                            "card", "paymaya"
                        },
                        payment_method_options = new {
                            card = new
                            {
                                request_three_d_secure = "any"
                            }
                        },
                        capture_type = "automatic"
                    }
                }
            };

            var paymentIntentRequest = new RestRequest("payment_intents");
            paymentIntentRequest.AddJsonBody(paymentIntentBody);
            paymentIntentRequest.AddHeader("Authorization", "Basic " + SK_BASE64);
            var paymentIntentResponse = await client.ExecutePostAsync(paymentIntentRequest);
            var paymentIntent = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, object>>>(paymentIntentResponse.Content);
            System.Diagnostics.Debug.WriteLine(paymentIntentResponse.Content);

            // Create payment method
            var paymentMethodRequest = new RestRequest("payment_methods");
            paymentMethodRequest.AddHeader("Authorization", "Basic " + SK_BASE64);
            var paymentMethodResponse = await client.ExecutePostAsync(paymentMethodRequest);
            var paymentMethod = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, object>>>(paymentMethodResponse.Content);
            System.Diagnostics.Debug.WriteLine(paymentMethodResponse.Content);
        }
        public static async void CreateTransaction(int amount, string source_type, string created_by)
        {
            if (source_type == "payment_intent")
            {
                CreateTransactionPaymentIntent(amount, created_by);
                return;
            }

            try
            {
                var payment_Guid = CreatePaymongoPayments(created_by);

                var host = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);
                var sourceBody = new
                {
                    data = new
                    {
                        attributes = new
                        {
                            amount = amount,
                            currency = "PHP",
                            type = source_type,
                            redirect = new
                            {
                                failed = host + "/PaymongoPayment?status=failed",
                                success = host + $"/PaymongoPayment?status=success&paymentGuid={payment_Guid}"
                            }
                        }
                    }
                };

                var sourceRequest = new RestRequest("sources");
                sourceRequest.AddJsonBody(sourceBody);
                sourceRequest.AddHeader("Authorization", "Basic " + SK_BASE64);
                var sourceResponse = await client.ExecutePostAsync(sourceRequest);
                var source = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, object>>>(sourceResponse.Content);
                string sourceId = source["data"]["id"].ToString();
                var sourceAttributes = ((JObject)source["data"]["attributes"]).ToObject<Dictionary<string, object>>();
                var sourceAttributesRedirect = ((JObject)sourceAttributes["redirect"]).ToObject<Dictionary<string, object>>();
                string checkoutUrl = (string)sourceAttributesRedirect["checkout_url"];

                var paymentBody = new
                {
                    data = new
                    {
                        attributes = new
                        {
                            type = source_type,
                            amount = amount,
                            currency = "PHP",
                            source = new
                            {
                                id = sourceId,
                                type = "source"
                            }
                        }
                    }
                };

                var paymentRequest = new RestRequest("payments");
                paymentRequest.AddJsonBody(paymentBody);

                paymentRequest.AddHeader("Authorization", "Basic " + SK_BASE64);
                var paymentResponse = await client.ExecutePostAsync(sourceRequest);
                var payment = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, object>>>(paymentResponse.Content);
                string paymentId = payment["data"]["id"].ToString();
                SqlConnection connection2 = Database.Connect();

                string query2 = $"UPDATE paymongo_payments_tbl SET " +
                    $"source_id='{sourceId}'," +
                    $"payment_id='{paymentId}'," +
                    $"amount='{amount}'," +
                    $"source_type='{source_type}'," +
                    $"checkout_url='{checkoutUrl}' " +
                    $"WHERE guid='{payment_Guid}'";
                SqlCommand cmd2 = new SqlCommand(query2, connection2);

                cmd2.ExecuteNonQuery();

                HttpContext.Current.Response.Redirect(checkoutUrl, false);
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            catch (Exception error)
            {
                System.Diagnostics.Debug.WriteLine(error.Message);
                throw error;
            }
        }
    }
}