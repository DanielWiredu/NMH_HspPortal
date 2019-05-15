using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using CrystalDecisions.Shared;

namespace NMH_HspPortal.Reports
{
    public partial class vwAdviceSlip : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            string cachedReports = "rptAdviceSlip";
            if (Cache[cachedReports] == null)
            {
                loadReport(cachedReports);
            }
            else
            {
                AdviceSlipReport.ReportSource = Cache[cachedReports];
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loadReport(string cachedReports)
        {
            int rptCacheTimeout = Convert.ToInt32(ConfigurationManager.AppSettings.Get("rptCacheTimeout").ToString());
            rptAdviceSlip rpt = new rptAdviceSlip();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataSet ds = new DataSet();
            string batchno = Request.QueryString["rptBatchNo"].ToString();

            adapter = new SqlDataAdapter("select * from Vw_AdviceSlip_Outcome where (ClaimsBatchNo = @ClaimsBatchNo)", connection);
            adapter.SelectCommand.Parameters.Add("@ClaimsBatchNo", SqlDbType.Int).Value = batchno;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "Vw_AdviceSlip_Outcome");
            rpt.SetDataSource(ds);

            adapter.Dispose();
            connection.Dispose();
            Cache.Insert(cachedReports, rpt, null, DateTime.MaxValue, TimeSpan.FromMinutes(rptCacheTimeout));
            AdviceSlipReport.ReportSource = rpt;
        }
    }
}