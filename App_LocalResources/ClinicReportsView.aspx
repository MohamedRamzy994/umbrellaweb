<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClinicReportsView.aspx.cs"
    Inherits="ClinicReportsView" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Src="~/ucfinancialReports.ascx" TagPrefix="uc1" TagName="ucfinancialReports" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Financials Reports View</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <!-- Bootstrap -->
    <link id="Link1" rel="stylesheet" href="css/bootstrap.min.css" meta:resourcekey="bootstrap" runat="server" />
    <!-- Bootstrap responsive -->
    <link id="Link2" rel="stylesheet" href="css/bootstrap-responsive.min.css" meta:resourcekey="bootstrapresponsive" runat="server" />
    <!-- jQuery UI -->
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/style.css"  meta:resourcekey="style" runat="server" />
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
    <%--    <!-- mSounds -->
    <script src="js/mSounds.js"></script>--%>
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
            $('#hfLoad').val('');
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
            $('a').unbind('click').bind('click', function () {
                debugger;
                var txt = $(this).text();
                if (txt == 'Summary') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbSummary', '');
                }
                if (txt == 'Visits') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbVisits', '');
                }
                else if (txt == 'From Companies_ud') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbFromCompanies_ud', '');
                }
                else if (txt == 'From Patients_ud') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbFromPatients_ud', '');
                }
                else if (txt == 'Returned Visits') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbReturnedVisits', '');
                }
                else if (txt == 'For Companies_ud') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbForCompanies_ud', '');
                }
                else if (txt == 'For Patients_ud') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbForPatients_ud', '');
                }
                else if (txt == 'For Examinations_ud') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbForExaminations_ud', '');
                }
                else if (txt == 'Withdrawals') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbWithdrawals', '');
                }
                else if (txt == 'Daily Summary') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbDailySummary', '');
                }
                else if (txt == 'Daily Detail') {
                    $('#hfLoad').val('1');
                    __doPostBack('lbDailyDetail', '');
                }
            });
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        }
        function MakeActive(aID) {
            $('#' + aID + '').parent().addClass('active');
        }
        function MakeActive2(aID) {
            $('#' + aID + '').parent().parent().parent().addClass('active');
        }
    </script>
</head>
<body class='<%= this.UserTheme%>'>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" meta:resourcekey="btnDefaultResource1" />
    <asp:HiddenField ID="hfLoad" runat="server" ClientIDMode="Static" />
        <uc1:ucfinancialReports runat="server" ID="ucfinancialReports" />
    <div id="content" class="container nav-fixed">
        <div id="main" style="margin-left: -55px;">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">
                        <CR:CrystalReportViewer ID="crv" runat="server" AutoDataBind="True" PrintMode="ActiveX"
                            ToolPanelView="None" GroupTreeImagesFolderUrl="" Height="50px" meta:resourcekey="crvResource1" ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="350px" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
    <asp:PlaceHolder runat="server" ID="phBottomScripts" />
</body>
</html>
