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
using System.Net.Mail;
using System.IO;

namespace NMH_HspPortal.Hsp
{
    public partial class ClaimsReceived : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfProviderId.Value = Request.QueryString["pid"].ToString();
                lblProvider.InnerText = Request.QueryString["pname"].ToString();
            }
        }

        protected void claimsGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Queries")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/Hsp/ClaimsQueries.aspx?adviceBatchNo=" + item["ID"].Text + "&pid=" + hfProviderId.Value + "&pname=" + lblProvider.InnerText);
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

        protected void btnSendQuery_Click(object sender, EventArgs e)
        {
            SendMail(txtBatchNo.Text);
            //using (SqlConnection connection = new SqlConnection(connectionString))
            //{
            //    string query = "insert into tblQueries(batchno,querymsg,hspofficer) values(@batchno,@querymsg,@hspofficer)";
            //    using (SqlCommand command = new SqlCommand(query, connection))
            //    {
            //        command.Parameters.Add("@batchno", SqlDbType.VarChar).Value = txtBatchNo.Text;
            //        command.Parameters.Add("@querymsg", SqlDbType.VarChar).Value = txtQuery.Text;
            //        command.Parameters.Add("@hspofficer", SqlDbType.VarChar).Value = User.Identity.Name;
            //        try
            //        {
            //            connection.Open();
            //            rows = command.ExecuteNonQuery();
            //            if (rows == 1)
            //            {
            //                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
            //                sendEmail(txtBatchNo.Text, txtQuery.Text);
            //                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "closeQueryModal();", true);    
            //            }
            //        }
            //        catch (Exception ex)
            //        {
            //            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            //        }  
            //    }
            //}
        }

        //protected void btnQuery_Click(object sender, EventArgs e)
        //{
        //    if (claimsGrid.SelectedItems.Count < 1)
        //    {
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('No Batch Selected', 'Error');", true);
        //        return;
        //    }

        //    txtBatchNo.Text = claimsGrid.SelectedValue.ToString();
        //    txtQuery.Text = "";
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showQueryModal();", true);
        //}
        protected void sendEmail(string batchNo, string querymsg)
        {
            try
            {
                string mailSubject = "HSP Query on " + batchNo;
                string message = querymsg;
                MailMessage myMessage = new MailMessage();
                myMessage.From = (new MailAddress("hsp@nmiapps.com", "HSP Officer"));
                myMessage.To.Add(new MailAddress("dbwiredu@nationwidemh.com"));
                myMessage.Subject = mailSubject;
                myMessage.Body = message;
                myMessage.IsBodyHtml = true;
                SmtpClient mySmtpClient = new SmtpClient();
                mySmtpClient.Send(myMessage);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mailsuccess", "toastr.success('Email Sent Successfully', 'Success');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mailerror", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
        }
        protected void SendMail(string batchno)
        {
            try
            {
                GridView objGV = new GridView();
                objGV.AutoGenerateColumns = false;
                BoundField field = new BoundField();
                field.HeaderText = "ClaimsNo";
                field.DataField = "ClaimsNo";
                objGV.Columns.Add(field);
                BoundField field2 = new BoundField();
                field2.HeaderText = "TariffName";
                field2.DataField = "TariffName";
                objGV.Columns.Add(field2);

                SqlConnection sqlConnection = new SqlConnection();
                sqlConnection.ConnectionString = connectionString; //Connection Details   
                                                                   //select fields to mail example student details   
                SqlCommand sqlCommand = new SqlCommand("select ClaimsNo, TariffName from Vw_AdviceSlip_Outcome where claimsno='NMH02490002881QJ17'", sqlConnection); //select query command  
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
                sqlDataAdapter.SelectCommand = sqlCommand; //add selected rows to sql data adapter  
                DataSet dataSetStud = new DataSet(); //create new data set  
                sqlConnection.Open();
                sqlDataAdapter.Fill(dataSetStud);

                objGV.DataSource = dataSetStud;
                objGV.DataBind();


                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        objGV.RenderControl(hw);
                        StringReader sr = new StringReader(sw.ToString());
                        string mailSubject = "HSP Query on " + batchno;
                        MailMessage myMessage = new MailMessage();
                        myMessage.From = (new MailAddress("hsp@nmiapps.com", "HSP Officer"));
                        myMessage.To.Add(new MailAddress("dbwiredu@nationwidemh.com"));
                        myMessage.Subject = mailSubject;
                        myMessage.Body = sw.ToString();
                        myMessage.IsBodyHtml = true;
                        SmtpClient mySmtpClient = new SmtpClient();
                        mySmtpClient.Send(myMessage);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "mailsuccess", "toastr.success('Email Sent Successfully', 'Success');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mailerror", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
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
                                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Sorry, a batch that is not awarded cannot be approved for payment')", true);
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
            //else
            //{
            //    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked NO!')", true);
            //}      
        }
    }
}