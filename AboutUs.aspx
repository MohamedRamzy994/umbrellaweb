<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AboutUs.aspx.cs" Inherits="AboutUs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>About Us</title>
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
            /////////////////////////////////////////////////
            ///////////// Account Tab////////////////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            /////////////////////////////////////////////////
            ///////////// End of Account Tab/////////////////
            /////////////////////////////////////////////////
        };

    </script>
    <style type="text/css">
        .boxInfo {
            padding: 15px;
            overflow: hidden;
            box-sizing: border-box;
            width: 100%;
        }
    </style>
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
                    <li class='active'><a href="AboutUs.aspx"><span>About Us</span> </a></li>
                </ul>
                <div class="user">
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
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2>About Us</h2>
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
                        <div id="t1" class="span12">
                            <div class="box box-color box-bordered">
                                <div class="box-title">
                                    <h3>
                                        <i class="glyphicon-tags"></i>About Us
                                    </h3>
                                </div>
                                <div class="box-content nopadding">
                                    <div class='form-horizontal form-column form-bordered'>
                                        <asp:UpdatePanel ID="upAccount" runat="server" UpdateMode="Always">
                                            <ContentTemplate>
                                                <div class="span6">
                                                    <div class="boxInfo">
                                                        <img src="img/Umbrella_logo.png" alt="" width="300" height="250"/>
                                                        <div>
                                                            <p>
                                                                </br> - Affairs Patients_ud (data - visits - balances).<br />
                                                                - Prepare the limitations of cash Transactions_ud and bonds automatically.<br />
                                                                - Encashment & Payment Vouchers.<br />
                                                                - Issuing various reports ready to print.<br />
                                                                - Interfaces featured and easy to use, its designed based on bootstrap.<br />
                                                                - Users_ud authorization.
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="span6">
                                                    <div class="boxInfo">
                                                        <img src="appletlogo.png" alt="" width="250" height="220">
                                                        <div>
                                                        </br> <i class="glyphicon-building"></i>&nbsp;Qism2
                                                            ,Mansourah, Ad Daqahliyah, Egypt</br>
                                                        <i class="icon-phone"></i>&nbsp;(+2) 050  4582 239 </br>
                                                        <i class="glyphicon-iphone"></i>&nbsp;(+2) 01061876572</br>
                                                        <i class="glyphicon-e-mail"></i>&nbsp;info@appletsoftware.co.in</br>
                                                        <i class="glyphicon-facebook"></i><a href="https://www.facebook.com/APPLETSoftware" target="_blank">&nbsp;Facebook.com/APPLET.eg</a></br>                                                   
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
                Umbrella v3.4 - © All Rights Reserved For <a href="#" target="_blank">APPLET Software</a>
            </p>
            <a href="#" class="gototop"><i class="icon-arrow-up"></i></a>
        </div>
    </form>
    <asp:PlaceHolder runat="server" ID="phBottomScripts" />
</body>
</html>
