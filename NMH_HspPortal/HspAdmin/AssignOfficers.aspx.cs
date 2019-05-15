using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace NMH_HspPortal.HspAdmin
{
    public partial class AssignOfficers : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            providerGrid.Rebind();
        }

        protected void providerGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Assign")
            {
                GridDataItem item = e.Item as GridDataItem;
                hfProviderId.Value = item["ID"].Text;
                lblServiceProvider.InnerText = item["ServiceProvider"].Text;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "newModal();", true);
                e.Canceled = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "update Vw_ServiceProvider set HspID = @HspID where ID=@Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@HspID", SqlDbType.Int).Value = dlOfficer.SelectedValue;
                        command.Parameters.Add("@Id", SqlDbType.Int).Value = hfProviderId.Value;
                        int rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Officer Assigend Successfully', 'Success');", true);
                            providerGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            providerGrid.MasterTableView.ExportToExcel();
        }
    }
}