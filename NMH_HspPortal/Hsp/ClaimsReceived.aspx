<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ClaimsReceived.aspx.cs" Inherits="NMH_HspPortal.Hsp.ClaimsReceived" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />

    <style type="text/css">
table {
    border-collapse: collapse;
    width: 100%;
}

/*th {
    padding: 8px;
    text-align: left;
    border-bottom: 3px solid #000000;
    font-size:larger;
}*/
h4 {
    text-align: left;
    /*border-bottom: 2px solid #000000;*/
    font-weight:bold;
}
td {
    padding: 5px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}
.tdlabel {
    padding: 5px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    font-weight:bold;
}
tr:hover{background-color:#f5f5f5}
/*tr:nth-child(odd) {background-color: #f2f2f2}*/
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Claims Received</h5>
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
                <asp:UpdatePanel runat="server" ID="upProcess">
                    <ContentTemplate>
                                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="BatchNo/Month/Year..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            
                                       </div>
                                            <div class="col-sm-4 text-center">
                                                
                                            </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnReturn" CssClass="btn-warning" Text="Return" CausesValidation="false" PostBackUrl="~/Hsp/ServiceProviders.aspx"/> 
                                                <asp:Button runat="server" ID="btnExcelExport" CssClass="btn-primary pull-right" Text="Excel" CausesValidation="false" OnClick="btnExcel_Click" />  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <%--<div class="alert alert-info" runat="server" id="lblCompany"></div>--%>
                        <div style="text-align:center;vertical-align:middle">
                             <h3 runat="server" id="lblProvider" style="color:black; background-color:white; font-weight:bold"></h3>
                        </div>
                       

                        <asp:HiddenField runat="server" ID="hfProviderId" />

                        <telerik:RadGrid ID="claimsGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="claimSource" GroupPanelPosition="Top" OnItemCommand="claimsGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="350px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="ClaimsReceived" HideStructureColumns="true">
                                    </ExportSettings>
                            <GroupHeaderItemStyle BackColor="#36C93E" ForeColor="Black" Font-Bold="true" Width="50px" Font-Size="Medium" />
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="claimSource" PageSize="50" GroupLoadMode="Server" DataKeyNames="ID">
                                <Columns>
                                    <telerik:GridClientSelectColumn>
                                        <HeaderStyle Width="30px" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="ID" DataType="System.Int32" FilterControlAltText="Filter ID column" HeaderText="Batch No" SortExpression="ID" UniqueName="ID">
                                    <HeaderStyle Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TypeOfBatch" FilterControlAltText="Filter TypeOfBatch column" HeaderText="TypeOfBatch" SortExpression="TypeOfBatch" UniqueName="TypeOfBatch">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TypeOfClaims" FilterControlAltText="Filter TypeOfClaims column" HeaderText="TypeOfClaims" SortExpression="TypeOfClaims" UniqueName="TypeOfClaims">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ClaimsMonth" FilterControlAltText="Filter ClaimsMonth column" HeaderText="MonthOfClaim" SortExpression="ClaimsMonth" UniqueName="ClaimsMonth">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DateOfClaim" FilterControlAltText="Filter DateOfClaim column" HeaderText="DateOfClaim" SortExpression="DateOfClaim" UniqueName="DateOfClaim" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NoOfClaims" FilterControlAltText="Filter NoOfClaims column" HeaderText="NoOfClaims" SortExpression="NoOfClaims" UniqueName="NoOfClaims">
                                    <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmountClaimed" FilterControlAltText="Filter AmountClaimed column" HeaderText="ProviderClaimed" SortExpression="AmountClaimed" UniqueName="AmountClaimed" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BatchSystemAward" FilterControlAltText="Filter BatchSystemAward column" HeaderText="SystemAward" SortExpression="BatchSystemAward" UniqueName="BatchSystemAward" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Status" FilterControlAltText="Filter Status column" HeaderText="Status" SortExpression="Status" UniqueName="Status" EmptyDataText="">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn Text="Queries" CommandName="Queries" UniqueName="Queries" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Font-Underline="true" ForeColor="Green" />
                                    </telerik:GridButtonColumn>
                                   <%-- <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete this Company Plan and all associated Benefits?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>--%>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="claimSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ID, DateOfClaim, NoOfClaims, ClaimsMonth, Status, AmountClaimed, BatchSystemAward, TypeOfClaims, TypeOfBatch FROM Vw_ClaimsBatch_Utili_RTP WHERE (([ServiceProvideID] = @ProviderId) AND (ClaimsMonth LIKE '%' + @SearchValue + '%' OR ID LIKE '%' + @SearchValue + '%')) ORDER BY DateOfClaim DESC">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="hfProviderId" Name="ProviderId" PropertyName="Value" Type="Int32" ConvertEmptyStringToNull="false" />
                                                <asp:ControlParameter ControlID="txtSearch" Name="SearchValue" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                        <div class="modal-footer">
                            <%--<asp:Button runat="server" ID="btnQuery" CssClass="btn btn-warning" Text="Query" OnClick="btnQuery_Click" />--%>  
                            <asp:Button runat="server" ID="btnTracker" CssClass="btn btn-info" Text="Tracker" OnClick="btnTracker_Click" style="margin-bottom:0px"/>  
                            <asp:Button runat="server" ID="btnAwards" CssClass="btn btn-success" Text="Awards" OnClick="btnAwards_Click" />  
                            <asp:Button runat="server" ID="btnPayments" CssClass="btn btn-primary" Text="Payments" OnClick="btnPayments_Click" />  
                            <asp:Button runat="server" ID="btnAdviceSlip" CssClass="btn btn-warning" Text="Advcie Slip" OnClick="btnAdviceSlip_Click" /> 
                            <asp:Button runat="server" ID="btnApproveForPayment" CssClass="btn btn-primary" Text="Approve For Payment" OnClick="btnApproveForPayment_Click" OnClientClick="Confirm();" Enabled="true"/>
                        </div>

                    </ContentTemplate>
                    <Triggers>
                                  <asp:PostBackTrigger ControlID="btnExcelExport" />
                                <asp:PostBackTrigger ControlID="btnApproveForPayment" />
                              </Triggers>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>


         <!--  Tracker modal -->
    <div class="modal fade" id="trackermodal">
    <div class="modal-dialog" style="width:60%">
      <asp:UpdatePanel runat="server">
          <ContentTemplate>
               <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Batch Tracker</h4>
                </div>
                        <div class="modal-body">
                             <asp:Panel ID="ListViewPanel2" runat="server">
            <telerik:RadListView ID="lvTracker" RenderMode="Lightweight" Width="97%" AllowPaging="True" runat="server"
                ItemPlaceholderID="trackerHolder">
                <LayoutTemplate>
                     <%--<h4>Batch Tracker</h4>--%>
                                <table>
                                    <tr>
                                        <td class="tdlabel" style="width:20%">BatchNo
                                            </td>
                                        <td class="tdlabel" style="width:20%">UserName
                                            </td>
                                        <td class="tdlabel" style="width:30%">DateStamp
                                            </td>
                                        <td class="tdlabel" style="width:30%">Status
                                            </td>
                                    </tr>
                                    </table>                    
                    <fieldset class="layoutFieldset" id="FieldSet2">
                        <asp:Panel ID="trackerHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                        <tr> 
                                            <td style="width:20%">
                                                <%# Eval("BatchNo") %>
                                            </td>
                                            <td style="width:20%">
                                               <%# Eval("UserName") %>
                                            </td>
                                            <td style="width:30%">
                                               <%# Eval("DateStamp") %>
                                            </td>
                                            <td style="width:30%">
                                               <%# Eval("Status") %>
                                            </td>
                                            <%--<td style="width:15%">
                                                 <%# DataBinder.Eval(Container.DataItem, "UnitPrice", "{0:0.00}") %>
                                            </td>--%>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
                       </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Return</button>
                </div>
            </div>
          </ContentTemplate>
      </asp:UpdatePanel>
        </div>
    </div>

    <!--  Awards modal -->
    <div class="modal fade" id="awardsmodal">
    <div class="modal-dialog" style="width:80%">
      <asp:UpdatePanel runat="server">
          <ContentTemplate>
               <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Batch Awards</h4>
                </div>
                        <div class="modal-body">
                             <asp:Panel ID="Panel1" runat="server">
            <telerik:RadListView ID="lvAwards" RenderMode="Lightweight" Width="97%" AllowPaging="True" runat="server"
                ItemPlaceholderID="awardsHolder">
                <LayoutTemplate>
                     <%--<h4>Batch Tracker</h4>--%>
                                <table>
                                    <tr>
                                        <td class="tdlabel" style="width:10%">BatchNo
                                            </td>
                                        <td class="tdlabel" style="width:10%">Claimed
                                            </td>
                                        <td class="tdlabel" style="width:10%">Awarded
                                            </td>
                                        <td class="tdlabel" style="width:10%">Advice
                                            </td>
                                        <td class="tdlabel" style="width:10%">WithHold %
                                            </td>
                                        <td class="tdlabel" style="width:10%">WithHold Amt
                                            </td>
                                        <td class="tdlabel" style="width:10%">Amount Due
                                            </td>
                                        <td class="tdlabel" style="width:20%">Award Date
                                            </td>
                                        <td class="tdlabel" style="width:10%">Status
                                            </td>
                                    </tr>
                                    </table>                    
                    <fieldset class="layoutFieldset" id="FieldSet2">
                        <asp:Panel ID="awardsHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                        <tr> 
                                            <td style="width:10%">
                                                <%# Eval("BatchNo") %>
                                            </td>
                                            <td style="width:10%">
                                                 <%# DataBinder.Eval(Container.DataItem, "Claimed", "{0:N02}") %>
                                            </td>
                                            <td style="width:10%">
                                                 <%# DataBinder.Eval(Container.DataItem, "Awarded", "{0:N02}") %>
                                            </td>
                                            <td style="width:10%">
                                                 <%# DataBinder.Eval(Container.DataItem, "Advice", "{0:N02}") %>
                                            </td>
                                            <td style="width:10%">
                                                 <%# DataBinder.Eval(Container.DataItem, "WithHoldingRate", "{0:N02}") %>
                                            </td>
                                            <td style="width:10%">
                                                 <%# DataBinder.Eval(Container.DataItem, "WitHold", "{0:N02}") %>
                                            </td>
                                            <td style="width:10%">
                                                 <%# DataBinder.Eval(Container.DataItem, "AmountDue", "{0:N02}") %>
                                            </td>
                                            <td style="width:20%">
                                                 <%# DataBinder.Eval(Container.DataItem, "AwardDate") %>
                                            </td>
                                            <td style="width:10%">
                                               <%# Eval("Status") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
                       </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Return</button>
                </div>
            </div>
          </ContentTemplate>
      </asp:UpdatePanel>
        </div>
    </div>

     <!--  Payments modal -->
    <div class="modal fade" id="paymentsmodal">
    <div class="modal-dialog" style="width:70%">
      <asp:UpdatePanel runat="server">
          <ContentTemplate>
               <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Batch Payments</h4>
                </div>
                        <div class="modal-body">
                             <asp:Panel ID="Panel2" runat="server">
            <telerik:RadListView ID="lvPayments" RenderMode="Lightweight" Width="97%" AllowPaging="True" runat="server"
                ItemPlaceholderID="paymentsHolder">
                <LayoutTemplate>
                     <%--<h4>Batch Tracker</h4>--%>
                                <table>
                                    <tr>
                                        <td class="tdlabel" style="width:10%">BatchNo
                                            </td>
                                        <td class="tdlabel" style="width:10%">Cheque No
                                            </td>
                                        <td class="tdlabel" style="width:15%">Cheque Date
                                            </td>
                                        <td class="tdlabel" style="width:15%">Cheque Amt
                                            </td>
                                        <td class="tdlabel" style="width:20%">DateStamp
                                            </td>
                                        <td class="tdlabel" style="width:20%">Bank
                                            </td>
                                        <td class="tdlabel" style="width:10%">Status
                                            </td>
                                    </tr>
                                    </table>                    
                    <fieldset class="layoutFieldset" id="FieldSet2">
                        <asp:Panel ID="paymentsHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                        <tr> 
                                            <td style="width:10%">
                                                <%# Eval("BatchNo") %>
                                            </td>
                                            <td style="width:10%">
                                                <%# Eval("ChequeNo") %>
                                            </td>
                                            <td style="width:15%">
                                                 <%# DataBinder.Eval(Container.DataItem, "ChequeDate", "{0:dd-MMM-yyyy}") %>
                                            </td>
                                            <td style="width:15%">
                                                 <%# DataBinder.Eval(Container.DataItem, "ChequeAmount", "{0:N02}") %>
                                            </td>
                                            <td style="width:20%">
                                                 <%# DataBinder.Eval(Container.DataItem, "DateStamp") %>
                                            </td>
                                            <td style="width:20%">
                                               <%# Eval("Bank") %>
                                            </td>
                                            <td style="width:10%">
                                               <%# Eval("Status") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
                       </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Return</button>
                </div>
            </div>
          </ContentTemplate>
      </asp:UpdatePanel>
        </div>
    </div>
     
    <!-- Query modal -->
         <div class="modal fade" id="querymodal">
    <div class="modal-dialog" style="width:50%">
        <%--<asp:Panel runat="server" DefaultButton="btnSearch">--%>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upMail">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label runat="server" Text="Processing... " />
	                              <asp:Image runat="server" ImageAlign="Top" ImageUrl="/Content/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>
            <asp:UpdatePanel runat="server" ID="upMail">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Batch Query</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Batch No</label>
                                       <asp:TextBox runat="server" ID="txtBatchNo" ClientIDMode="Static" Width="100%" Enabled="false"></asp:TextBox>
                             </div>
                            <div class="form-group">
                                        <label>Query</label>
                                       <asp:TextBox runat="server" ID="txtQuery" ClientIDMode="Static" Width="100%" TextMode="MultiLine" Rows="7"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtQuery" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="query"></asp:RequiredFieldValidator>
                             </div>
                            <div>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSendQuery" runat="server" Text="Save & Send" CssClass="btn btn-primary"  OnClick="btnSendQuery_Click" ValidationGroup="query" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--</asp:Panel>--%>
        </div>
         </div>
          
    <script type="text/javascript">
            function showTrackerModal() {
                $('#trackermodal').modal('show');
            }
            function showAwardsModal() {
                $('#awardsmodal').modal('show');
            }
            function showPaymentsModal() {
                $('#paymentsmodal').modal('show');
            }
            function showQueryModal() {
                $('#querymodal').modal('show');
                $('#querymodal').appendTo($("form:first"));
            }
            function closeQueryModal() {
                $('#querymodal').modal('hide');
            }
            $('#querymodal').on('shown.bs.modal', function () {
                // jQuery code is in here
                $('#txtQuery').focus();
            });
            function Confirm() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Continue to Approve Batch for Payment?")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
    </script>
</asp:Content>
