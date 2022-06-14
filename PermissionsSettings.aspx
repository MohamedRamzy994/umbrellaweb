<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PermissionsSettings.aspx.cs"
    Inherits="PermissionsSettings" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Src="~/ucMenuControlPanel.ascx" TagPrefix="uc1" TagName="ucMenuControlPanel" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Permissions Settings</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css" meta:resourcekey="bootstrap" runat="server" />
    <!-- Bootstrap responsive -->
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" meta:resourcekey="bootstrapresponsive" runat="server" />
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/style.css" meta:resourcekey="style" runat="server" />
    <!-- jQuery UI -->
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
    <!-- Color CSS -->
    <link rel="stylesheet" href="css/themes.css" />
    <!-- GridView CSS -->
    <link href="css/gridview.css" rel="stylesheet" />
    <!-- Select2 CSS-->
    <link rel="stylesheet" href="css/plugins/select2/select2.css" />
    <!-- jQuery -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- My Library -->
    <script type="text/javascript" src="js/FQuery.js"></script>
    <!-- jQuery UI -->
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.core.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.widget.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.mouse.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.resizable.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.sortable.min.js"></script>
    <!-- Bootstrap -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <!-- NiceScroll -->
    <script type="text/javascript" src="js/plugins/nicescroll/jquery.nicescroll.min.js"></script>
    <!-- mNotification -->
    <link href="css/toastr.css" rel="stylesheet" />
    <script src="js/toastr.js"></script>
    <!-- ion.sound -->
    <script type="text/javascript" src="js/ion.sound.min.js"></script>
    <!-- persianumber -->
    <script src="js/persianumber.min.js"></script>
    <!-- mQuery -->
    <script src="js/mQuery.js"></script>
    <!-- Select2 -->
    <script type="text/javascript" src="js/plugins/select2/select2.min.js"></script>
    <!-- Theme framework -->
    <script type="text/javascript" src="js/eakroko.min.js"></script>
    <!-- Theme scripts -->
    <script type="text/javascript" src="js/application.min.js"></script>
    <!-- Just for demonstration -->
    <script type="text/javascript" src="js/demonstration.min.js"></script>
    <!--[if lte IE 9]>
		<script type="text/javascript" src="js/plugins/placeholder/jquery.placeholder.min.js"></script>
		<script>
			$(document).ready(function() {
				$('input, textarea').placeholder();
			});
		</script>
		<![endif]-->
    <!-- umbrella -->
    <link rel="shortcut icon" href="img/umbrella.ico" />
    <!-- Apple devices Homescreen icon -->
    <link rel="apple-touch-icon-precomposed" href="img/apple-touch-icon-precomposed.png" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="PermissionsSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };
        function DoWork() {

            /////////////////////////////////////////////////
            /////////// Users_ud Permissions Tab ///////////////
            /////////////////////////////////////////////////
            $('#drpSections').select2();
            $('#drpUsers_ud').select2();
            $('#gvPerm .gvrow td:nth-child(3)').click(function () {
                $(this).parent().toggleClass("blue3");
            });
            /////////////////////////////////////////////////
            ////// End of Users_ud Permissions Tab /////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
    </script>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide"  />
        <uc1:ucMenuControlPanel runat="server" ID="ucMenuControlPanel" />
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="hPermSettings" runat="server">Permissions Settings</h2>
                        </div>
                        <div class="pull-right">
                            <ul class="stats">
                                <li class='grey'><i class="icon-calendar"></i>
                                    <div class="details">
                                        <span class="big">August 14, 2013</span> <span>Wednesday, 04:04</span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="box box-color">
                                <div class="box-title">
                                    <h3 meta:resourcekey="hPermSett" runat="server">
                                        <i class="glyphicon-settings"></i>Permissions Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="aPermSett" runat="server">Permissions Settings</a></li>
                                        <li><a href="UsersSettings.aspx" meta:resourcekey="aUsers_udSett" runat="server">Users_ud Settings</a></li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div id="divPerm" runat="server" class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hUsers_udPerm" runat="server">
                                                            <i class="glyphicon-lock"></i>User's Permissions</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upPerm" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblPerm" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <asp:Button ID="btnPermSave" Text="Save" runat="server" CssClass="btn btn-grey"
                                                                                Width="85px" OnClick="btnPermSave_Click" OnClientClick="this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnPermSaveResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblUsers_ud" runat="server">
                                                                            Users_ud:-</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpUsers_ud" runat="server" CssClass="input-large" AutoPostBack="True"
                                                                                OnSelectedIndexChanged="drpUsers_ud_SelectedIndexChanged" meta:resourcekey="drpUsers_udResource1">
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblSections" runat="server">
                                                                            Sections:-</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpSections" runat="server" CssClass="input-large" AutoPostBack="True"
                                                                                OnSelectedIndexChanged="drpPerm_SelectedIndexChanged" meta:resourcekey="drpSectionsResource1">
                                                                                <asp:ListItem Text="Reception" Value="1" meta:resourcekey="ListItemResource1" />
                                                                                <asp:ListItem Text="General Clinic_ud " Value="2" meta:resourcekey="ListItemResource2" />
                                                                                <asp:ListItem Text="Control Panel" Value="3" meta:resourcekey="ListItemResource3" />
                                                                                <asp:ListItem Text="Financial" Value="4" meta:resourcekey="ListItemResource4" />
                                                                                <asp:ListItem Text="Reports" Value="5" meta:resourcekey="ListItemResource5" />
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span7">
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvPerm" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvPermResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="page_id" HeaderText="page_id" meta:resourcekey="BoundFieldResource1" >
                                                                                <HeaderStyle CssClass="hide" />
                                                                                <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="section_id" HeaderText="section_id" meta:resourcekey="BoundFieldResource2" >
                                                                                <HeaderStyle CssClass="hide" />
                                                                                <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="page_name" HeaderText="Page Name" meta:resourcekey="BoundFieldResource3" />
                                                                                <asp:TemplateField HeaderText="View" meta:resourcekey="TemplateFieldResource1">
                                                                                    <ItemTemplate>
                                                                                        <asp:CheckBox ID="ChkView" runat="server" Enabled='<%# Convert.ToBoolean(Eval("isview")) %>' meta:resourcekey="ChkViewResource1" />
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Save" meta:resourcekey="TemplateFieldResource2">
                                                                                    <ItemTemplate>
                                                                                        <asp:CheckBox ID="ChkSave" runat="server" Enabled='<%# Convert.ToBoolean(Eval("issave")) %>' meta:resourcekey="ChkSaveResource1" />
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Update" meta:resourcekey="TemplateFieldResource3">
                                                                                    <ItemTemplate>
                                                                                        <asp:CheckBox ID="ChkUpdate" runat="server" Enabled='<%# Convert.ToBoolean(Eval("isupdate")) %>' meta:resourcekey="ChkUpdateResource1" />
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Delete" meta:resourcekey="TemplateFieldResource4">
                                                                                    <ItemTemplate>
                                                                                        <asp:CheckBox ID="ChkDelete" runat="server" Enabled='<%# Convert.ToBoolean(Eval("isdelete")) %>' meta:resourcekey="ChkDeleteResource1" />
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Print" meta:resourcekey="TemplateFieldResource5">
                                                                                    <ItemTemplate>
                                                                                        <asp:CheckBox ID="ChkPrint" runat="server" Enabled='<%# Convert.ToBoolean(Eval("isprint")) %>' meta:resourcekey="ChkPrintResource1" />
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                            <HeaderStyle CssClass="gvgray" />
                                                                            <RowStyle CssClass="blue2 gvrow" />
                                                                            <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                            <EmptyDataRowStyle CssClass="gvempty" />
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <br />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="modal-1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
            aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×</button>
                <h3 id="myModalLabel" meta:resourcekey="myModalLabel" runat="server">Deletion Confirmation</h3>
            </div>
            <div class="modal-body">
                <p id="P1" meta:resourcekey="pDelete" runat="server">
                    Are you sure that you want to permanently delete this record ?
                </p>
            </div>
            <div class="modal-footer">
                <button id="Button1" class="btn" data-dismiss="modal" aria-hidden="true" meta:resourcekey="btnNo" runat="server">
                    No
                </button>
                <button id="btnConfirm" class="btn btn-primary" data-dismiss="modal" meta:resourcekey="btnYes" runat="server">
                    Yes
                </button>
            </div>
        </div>
        <asp:HiddenField ID="hfTheme" runat="server" ClientIDMode="Static" />
        <asp:Button ID="btnSaveTheme" runat="server" OnClick="btnSaveTheme_Click" CssClass="hide"/>
        <div id="footer">
            <p id="P2" meta:resourcekey="pAboutus" runat="server">
                Umbrella v3.4 - © All Rights Reserved For APPLET Software <span class="font-grey-4">|</span><a href="AboutUs.aspx" target="_blank"> About Us </a>
            </p>
            <a href="#" class="gototop"><i class="icon-arrow-up"></i></a>
        </div>
    </form>
</body>
</html>
