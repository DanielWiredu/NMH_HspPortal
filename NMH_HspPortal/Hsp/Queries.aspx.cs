using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace NMH_HspPortal.Hsp
{
    public partial class Queries : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            queryGrid.Rebind();
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            queryGrid.MasterTableView.ExportToExcel();
        }

        protected void queryGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                //string QueryMsg = item["QueryMsg"].Text;
                //if (QueryMsg.Length > 90)
                //{
                //    item["QueryMsg"].Text = QueryMsg.Substring(0, 90);
                //    item["QueryMsg"].ToolTip = QueryMsg;
                //}
                string QueryStatus = item["QueryStatus"].Text;
                if (QueryStatus == "Pending")
                {
                    item.BackColor = Color.Pink;
                }
                else if (QueryStatus == "Completed")
                {
                    item.BackColor = Color.GreenYellow;
                }
            }
        }

        protected void queryGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Complete")
            {
                GridDataItem item = e.Item as GridDataItem;
                int queryId = Convert.ToInt32(item["Id"].Text);
                string query = "update tblQueries set QueryStatus='Completed' where Id=@Id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@Id", SqlDbType.Int).Value = queryId;
                        try
                        {
                            connection.Open();
                            int rows = command.ExecuteNonQuery();
                            if (rows == 1)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Completed Successfully', 'Success');", true);
                                queryGrid.Rebind();
                            }
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        }
                    }
                }
            }
            else if (e.CommandName == "QueriedAdvice")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/Hsp/QueriedAdvice.aspx?adviceBatchNo=" + item["BatchNo"].Text);
            }
        }
    }
}