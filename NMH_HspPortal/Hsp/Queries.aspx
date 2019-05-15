<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Queries.aspx.cs" Inherits="NMH_HspPortal.Hsp.Queries" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Batch Queries </h5>
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
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Batch No..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <%--<asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal()"/>--%>  
                                                <asp:Button runat="server" ID="btnExcelExport" CssClass="btn-primary pull-right" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click" /> 
                                            </div>
                                        </div>
                                    </div>
                        <hr />

                        <telerik:RadGrid ID="queryGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="querySource" GroupPanelPosition="Top" OnItemDataBound="queryGrid_ItemDataBound" OnItemCommand="queryGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="350px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="Queries" HideStructureColumns="true">
                                    </ExportSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="querySource" PageSize="50" DataKeyNames="Id">
                                <Columns>
                                    <telerik:GridButtonColumn Text="Queried Advice" CommandName="QueriedAdvice" UniqueName="QueriedAdvice" ButtonType="PushButton" ButtonCssClass="btn-primary" Exportable="false">
                                        <HeaderStyle Width="120px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" SortExpression="Id" UniqueName="Id" Display="false">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BatchNo" HeaderText="BatchNo" SortExpression="BatchNo" UniqueName="BatchNo">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ServiceProvider" HeaderText="ServiceProvider" SortExpression="ServiceProvider" UniqueName="ServiceProvider">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DateStamp" HeaderText="DateStamp" SortExpression="DateStamp" UniqueName="DateStamp">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="QueryStatus" HeaderText="QueryStatus" SortExpression="QueryStatus" UniqueName="QueryStatus">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UserName" HeaderText="UserName" SortExpression="UserName" UniqueName="UserName">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn Text="Complete" CommandName="Complete" UniqueName="Complete" ConfirmText="Complete Query?" ButtonType="PushButton" ButtonCssClass="btn-info" Exportable="false">
                                        <HeaderStyle Width="80px" />
                                    </telerik:GridButtonColumn>
                                   
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="querySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top(50) Id, BatchNo, ServiceProvider, DateStamp, QueryStatus, UserName FROM vwQueries WHERE ([BatchNo] LIKE '%' + @BatchNo + '%' AND HspOfficerId LIKE '%' + @UserId + '%') ORDER BY DateStamp DESC">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtSearch" Name="BatchNo" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
                                                <asp:CookieParameter CookieName="userid" Type="String" Name="UserId" DefaultValue="" ConvertEmptyStringToNull="false" />
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
</asp:Content>
