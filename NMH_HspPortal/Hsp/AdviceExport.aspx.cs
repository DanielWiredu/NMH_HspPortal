using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace NMH_HspPortal.Hsp
{
    public partial class AdviceExport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            adviceGrid.Rebind();
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            adviceGrid.MasterTableView.ExportToExcel();
        }
    }
}