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
    public partial class AddArtwork : Page
    {
        protected Dictionary<string, object> user;
        protected Dictionary<string, object> package;
        protected string package_guid;

        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutoLogin();

        }
    }
}