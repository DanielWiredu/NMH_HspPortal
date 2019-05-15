<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="NMH_HspPortal.Dashboard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Dashboard</h5>
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

                        <div style="text-align:center;vertical-align:middle">
                            <a class="btn btn-success" href="/Hsp/MyDashboard.aspx"> My Dashboard </a>
                        </div>

                        <div class="row">
                    <div class="col-md-12">
                                    <telerik:RadHtmlChart runat="server" Width="100%" Height="600px" ID="chtProviderDistribution" Skin="Silk" DataSourceID="providerSource">
            <PlotArea>
                <Series>
                    <telerik:ColumnSeries Name="No of Providers" DataFieldY="PROVIDERS">
                        <TooltipsAppearance Color="White"  />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis  DataLabelsField="REGION">
                    <LabelsAppearance RotationAngle="45">
                    </LabelsAppearance>
                    <TitleAppearance Text="Region">
                    </TitleAppearance>
                </XAxis>
                <YAxis>
                    <TitleAppearance Text="No of Providers">
                    </TitleAppearance>
                </YAxis>
            </PlotArea>
            <Legend>
                <Appearance Visible="false">
                </Appearance>
            </Legend>
            <ChartTitle Text="Providers Regional Distribution">
            </ChartTitle>
        </telerik:RadHtmlChart>

                    <asp:SqlDataSource ID="providerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select REGION, count(id) AS PROVIDERS from Vw_ServiceProvider WHERE Region is not null group by Region"></asp:SqlDataSource>

                    </div>

                </div>
                    </div>
                </div>
        </div>
</asp:Content>
