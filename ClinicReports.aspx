<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClinicReports.aspx.cs"
    Inherits="FinancialsReports" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="~/ucReports.ascx" TagPrefix="uc1" TagName="ucReports" %>
<%@ Register Src="~/ucStyle_Scripts.ascx" TagPrefix="uc1" TagName="ucStyle_Scripts" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Financials Reports</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="ClinicReports.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });

        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        }
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
        };
    </script>
    <style type="text/css">
        .rep-list {
            background: #f6f6f6;
            border: 5px solid #e5e5e5;
            border-radius: 3px;
            margin: auto;
            list-style: url(img/mark.png) inside;
            padding: 0;
        }

            .rep-list li {
                border-bottom: 1px solid #E5E5E5;
                height: 30px;
                padding: 10px;
            }

                .rep-list li:last-child {
                    border-bottom: none;
                }

        .rep-link {
            text-decoration: none;
            font-size: 14px;
            color: #535353;
        }

            .rep-link:hover {
                color: #00B9EE;
                text-decoration: underline;
            }
    </style>
</head>
<body class='<%= this.UserTheme%>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" meta:resourcekey="btnDefaultResource1" />
        <uc1:ucReports runat="server" ID="ucReports" />
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="h2Financials_Reports" runat="server">Clinic_ud Reports</h2>
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
                    <div class="row-fluid container-fluid">
                        <div class="container-fluid">
                            <div class="box box-color box-bordered">
                                <div class="box-title">
                                    <h3 meta:resourcekey="h3Financials_Reports" runat="server">
                                        <i class="glyphicon-coins"></i>Clinic_ud Reports
                                    </h3>
                                </div>
                                <div class="box-content nopadding">
                                    <ul class="rep-list">
                                        <li><a href="PatientVisitReport.aspx" class="rep-link" meta:resourcekey="Patient_Visits_Report" runat="server">Patient Visits Report</a>
                                        </li>
                                        <li><a href="PatientDetailReport.aspx" class="rep-link" meta:resourcekey="patient_Datials_Report" runat="server">patient Datials Report</a>
                                        </li>
                                        <li><a id="A1" href="PatientAccountReport.aspx" class="rep-link" meta:resourcekey="Patient_Account_Report" runat="server">Patient Account Report</a>
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
            <p id="P2" meta:resourcekey="pAboutus" runat="server">
                Umbrella v3.4 - © All Rights Reserved For APPLET Software <span class="font-grey-4">|</span><a href="AboutUs.aspx" target="_blank"> About Us </a>
            </p>
            <a href="#" class="gototop"><i class="icon-arrow-up"></i></a>
        </div>
    </form>
    <asp:PlaceHolder runat="server" ID="phBottomScripts" />
</body>
</html>
