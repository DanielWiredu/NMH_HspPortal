<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="QueriedAdvice.aspx.cs" Inherits="NMH_HspPortal.Hsp.QueriedAdvice" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Queried Advice</h5>
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

                         <asp:Button ID="btnReturn" CssClass="btn-warning" runat="server" Text="Return" PostBackUrl="~/Hsp/Queries.aspx"/>       
                         <br />

                        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upProcess">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label ID="lblWait" runat="server" Text="Processing... " />
	                              <asp:Image ID="imgWait" runat="server" ImageAlign="Top" ImageUrl="/Content/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>
                        <asp:UpdatePanel runat="server" ID="upProcess">
                    <ContentTemplate>     
                        <div  style="text-align:center;vertical-align:middle">
                            <h3 id="lblBatchNo" runat="server" ></h3>
                        </div>                        
                        
                        <telerik:RadGrid ID="grdAdvice" runat="server" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" DataSourceID="clmSource" GroupPanelPosition="Top" ShowGroupPanel="true">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <GroupHeaderItemStyle BackColor="#36C93E" ForeColor="Black" Font-Bold="true" Font-Size="Small" Wrap="true" />
                            
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="RowID" DataSourceID="clmSource" PageSize="50" GroupLoadMode="Server">
                                <GroupByExpressions>
                                           <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldAlias="ClaimNo" FieldName="ClaimsNo"></telerik:GridGroupByField>
                                                   <telerik:GridGroupByField FieldAlias="Attendance" FieldName="DateofAttendance" FormatString="{0:dd-MMM-yyyy}"></telerik:GridGroupByField>
                                                   <telerik:GridGroupByField FieldAlias="Name" FieldName="AdviceMemberName"></telerik:GridGroupByField>
                                                   <telerik:GridGroupByField FieldAlias="Gender" FieldName="Gender"></telerik:GridGroupByField>
                                                   <telerik:GridGroupByField FieldAlias="Age" FieldName="MemberAge"></telerik:GridGroupByField>
                                                   <%--<telerik:GridGroupByField FieldAlias="Company" FieldName="Company"></telerik:GridGroupByField>--%>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="ClaimsNo" SortOrder="Descending"></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                       </GroupByExpressions>
                                <Columns>
                                    <telerik:GridBoundColumn DataField="RowID" DataType="System.Int32" FilterControlAltText="Filter RowID column" HeaderText="RowID" ReadOnly="True" SortExpression="RowID" UniqueName="RowID" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Diagnosis" FilterControlAltText="Filter Diagnosis column" HeaderText="Diagnosis" SortExpression="Diagnosis" UniqueName="Diagnosis" AutoPostBackOnFilter="true" FilterControlWidth="150px" ShowFilterIcon="false">
                                    <HeaderStyle Width="250px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TariffName" FilterControlAltText="Filter TariffName column" HeaderText="TariffName" SortExpression="TariffName" UniqueName="TariffName" AutoPostBackOnFilter="true" FilterControlWidth="200px" ShowFilterIcon="false">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Qty" DataType="System.Int32" FilterControlAltText="Filter Qty column" HeaderText="Qty" SortExpression="Qty" UniqueName="Qty">
                                     <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Claimed" DataType="System.Double" FilterControlAltText="Filter Claimed column" HeaderText="Claimed" SortExpression="Claimed" UniqueName="Claimed">
                                    <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ApprovedAmount" DataType="System.Double" FilterControlAltText="Filter ApprovedAmount column" HeaderText="Approved" SortExpression="ApprovedAmount" UniqueName="ApprovedAmount">
                                    <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Tariff_X_RejectionComments" FilterControlAltText="Filter Tariff_X_RejectionComments column" HeaderText="Tariff_X_RejectionComments" SortExpression="Tariff_X_RejectionComments" UniqueName="Tariff_X_RejectionComments" AutoPostBackOnFilter="true" FilterControlWidth="200px" ShowFilterIcon="false">
                                    <HeaderStyle Width="250px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="HspQuery" FilterControlAltText="Filter HspQuery column" HeaderText="HspQuery" SortExpression="HspQuery" UniqueName="HspQuery" EmptyDataText="">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="clmSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT [RowID], [DateofAttendance], [AdviceMemberName], [Diagnosis], [ClaimsNo], [TariffName], [Qty], [Tariff_X_RejectionComments], [Gender], [MemberAge], [Claimed], [ApprovedAmount], [HspQuery] FROM [Vw_Queried_Advice] WHERE [ClaimsBatchNo] = @BatchNo and RowID IS NOT NULL">
                            <SelectParameters>
                                <%--<asp:SessionParameter Name="BatchNo" SessionField="pendingBatchNo" DefaultValue="0" Type="Int32" />--%>
                                <asp:QueryStringParameter Name="BatchNo" QueryStringField="adviceBatchNo" Type="Int32" DefaultValue="0" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </ContentTemplate>
                </asp:UpdatePanel>

                    </div>
                </div>
        </div>
</asp:Content>
