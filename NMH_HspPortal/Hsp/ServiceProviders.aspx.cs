using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace NMH_HspPortal.Hsp
{
    public partial class ServiceProviders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            providerGrid.Rebind();
        }

        protected void providerGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Claims")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/HSP/ClaimsReceived.aspx?pid=" + item["ID"].Text + "&pname=" + item["ServiceProvider"].Text);
            }
        }
    }
}