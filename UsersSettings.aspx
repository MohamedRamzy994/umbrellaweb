<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UsersSettings.aspx.cs" Inherits="UsersSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="~/ucMenuControlPanel.ascx" TagPrefix="uc1" TagName="ucMenuControlPanel" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Users_ud Settings</title>
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
    <link rel="stylesheet" href="css/gridview.css" />
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
        var usernameFound;
        var emailFound;
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="UsersSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();

        };
        function DoWork() {
            $('#btnUsers_udave').attr('disabled', false);
            $('#btnUserUpdate').attr('disabled', true);
            $('#btnUserDelete').attr('disabled', true);

            /////////////////////////////////////////////////
            ///////////// Users_ud Tab/////////////////////////
            /////////////////////////////////////////////////

            //CheckUserName();
            $('#btnUserNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvUsers_ud .gvrow").removeClass("blue3");
                $('#btnUsers_udave').attr('disabled', false);
                $('#btnUserUpdate').attr('disabled', true);
                $('#btnUserDelete').attr('disabled', true);
                $('#tblUser').fClear();
            });

            $('#btnUserDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnUserDelete').attr('disabled', true);
                    $('#btnUserUpdate').attr('disabled', true);
                    $('#btnUserDelete').attr('value', 'Deleting');
                    __doPostBack('btnUserDelete', '');
                });
            });

            $('#txtSearchgvUser').keyup(function SearchtxtgvUser() {
                ClearUsertbl();
                $('#drpSearchgvUser').val('');
                var searchKey = $.trim($('#txtSearchgvUser').val().toLowerCase());
                $("#gvUsers_ud tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });

            });
            $('#drpSearchgvUser').change(function SearchdrpgvUser() {
                ClearUsertbl();
                $('#txtSearchgvUser').val('');
                var searchKey = $.trim($('#drpSearchgvUser').val().toLowerCase());
                $("#gvUsers_ud tr td:nth-child(6)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvUsers_ud .gvrow").click(function () {
                $("#gvUsers_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtUserID").val($(cells[0]).text());
                $("#txtUserName").val($(cells[1]).text());
                $("#txtPassword").val($(cells[2]).text());
                $("#txtEmail").val($(cells[3]).text());
                $("#drpAdmin").val($(cells[4]).text());
                $("#drpUsers_udtatus").val($(cells[5]).text());
                $('#btnUsers_udave').attr('disabled', true);
                $('#btnUserUpdate').attr('disabled', false);
                $('#btnUserDelete').attr('disabled', false);
                Page_ClientValidate("e");
            });

            /////////////////////////////////////////////////
            ///////////// End of Users_ud Tab///////////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
        function ClearUsertbl() {
            $("#gvUsers_ud .gvrow").removeClass("blue3");
            $('#tblUser').fClear();
            $('#btnUsers_udave').attr('disabled', false);
            $('#btnUserUpdate').attr('disabled', true);
            $('#btnUserDelete').attr('disabled', true);
        };
        function ClearSrch() {
            $('#txtSearchgvUser').val('');
            $('#drpSearchgvUser').val('');
        }
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
                            <h2 meta:resourcekey="hUsers_udSett" runat="server">Users_ud Settings</h2>
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
                                    <h3 meta:resourcekey="hUsersSettings" runat="server">
                                        <i class="glyphicon-settings"></i>Users_ud Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab"  meta:resourcekey="hUsers_udSett" runat="server">Users_ud Settings</a></li>
                                        <li><a href="PermissionsSettings.aspx"  meta:resourcekey="aPerm" runat="server">Permissions Settings</a></li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <asp:UpdatePanel ID="upUser" runat="server">
                                                    <ContentTemplate>
                                                        <div class="box box-bordered box-color">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hUsers_ud" runat="server">
                                                                    <i class="glyphicon-user"></i>Users_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div id="tblUser" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnUserNew" value="New" class="btn btn-grey" style="width: 70px" runat="server" meta:resourcekey="btnUserNew" />
                                                                            <asp:Button ID="btnUsers_udave" Text="Save" runat="server" CssClass="btn btn-blue" Width="70px"
                                                                                OnClick="btnUsers_udave_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnUsers_udaveResource1" />
                                                                            <asp:Button ID="btnUserUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnUserUpdate_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnUserDelete')!= null){document.getElementById('btnUserDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnUserUpdateResource1" />
                                                                            <asp:Button ID="btnUserDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnUserDelete_Click" CommandArgument="delete" meta:resourcekey="btnUserDeleteResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label">
                                                                            User-ID:</label>
                                                                        <div class="controls">
                                                                            <input id="txtUserID" runat="server" type="text" placeholder="User ID" class="input-xlarge"
                                                                                disabled="disabled" />
                                                                            &nbsp;
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblName" runat="server">
                                                                            User-Name:</label>
                                                                        <div class="controls">
                                                                            <input id="txtUserName" runat="server" type="text" placeholder="User Name" class="input-xlarge txtFocus"
                                                                                maxlength="50" autocomplete="off" validationgroup="e"  meta:resourcekey="txtUserName" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvtxtUserName" runat="server" ControlToValidate="txtUserName"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtUserNameResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtUserName" runat="server" ControlToValidate="txtUserName"
                                                                                Display="Dynamic" ErrorMessage="<br/>User Name length must be between 5 to 50 characters<br/>Spaces & Special Characters are not allowed"
                                                                                ForeColor="#CC0000" SetFocusOnError="True" ValidationGroup="e" ValidationExpression="[a-zA-Z0-9_]{5,50}" meta:resourcekey="retxtUserNameResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblPassword" runat="server">
                                                                            Password:</label>
                                                                        <div class="controls">
                                                                            <input id="txtPassword" runat="server" type="text" placeholder="User Password" class="input-xlarge"
                                                                                maxlength="35" autocomplete="off" validationgroup="e" meta:resourcekey="txtPassword" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvtxtPassword" runat="server" ControlToValidate="txtPassword"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtPasswordResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtPassword" runat="server" ControlToValidate="txtPassword"
                                                                                Display="Dynamic" ErrorMessage="<br/>Password length must be between 5 to 35 characters"
                                                                                ForeColor="#CC0000" SetFocusOnError="True" ValidationGroup="e" ValidationExpression="^.{5,35}$" meta:resourcekey="retxtPasswordResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblEmail" runat="server">
                                                                            Email:</label>
                                                                        <div class="controls">
                                                                            <input id="txtEmail" runat="server" type="text" placeholder="User Email" class="input-xlarge"
                                                                                maxlength="50" autocomplete="off" validationgroup="e" meta:resourcekey="txtEmail"/>
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvtxtEmail" runat="server" ControlToValidate="txtEmail"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtEmailResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtEmail" runat="server" ControlToValidate="txtEmail"
                                                                                Display="Dynamic" ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" meta:resourcekey="retxtEmailResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblAdmin" runat="server">
                                                                            Admin:</label>
                                                                        <div class="controls">
                                                                               <asp:DropDownList ID="drpAdmin" runat="server" CssClass='input-xlarge'>
                                                                                <asp:ListItem Value="1" Text="Yes" meta:resourcekey="drpYes" />
                                                                                <asp:ListItem Value="0" Text="No" meta:resourcekey="drpNo" />
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblStatus" runat="server">
                                                                            Status:</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpUsers_udtatus" runat="server" CssClass='input-xlarge'>
                                                                                <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                                <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span7">
                                                                    <div class="div_search_box">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSearchgvUser" type="text" value="" class="input-xlarge" placeholder="Search By User Name ..."
                                                                                autocomplete="off" meta:resourcekey="txtSrch" runat="server"/>
                                                                        </div>
                                                                        <asp:DropDownList ID="drpSearchgvUser" runat="server" CssClass='input-medium'>
                                                                             <asp:ListItem Value="" Text="All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvUsers_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvUsers_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="user_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="user_name" HeaderText="User Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="user_password" HeaderText="Password" meta:resourcekey="BoundFieldResource3" />
                                                                                <asp:BoundField DataField="user_email" HeaderText="Email" meta:resourcekey="BoundFieldResource4" />
                                                                                <asp:BoundField DataField="admin" HeaderText="admin" meta:resourcekey="BoundFieldResource5">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="active" HeaderText="Status" meta:resourcekey="BoundFieldResource6">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="isadmin" HeaderText="Admin" meta:resourcekey="BoundFieldResource7" ItemStyle-CssClass="yesno"/>
                                                                                   <asp:TemplateField HeaderText="Status" meta:resourcekey="BoundFieldResource6" HeaderStyle-Width="12%">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("status")%>
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
                                                            </div>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
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
        <asp:Button ID="btnSaveTheme" runat="server" OnClick="btnSaveTheme_Click" CssClass="hide" meta:resourcekey="btnSaveThemeResource1" />
        <div id="footer">
            <p id="P2" meta:resourcekey="pAboutus" runat="server">
                Umbrella v3.4 - © All Rights Reserved For APPLET Software <span class="font-grey-4">|</span><a href="AboutUs.aspx" target="_blank"> About Us </a>
            </p>
            <a href="#" class="gototop"><i class="icon-arrow-up"></i></a>
        </div>
    </form>
</body>
</html>
