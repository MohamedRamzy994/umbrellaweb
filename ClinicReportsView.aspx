<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClinicReportsView.aspx.cs"
    Inherits="ClinicReportsView" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Src="~/ucfinancialReports.ascx" TagPrefix="uc1" TagName="ucfinancialReports" %>
<%@ Register Src="~/ucStyle_Scripts.ascx" TagPrefix="uc1" TagName="ucStyle_Scripts" %>
<%@ Register Src="~/ucGeneralClinicReports.ascx" TagPrefix="uc1" TagName="ucGeneralClinicReports" %>
<%@ Register Src="~/ucGeneralClinicsReports.ascx" TagPrefix="uc1" TagName="ucGeneralClinicsReports" %>
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
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
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
        <uc1:ucGeneralClinicsReports runat="server" ID="ucGeneralClinicsReports" />
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
