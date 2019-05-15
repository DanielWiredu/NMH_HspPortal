using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using Telerik.Web.UI;

namespace NMH_HspPortal.Hsp
{
    public partial class ClaimsReceivedByStatusToday : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["batchStatusId"] = Request.QueryString["batchStatusId"].ToString();
            }
        }

        protected void claimsGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Queries")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/Hsp/ClaimsQueriesByStatusToday.aspx?adviceBatchNo=" + item["BatchNo"].Text + "&pname=" + item["ServiceProvider"].Text + "&batchStatusId=" + ViewState["batchStatusId"].ToString());
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            claimsGrid.Rebind();
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            claimsGrid.MasterTableView.ExportToExcel();
        }

        protected void btnTracker_Click(object sender, EventArgs e)
        {
            if (claimsGrid.SelectedItems.Count < 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('No Batch Selected', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string batchNo = claimsGrid.SelectedValue.ToString();
                    string selectquery = "select batchno, username, datestamp, status from Vw_Batch_Status_Info where batchno = @batchno order by datestamp";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    adapter.SelectCommand.Parameters.Add("@batchno", SqlDbType.VarChar).Value = batchNo;
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvTracker.DataSource = dTable;
                        lvTracker.DataBind();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showTrackerModal();", true);
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnAwards_Click(object sender, EventArgs e)
        {
            if (claimsGrid.SelectedItems.Count < 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('No Batch Selected', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string batchNo = claimsGrid.SelectedValue.ToString();
                    string selectquery = "select batchno, claimed, awarded, claimed-awarded as advice, withholdingrate, withold, amountdue, awarddate, case status when 1 then 'Active' else 'Inactive' end as status from ClaimsAwards where batchno = @batchno order by status";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    adapter.SelectCommand.Parameters.Add("@batchno", SqlDbType.VarChar).Value = batchNo;
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvAwards.DataSource = dTable;
                        lvAwards.DataBind();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showAwardsModal();", true);
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnPayments_Click(object sender, EventArgs e)
        {
            if (claimsGrid.SelectedItems.Count < 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('No Batch Selected', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string batchNo = claimsGrid.SelectedValue.ToString();
                    string selectquery = "select batchno, chequeno, chequedate, chequeamount, datestamp, bank, case paystatus when 2 then 'Active' else 'Inactive' end as status from Vw_ClaimsPayments_HSP where batchno = @batchno order by status";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    adapter.SelectCommand.Parameters.Add("@batchno", SqlDbType.VarChar).Value = batchNo;
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvPayments.DataSource = dTable;
                        lvPayments.DataBind();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showPaymentsModal();", true);
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnAdviceSlip_Click(object sender, EventArgs e)
        {
            if (claimsGrid.SelectedItems.Count < 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('No Batch Selected', 'Error');", true);
                return;
            }
            if (Cache["rptAdviceSlip"] != null)
                Cache.Remove("rptAdviceSlip");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/vwAdviceSlip.aspx?rptBatchNo=" + claimsGrid.SelectedValue.ToString() + "');", true);
        }

        protected void btnApproveForPayment_Click(object sender, EventArgs e)
        {
            if (claimsGrid.SelectedItems.Count < 1)
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('No Batch Selected', 'Error');", true);
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('No Batch Selected')", true);
                return;
            }
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                string NmiUserId = Request.Cookies.Get("NmiUserId").Value;
                string batchNo = claimsGrid.SelectedValue.ToString();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand("spApproveBatchForPayment", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@batchNo", SqlDbType.Int).Value = batchNo;
                        command.Parameters.Add("@NmiUserId", SqlDbType.Int).Value = NmiUserId;
                        command.Parameters.Add("@Username", SqlDbType.VarChar).Value = User.Identity.Name;
                        command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                        try
                        {
                            connection.Open();
                            command.ExecuteNonQuery();
                            int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                            if (retVal == 0)
                            {
                                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Approved for Payment Successfully')", true);
                                claimsGrid.Rebind();
                            }
                            else if (retVal == -1)
                            {
                                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Sorry, a batch that is not at Awarded stage cannot be approved for payment')", true);
                                //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Sorry, a batch that is not awarded cannot be approved for payment', 'Error');", true);
                            }
                        }
                        catch (Exception ex)
                        {
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "')", true);
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        }
                    }
                }
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Approved for Payment Successfully', 'Success');", true);
            }
        }
    }
}