using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NMH_HspPortal.Hsp
{
    public partial class ServiceProvidersClaimOnMonth : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int year = DateTime.Now.Year;
                for (int i = 2015; i <= year; i++)
                {
                    dlYear.Items.Add(i.ToString());
                }
            }
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            claimsGrid.MasterTableView.ExportToExcel();
        }

        protected void btnRun_Click(object sender, EventArgs e)
        {
            claimsGrid.Rebind();
        }
    }
}