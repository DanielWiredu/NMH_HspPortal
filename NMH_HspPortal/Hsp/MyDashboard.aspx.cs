using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace NMH_HspPortal.Hsp
{
    public partial class MyDashboard : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string userid = Request.Cookies.Get("userid").Value;
                loadDashboard(userid);
                loadDashboardToday(userid);
            }
        }
        protected void loadDashboard(string userid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetUserDashboard", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@hspid", SqlDbType.VarChar).Value = userid;
                    command.Parameters.Add("@received", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@medicalvetting", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@awarded", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@senttoaccounts", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@paid", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@approvedforpayment", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@cancelaward", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@paymentcancelled", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        lblReceived.InnerText = Convert.ToInt32(command.Parameters["@received"].Value).ToString("N00");
                        lblMedicalVetting.InnerText = Convert.ToInt32(command.Parameters["@medicalvetting"].Value).ToString("N00");
                        lblAwarded.InnerText = Convert.ToInt32(command.Parameters["@awarded"].Value).ToString("N00");
                        lblSenttoAccounts.InnerText = Convert.ToInt32(command.Parameters["@senttoaccounts"].Value).ToString("N00");
                        lblPaid.InnerText = Convert.ToInt32(command.Parameters["@paid"].Value).ToString("N00");
                        lblApprovedForPayment.InnerText = Convert.ToInt32(command.Parameters["@approvedforpayment"].Value).ToString("N00");
                        lblCancelAward.InnerText = Convert.ToInt32(command.Parameters["@cancelaward"].Value).ToString("N00");
                        lblPaymentCancelled.InnerText = Convert.ToInt32(command.Parameters["@paymentcancelled"].Value).ToString("N00");
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void loadDashboardToday(string userid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetUserDashboardToday", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@hspid", SqlDbType.VarChar).Value = userid;
                    command.Parameters.Add("@received", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@medicalvetting", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@awarded", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@senttoaccounts", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@paid", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@approvedforpayment", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@cancelaward", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@paymentcancelled", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        lblReceivedToday.InnerText = Convert.ToInt32(command.Parameters["@received"].Value).ToString("N00");
                        lblMedicalVettingToday.InnerText = Convert.ToInt32(command.Parameters["@medicalvetting"].Value).ToString("N00");
                        lblAwardedToday.InnerText = Convert.ToInt32(command.Parameters["@awarded"].Value).ToString("N00");
                        lblSenttoAccountsToday.InnerText = Convert.ToInt32(command.Parameters["@senttoaccounts"].Value).ToString("N00");
                        lblPaidToday.InnerText = Convert.ToInt32(command.Parameters["@paid"].Value).ToString("N00");
                        lblApprovedForPaymentToday.InnerText = Convert.ToInt32(command.Parameters["@approvedforpayment"].Value).ToString("N00");
                        lblCancelAwardToday.InnerText = Convert.ToInt32(command.Parameters["@cancelaward"].Value).ToString("N00");
                        lblPaymentCancelledToday.InnerText = Convert.ToInt32(command.Parameters["@paymentcancelled"].Value).ToString("N00");
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }


        protected void lkMedicalVetting_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatus.aspx?batchStatusId=28");
        }

        protected void lkAwarded_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatus.aspx?batchStatusId=1");
        }

        protected void lkSenttoAccounts_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatus.aspx?batchStatusId=18");
        }

        protected void lkPaid_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatus.aspx?batchStatusId=2");
        }

        protected void lkReceived_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatus.aspx?batchStatusId=3,23");
        }

        protected void lkApprovedForPayment_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatus.aspx?batchStatusId=33");
        }

        protected void lkCancelAward_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatus.aspx?batchStatusId=4");
        }

        protected void lkPaymentCancelled_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatus.aspx?batchStatusId=8");
        }
        protected void lkMedicalVettingToday_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatusToday.aspx?batchStatusId=28");
        }

        protected void lkAwardedToday_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatusToday.aspx?batchStatusId=1");
        }

        protected void lkSenttoAccountsToday_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatusToday.aspx?batchStatusId=18");
        }

        protected void lkPaidToday_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatusToday.aspx?batchStatusId=2");
        }

        protected void lkReceivedToday_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatusToday.aspx?batchStatusId=3,23");
        }

        protected void lkApprovedForPaymentToday_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatusToday.aspx?batchStatusId=33");
        }

        protected void lkCancelAwardToday_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatusToday.aspx?batchStatusId=4");
        }

        protected void lkPaymentCancelledToday_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatusToday.aspx?batchStatusId=8");
        }
    }
}