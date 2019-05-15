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
    public partial class HSPOfficers : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            hspGrid.Rebind();
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            hspGrid.MasterTableView.ExportToExcel();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!User.IsInRole("Admin"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Sorry, you do not have privilege to execute this command', 'Error');", true);
                return;
            }
            string query = "insert into tblUsers(username,userpassword,email,userrole) values(@username,@userpassword,@email,@userrole)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@username", SqlDbType.VarChar).Value = txtUsername.Text;
                    command.Parameters.Add("@userpassword", SqlDbType.VarChar).Value = txtPassword.Text;
                    command.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail.Text;
                    command.Parameters.Add("@userrole", SqlDbType.VarChar).Value = dlRole.SelectedText;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            txtUsername.Text = "";
                            txtEmail.Text = "";
                            hspGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }           
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!User.IsInRole("Admin"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Sorry, you do not have privilege to execute this command', 'Error');", true);
                return;
            }
            string query = "update tblUsers set username=@username,userpassword=@userpassword,email=@email,userrole=@userrole where userid=@userid";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@username", SqlDbType.VarChar).Value = txtUsername1.Text;
                    command.Parameters.Add("@userpassword", SqlDbType.VarChar).Value = txtPassword1.Text;
                    command.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail1.Text;
                    command.Parameters.Add("@userrole", SqlDbType.VarChar).Value = dlRole1.SelectedText;
                    command.Parameters.Add("@userid", SqlDbType.Int).Value = ViewState["UserId"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                            hspGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void hspGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["UserId"] = item["UserID"].Text;
                txtUsername1.Text = item["UserName"].Text;
                //txtPassword1.Text = item["UserPassword"].Text;
                txtEmail1.Text = item["Email"].Text;
                dlRole1.SelectedText = item["UserRole"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "editModal();", true);
                e.Canceled = true;
            }
        }
    }
}