<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AccountSettings.aspx.cs"
    Inherits="AccountSettings" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Account Settings</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <!-- Bootstrap responsive -->
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
    <!-- jQuery UI -->
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/style.css" />
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
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();

        };
        function DoWork() {
            $('#brand').on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            /////////////////////////////////////////////////
            ///////////// Account Tab////////////////////////
            /////////////////////////////////////////////////

            /////////////////////////////////////////////////
            ///////////// End of Account Tab/////////////////
            /////////////////////////////////////////////////
        };

    </script>
</head>
<body class='<%= this.UserTheme%>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" />
        <div id="navigation" class="navbar-fixed-top">
            <!-- Header -->
            <div class="container-fluid">
                <a id="brand">Umbrella</a> <a href="#" class="toggle-nav" rel="tooltip" data-placement="bottom"
                    title="Toggle navigation"><i class="icon-reorder"></i></a>
                <ul class='main-nav'>
                    <li><a href="Home.aspx"><span>Home</span> </a></li>
                    <li class='active'><a href="AccountSettings.aspx"><span>Account Settings</span> </a>
                    </li>
                </ul>
                <div class="user">
                    <ul class="icon-nav">
                        <li class='dropdown colo'><a href="#" class='dropdown-toggle' data-toggle="dropdown">
                            <i class="icon-tint"></i></a>
                            <ul class="dropdown-menu pull-right theme-colors">
                                <li class="subtitle">Predefined colors </li>
                                <li><span class='red'></span><span class='orange'></span><span class='green'></span>
                                    <span class="brown"></span><span class="blue"></span><span class='lime'></span><span
                                        class="teal"></span><span class="purple"></span><span class="pink"></span><span class="magenta"></span><span class="grey"></span><span class="darkblue"></span><span class="lightred"></span><span class="lightgrey"></span><span class="satblue"></span><span class="satgreen"></span></li>
                            </ul>
                        </li>
                    </ul>
                    <div class="dropdown">
                        <a href="#" class='dropdown-toggle' data-toggle="dropdown">
                            <asp:Label ID="lblUserName" Text="Moustafa Ebrahem" runat="server" />
                            <img src="img/demo/user-img-s.png" alt="" /></a>
                        <ul class="dropdown-menu pull-right">
                            <li><a href="AccountSettings.aspx">Account Settings</a></li>
                            <li>
                                <asp:LinkButton ID="lbSignOut" runat="server" OnClick="lbSignOut_Click">Sign Out</asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- End of Header -->
        </div>
        <div id="content" class="container nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2>Account Settings</h2>
                        </div>
                        <div class="pull-right">
                            <ul class="stats">
                                <li class='lightred'><i class="icon-calendar"></i>
                                    <div class="details">
                                        <span class="big">August 14, 2013</span> <span>Wednesday, 04:04</span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div id="t1" class="span12">
                            <div class="box box-color box-bordered">
                                <div class="box-title">
                                    <h3>
                                        <i class="glyphicon-settings"></i>Account Settings
                                    </h3>
                                </div>
                                <div class="box-content nopadding">
                                    <div class='form-horizontal form-column form-bordered'>
                                        <asp:UpdatePanel ID="upAccount" runat="server" UpdateMode="Always">
                                            <ContentTemplate>
                                                <div id="tblAccount" class="span6">
                                                    <div class="control-group">
                                                        <label for="textfield" class="control-label">
                                                            Action:</label>
                                                        <div class="controls">
                                                            <asp:Button ID="btnUpdateEmail" Text="Update Email" runat="server" CssClass="btn btn-primary"
                                                                Width="130px" ValidationGroup="e" OnClick="btnUpdateEmail_Click" OnClientClick="if (!Page_ClientValidate('e')){ return false; } this.disabled = true; this.value = 'Updating';"
                                                                UseSubmitBehavior="false" />
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label for="textfield" class="control-label">
                                                            User-Name:</label>
                                                        <div class="controls">
                                                            <input id="txtUserName" runat="server" type="text" placeholder="User Name" class="input-xlarge"
                                                                disabled="disabled" />
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label for="textfield" class="control-label">
                                                            Email:</label>
                                                        <div class="controls">
                                                            <input id="txtEmail" runat="server" type="text" placeholder="Email Address" class="input-xlarge"
                                                                maxlength="50" autocomplete="off" validationgroup="e" />
                                                            <asp:RequiredFieldValidator ID="rvtxtEmail" runat="server" ControlToValidate="txtEmail"
                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                ValidationGroup="e"></asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="retxtEmail" runat="server" ControlToValidate="txtEmail"
                                                                Display="Dynamic" ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True"
                                                                ValidationGroup="e" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="span6">
                                                    <div class="control-group">
                                                        <label for="textfield" class="control-label">
                                                            Action:</label>
                                                        <div class="controls">
                                                            <asp:Button ID="btnUpdatePass" Text="Update Password" runat="server" CssClass="btn btn-primary"
                                                                Width="130px" ValidationGroup="p" OnClick="btnUpdatePass_Click" OnClientClick="if (!Page_ClientValidate('p')){ return false; } this.disabled = true; this.value = 'Updating';"
                                                                UseSubmitBehavior="false" />
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label for="textfield" class="control-label">
                                                            Old-Pass:</label>
                                                        <div class="controls">
                                                            <input id="txtOldPass" runat="server" type="password" placeholder="Old Password"
                                                                class="input-xlarge" maxlength="35" autocomplete="off" validationgroup="p" />
                                                            <asp:RequiredFieldValidator ID="rvtxtOldPass" runat="server" ControlToValidate="txtOldPass"
                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                ValidationGroup="p"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label for="textfield" class="control-label">
                                                            New-Pass:</label>
                                                        <div class="controls">
                                                            <input id="txtNewPass" runat="server" type="password" placeholder="New Password"
                                                                class="input-xlarge" maxlength="35" autocomplete="off" validationgroup="p" />
                                                            <asp:RequiredFieldValidator ID="rvtxtNewPass" runat="server" ControlToValidate="txtNewPass"
                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                ValidationGroup="p"></asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="retxtNewPass" runat="server" ControlToValidate="txtNewPass"
                                                                Display="Dynamic" ErrorMessage="<br/>Password length must be between 5 to 35 characters"
                                                                ForeColor="#CC0000" SetFocusOnError="True" ValidationGroup="p" ValidationExpression="^.{5,35}$"></asp:RegularExpressionValidator>
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label for="textfield" class="control-label">
                                                            Confirm-Pass:</label>
                                                        <div class="controls">
                                                            <input id="txtConfirmPass" runat="server" type="password" placeholder="Confirm Password"
                                                                class="input-xlarge" maxlength="35" autocomplete="off" validationgroup="p" />
                                                            <asp:RequiredFieldValidator ID="rvtxtConfirmPass" runat="server" ControlToValidate="txtConfirmPass"
                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                ValidationGroup="p"></asp:RequiredFieldValidator>
                                                            <asp:CompareValidator ID="cvtxtConfirmPass" runat="server" ControlToCompare="txtNewPass"
                                                                Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True" ControlToValidate="txtConfirmPass"
                                                                ErrorMessage="*Not Match" ValidationGroup="p"></asp:CompareValidator>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfTheme" runat="server" ClientIDMode="Static" />
        <asp:Button ID="btnSaveTheme" runat="server" OnClick="btnSaveTheme_Click" CssClass="hide" />
        <div id="footer">
            <p meta:resourcekey="pAboutus" runat="server">
                Umbrella v3.4 - © All Rights Reserved For APPLET Software <span class="font-grey-4">|</span><a href="AboutUs.aspx" target="_blank"> About Us </a>
            </p>
            <a href="#" class="gototop"><i class="icon-arrow-up"></i></a>
        </div>
    </form>
    <asp:PlaceHolder runat="server" ID="phBottomScripts" />
</body>
</html>
