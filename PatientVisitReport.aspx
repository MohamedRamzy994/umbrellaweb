<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientVisitReport.aspx.cs"
    Inherits="PatientDetailReport" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

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
    <title>Patient Visit Report</title>
    <script src="js/jquery.min.js"></script>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="PatientDetailReport.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };
        var row;
        function DoWork() {
           
           
            $('#txtDateRange').daterangepicker({ singleDatePicker: true, format: 'DD/MM/YYYY' }, function (start, end, label) {
                //console.log(start.toISOString(), end.toISOString(), label);
            }).on('changeDate', function () {
                debugger;
                __doPostBack('btnDateSplit', '');
            });

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
            $("#txtDateRange").blur(function () {
                debugger;
                __doPostBack('btnDateSplit', '');
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
            $('#btnResultSearch').unbind('click').bind('click', function (event) {

                if (row != null) {
                    row.addClass("blue3");
                }
            });
            $('#btnResultPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                debugger;
                //if (!Page_ClientValidate('r')) { return false; }
                //if ($('#txtDateFrom').val() == '' || $('#txtDateTo').val() == '') { return; }
               
                var str = "ClinicReportsView.aspx?data=detvisits," + $('#txtPatId').val() + "," + $('#txtDateFrom').val() + "," + $('#txtDateTo').val() ;
                // $.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            $("#gvPatients_ud .gvrow").click(function () {
                $("#gvPatients_ud .gvrow").removeClass("blue3");
                row = $(this);
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtPatId").val($(cells[0]).text());
                $("#txtPatName").val($(cells[1]).text());
                $("html, body").animate({ scrollTop: "600px" }, "normal");
                __doPostBack('btnDateValidation', '');
                //$("#").
            });
            $("#gvResults .gvrow").click(function () {
                debugger;
                // $("#gvResults .gvrow").removeClass("blue3");
                $(this).toggleClass("blue3");


            });
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            if ($("#drpSearchgvPatients_udCol").val() == '0') {
                $('#txtSearchgvPatients_ud').val('');
                $('#txtSearchgvPatients_ud').attr("disabled", "disabled");
            }
            $('#drpSearchgvPatients_udCol').change(function SearchdrpgvPatients_ud() {
                if ($(this).val() == '0') {
                    $('#txtSearchgvPatients_ud').val('');
                    $('#txtSearchgvPatients_ud').attr("disabled", "disabled");
                }
                else {
                    $('#txtSearchgvPatients_ud').removeAttr("disabled")
                }
            });
        }

        function ClearPatients_udtbl() {
            $("#gvPatients_ud .gvrow").removeClass("blue3");
            $('.tblPatients_ud').fClear();
            $('#btnPatients_udSave').attr('disabled', false);
            $('#btnPatients_udUpdate').attr('disabled', true);
            $('#btnPatients_udDelete').attr('disabled', true);
        };
    </script>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" meta:resourcekey="btnDefaultResource1" />
        <uc1:ucReports runat="server" ID="ucReports" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
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


                                    <div id="divSrch" class="box box-bordered box-color">
                                        <div class="box-title">
                                            <h3 id="H1" meta:resourcekey="Search_Patients_ud" runat="server">
                                                <i class="icon-search"></i>Search Patients_ud</h3>
                                        </div>
                                        <div id="divSearch" class="box-content nopadding">
                                            <div class="span12">
                                                <div class="input-append input-prepend">
                                                    <span class="add-on">
                                                        <li class="icon-search"></li>
                                                    </span>
                                                </div>
                                                <asp:DropDownList ID="drpSearchgvPatients_udCol" class='input-xlarge' runat="server" meta:resourcekey="drpSearchgvPatients_udColResource1">
                                                    <asp:ListItem Text="All Patients_ud" Value="0" meta:resourcekey="ListItemResource24"></asp:ListItem>
                                                    <asp:ListItem Text="ID" Value="1" meta:resourcekey="ListItemResource25"></asp:ListItem>
                                                    <asp:ListItem Text="Name" Value="2" meta:resourcekey="ListItemResource26"></asp:ListItem>
                                                    <asp:ListItem Text="Birthdate" Value="3" meta:resourcekey="ListItemResource27"></asp:ListItem>
                                                    <asp:ListItem Text="Mobile or Phone" Value="4" meta:resourcekey="ListItemResource28"></asp:ListItem>
                                                </asp:DropDownList>
                                                <input id="txtSearchgvPatients_ud" meta:resourcekey="txtSearchgvPatients_ud" runat="server" type="text" class="input-large"
                                                    placeholder="Search Here..." autocomplete="off" maxlength="30" />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnPatients_udSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                                                    Width="80px" OnClick="btnPatients_udSearch_Click" OnClientClick="this.disabled = true; this.value = 'Searching';"
                                                    UseSubmitBehavior="False" meta:resourcekey="btnPatients_udSearchResource1" />
                                                <asp:DropDownList ID="drpSearchgvPatients_udGender" class='input-xlarge' runat="server" meta:resourcekey="drpSearchgvPatients_udGenderResource1">
                                                    <asp:ListItem Text="Gender" Value="" meta:resourcekey="ListItemResource29"></asp:ListItem>
                                                    <asp:ListItem Text="Male" Value="m" meta:resourcekey="ListItemResource30"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="f" meta:resourcekey="ListItemResource31"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="drpSearchgvPatients_udStatus" class='input-xlarge' runat="server" meta:resourcekey="drpSearchgvPatients_udStatusResource1">
                                                    <asp:ListItem Text="Status" Value="" meta:resourcekey="ListItemResource32"></asp:ListItem>
                                                    <asp:ListItem Text="Active" Value="1" meta:resourcekey="ListItemResource33"></asp:ListItem>
                                                    <asp:ListItem Text="Inactive" Value="0" meta:resourcekey="ListItemResource34"></asp:ListItem>
                                                </asp:DropDownList>
                                                <div class="scroll scrollbig2">
                                                    <asp:UpdatePanel ID="upPatientResult" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="gvPatients_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                EmptyDataText="No Results Found" AllowPaging="True" PageSize="11" OnPageIndexChanging="gvPatients_ud_PageIndexChanging" meta:resourcekey="gvPatients_udResource1">
                                                                <Columns>
                                                                    <asp:BoundField DataField="pat_id" HeaderText="No." meta:resourcekey="BoundFieldResource1" />
                                                                    <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource2" />
                                                                    <asp:BoundField DataField="pat_birthdate" HeaderText="Birthdate" meta:resourcekey="BoundFieldResource3" />
                                                                    <asp:BoundField DataField="pat_address" HeaderText="Address" meta:resourcekey="BoundFieldResource4" />
                                                                    <asp:BoundField DataField="gen" HeaderText="Gender" meta:resourcekey="BoundFieldResource5" />
                                                                    <asp:BoundField DataField="pat_mobile" HeaderText="Mobile" meta:resourcekey="BoundFieldResource6" />
                                                                    <asp:BoundField DataField="pat_phone" HeaderText="Phone" meta:resourcekey="BoundFieldResource7" />
                                                                    <asp:BoundField DataField="pat_job" HeaderText="Job" meta:resourcekey="BoundFieldResource8" />
                                                                    <asp:BoundField DataField="marital_id" HeaderText="marital_id" meta:resourcekey="BoundFieldResource9">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="blood_id" HeaderText="blood_id" meta:resourcekey="BoundFieldResource10">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="pat_smoker" HeaderText="Smoker" meta:resourcekey="BoundFieldResource11">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="pat_dm" HeaderText="DM" meta:resourcekey="BoundFieldResource12">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="pat_htn" HeaderText="HTN" meta:resourcekey="BoundFieldResource13">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="created_date" HeaderText="Created Date" meta:resourcekey="BoundFieldResource14">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="created_by" HeaderText="Created By" meta:resourcekey="BoundFieldResource15">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="modified_date" HeaderText="Modified Date" meta:resourcekey="BoundFieldResource16">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="modified_by" HeaderText="Modified By" meta:resourcekey="BoundFieldResource17">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="active" HeaderText="Status" HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide" meta:resourcekey="BoundFieldResource18" />
                                                                    <asp:TemplateField HeaderText="Status" meta:resourcekey="BoundFieldResource5">
                                                                        <ItemTemplate>
                                                                            <%# Eval("status")%>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="pat_gender" HeaderText="Gender" meta:resourcekey="BoundFieldResource19">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="pat_balance" HeaderText="Balance" meta:resourcekey="BoundFieldResource20" />
                                                                </Columns>
                                                                <PagerSettings Mode="NumericFirstLast" />
                                                                <PagerStyle CssClass="gvpagination" />
                                                                <HeaderStyle CssClass="gvgray" />
                                                                <RowStyle CssClass="blue2 gvrow" />
                                                                <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                <EmptyDataRowStyle CssClass="gvempty" />

                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <asp:UpdatePanel ID="upResult" runat="server">
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
                                                                                OnClick="btnResultSearch_Click"
                                                                                UseSubmitBehavior="False" Width="104px" ValidationGroup="r" ToolTip="Search for Results" meta:resourcekey="btnResultSearchResource1" />&nbsp;&nbsp;
                                                                <asp:Button ID="btnResultPrint" Text="Print" runat="server" CssClass="btn btn-satblue"
                                                                    Width="104px" ValidationGroup="r" CommandArgument="print" ToolTip="Print Results" meta:resourcekey="btnResultPrintResource1" />
                                                                            <asp:Button ID="btnDateValidation" runat="server" CssClass="hide" OnClick="btnDateValidation_Click" meta:resourcekey="btnDateValidationResource1" />
                                                                            <asp:Button ID="btnDateSplit" OnClick="btnDateSplit_Click" style="display:none" runat="server" Text="Button" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" title="Date From" meta:resourcekey="textfieldPeriod" runat="server">
                                                                            Period:</label>
                                                                        <div class="controls">
                                                                            <input id="txtPatId" meta:resourcekey="txtPatId" runat="server" type="text" placeholder="Patient Id" disabled="disabled" class="input-small"
                                                                                maxlength="10" autocomplete="off" title="Date From" />

                                                                            <input id="txtPatName" meta:resourcekey="txtpatName" runat="server" type="text" placeholder="Patient Name" style="width: 200px" disabled="disabled" class="input-small"
                                                                                maxlength="10" autocomplete="off" title="Date From" />
                                                                            <div class="input-prepend input-group">
                                                                                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                                                                                <%--<input id="txtDateRange" meta:resourcekey="txtDateRange"  runat="server" type="text" placeholder="Date Range" style="width: 200px" class="input-small"
                                                                                    maxlength="10" autocomplete="off" title="Date From" />--%>
                                                                                <asp:TextBox id="txtDateRange" placeholder="Date Range" style="width: 200px" class="input-small"
                                                                                     meta:resourcekey="txtDateRange" maxlength="10" autocomplete="off" title="Date From" runat="server" 
                                                                                    OnTextChanged="txtDateRange_TextChanged" ></asp:TextBox>
                                                                            </div>
                                                                            <input id="txtDateFrom" meta:resourcekey="txtpatName" runat="server" type="text" placeholder="Patient Name" style="width: 200px;display:none" disabled="disabled" class="input-small"
                                                                                maxlength="10" autocomplete="off" title="Date From"   />
                                                                            <input id="txtDateTo" meta:resourcekey="txtpatName" runat="server" type="text" placeholder="Patient Name" style="width: 200px;display:none" disabled="disabled" class="input-small"
                                                                                maxlength="10" autocomplete="off" title="Date From"   />

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

                                                            <asp:GridView ID="gvVisits" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                EmptyDataText="No Results Found" AllowPaging="True" PageSize="11" OnPageIndexChanging="gvVisits_PageIndexChanging" meta:resourcekey="gvVisitsResource1">
                                                                <Columns>
                                                                    <asp:BoundField DataField="pat_visit_id" HeaderText="V.ID" />
                                                                    <asp:BoundField DataField="pat_id" HeaderText="pat_id" />
                                                                    <asp:BoundField DataField="pat_name" HeaderText="pat_name">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="pat_visit_date" HeaderText="Date" />
                                                                    <asp:BoundField DataField="pat_visit_time" HeaderText="Time" />
                                                                    <asp:BoundField DataField="exam_full" HeaderText="Exam" />
                                                                    <asp:BoundField DataField="paid_status" HeaderText="Paid" />
                                                                    <asp:BoundField DataField="transact_amount" HeaderText="Amount" />
                                                                    <asp:BoundField DataField="visit_status" HeaderText="Status" />
                                                                    <asp:BoundField DataField="exam_det_id" HeaderText="exam_det_id">
                                                                        <HeaderStyle CssClass="hide" />
                                                                        <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="user_name" HeaderText="User" />
                                                                    <%--<asp:BoundField DatkaField="pat_id" HeaderText="pat_id" />--%>
                                                                    <asp:BoundField DataField="pat_name" HeaderText="pat_name" />
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
                                <br />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hfTheme" runat="server" ClientIDMode="Static" />
        <asp:Button ID="btnSaveTheme" runat="server" OnClick="btnSaveTheme_Click" CssClass="hide" meta:resourcekey="btnSaveThemeResource1" />
        <div id="footer">
            <p id="P2" meta:resourcekey="pAboutus" runat="server">
                Umbrella v3.4 - © All Rights Reserved For APPLET Software <span class="font-grey-4">|</span><a href="AboutUs.aspx" target="_blank"> About Us </a>
            </p>
            <a href="#" class="gototop"><i class="icon-arrow-up"></i></a>
        </div>
        <asp:HiddenField ID="HiddenDateFrom" runat="server" />
        <asp:HiddenField ID="HiddenDateTo" runat="server" />
    </form>
    <asp:PlaceHolder runat="server" ID="phBottomScripts" />

</body>
</html>
