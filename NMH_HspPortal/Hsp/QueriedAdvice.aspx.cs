using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NMH_HspPortal.Hsp
{
    public partial class QueriedAdvice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblBatchNo.InnerText = "Batch No : " + Request.QueryString["adviceBatchNo"].ToString();
            }
        }
    }
}