<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="AssignOfficers.aspx.cs" Inherits="NMH_HspPortal.HspAdmin.AssignOfficers" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Assign HSP Officers </h5>
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
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Provider / Officer Name..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnExcelExport" CssClass="btn-primary" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click" />  
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="providerGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="providerSource" GroupPanelPosition="Top" OnItemCommand="providerGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="350px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="ServiceProviders" HideStructureColumns="true">
                                    </ExportSettings>
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="providerSource" PageSize="50">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="ID" DataType="System.Int32" FilterControlAltText="Filter ID column" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="ID">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ServiceProvider" FilterControlAltText="Filter ServiceProvider column" HeaderText="ServiceProvider" SortExpression="ServiceProvider" UniqueName="ServiceProvider">
                                    <HeaderStyle Width="300px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Region" FilterControlAltText="Filter Region column" HeaderText="Region" SortExpression="Region" UniqueName="Region">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ServiceType" FilterControlAltText="Filter ServiceType column" HeaderText="ServiceType" SortExpression="ServiceType" UniqueName="ServiceType">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UserName" FilterControlAltText="Filter UserName column" HeaderText="Officer Name" SortExpression="UserName" UniqueName="UserName">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn Text="Assign" CommandName="Assign" UniqueName="Assign" ButtonType="PushButton" ButtonCssClass="btn-warning" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="providerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ID, ServiceProvider, Region, ServiceType, UserName FROM Vw_ServiceProviderByUser WHERE ([ServiceProvider] LIKE '%' + @SearchValue + '%' OR [UserName] LIKE '%' + @SearchValue + '%') ORDER BY ServiceProvider">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtSearch" Name="SearchValue" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                    </ContentTemplate>
                    <Triggers>
                                  <asp:PostBackTrigger ControlID="btnExcelExport" />
                              </Triggers>
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
                    <h4 class="modal-title">Doctor </h4>
                </div>
                        <div class="modal-body">
                             <asp:HiddenField runat="server" ID="hfProviderId" />
                            <div class="alert alert-info" runat="server" id="lblServiceProvider"></div>
                             <div class="form-group">
                                        <label>HSP Officer </label>
                                 <telerik:RadDropDownList ID="dlOfficer" runat="server" Width="100%" DataSourceID="officerSource" DataTextField="UserName" DataValueField="UserID" CausesValidation="false"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="officerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT UserID, UserName FROM [tblUsers]"></asp:SqlDataSource>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlOfficer" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="new" OnClick="btnSave_Click" />
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
