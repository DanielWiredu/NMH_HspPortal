<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ServiceProviders.aspx.cs" Inherits="NMH_HspPortal.Hsp.ServiceProviders" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Service Providers </h5>
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
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Provider Name..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <%--<asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal()"/>--%>  
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
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="providerSource" PageSize="50">
                                <Columns>
                                    <telerik:GridButtonColumn Text="Claims" CommandName="Claims" UniqueName="Claims" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Font-Underline="true" ForeColor="Green" />
                                    </telerik:GridButtonColumn>
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
                                   <%-- <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete this Company Plan and all associated Benefits?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>--%>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="providerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ID, ServiceProvider, Region, ServiceType FROM Vw_ServiceProvider WHERE ([ServiceProvider] LIKE '%' + @ServiceProvider + '%') AND HspID LIKE '%' + @UserId + '%' ORDER BY ServiceProvider">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtSearch" Name="ServiceProvider" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                                                <asp:CookieParameter CookieName="userid" Type="String" Name="UserId" DefaultValue="" ConvertEmptyStringToNull="false" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                    </ContentTemplate>
                    <Triggers>
                                  <%--<asp:PostBackTrigger ControlID="btnExcelExport" />--%>
                              </Triggers>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

</asp:Content>
