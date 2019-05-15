﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Security.Cryptography;

namespace NMH_HspPortal
{
    public partial class Login : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        SqlDataReader reader;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                    // This is an unauthorized, authenticated request...
                    Response.Redirect("/Errors/UnauthorizedAccess.aspx");

                //if (!String.IsNullOrEmpty(Context.User.Identity.Name))
                //{
                //    try
                //    {
                //        //save audit trail
                //        command = new SqlCommand("spAddAuditTrail", connection);
                //        command.CommandType = CommandType.StoredProcedure;
                //        command.Parameters.Add("@actiondate", SqlDbType.DateTime).Value = DateTime.Now;
                //        command.Parameters.Add("@actionby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                //        command.Parameters.Add("@actiondescription", SqlDbType.VarChar).Value = "LOGOUT Successful";
                //        command.Parameters.Add("@actionid", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                //        connection.Open();
                //        command.ExecuteNonQuery();
                //        command.Dispose();
                //    }
                //    catch (Exception ex)
                //    {
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Login Failed');", true);
                //    }
                //    finally
                //    {
                //        connection.Dispose();
                //    }
                //}

                FormsAuthentication.SignOut();
                Session.Abandon();

                //clear authentication cookie
                //HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
                //cookie1.Expires = DateTime.Now.AddYears(-1);
                //Response.Cookies.Add(cookie1);

                //
                //HttpCookie cookie2 = new HttpCookie("ASP.NET_SessionId", "");
                //cookie2.Expires = DateTime.Now.AddYears(-1);
                //Response.Cookies.Add(cookie2);

                //clear userkey cookie
                //HttpCookie ckUserkey = new HttpCookie("userkey", "");
                //ckUserkey.Expires = DateTime.Now.AddYears(-1);
                //Response.Cookies.Add(ckUserkey);

                //Clear cookies
                string[] cookies = Request.Cookies.AllKeys;
                foreach (string cookie in cookies)
                {
                    Response.Cookies[cookie].Expires = DateTime.Now.AddYears(-1);
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //Response.Redirect("/Dashboard.aspx");
            try
            {
                string query = "select username,userpassword,blocked,userid,userrole,nmiuserid from tblUsers where UserName = @username";
                command = new SqlCommand(query, connection);
                command.Parameters.Add("@username", SqlDbType.VarChar).Value = txtUsername.Value.Trim();
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    if (Convert.ToBoolean(reader["Blocked"]))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.warning('Your Account is Deactivated...Please contact the Administrator','Login Failed');", true);
                        return;
                    }
                    if (reader["UserPassword"].ToString() == txtPassword.Value.Trim())
                    {
                        string userrole = reader["userrole"].ToString();
                        string userid = "";
                        string hspOfficerId = "";
                        if (userrole == "User")
                        {
                            userid = reader["userid"].ToString();
                            hspOfficerId = userid;
                        }
                        else if (userrole == "Admin")
                        {
                            hspOfficerId = reader["userid"].ToString();
                        }                          

                        HttpCookie UserId = new HttpCookie("userid", userid);
                        HttpCookie HspOfficerId = new HttpCookie("hspofficerid", hspOfficerId);
                        HttpCookie NmiUserId = new HttpCookie("NmiUserId", reader["nmiuserid"].ToString());

                        FormsAuthentication.SetAuthCookie(txtUsername.Value.Trim(), false);

                        FormsAuthenticationTicket ticket1 = new FormsAuthenticationTicket(
                                   1,                                   // version
                                                                        //this.txtUsername.Text.Trim(),   // get username  from the form
                                reader["username"].ToString(),
                                DateTime.Now,                        // issue time is now
                                DateTime.Now.AddMinutes(45),         // expires in 30 minutes
                                false,      // cookie is not persistent
                                userrole                            // role assignment is stored in userData
                                );

                        reader.Close();
                        command.Dispose();
                        HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket1));
                        Response.Cookies.Add(cookie1);

                        //ckUserkey.Expires = DateTime.Now.AddMinutes(50);
                        Response.Cookies.Add(UserId);
                        Response.Cookies.Add(HspOfficerId);
                        Response.Cookies.Add(NmiUserId);

                        //save audit trail
                        //command = new SqlCommand("spAddAuditTrail", connection);
                        //command.CommandType = CommandType.StoredProcedure;
                        //command.Parameters.Add("@actiondate", SqlDbType.DateTime).Value = DateTime.Now;
                        //command.Parameters.Add("@actionby", SqlDbType.VarChar).Value = txtUsername.Text.Trim();
                        //command.Parameters.Add("@actiondescription", SqlDbType.VarChar).Value = "LOGIN Successful";
                        //command.Parameters.Add("@actionid", SqlDbType.VarChar).Value = txtUsername.Text.Trim();
                        //command.ExecuteNonQuery();
                        //command.Dispose();

                        // 4. Do the redirect. 
                        String returnUrl1 = "/Dashboard.aspx";
                        //the login is successful
                        //if (Request.QueryString["ReturnUrl"] == null || Request.QueryString["ReturnUrl"] == "/")
                        //{
                        //    returnUrl1 = "/Dashboard.aspx";
                        //}
                        ////login not unsuccessful 
                        //else
                        //{
                        //    returnUrl1 = Request.QueryString["ReturnUrl"];
                        //}
                        Response.Redirect(returnUrl1);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Wrong Password','Login Failed');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('User does not exist','Login Failed');", true);
                }
                reader.Close();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Login Failed');", true);
            }
            finally
            {
                connection.Dispose();
            }
        }
        private static bool MatchSHA1(byte[] p1, byte[] p2)
        {
            bool result = false;
            if (p1 != null && p2 != null)
            {
                if (p1.Length == p2.Length)
                {
                    result = true;
                    for (int i = 0; i < p1.Length; i++)
                    {
                        if (p1[i] != p2[i])
                        {
                            result = false;
                            break;
                        }
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// Returns the SHA1 hash of the combined userID and password.
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        private static byte[] GetSHA1(string password)
        {
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            return sha.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
        }
    }
}