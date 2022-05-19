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
    public partial class Commission : Page
    {
        protected Dictionary<string, object> user;
        protected List<Dictionary<string, object>> artistCommissions = new List<Dictionary<string, object>>();

        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

            var commissionsCmd = new SqlCommand("SELECT * FROM commissions_tbl LEFT JOIN users_tbl ON commissions_tbl.created_by = users_tbl.user_guid LEFT JOIN (SELECT title AS package_title, price AS package_price, package_guid AS p_guid FROM packages_tbl) packages_tbl ON commissions_tbl.package_guid = packages_tbl.p_guid WHERE artist_guid=@artistGuid", Helpers.Database.Connect());
            commissionsCmd.Parameters.AddWithValue("@artistGuid", user["user_guid"].ToString());

            var commissionsReader = commissionsCmd.ExecuteReader();

            while (commissionsReader.Read())
            {
                var commission = new Dictionary<string, object>();
                for (int lp = 0; lp < commissionsReader.FieldCount; lp++)
                {
                    commission.Add(commissionsReader.GetName(lp), commissionsReader.GetValue(lp));
                }
                artistCommissions.Add(commission);
            }
        }
    }
}