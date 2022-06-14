<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientAccountReport.aspx.cs"
    Inherits="PatientAccountReport" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

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
    <title>Patient Account Report</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="AllClinicReports.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };
        function DoWork() {

            $('#txtDateFrom').datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
            }).on('changeDate', function () {
                if ($('#txtDateTo').val() == '')
                    return;
                __doPostBack('btnDateValidation', '');
            });

            $('#txtDateTo').datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
            }).on('changeDate', function () {
                if ($('#txtDateFrom').val() == '')
                    return;
                __doPostBack('btnDateValidation', '');
            });
            $('#txtDateFrom').on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });
            $('#txtDateTo').on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });

            $('#btnResultPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if (!Page_ClientValidate('r')) { return false; }
                if ($('#txtDateFrom').val() == '' || $('#txtDateTo').val() == '') { return; }
                var str = "FinancialsReportsView.aspx?data=perdet," + $('#txtDateFrom').val() + "," + $('#txtDateTo').val();
                // $.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            $("#gvResults .gvrow").click(function () {
                // $("#gvResults .gvrow").removeClass("blue3");
                $(this).toggleClass("blue3");
            });
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
    </script>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
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
                            <h2 meta:resourcekey="h2Daily_Summary_Report" runat="server">Daily Detail Report</h2>
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
                            <asp:UpdatePanel ID="upResult" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div class="box box-color box-bordered">
                                        <div class="box-title">
                                            <h3 meta:resourcekey="h3Daily_Summary_Report" runat="server">
                                                <i class="glyphicon-settings"></i>Daily Detail Report
                                            </h3>
                                            <div class="actions">
                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".r1"><i class="icon-sort"></i></a>
                                            </div>
                                        </div>
                                        <div class="box-content nopadding r1 in collapse">
                                            <div class="tab-content">
                                                <div id="t1" class="tab-pane active">
                                                    <div class='form-horizontal form-column form-bordered'>
                                                        <div class="span12">
                                                            <div class="control-group">
                                                                <label for="textfield" class="control-label" title="Actions" meta:resourcekey="textfieldActions" runat="server">
                                                                    Actions:</label>
                                                                <div class="controls">
                                                                    <asp:Button ID="btnResultSearch" Text="Search" runat="server" CssClass="btn btn-grey"
                                                                        OnClick="btnResultSearch_Click" OnClientClick="if (!Page_ClientValidate('r')){ return false; } this.disabled = true; this.value = 'Searching'; if(document.getElementById('btnResultPrint')!= null){document.getElementById('btnResultPrint').disabled=true;}"
                                                                        UseSubmitBehavior="False" Width="104px" ValidationGroup="r" ToolTip="Search for Results" meta:resourcekey="btnResultSearchResource1" />&nbsp;&nbsp;
                                                                <asp:Button ID="btnResultPrint" Text="Print" runat="server" CssClass="btn btn-satblue"
                                                                    Width="104px" ValidationGroup="r" CommandArgument="print" ToolTip="Print Results" meta:resourcekey="btnResultPrintResource1" />
                                                                    <asp:Button ID="btnDateValidation" runat="server" CssClass="hide" OnClick="btnDateValidation_Click" meta:resourcekey="btnDateValidationResource1" />
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label for="textfield" class="control-label" title="Date From" meta:resourcekey="textfieldPeriod" runat="server">
                                                                    Period:</label>
                                                                <div class="controls">
                                                                    <input id="txtDateFrom" meta:resourcekey="txtDateFrom" runat="server" type="text" placeholder="Date From" class="input-small"
                                                                        maxlength="10" autocomplete="off" title="Date From" readonly="readonly" />
                                                                    &nbsp;<asp:RequiredFieldValidator ID="rvtxtDateFrom" runat="server" ControlToValidate="txtDateFrom"
                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                        ValidationGroup="r" meta:resourcekey="rvtxtDateFromResource1"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="retxtDateFrom" runat="server" ControlToValidate="txtDateFrom"
                                                                        ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                                        Display="Dynamic" ValidationGroup="r" meta:resourcekey="retxtDateFromResource1"></asp:RegularExpressionValidator>
                                                                    &nbsp;&nbsp;
                                                                <input id="txtDateTo" meta:resourcekey="txtDateTo" runat="server" type="text" placeholder="Date To" class="input-small"
                                                                    maxlength="10" autocomplete="off" validationgroup="e" title="Date To" readonly="readonly" />
                                                                    &nbsp;<asp:RequiredFieldValidator ID="rvtxtDateTo" runat="server" ControlToValidate="txtDateTo"
                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                        ValidationGroup="r" meta:resourcekey="rvtxtDateToResource1"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="retxtDateTo" runat="server" ControlToValidate="txtDateTo"
                                                                        ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                                        Display="Dynamic" ValidationGroup="r" meta:resourcekey="retxtDateToResource1"></asp:RegularExpressionValidator>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box box-color box-bordered">
                                        <div class="box-title">
                                            <h3 meta:resourcekey="h3Results" runat="server">
                                                <i class="glyphicon-search"></i>Results
                                            </h3>
                                        </div>
                                        <div class="box-content nopadding">
                                            <div class="span12">
                                                <div class="scroll scrollbig3">
                                                    <asp:GridView ID="gvResults" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                        AllowPaging="True" PageSize="11" EmptyDataText="No Results Found" OnPageIndexChanging="gvResults_PageIndexChanging" meta:resourcekey="gvResultsResource1">
                                                        <Columns>
                                                            <asp:BoundField DataField="the_date" HeaderText="Date" meta:resourcekey="BoundFieldResource1" />
                                                            <asp:BoundField DataField="visits_count" HeaderText="Visits Count" meta:resourcekey="BoundFieldResource2" />
                                                            <asp:BoundField DataField="visits_total" HeaderText="Visits Total" meta:resourcekey="BoundFieldResource3" />
                                                            <asp:BoundField DataField="encash_comp_count" HeaderText="Companies_ud's EV Count" meta:resourcekey="BoundFieldResource4" />
                                                            <asp:BoundField DataField="encash_comp_total" HeaderText="Companies_ud's EV Total" meta:resourcekey="BoundFieldResource5" />
                                                            <asp:BoundField DataField="encash_pat_count" HeaderText="Patients_ud's EV Count" meta:resourcekey="BoundFieldResource6" />
                                                            <asp:BoundField DataField="encash_pat_total" HeaderText="Patients_ud's EV Total" meta:resourcekey="BoundFieldResource7" />
                                                            <asp:BoundField DataField="ret_visits_count" HeaderText="Returned Visits Count" meta:resourcekey="BoundFieldResource8" />
                                                            <asp:BoundField DataField="ret_visits_total" HeaderText="Returned Visits Total" meta:resourcekey="BoundFieldResource9" />
                                                            <asp:BoundField DataField="pay_comp_count" HeaderText="Companies_ud's PV Count" meta:resourcekey="BoundFieldResource10" />
                                                            <asp:BoundField DataField="pay_comp_total" HeaderText="Companies_ud's PV Total" meta:resourcekey="BoundFieldResource11" />
                                                            <asp:BoundField DataField="pay_pat_count" HeaderText="Patients_ud's PV Count" meta:resourcekey="BoundFieldResource12" />
                                                            <asp:BoundField DataField="pay_pat_total" HeaderText="Patients_ud's PV Total" meta:resourcekey="BoundFieldResource13" />
                                                            <asp:BoundField DataField="pay_exp_count" HeaderText="Examinations_ud's PV Count" meta:resourcekey="BoundFieldResource14" />
                                                            <asp:BoundField DataField="pay_exp_total" HeaderText="Examinations_ud's Total" meta:resourcekey="BoundFieldResource15" />
                                                            <asp:BoundField DataField="with_count" HeaderText="Withdrawals Count" meta:resourcekey="BoundFieldResource16" />
                                                            <asp:BoundField DataField="with_total" HeaderText="Withdrawals Total" meta:resourcekey="BoundFieldResource17" />
                                                        </Columns>
                                                        <PagerSettings Mode="NumericFirstLast" />
                                                        <PagerStyle CssClass="gvpagination" />
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
                        <br />
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
