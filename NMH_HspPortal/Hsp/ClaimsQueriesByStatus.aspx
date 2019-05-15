<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ClaimsQueriesByStatus.aspx.cs" Inherits="NMH_HspPortal.Hsp.ClaimsQueriesByStatus" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Claims Queries</h5>
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

                         <asp:Button ID="btnReturn" CssClass="btn-warning" runat="server" Text="Return" OnClick="btnReturn_Click"/>       
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
                        
                        <telerik:RadGrid ID="grdAdvice" runat="server" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" DataSourceID="clmSource" GroupPanelPosition="Top" OnItemCommand="grdAdvice_ItemCommand" ShowGroupPanel="true">
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
                                    <telerik:GridButtonColumn Text="Comment" CommandName="Comment" UniqueName="Comment"  ButtonType="PushButton" ButtonCssClass="btn-info" Exportable="false">
                                        <HeaderStyle Width="80px" />
                                    </telerik:GridButtonColumn>
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
                                    <telerik:GridBoundColumn DataField="Diff" DataType="System.Decimal" FilterControlAltText="Filter Diff column" HeaderText="Diff" ReadOnly="True" SortExpression="Diff" UniqueName="Diff">
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

                        <asp:SqlDataSource ID="clmSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [RowID], [DateofAttendance], [AdviceMemberName], [Diagnosis], [ClaimsNo], [TariffName], [Tariff_X_RejectionComments], [Gender], [MemberAge], [Qty], [Claimed], [ApprovedAmount], [Diff], [HspQuery] FROM [Vw_AdviceSlip_Outcome] WHERE [ClaimsBatchNo] = @BatchNo and RowID IS NOT NULL">
                            <SelectParameters>
                                <%--<asp:SessionParameter Name="BatchNo" SessionField="pendingBatchNo" DefaultValue="0" Type="Int32" />--%>
                                <asp:QueryStringParameter Name="BatchNo" QueryStringField="adviceBatchNo" Type="Int32" DefaultValue="0" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnSendQuery" CssClass="btn btn-primary" Text="Send Query" OnClick="btnSendQuery_Click" />   
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                    </div>
                </div>
        </div>

    <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"> Comment </h4>
                </div>
                        <div class="modal-body">
                            <asp:HiddenField runat="server" ID="hfAdviceID" />
                             <div class="form-group">
                                       <asp:TextBox runat="server" ID="txtComment" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                   <%--<asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtComment" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>--%>
                             </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveComment" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="new" OnClick="btnSaveComment_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

      <script type="text/javascript">
            function newModal() {
                $('#newmodal').modal('show');
                $('#newmodal').appendTo($("form:first"));
            }
            function closenewModal() {
                $('#newmodal').modal('hide');
            }
    </script>
</asp:Content>
