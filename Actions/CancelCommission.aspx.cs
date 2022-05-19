using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Data.SqlClient;
using System.Diagnostics;

namespace ipt101_gallery_project.Actions
{
    public partial class CancelCommission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var user = Helpers.User.AutoLogin();

            if (Request.QueryString["commission_guid"] == null) Response.Redirect("~/MyCommission");
            string artist_guid;
            int price;

            using (var conn = Helpers.Database.Connect())
            {
                try
                {
                    var selectCommissionCmd = new SqlCommand("SELECT * FROM commissions_tbl LEFT JOIN (SELECT package_guid AS p_guid, price FROM packages_tbl)packages_tbl ON commissions_tbl.package_guid = packages_tbl.p_guid WHERE commission_guid=@commissionGuid", conn);
                    selectCommissionCmd.Parameters.AddWithValue("@commissionGuid", Request.QueryString["commission_guid"]);

                    var selectCommissionReader = selectCommissionCmd.ExecuteReader();
                    selectCommissionReader.Read();
                    artist_guid = selectCommissionReader.GetValue(selectCommissionReader.GetOrdinal("artist_guid")).ToString();
                    price = int.Parse(selectCommissionReader.GetValue(selectCommissionReader.GetOrdinal("price")).ToString());

                }
                catch
                {
                    throw;
                }
            }
            Debug.WriteLine(price);

            using (var conn = Helpers.Database.Connect())
            {
                var transaction = conn.BeginTransaction();

                try
                {
                    

                    var updateStatusCmd = new SqlCommand("UPDATE commissions_tbl SET status='CANCELLED' WHERE commission_guid=@commissionGuid", conn, transaction);
                    updateStatusCmd.Parameters.AddWithValue("@commissionGuid", Request.QueryString["commission_guid"]);
                    updateStatusCmd.ExecuteNonQuery();

                    var updateClientCmd = new SqlCommand("UPDATE users_tbl SET wallet = wallet + @amount WHERE user_guid=@userGuid", conn, transaction);
                    updateClientCmd.Parameters.AddWithValue("@userGuid", user["user_guid"]);
                    updateClientCmd.Parameters.AddWithValue("@amount", price);

                    updateClientCmd.ExecuteNonQuery();

                    var updateArtistCmd = new SqlCommand("UPDATE users_tbl SET wallet = wallet - @amount WHERE user_guid=@userGuid", conn, transaction);
                    updateArtistCmd.Parameters.AddWithValue("@userGuid", artist_guid);
                    updateArtistCmd.Parameters.AddWithValue("@amount", price);

                    updateArtistCmd.ExecuteNonQuery();
                }
                catch
                {
                    transaction.Rollback();
                    throw;

                }
                finally
                {
                    transaction.Commit();
                }
            }
            
            

            Response.Redirect("~/MyCommission");
        }
    }
}