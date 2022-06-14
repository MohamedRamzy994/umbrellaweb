<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" Culture="auto" meta:resourcekey="PageTitle" UICulture="auto" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Home</title>
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
    <link href="css/gridview.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- My Library -->
    <script src="js/FQuery.js" type="text/javascript"></script>
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
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });

        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        }
        function DoWork() {
          
            
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
    </script>
    <style>
        #navigation .user .dropdown > a {
            padding: 11px 9px 9px 9px !important;
        }
    </style>
</head>
<body class='<%= this.user.theme %>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" />
        <div id="navigation" class="navbar-fixed-top">
            <!-- Header -->
            <div class="container-fluid">
                <a id="brand" meta:resourcekey="Umrella" runat="server" class="brand">Umbrella</a>
                <ul class='main-nav'>
                    <li class='active'><a href="Home.aspx" meta:resourcekey="Home" runat="server"><span>Home</span></a></li>
                    <li><a href="Reception.aspx" meta:resourcekey="Reception" runat="server"><span>Reception</span></a></li>
                    <li><a href="GeneralClinic.aspx" meta:resourcekey="GeneralClinic" runat="server"><span>General Clinic_ud</span></a></li>
                    <li><a href="ControlPanel.aspx" meta:resourcekey="ControlPanel" runat="server"><span>Control Panel</span></a></li>
                    <li><a href="Financials.aspx" meta:resourcekey="Financials" runat="server"><span>Financials</span></a></li>
                    <li><a href="Reports.aspx" meta:resourcekey="Reports" runat="server"><span>Reports</span></a></li>
                </ul>
                <div class="user">
                    <ul class="icon-nav">
                        <li id="drpColors" class='dropdown colo'><a href="#" class='dropdown-toggle' data-toggle="dropdown">
                            <i class="icon-umbrella" meta:resourcekey="iconumbrella" runat="server"></i></a>
                            <ul class="dropdown-menu pull-right theme-colors" style="width: 240px;">
                                <li class="subtitle colors" id="colors" meta:resourcekey="colors" runat="server" style="text-align: center">Favorite Colors</li>
                                 <li class="colors"><span class="grey"></span><span class='lightgrey'></span><span class="lightred"></span><span class="darkblue"></span>
                            <span class="blue"></span><span class="satblue"></span></li>
                            </ul>
                        </li>
                              <li>
                    <asp:LinkButton ID="lnkSounds" runat="server" OnClick="lnkSounds_Click" meta:resourcekey="lnkSounds" CssClass="lnkSounds"><i class='<%= this.user.msounds%>'></i></asp:LinkButton></li>
                        <li>
                            <asp:LinkButton ID="lnklang" Text="EN" runat="server" OnClick="lnklang_Click" meta:resourcekey="lnklang" CssClass="lnklang" /></li>
                    </ul>
                    <div class="dropdown">
                        <a href="#" class='dropdown-toggle' data-toggle="dropdown">
                            <asp:Label ID="lblUserName" Text="Moustafa Ebrahem" runat="server" meta:resourcekey="lblUserName" CssClass="lblUserName" />
                            <i class="icon-user"></i></a>
                        <ul class="dropdown-menu pull-right">
                            <li><a href="AccountSettings.aspx" id="aAccountSettings" meta:resourcekey="aAccountSettings" runat="server">Account Settings</a></li>
                            <li>
                                <asp:LinkButton ID="lbSignOut2" runat="server" OnClick="lbSignOut_Click" meta:resourcekey="lbSignOut2">Sign Out</asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- End of Header -->
        </div>
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="hHome" runat="server">Home</h2>
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
                            <div class="box box-color box-bordered">
                                <div class="box-title">
                                    <h3 meta:resourcekey="aApp" runat="server">
                                        <i class="icon-th-large"></i>Application Sections
                                    </h3>
                                </div>
                                <div class="box-content">
                                    <ul class="tiles">
                                        <asp:PlaceHolder ID="phAppSections" runat="server"></asp:PlaceHolder>
                                        <li class="lightred">
                                            <asp:LinkButton ID="lbSignOut" runat="server" OnClick="lbSignOut_Click" meta:resourcekey="lbSignOut"><span><i class="icon-signout"></i></span><span
                                            class='name'>Sign Out</span></asp:LinkButton>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfTheme" runat="server" ClientIDMode="Static" />
        <asp:Button ID="btnSaveTheme" runat="server" OnClick="btnSaveTheme_Click" CssClass="hide" meta:resourcekey="btnSaveThemeResource1" />
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
