<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="HSPOfficers.aspx.cs" Inherits="NMH_HspPortal.Hsp.HSPOfficers" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>HSP Officers </h5>
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
                                           <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Name..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                       </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <%--<asp:Button runat="server" ID="btnAdd" CssClass="btn-primary" Text="Add New" CausesValidation="false" OnClientClick="newModal()"/>--%>  
                                                <asp:Button runat="server" ID="btnExcelExport" CssClass="btn-primary pull-right" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click" /> 
                                            </div>
                                        </div>
                                    </div>

                        <asp:Button runat="server" ID="btnAddUser" CssClass="btn btn-success" Text="Add Officer" OnClientClick="newModal();" />
                       <hr />
                        <telerik:RadGrid ID="hspGrid" runat="server" AllowPaging="true" AllowSorting="True" DataSourceID="hspSource" GroupPanelPosition="Top" OnItemCommand="hspGrid_ItemCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" ScrollHeight="350px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="HSP_Officers_List" HideStructureColumns="true">
                                    </ExportSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="hspSource" PageSize="50">
                                <Columns>
                                    <telerik:GridBoundColumn Display="false" DataField="UserID" DataType="System.Int32" FilterControlAltText="Filter UserID column" HeaderText="UserID" ReadOnly="True" SortExpression="UserID" UniqueName="UserID">
                                    <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UserName" FilterControlAltText="Filter UserName column" HeaderText="UserName" SortExpression="UserName" UniqueName="UserName">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhoneNumber" FilterControlAltText="Filter PhoneNumber column" HeaderText="PhoneNumber" SortExpression="PhoneNumber" UniqueName="PhoneNumber">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UserRole" FilterControlAltText="Filter UserRole column" HeaderText="UserRole" SortExpression="UserRole" UniqueName="UserRole">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn Text="Edit" CommandName="Edit" UniqueName="Edit" ButtonType="PushButton" ButtonCssClass="btn-info" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                   <%-- <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete this Company Plan and all associated Benefits?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>--%>
                                </Columns>
                            </MasterTableView>
                                        </telerik:RadGrid>

                                        <asp:SqlDataSource ID="hspSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top(50) UserID, UserName, Email, PhoneNumber, UserRole FROM tblUsers WHERE ([UserName] LIKE '%' + @UserName + '%') ORDER BY UserName">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtSearch" Name="UserName" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
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

    <!-- New modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <%--<asp:Panel runat="server" DefaultButton="btnSearch">--%>
            <asp:UpdatePanel runat="server" ID="upMail">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Officer</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Username</label>
                                       <asp:TextBox runat="server" ID="txtUsername" ClientIDMode="Static" Width="100%" MaxLength="50" ></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtUsername" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label>Password</label>
                                       <asp:TextBox runat="server" ID="txtPassword" Width="100%" TextMode="Password" MaxLength="50" ></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label>Email</label>
                                       <asp:TextBox runat="server" ID="txtEmail" Width="100%" TextMode="Email" MaxLength="50" ></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label>Role</label>
                                       <telerik:RadDropDownList runat="server" ID="dlRole" Width="100%">
                                           <Items>
                                               <telerik:DropDownListItem Text="User" />
                                               <telerik:DropDownListItem Text="Admin" />
                                           </Items>
                                       </telerik:RadDropDownList>
                             </div>
                            <div>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary"  OnClick="btnSave_Click" ValidationGroup="new" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--</asp:Panel>--%>
        </div>
         </div>

    <!-- Edit modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <%--<asp:Panel runat="server" DefaultButton="btnSearch">--%>
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Officer</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Username</label>
                                       <asp:TextBox runat="server" ID="txtUsername1" ClientIDMode="Static" Width="100%" MaxLength="50" ></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtUsername1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label>Password</label>
                                       <asp:TextBox runat="server" ID="txtPassword1" Width="100%" TextMode="Password" MaxLength="50" ></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtPassword1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label>Email</label>
                                       <asp:TextBox runat="server" ID="txtEmail1" Width="100%" TextMode="Email" MaxLength="50" ></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtEmail1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label>Role</label>
                                       <telerik:RadDropDownList runat="server" ID="dlRole1" Width="100%">
                                           <Items>
                                               <telerik:DropDownListItem Text="User" />
                                               <telerik:DropDownListItem Text="Admin" />
                                           </Items>
                                       </telerik:RadDropDownList>
                             </div>
                            <div>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary"  OnClick="btnUpdate_Click" ValidationGroup="edit" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--</asp:Panel>--%>
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
            $('#newmodal').on('shown.bs.modal', function () {
                // jQuery code is in here
                $('#txtUsername').focus();
            });
            function editModal() {
                $('#editmodal').modal('show');
                $('#editmodal').appendTo($("form:first"));
            }
            function closeeditModal() {
                $('#editmodal').modal('hide');
            }
            $('#editmodal').on('shown.bs.modal', function () {
                // jQuery code is in here
                $('#txtUsername1').focus();
            });
    </script>
</asp:Content>
