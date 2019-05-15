<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="MyDashboard.aspx.cs" Inherits="NMH_HspPortal.Hsp.MyDashboard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                       <p>My Dashboard</p>
                       
                       <div class="row" >
           <%-- <div class="col-lg-3">
                <div class="widget style1 blue-bg">
                        <div class="row">
                            <div class="col-xs-4 text-center">
                                <i class="fa fa-trophy fa-5x"></i>
                            </div>
                            <div class="col-xs-8 text-right">
                                <span> Today income </span>
                                <h2 class="font-bold">$ 4,232</h2>
                            </div>
                        </div>
                </div>
            </div>--%>
            <div class="col-lg-3">
                <div class="widget style1 navy-bg">
                    <div class="row">
                        <%--<div class="col-xs-4">
                            <i class="fa fa-cloud fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Medical Vetting </span>
                            <a style="color:white" runat="server" id="lkMedicalVetting" onserverclick="lkMedicalVetting_ServerClick">
                                    <h2 class="font-bold" runat="server" id="lblMedicalVetting"> 642</h2>
                                    </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="widget style1 lazur-bg">
                    <div class="row">
                        <%--<div class="col-xs-4">
                            <i class="fa fa-envelope-o fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Awarded </span>
                            <a style="color:white" runat="server" id="lkAwarded" onserverclick="lkAwarded_ServerClick">
                                <h2 class="font-bold" runat="server" id="lblAwarded">5 </h2>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="widget style1 yellow-bg">
                    <div class="row">
                       <%-- <div class="col-xs-4">
                            <i class="fa fa-music fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span>Sent to Accounts</span>
                            <a style="color:white" runat="server" id="lkSenttoAccounts" onserverclick="lkSenttoAccounts_ServerClick">
                                <h2 class="font-bold" runat="server" id="lblSenttoAccounts"> 23 </h2>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="widget style1 red-bg">
                    <div class="row">
                       <%-- <div class="col-xs-4">
                            <i class="fa fa-music fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Paid </span>
                            <a style="color:white" runat="server" id="lkPaid" onserverclick="lkPaid_ServerClick">
                                <h2 class="font-bold" runat="server" id="lblPaid">12  </h2>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

          <div class="row" >
            <div class="col-lg-3">
                <div class="widget style1 blue-bg">
                    <div class="row">
                        <%--<div class="col-xs-4">
                            <i class="fa fa-cloud fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Received / Batched </span>
                            <a style="color:white" runat="server" id="lkReceived" onserverclick="lkReceived_ServerClick">
                                    <h2 class="font-bold" runat="server" id="lblReceived"> 642</h2>
                                    </a>
                        </div>
                    </div>
                </div>
            </div>
              <div class="col-lg-3">
                <div class="widget style1 navy-bg">
                    <div class="row">
                        <%--<div class="col-xs-4">
                            <i class="fa fa-cloud fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Approved For Payment </span>
                            <a style="color:white" runat="server" id="lkApprovedForPayment" onserverclick="lkApprovedForPayment_ServerClick">
                                    <h2 class="font-bold" runat="server" id="lblApprovedForPayment"> 642</h2>
                                    </a>
                        </div>
                    </div>
                </div>
            </div>
              <div class="col-lg-3">
                <div class="widget style lazur-bg">
                    <div class="row">
                       <%-- <div class="col-xs-4">
                            <i class="fa fa-music fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Cancel Award </span>
                            <a style="color:white" runat="server" id="lkCancelAward" onserverclick="lkCancelAward_ServerClick">
                                <h2 class="font-bold" runat="server" id="lblCancelAward">12  </h2>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
              <div class="col-lg-3">
                <div class="widget style1 yellow-bg">
                    <div class="row">
                       <%-- <div class="col-xs-4">
                            <i class="fa fa-music fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span>Payment Cancelled</span>
                            <a style="color:white" runat="server" id="lkPaymentCancelled" onserverclick="lkPaymentCancelled_ServerClick">
                                <h2 class="font-bold" runat="server" id="lblPaymentCancelled"> 23 </h2>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" >
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-primary pull-right">Medical Vetting</span>
                                <h5>Batches</h5>
                            </div>
                            <div class="ibox-content">
                                <a style="color:black" runat="server" id="lkMedicalVettingToday" onserverclick="lkMedicalVettingToday_ServerClick">
                                    <h1 class="no-margins" runat="server" id="lblMedicalVettingToday">40 886,200</h1>
                                </a>
                                
                                <small>Medical Vetting</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-info pull-right">Awarded</span>
                                <h5>Batches</h5>
                            </div>
                            <div class="ibox-content">
                                <a style="color:black" runat="server" id="lkAwardedToday" onserverclick="lkAwardedToday_ServerClick">
                                    <h1 class="no-margins" runat="server" id="lblAwardedToday">275,800</h1>
                                </a>
                                
                                <small>Awarded</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-warning pull-right">Sent to Accounts</span>
                                <h5>Batches</h5>
                            </div>
                            <div class="ibox-content">
                                <a style="color:black" runat="server" id="lkSenttoAccountsToday" onserverclick="lkSenttoAccountsToday_ServerClick">
                                    <h1 class="no-margins" runat="server" id="lblSenttoAccountsToday">106,120</h1>
                                </a>
                                
                                <small>Sent to Accounts</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-danger pull-right">Paid</span>
                                <h5>Batches</h5>
                            </div>
                            <div class="ibox-content">
                                <a style="color:black" runat="server" id="lkPaidToday" onserverclick="lkPaidToday_ServerClick">
                                    <h1 class="no-margins" runat="server" id="lblPaidToday">80,600</h1>
                                </a>
                                
                                <small>Paid</small>
                            </div>
                        </div>
            </div>
        </div>

                        <div class="row">
                             <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-success pull-right">Received / Batched</span>
                                <h5>Batches</h5>
                            </div>
                            <div class="ibox-content">
                                <a style="color:black" runat="server" id="lkReceivedToday" onserverclick="lkReceivedToday_ServerClick">
                                    <h1 class="no-margins" runat="server" id="lblReceivedToday">40 886,200</h1>
                                </a>
                                
                                <small>Received / Batched</small>
                            </div>
                        </div>
                    </div>
                            <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-primary pull-right">Approved For Payment </span>
                                <h5>Batches</h5>
                            </div>
                            <div class="ibox-content">
                                <a style="color:black" runat="server" id="lkApprovedForPaymentToday" onserverclick="lkApprovedForPaymentToday_ServerClick">
                                    <h1 class="no-margins" runat="server" id="lblApprovedForPaymentToday">40 886,200</h1>
                                </a>
                                
                                <small>Approved For Payment </small>
                            </div>
                        </div>
                    </div>
                            <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-info pull-right">Cancel Award</span>
                                <h5>Batches</h5>
                            </div>
                            <div class="ibox-content">
                                <a style="color:black" runat="server" id="lkCancelAwardToday" onserverclick="lkCancelAwardToday_ServerClick">
                                    <h1 class="no-margins" runat="server" id="lblCancelAwardToday">80,600</h1>
                                </a>
                                
                                <small>Cancel Award</small>
                            </div>
                        </div>
            </div>
                            <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-warning pull-right">Payment Cancelled</span>
                                <h5>Batches</h5>
                            </div>
                            <div class="ibox-content">
                                <a style="color:black" runat="server" id="lkPaymentCancelledToday" onserverclick="lkPaymentCancelledToday_ServerClick">
                                    <h1 class="no-margins" runat="server" id="lblPaymentCancelledToday">106,120</h1>
                                </a>
                                
                                <small>Payment Cancelled</small>
                            </div>
                        </div>
                    </div>
                        </div>
                    </div>
                </div>
            </div>

                </div>
        </div>
</asp:Content>
