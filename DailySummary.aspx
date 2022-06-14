<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DailySummary.aspx.cs" Inherits="DailySummary" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Src="~/ucFinancials.ascx" TagPrefix="uc1" TagName="ucFinancials" %>
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
    <title>Daily Summary</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="DailySummary.aspx"]').parent().addClass('active');
            $('a[id="ucFinancials_brand"]').attr('id', 'brand');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };
        function DoWork() {
            $('#txtDate').datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
            }).on('changeDate', function (ev) {
                $("#imgLoading").show();
                __doPostBack('btnRefresh', '');
            });
            $('#txtDate').on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });
            //if ($('#ucFinancials_lnklang').html() == "EN") {
            //    $('.datepicker-dropdown').css("right", "155px");
            //};
            $("#imgLoading").hide();
            $('.gvtoggle .gvrow').click(function () {
                $(this).toggleClass("blue3");
            });

            $('#btnDailyPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if (!Page_ClientValidate('s')) { return false; }
                var str = "FinancialsReportsView.aspx?data=summary," + $('#txtDate').val();
                window.open(str, '_blank');
            });
 
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        }
    </script>
<%--        <style>
        #navigation .user .dropdown > a {
            padding: 11px 9px 9px 9px !important;
        }
    </style>--%>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" />
    <uc1:ucFinancials runat="server" ID="ucFinancials" />
    <div id="content" class="container-fluid nav-fixed">
        <div id="main" style="margin-left: 0px;">
            <div class="container-fluid">
                <div class="page-header">
                    <div class="pull-left">
                        <h2 meta:resourcekey="hDS" runat="server">
                            Daily Summary</h2>
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
                        <asp:UpdatePanel ID="upDailySummary" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="box box-color">
                                    <div class="box-title">
                                        <h3 meta:resourcekey="hDSi" runat="server">
                                            <i class="glyphicon-stats"></i>Daily Summary
                                        </h3>
                                       
                                        <ul class="tabs">
                                            <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="aSummary" runat="server">Summary</a> </li>
                                            <li><a href="#t2" data-toggle="tab" meta:resourcekey="aDetails" runat="server">Details</a> </li>
                                        </ul>
                                    </div> <div class="box-content nopadding">
                                        <div class='form-horizontal form-column form-bordered'>
                                        <div id="divAction" class="span4">
                                            <div class="control-group">
                                                <label for="textfield" class="control-label" meta:resourcekey="lblDay" runat="server">
                                                    Day:</label>
                                                <div class="controls">
                                                    <input id="txtDate" runat="server" type="text" class="input-medium" maxlength="10"
                                                        autocomplete="off" style="text-align: center" readonly="readonly" />
                                                    &nbsp;<asp:RequiredFieldValidator ID="rvtxtDate" runat="server" ControlToValidate="txtDate"
                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                        ValidationGroup="s" meta:resourcekey="rvtxtDateResource1"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="retxtDate" runat="server" ControlToValidate="txtDate"
                                                        ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                        Display="Dynamic" ValidationGroup="s" meta:resourcekey="retxtDateResource1"></asp:RegularExpressionValidator>
                                                    <img id="imgLoading" src="img/loading.gif" alt="Loadind" width="30" height="30" />
                                                    <asp:Button ID="btnRefresh" runat="server" OnClick="btnRefresh_Click" CssClass="hide" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label for="textfield" class="control-label" meta:resourcekey="lblAction" runat="server">
                                                    Actions:</label>
                                                <div class="controls">
                                                    <asp:Button ID="btnDailyPrint" runat="server" Text="Print Summary & Details" CssClass="btn btn-primary"
                                                        Width="220px" CommandArgument="print" ToolTip="Print Daily Summary - A4 Paper Size" meta:resourcekey="btnDailyPrintResource1" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                        </div>
                                    
                                    <div class="box-content nopadding">
                                        <div class="tab-content">
                                            <div id="t1" class="tab-pane active">
                                                <div class='form-horizontal form-column form-bordered'>
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title"  data-toggle="collapse" data-target=".s1" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hsot" runat="server">
                                                                <i class="icon-pushpin"></i>Summary of Transactions_ud
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".s1"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding s1 in collapse">
                                                            <div class="scroll scrollmini">
                                                                <asp:GridView ID="gvSummary" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                    EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvSummaryResource1">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="start_balance" HeaderText="Start Balance" meta:resourcekey="BoundFieldResource1" HeaderStyle-Width="20%"/>
                                                                        <asp:BoundField DataField="income" HeaderText="Income" meta:resourcekey="BoundFieldResource2" HeaderStyle-Width="20%"/>
                                                                        <asp:BoundField DataField="outcome" HeaderText="Outcome" meta:resourcekey="BoundFieldResource3" HeaderStyle-Width="20%"/>
                                                                        <asp:BoundField DataField="withdrawals" HeaderText="Withdrawals" meta:resourcekey="BoundFieldResource4" HeaderStyle-Width="20%"/>
                                                                        <asp:BoundField DataField="balance" HeaderText="Balance" meta:resourcekey="BoundFieldResource5" HeaderStyle-Width="20%"/>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="gvgray" />
                                                                    <RowStyle CssClass="blue2 gvrow" />
                                                                    <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                    <EmptyDataRowStyle CssClass="gvempty" />
                                                                </asp:GridView>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".s2" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hsoi" runat="server">
                                                                <i class="glyphicon-cart_in"></i>Summary of Income
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".s2"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding s2 collapse">
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvSummaryVisits" runat="server" CssClass="tblbordered gvtoggle" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" meta:resourcekey="gvSummaryVisitsResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="visits_count" HeaderText="Count of Visits" meta:resourcekey="BoundFieldResource6" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="visits_total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource7" HeaderStyle-Width="40%"/>
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvSummaryEncash" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvSummaryEncashResource1" >
                                                                        <Columns>
                                                                            <asp:BoundField DataField="encash_count" HeaderText="Count of Encashment Vouchers" meta:resourcekey="BoundFieldResource8" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="encash_total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource9" HeaderStyle-Width="40%"/>
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
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".s3" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hsou" runat="server">
                                                                <i class="glyphicon-cart_out"></i>Summary of Outcome
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".s3"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding s3 collapse">
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvSummaryRetVisits" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvSummaryRetVisitsResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="ret_visits_count" HeaderText="Count of Returned Visits" meta:resourcekey="BoundFieldResource10" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="ret_visits_total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource11" HeaderStyle-Width="40%"/>
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvSummaryPay" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvSummaryPayResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="pay_count" HeaderText="Count of Payment Vouchers" meta:resourcekey="BoundFieldResource12" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="pay_total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource13" HeaderStyle-Width="40%"/>
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
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".s4" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hsow" runat="server">
                                                                <i class="glyphicon-credit_card"></i>Summary of Withdrawals
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".s4"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding s4 collapse">
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvSummaryWith" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvSummaryWithResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="with_count" HeaderText="Count of Withdrawals" meta:resourcekey="BoundFieldResource14" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="with_total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource15" HeaderStyle-Width="40%"/>
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
                                                </div>
                                            </div>
                                            <div id="t2" class="tab-pane">
                                                <div class='form-horizontal form-column form-bordered'>
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".d1" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hv" runat="server">
                                                                <i class="icon-stethoscope"></i>Visits
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".d1"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding d1 collapse">
                                                            <div class="span12">
                                                                <div class="scroll scrollmini2">
                                                                    <asp:GridView ID="gvDetVisits" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetVisitsResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="time" HeaderText="Time" meta:resourcekey="BoundFieldResource16" />
                                                                            <asp:BoundField DataField="pat_visit_id" HeaderText="V.ID" meta:resourcekey="BoundFieldResource17" />
                                                                            <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource18" />
                                                                            <asp:BoundField DataField="exam_full" HeaderText="Exam" meta:resourcekey="BoundFieldResource19" />
                                                                            <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource20" />
                                                                            <asp:BoundField DataField="viacompany" HeaderText="ViaC." meta:resourcekey="BoundFieldResource21" />
                                                                            <asp:BoundField DataField="company_name" HeaderText="Company" meta:resourcekey="BoundFieldResource22" />
                                                                            <asp:BoundField DataField="contract_id" HeaderText="C.ID" meta:resourcekey="BoundFieldResource23" />
                                                                            <asp:BoundField DataField="contract_discount" HeaderText="Dis %" meta:resourcekey="BoundFieldResource24" />
                                                                            <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource25" />
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvDetVisitsTotal" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetVisitsTotalResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="count" HeaderText="Count of visits" meta:resourcekey="BoundFieldResource26" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource27" HeaderStyle-Width="40%"/>
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
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".d2" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hevfc" runat="server">
                                                                <i class="glyphicon-building"></i>Encashment Vouchers From Companies_ud
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".d2"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding d2 collapse">
                                                            <div class="span12">
                                                                <div class="scroll scrollmini2">
                                                                    <asp:GridView ID="gvDetEncashComp" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetEncashCompResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="time" HeaderText="Time" meta:resourcekey="BoundFieldResource28" />
                                                                            <asp:BoundField DataField="company_name" HeaderText="Company Name" meta:resourcekey="BoundFieldResource29" />
                                                                            <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource30" />
                                                                            <asp:BoundField DataField="transact_note" HeaderText="Note" meta:resourcekey="BoundFieldResource31" />
                                                                            <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource32" />
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvDetEncashCompTotal" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetEncashCompTotalResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="count" HeaderText="Count of Encashment Vouchers" meta:resourcekey="BoundFieldResource33" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource34" HeaderStyle-Width="40%"/>
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
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".d3" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hevfp" runat="server">
                                                                <i class="glyphicon-parents"></i>Encashment Vouchers From Patients_ud
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".d3"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding d3 collapse">
                                                            <div class="span12">
                                                                <div class="scroll scrollmini2">
                                                                    <asp:GridView ID="gvDetEncashPat" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetEncashPatResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="time" HeaderText="Time" meta:resourcekey="BoundFieldResource35" />
                                                                            <asp:BoundField DataField="pat_name" HeaderText="Company Name" meta:resourcekey="BoundFieldResource36" />
                                                                            <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource37" />
                                                                            <asp:BoundField DataField="transact_note" HeaderText="Note" meta:resourcekey="BoundFieldResource38" />
                                                                            <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource39" />
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvDetEncashPatTotal" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetEncashPatTotalResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="count" HeaderText="Count of Encashment Vouchers" meta:resourcekey="BoundFieldResource40" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource41" HeaderStyle-Width="40%" />
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
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".d4" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hrv" runat="server">
                                                                <i class="icon-stethoscope"></i>Returned Visits
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".d4"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding d4 collapse">
                                                            <div class="span12">
                                                                <div class="scroll scrollmini2">
                                                                    <asp:GridView ID="gvDetRetVisits" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetRetVisitsResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="time" HeaderText="Time" meta:resourcekey="BoundFieldResource42" />
                                                                            <asp:BoundField DataField="pat_visit_id" HeaderText="V.ID" meta:resourcekey="BoundFieldResource43" />
                                                                            <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource44" />
                                                                            <asp:BoundField DataField="exam_full" HeaderText="Exam" meta:resourcekey="BoundFieldResource45" />
                                                                            <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource46" />
                                                                            <asp:BoundField DataField="viacompany" HeaderText="ViaC." meta:resourcekey="BoundFieldResource47" />
                                                                            <asp:BoundField DataField="company_name" HeaderText="Company" meta:resourcekey="BoundFieldResource48" />
                                                                            <asp:BoundField DataField="contract_id" HeaderText="C.ID" meta:resourcekey="BoundFieldResource49" />
                                                                            <asp:BoundField DataField="contract_discount" HeaderText="Dis %" meta:resourcekey="BoundFieldResource50" />
                                                                            <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource51" />
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvDetRetVisitsTotal" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetRetVisitsTotalResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="count" HeaderText="Count of Returned visits" meta:resourcekey="BoundFieldResource52" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource53" HeaderStyle-Width="40%"/>
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
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".d5" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hpvfc" runat="server">
                                                                <i class="glyphicon-building"></i>Payment Vouchers For Companies_ud
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".d5"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding d5 collapse">
                                                            <div class="span12">
                                                                <div class="scroll scrollmini2">
                                                                    <asp:GridView ID="gvDetPayComp" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetPayCompResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="time" HeaderText="Time" meta:resourcekey="BoundFieldResource54" />
                                                                            <asp:BoundField DataField="company_name" HeaderText="Company Name" meta:resourcekey="BoundFieldResource55" />
                                                                            <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource56" />
                                                                            <asp:BoundField DataField="transact_note" HeaderText="Note" meta:resourcekey="BoundFieldResource57" />
                                                                            <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource58" />
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvDetPayCompTotal" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetPayCompTotalResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="count" HeaderText="Count of Payment Vouchers" meta:resourcekey="BoundFieldResource59" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource60" HeaderStyle-Width="40%"/>
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
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".d6" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hpvfp" runat="server">
                                                                <i class="glyphicon-parents"></i>Payment Vouchers For Patients_ud
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".d6"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding d6 collapse">
                                                            <div class="span12">
                                                                <div class="scroll scrollmini2">
                                                                    <asp:GridView ID="gvDetPayPat" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetPayPatResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="time" HeaderText="Time" meta:resourcekey="BoundFieldResource61" />
                                                                            <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource62" />
                                                                            <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource63" />
                                                                            <asp:BoundField DataField="transact_note" HeaderText="Note" meta:resourcekey="BoundFieldResource64" />
                                                                            <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource65" />
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvDetPayPatTotal" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetPayPatTotalResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="count" HeaderText="Count of Payment Vouchers" meta:resourcekey="BoundFieldResource66" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource67" HeaderStyle-Width="40%"/>
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
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".d7" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hpvfe" runat="server">
                                                                <i class="glyphicon-calculator"></i>Payment Vouchers For Examinations_ud
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".d7"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding d7 collapse">
                                                            <div class="span12">
                                                                <div class="scroll scrollmini2">
                                                                    <asp:GridView ID="gvDetPayExp" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetPayExpResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="time" HeaderText="Time" meta:resourcekey="BoundFieldResource68" />
                                                                            <asp:BoundField DataField="expense_name" HeaderText="Expense Name" meta:resourcekey="BoundFieldResource69" />
                                                                            <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource70" />
                                                                            <asp:BoundField DataField="transact_note" HeaderText="Note" meta:resourcekey="BoundFieldResource71" />
                                                                            <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource72" />
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvDetPayExpTotal" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetPayExpTotalResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="count" HeaderText="Count of Payment Vouchers" meta:resourcekey="BoundFieldResource73" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource74" HeaderStyle-Width="40%"/>
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
                                                    <div class="box box-bordered box-color">
                                                        <div class="box-title" data-toggle="collapse" data-target=".d8" style="cursor:pointer">
                                                            <h3 meta:resourcekey="hw" runat="server">
                                                                <i class="glyphicon-credit_card"></i>Withdrawals
                                                            </h3>
                                                            <div class="actions">
                                                                <a class="btn btn-mini" data-toggle="collapse" data-target=".d8"><i class="icon-sort">
                                                                </i></a>
                                                            </div>
                                                        </div>
                                                        <div class="box-content nopadding d8 collapse">
                                                            <div class="span12">
                                                                <div class="scroll scrollmini2">
                                                                    <asp:GridView ID="gvDetWith" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetWithResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="time" HeaderText="Time" meta:resourcekey="BoundFieldResource75" />
                                                                            <asp:BoundField DataField="Clinic_ud_name" HeaderText="Clinic_ud Name" meta:resourcekey="BoundFieldResource76" />
                                                                            <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource77" />
                                                                            <asp:BoundField DataField="transact_note" HeaderText="Note" meta:resourcekey="BoundFieldResource78" />
                                                                            <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource79" />
                                                                        </Columns>
                                                                        <HeaderStyle CssClass="gvgray" />
                                                                        <RowStyle CssClass="blue2 gvrow" />
                                                                        <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                        <EmptyDataRowStyle CssClass="gvempty" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div class="span6">
                                                                <div class="scroll scrollmini">
                                                                    <asp:GridView ID="gvDetWithTotal" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        EmptyDataText="No Results Found" CssClass="tblbordered gvtoggle" meta:resourcekey="gvDetWithTotalResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="count" HeaderText="Count of Payment Vouchers" meta:resourcekey="BoundFieldResource80" HeaderStyle-Width="60%"/>
                                                                            <asp:BoundField DataField="total" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource81" HeaderStyle-Width="40%"/>
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
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />
                    </div>
                </div>
            </div>
        </div>
    </div>
       <asp:HiddenField ID="hfTheme" runat="server" ClientIDMode="Static" />
        <asp:Button ID="btnSaveTheme" runat="server" OnClick="btnSaveTheme_Click" CssClass="hide" />
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
