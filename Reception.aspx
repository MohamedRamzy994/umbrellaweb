<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reception.aspx.cs" Inherits="Reception" culture="auto" meta:resourcekey="Page" uiculture="auto" %>

<%@ Register Src="~/ucReception.ascx" TagPrefix="uc1" TagName="ucReception" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Reception</title>
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
    <script src="js/FQuery.js" type="text/javascript"></script>
    <!-- jQuery UI -->
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.core.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.widget.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.mouse.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.resizable.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.sortable.min.js"></script>
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
    <!-- Bootstrap -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
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
            $('a[href="Reception.aspx"]').parent().addClass('active');
            $('a[id="ucReception_brand"]').attr('id', 'brand');
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
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" />
        <uc1:ucReception runat="server" id="ucReception" />
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="hReception" runat="server">Reception</h2>
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
                                    <h3 meta:resourcekey="hRecep" runat="server">
                                        <i class="icon-ambulance"></i>Reception
                                    </h3>
                                </div>
                                <div class="box-content">
                                    <ul class="tiles">
                                        <asp:PlaceHolder ID="phReception" runat="server"></asp:PlaceHolder>
                                        <li class="lightred"><a href="Home.aspx" meta:resourcekey="tHome" runat="server"><span><i class="glyphicon-home"></i></span>
                                            <span class='name'>Home</span></a> </li>
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
