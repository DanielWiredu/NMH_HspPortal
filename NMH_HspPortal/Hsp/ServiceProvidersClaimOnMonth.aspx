<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ServiceProvidersClaimOnMonth.aspx.cs" Inherits="NMH_HspPortal.Hsp.ServiceProvidersClaimOnMonth" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                       <p>Service Providers Month-On-Month Submitted Claim Amount</p>
                        

                        <div class="form-group">
                          <div class="row">
                              <div class="col-md-3">

                              </div>
                                    <div class="col-md-3">
                                        <label>Year</label>
                                         <telerik:RadDropDownList ID="dlYear" runat="server" Width="100%" DropDownHeight="200px"></telerik:RadDropDownList>
                                    </div>
                              <div class="col-md-2">
                                        <label>Click</label>
                                         <asp:Button runat="server" ID="btnRun" Text="Run" CssClass="btn-primary" OnClick="btnRun_Click" Width="100%" />
                                    </div>
                              <div class="col-md-3">

                              </div>
                          </div>
                      </div>

                        <div class="row">
              <telerik:RadGrid ID="claimsGrid" runat="server" AllowPaging="true" AutoGenerateColumns="false" AllowFilteringByColumn="False" AllowSorting="True" DataSourceID="claimSource" GroupPanelPosition="Top" CellSpacing="-1" GridLines="Both">
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" />
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                         <Resizing AllowColumnResize="true" AllowRowResize="true" />
                                    </ClientSettings>
                                    <GroupingSettings CaseSensitive="false" />
                                    <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="claimSummary" HideStructureColumns="true">
                                    </ExportSettings>
                                    <MasterTableView DataSourceID="claimSource" PageSize="100">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="ServiceProvider" FilterControlAltText="Filter ServiceProvider column" HeaderText="ServiceProvider" SortExpression="ServiceProvider" UniqueName="ServiceProvider">
                                                <HeaderStyle Width="250px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Jan"  HeaderText="Jan" SortExpression="Jan" UniqueName="Jan" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Feb" HeaderText="Feb" SortExpression="Feb" UniqueName="Feb" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Mar" HeaderText="Mar" SortExpression="Mar" UniqueName="Mar" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Apr" HeaderText="Apr" SortExpression="Apr" UniqueName="Apr" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="May" HeaderText="May" SortExpression="May" UniqueName="May" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Jun" HeaderText="Jun" SortExpression="Jun" UniqueName="Jun" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Jul" HeaderText="Jul" SortExpression="Jul" UniqueName="Jul" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Aug" HeaderText="Aug" SortExpression="Aug" UniqueName="Aug" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Sep" HeaderText="Sep" SortExpression="Sep" UniqueName="Sep" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Oct" HeaderText="Oct" SortExpression="Oct" UniqueName="Oct" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Nov" HeaderText="Nov" SortExpression="Nov" UniqueName="Nov" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Dec" HeaderText="Dec" SortExpression="Dec" UniqueName="Dec" EmptyDataText="0.00" DataFormatString="{0:N02}">
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
             <asp:SqlDataSource ID="claimSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="spGetAllProviderClaim_OnMonth" SelectCommandType="StoredProcedure">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="dlYear" Name="YearOfClaim" PropertyName="SelectedText" Type="Int32" DefaultValue="2000" ConvertEmptyStringToNull="false" />
                     <asp:CookieParameter CookieName="userid" Type="String" Name="UserId" DefaultValue="" ConvertEmptyStringToNull="false" />
                 </SelectParameters>
                </asp:SqlDataSource>
             
                <div class="modal-footer">
                    <asp:Button ID="btnExcelExport" runat="server" Text="Excel" CssClass="btn btn-primary" OnClick="btnExcelExport_Click" CausesValidation="false" />
                </div>
         </div>
                    </div>
                </div>
            </div>
                </div>

         

        </div>
</asp:Content>
