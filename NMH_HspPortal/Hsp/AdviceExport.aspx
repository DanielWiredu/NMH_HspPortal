<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="AdviceExport.aspx.cs" Inherits="NMH_HspPortal.Hsp.AdviceExport" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Advice Slip </h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upProcess">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label ID="lblWait" runat="server" Text="Loading... " />
	                              <asp:Image ID="imgWait" runat="server" ImageAlign="Top" ImageUrl="/Content/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>

                   <asp:Panel runat="server" DefaultButton="btnSearch">
            <asp:UpdatePanel runat="server" ID="upProcess">
            <ContentTemplate>
                 <div class="modal-content">
                        <div class="modal-body">
                             <div class="form-group">
                                 <div class="row">
                                    <div class="col-md-12">
                                    <label>Batch Numbers (separate by commas if many)</label>
                                    <asp:TextBox runat="server" ID="txtBatchNo" Width="100%" ></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Enter Batch No" ControlToValidate="txtBatchNo" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </div> 
                                 </div>
                                  
                             </div>
                            <div>
                                <telerik:RadGrid ID="adviceGrid" runat="server" AllowPaging="true" ShowFooter="False" AutoGenerateColumns="False" AllowSorting="True" DataSourceID="adviceSource" GroupPanelPosition="Top" CellSpacing="-1" GridLines="Both">
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" />
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                         <Resizing AllowColumnResize="true" AllowRowResize="true" AllowResizeToFit="true" EnableRealTimeResize="true" ClipCellContentOnResize="true" ResizeGridOnColumnResize="true" />
                                    </ClientSettings>
                                    <GroupingSettings CaseSensitive="false" />
                                    <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="AdviceSlip" HideStructureColumns="true">

                                    </ExportSettings>
                                    <MasterTableView DataSourceID="adviceSource" PageSize="100">
                                        <Columns>
                                         <telerik:GridBoundColumn DataField="ClaimsBatchNo" FilterControlAltText="Filter ClaimsBatchNo column" HeaderText="BatchNo" SortExpression="ClaimsBatchNo" UniqueName="ClaimsBatchNo" DataType="System.Int32">
                                         <HeaderStyle Width="70px" />
                                         </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ClaimsNo" FilterControlAltText="Filter ClaimsNo column" HeaderText="ClaimsNo" SortExpression="ClaimsNo" UniqueName="ClaimsNo">
                                            <HeaderStyle Width="120px" />
                                            </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="AdviceMemberName" FilterControlAltText="Filter AdviceMemberName column" HeaderText="AdviceMemberName" SortExpression="AdviceMemberName" UniqueName="AdviceMemberName" ReadOnly="True">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Gender" FilterControlAltText="Filter Gender column" HeaderText="Gender" SortExpression="Gender" UniqueName="Gender">
                                         <HeaderStyle Width="70px" />
                                         </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DOB2" DataType="System.DateTime" FilterControlAltText="Filter DOB2 column" HeaderText="DOB2" SortExpression="DOB2" UniqueName="DOB2" DataFormatString="{0:MM/dd/yyyy}">
                                            <HeaderStyle Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="MemberAge" FilterControlAltText="Filter MemberAge column" HeaderText="MemberAge" ReadOnly="True" SortExpression="MemberAge" UniqueName="MemberAge">
                                            <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="BenefitOption" FilterControlAltText="Filter BenefitOption column" HeaderText="BenefitOption" SortExpression="BenefitOption" UniqueName="BenefitOption">
                                            <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DateofAttendance" DataType="System.DateTime" FilterControlAltText="Filter DateofAttendance column" HeaderText="DateofAttendance" SortExpression="DateofAttendance" UniqueName="DateofAttendance" DataFormatString="{0:MM/dd/yyyy}">
                                            <HeaderStyle Width="110px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Inout" FilterControlAltText="Filter Inout column" HeaderText="Inout" ReadOnly="True" SortExpression="Inout" UniqueName="Inout">
                                            <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TariffName" FilterControlAltText="Filter TariffName column" HeaderText="TariffName" SortExpression="TariffName" UniqueName="TariffName">
                                            <HeaderStyle Width="180px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Qty" DataType="System.Int32" FilterControlAltText="Filter Qty column" HeaderText="Qty" SortExpression="Qty" UniqueName="Qty">
                                            <HeaderStyle Width="60px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Claimed" DataType="System.Decimal" FilterControlAltText="Filter Claimed column" HeaderText="Claimed" SortExpression="Claimed" UniqueName="Claimed">
                                            <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ApprovedAmount" DataType="System.Decimal" FilterControlAltText="Filter ApprovedAmount column" HeaderText="Approved" SortExpression="ApprovedAmount" UniqueName="ApprovedAmount">
                                            <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Diff" DataType="System.Decimal" FilterControlAltText="Filter Diff column" HeaderText="Diff" ReadOnly="True" SortExpression="Diff" UniqueName="Diff">
                                            <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Tariff_X_RejectionComments" FilterControlAltText="Filter Tariff_X_RejectionComments column" HeaderText="Tariff_X_RejectionComments" SortExpression="Tariff_X_RejectionComments" UniqueName="Tariff_X_RejectionComments">
                                            <HeaderStyle Width="200px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Diagnosis" FilterControlAltText="Filter Diagnosis column" HeaderText="Diagnosis" SortExpression="Diagnosis" UniqueName="Diagnosis">
                                            <HeaderStyle Width="200px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DateOfClaim" DataType="System.DateTime" FilterControlAltText="Filter DateOfClaim column" HeaderText="DateOfClaim" SortExpression="DateOfClaim" UniqueName="DateOfClaim" DataFormatString="{0:MM/dd/yyyy}">
                                            <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ServiceProvider" FilterControlAltText="Filter ServiceProvider column" HeaderText="ServiceProvider" SortExpression="ServiceProvider" UniqueName="ServiceProvider">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TypeName" FilterControlAltText="Filter TypeName column" HeaderText="TypeName" SortExpression="TypeName" UniqueName="TypeName">
                                            <HeaderStyle Width="150px" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                                <asp:SqlDataSource ID="adviceSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Get_AdviceSlip" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="txtBatchNo" DefaultValue="0" Name="Batches" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                       </div>

                <div class="modal-footer">
                    <asp:Button ID="btnSearch" runat="server" Text="Find" CssClass="btn btn-success" style="margin-bottom:0px" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnExcelExport" runat="server" Text="Excel" CssClass="btn btn-primary" OnClick="btnExcelExport_Click" CausesValidation="false" />
                </div>
            </div>
            </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnExcelExport" />
                </Triggers>
        </asp:UpdatePanel>
        </asp:Panel>
                    </div>
                </div>
        </div>
</asp:Content>
