using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;

namespace NMH_HspPortal.Hsp
{
    public partial class ClaimsQueriesByStatus : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["batchStatusId"] = Request.QueryString["batchStatusId"].ToString();
                ViewState["pname"] = Request.QueryString["pname"].ToString();
                ViewState["adviceBatchNo"] = Request.QueryString["adviceBatchNo"].ToString();
                lblBatchNo.InnerText = "Batch No : " + ViewState["adviceBatchNo"].ToString() + ",   Provider : " + ViewState["pname"].ToString();

            }
        }
        protected void btnSaveComment_Click(object sender, EventArgs e)
        {
            string query = "update Vw_AdviceSlip_Outcome set HspQuery=@HspQuery where RowID=@RowID";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@HspQuery", SqlDbType.VarChar).Value = txtComment.Text;
                        command.Parameters.Add("@RowID", SqlDbType.Int).Value = Convert.ToInt32(hfAdviceID.Value);
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            grdAdvice.Rebind();
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

        protected void grdAdvice_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Comment")
            {
                GridDataItem item = e.Item as GridDataItem;
                hfAdviceID.Value = item["RowID"].Text;
                txtComment.Text = item["HspQuery"].Text;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "newModal();", true);
            }
        }

        protected void btnSendQuery_Click(object sender, EventArgs e)
        {
            if (!SendMail(ViewState["adviceBatchNo"].ToString()))
                return;

            string hspofficerid = Request.Cookies.Get("hspofficerid").Value;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "insert into tblQueries(batchno,serviceprovider,hspofficerid) values(@batchno,@serviceprovider,@hspofficerid)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@batchno", SqlDbType.VarChar).Value = ViewState["adviceBatchNo"].ToString();
                    command.Parameters.Add("@serviceprovider", SqlDbType.VarChar).Value = ViewState["pname"].ToString();
                    command.Parameters.Add("@hspofficerid", SqlDbType.Int).Value = Convert.ToInt32(hspofficerid);
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
        protected bool SendMail(string batchno)
        {
            bool mailSent = false;
            try
            {
                GridView objGV = new GridView();
                objGV.AutoGenerateColumns = false;
                BoundField bfClaimno = new BoundField();
                bfClaimno.HeaderText = "ClaimsNo";
                bfClaimno.DataField = "ClaimsNo";
                objGV.Columns.Add(bfClaimno);
                BoundField bfDateofAttendance = new BoundField();
                bfDateofAttendance.HeaderText = "DateOfAttendance";
                bfDateofAttendance.DataField = "DateOfAttendance";
                bfDateofAttendance.DataFormatString = "{0:dd-MMM-yyyy}";
                objGV.Columns.Add(bfDateofAttendance);
                BoundField bfDiagnosis = new BoundField();
                bfDiagnosis.HeaderText = "Diagnosis";
                bfDiagnosis.DataField = "Diagnosis";
                objGV.Columns.Add(bfDiagnosis);
                BoundField bfTariff = new BoundField();
                bfTariff.HeaderText = "TariffName";
                bfTariff.DataField = "TariffName";
                objGV.Columns.Add(bfTariff);
                BoundField bfClaimed = new BoundField();
                bfClaimed.HeaderText = "Claimed";
                bfClaimed.DataField = "Claimed";
                objGV.Columns.Add(bfClaimed);
                BoundField bfApproved = new BoundField();
                bfApproved.HeaderText = "Approved";
                bfApproved.DataField = "ApprovedAmount";
                objGV.Columns.Add(bfApproved);
                BoundField bfRejComment = new BoundField();
                bfRejComment.HeaderText = "Rejection Comment";
                bfRejComment.DataField = "Tariff_X_RejectionComments";
                objGV.Columns.Add(bfRejComment);
                BoundField bfQuery = new BoundField();
                bfQuery.HeaderText = "HSP Query";
                bfQuery.DataField = "HspQuery";
                objGV.Columns.Add(bfQuery);

                SqlConnection sqlConnection = new SqlConnection();
                sqlConnection.ConnectionString = connectionString; //Connection Details   
                                                                   //select fields to mail example student details   
                SqlCommand sqlCommand = new SqlCommand("select ClaimsNo, DateOfAttendance, TariffName, Diagnosis, Claimed, ApprovedAmount, Tariff_X_RejectionComments, HspQuery from Vw_AdviceSlip_Outcome where claimsbatchno = '" + batchno + "' and hspquery is not null", sqlConnection); //select query command  
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
                sqlDataAdapter.SelectCommand = sqlCommand; //add selected rows to sql data adapter  
                DataSet dataSetStud = new DataSet(); //create new data set  
                sqlConnection.Open();
                sqlDataAdapter.Fill(dataSetStud);

                if (dataSetStud.Tables[0].Rows.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "noquery", "toastr.warning('No query on this batch', 'Not Sent');", true);
                    return false;
                }

                objGV.DataSource = dataSetStud;
                objGV.DataBind();

                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        objGV.RenderControl(hw);
                        StringReader sr = new StringReader(sw.ToString());
                        string mailSubject = User.Identity.Name + " Query on " + batchno;
                        MailMessage myMessage = new MailMessage();
                        myMessage.From = (new MailAddress("hsp@nmiapps.com", "HSP Officer"));
                        myMessage.To.Add(new MailAddress("ellis@nationwidemh.com"));
                        myMessage.To.Add(new MailAddress("dbwiredu@nationwidemh.com"));
                        myMessage.Subject = mailSubject;
                        myMessage.Body = "Queries on " + batchno + " - " + ViewState["pname"].ToString() + sw.ToString();
                        myMessage.IsBodyHtml = true;
                        SmtpClient mySmtpClient = new SmtpClient();
                        mySmtpClient.Send(myMessage);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "mailsuccess", "toastr.success('Email Sent Successfully', 'Success');", true);
                        mailSent = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mailerror", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            return mailSent;
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Hsp/ClaimsReceivedByStatus.aspx?batchStatusId=" + ViewState["batchStatusId"].ToString());
        }
    }
}