<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientsVisits.aspx.cs" Inherits="PatientsVisits" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="~/ucMenuControlPanel.ascx" TagPrefix="uc1" TagName="ucMenuControlPanel" %>
<%@ Register Src="~/ucReception.ascx" TagPrefix="uc1" TagName="ucReception" %>
<%@ Register Src="~/ucStyle_Scripts.ascx" TagPrefix="uc1" TagName="ucStyle_Scripts" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Patients_ud Visits</title>
    
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    
    <script type="text/javascript">
        var timeout;
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="PatientsVisits.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            $('#divVisits').hide();
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };

        function DoWork() {
            //alert("this");
            //$("#Div1").defaultButton("#Button1");
            $("#divSearch").defaultButton("#btnPatients_udSearch");


            ///////////////////////////////////////////////
            //////////// Visits Tab ///////////////////////
            ///////////////////////////////////////////////
            $('.gvBtnv').unbind("click").bind("click", function () {

                $('#aVisits').click();

            });
            $('.gvBtnp').unbind("click").bind("click", function () {

                $('#aPatients_ud').click();

            });
            $('#aVisits').parent().hide();
            $('#aVisits').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#divPatients_ud').hide();
                $('#divVisits').fadeIn();
                ClearVisitsTbl();
                __doPostBack('btnVisitsRefresh', '');
            });
            $(".gvpagination").find("span").addClass("gvcurrentrow");
            $(".gvpagination").find("a").addClass("gvnumbtn");
            $(".gvpagination table").first().css("width", "auto");

            $("#gvPatients_ud .gvrow").hover(function () {

                // $(this).addClass("blue4");
                var cells = $(this).find("td");
                $("#txtPatID").val($(cells[0]).text());
                $("#lblPatName").val(' ' + $(cells[0]).text() + '- ' + $(cells[1]).text());
                $("#lblBalance").val(' Code: ' + $(cells[2]).text() + '  Balance: ' + $(cells[3]).text());
                // $("html, body").animate({ scrollTop: "+900px" }, "slow");
                //$('#aVisits').parent().show();
            }, function () {
                // $("#gvPatients_ud .gvrow").removeClass("blue4");
            });
            $("#gvPatients_ud .gvrow").unbind("click").bind("click", function () {
                $("#gvPatients_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtPatID").val($(cells[0]).text());
                $("#lblPatName").val(' ' + $(cells[0]).text() + '- ' + $(cells[1]).text());
                $("#lblBalance").val(' Code: ' + $(cells[2]).text() + '  Balance: ' + $(cells[3]).text());
                $("html, body").animate({ scrollTop: "+900px" }, "slow");
                $('#aVisits').parent().show();
            });
            $('#txtPaidAmount').attr("disabled", true);
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

            $('#drpVisitExam').change(function () {
                var selectedValue = $(this).val();
                if (selectedValue != "0") {
                    $('#txtPaidAmount').val($("#drpExam option[value=" + selectedValue + "]").text());
                }
                else {
                    $('#txtPaidAmount').val('');
                }
            });

            $('#chkVisitPaid').change(function () {
                var chk = $('#chkVisitPaid').is(':checked') ? "1" : "0";
                if (chk == "1") {
                    $('#txtPaidAmount').attr("disabled", false);
                }
                else if (chk == "0") {
                    $('#txtPaidAmount').attr("disabled", true);
                }
            });
            $(".has-switch div:nth-child(2)").parent().remove();
            $('#chkVisitPaid').bootstrapSwitch();
            $('#chkVisitPaid').bootstrapSwitch('setState', false); // true || false
            $('#txtVisitDate').datepicker({
                format: 'dd/mm/yyyy',
                startDate: '+0d',
                autoclose: true
            });
            $('#txtVisitTime').timepicker({
                minuteStep: 5,
                showInputs: false,
                disableFocus: true
            });

            $('#btnVisitSave').attr('disabled', false);
            $('#btnVisitDelete').attr('disabled', true);
            $('#btnVisitUpdate').attr('disabled', true);

            $('#aVisits').parent().on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });
            $('#aPatients_ud').parent().on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });
            $('#aPatients_ud').unbind("click").bind("click", function (event) {
                alert("aPatients_ud");
                event.preventDefault();
                $('#divVisits').hide();
                $('#divPatients_ud').fadeIn();
                $('#aVisits').parent().show();
            });

            $('#btnVisitNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvVisits .gvrow").removeClass("blue3");
                $('#btnVisitSave').attr('disabled', false);
                $('#btnVisitDelete').attr('disabled', true);
                $('#btnVisitUpdate').attr('disabled', true);
                $('#txtVisitDate').attr("disabled", false);
                $('#txtVisitTime').attr("disabled", false);
                $('#drpVisitExam').attr("disabled", false);
                $('#chkVisitPaid').attr("disabled", false);
                $('#chkVisitPaid').bootstrapSwitch('setState', false);
                ClearVisitsTbl();

            });
            $("#gvVisits .gvrow").unbind("click").bind("click", function () {
                $("#gvVisits .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                $('#btnVisitSave').attr('disabled', true);
                $('#btnVisitDelete').attr('disabled', true);
                $('#btnVisitUpdate').attr('disabled', true);
                $('#txtVisitDate').attr("disabled", true);
                $('#txtVisitTime').attr("disabled", true);
                $('#drpVisitExam').attr("disabled", true);
                $('#chkVisitPaid').attr("disabled", true);
                var c = $(this).find("td");
                $("#txtVisitID").val($(c[0]).text());
                $("#txtVisitDate").val($(c[2]).text());
                $("#txtVisitTime").val($(c[3]).text());
                $("#drpVisitExam").val($(c[8]).text());
                $('#chkVisitPaid').bootstrapSwitch('setState', false);
                if ($(c[7]).text().toLowerCase() == "new") {
                    $('#btnVisitDelete').attr('disabled', false);
                    $('#btnVisitUpdate').attr('disabled', false);
                    $('#txtVisitDate').attr("disabled", false);
                    $('#txtVisitTime').attr("disabled", false);
                }
                if ($(c[5]).text().toLowerCase() == "yes") {
                    $('#chkVisitPaid').bootstrapSwitch('setState', true);
                }
                $('#txtPaidAmount').val($(c[6]).text());
                $('#txtPaidAmount').attr("disabled", true);
                Page_ClientValidate('v');
            });

            $('#btnVisitDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnVisitDelete').attr('disabled', true);
                    $('#btnVisitUpdate').attr('disabled', true);
                    $('#btnVisitDelete').attr('value', 'Deleting');
                    __doPostBack('btnVisitDelete', '');
                });
            });
            $('#txtVisitDate').attr('readonly', 'readonly');
            $('#txtVisitDate').on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });
            /////////////////////////////////////////
            /////////End Visits Tab//////////////////
            /////////////////////////////////////////

            ////////////////////////////////////////
            ////////// Doctor Tab //////////////////
            ///////////////////////////////////////
            $('#drpSrchgvDoctorDates').change(function () {
                //$("#gvDoctorDates .gvrow").removeClass("blue3");
                var searchKey = $.trim($('#drpSrchgvDoctorDates').val().toLowerCase());
                $("#gvDoctorDates tr td:nth-child(1)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvDoctorDates .gvrow").unbind("click").bind("click", function () {
                // $("#gvDoctorDates .gvrow").removeClass("blue3");
                $(this).toggleClass("blue3");
            });
            ////////////////////////////////////////
            ////////////End Doctor Tab//////////////
            ////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $("#gvPatients_ud tr td:nth-child(7)").each(function () {
                var cellText = $(this).text().toLowerCase();
                if ($('.lnklang').html() == "EN") {
                    if (cellText == 'm') {
                        $(this).text('ذكـر');
                    }
                    else {
                        $(this).text('أنثـى');
                    }
                }
                else {
                    if (cellText == 'm') {
                        $(this).text('Male');
                    }
                    else {
                        $(this).text('Female');
                    }
                }
            });
        };
        function ClearVisitsTbl() {
            // $('#chkVisitPaid').bootstrapSwitch('setState', false);
            $('#txtVisitID').val('');
            $('#txtVisitDate').val('');
            $('#drpVisitExam').val('0');
            $('#txtPaidAmount').val('');
        };
        function UpdateBalance(balance) {
            $("#gvPatients_ud .blue3 td:eq(3)").text(balance);
            $("#lblBalance").val(' Code: ' + $("#gvPatients_ud .blue3 td:eq(2)").text() + '  Balance: ' + balance);
        }
    </script>
    <style>
        textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"] {
            padding: 5px 9px 4px 0px !important;
        }
    </style>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" meta:resourcekey="btnDefaultResource1" />
        <uc1:ucReception runat="server" ID="ucReception" />
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="h2Patients_ud_Visits" runat="server">Patients_ud Visits</h2>
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
                            <div class="box box-color">
                                <div class="box-title">
                                    <h3 meta:resourcekey="Patients_ud_Reservations" runat="server">
                                        <i class="glyphicon-parents"></i>
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="liNew_Visits" runat="server">New Visits</a></li>
                                        <li><a href="#t2" data-toggle="tab" meta:resourcekey="liDoctor_Appointments" runat="server">Doctor's Appointments</a></li>
                                        <li><a href="VisitsViaCompany.aspx" meta:resourcekey="liVisits_Via_Company" runat="server">Visits Via Company</a></li>
                                        <li><a href="WaitingList.aspx" meta:resourcekey="liWaiting_List" runat="server">Waiting List</a> </li>
                                        <li><a href="PatientsCurrentVisits.aspx" meta:resourcekey="liCurrent_Visits" runat="server">Current Visits</a></li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div id="divPatients_ud" class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3>
                                                            <i class="icon-search" meta:resourcekey="liSearch_Patients_ud" runat="server">Search Patients_ud</i></h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upPatients_ud" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <div id="divSearch" class="box-content nopadding">
                                                                <div class="span12">
                                                                    <div class="input-append input-prepend">
                                                                        <span class="add-on">
                                                                            <li class="icon-search"></li>
                                                                        </span>
                                                                    </div>

                                                                    <asp:DropDownList ID="drpSearchgvPatients_udCol" runat="server" class='input-medium' meta:resourcekey="drpSearchgvPatients_udColResource1">
                                                                        <asp:ListItem Value="0" Text="All Patients_ud" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                        <asp:ListItem Value="1" Text="ID" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                        <asp:ListItem Value="2" Text="Name" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                        <asp:ListItem Value="3" Text="Birthdate" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                        <asp:ListItem Value="4" Text="Mobile or Phone" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <input id="txtSearchgvPatients_ud" meta:resourcekey="txtSearchgvPatients_ud" runat="server" type="text" class="input-large"
                                                                        placeholder="Search Here..." autocomplete="off" maxlength="30" />
                                                                    <asp:Button ID="btnPatients_udSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                                                                        Width="100px" OnClick="btnPatients_udSearch_Click" OnClientClick="this.disabled = true; this.value = 'Searching';"
                                                                        UseSubmitBehavior="False" meta:resourcekey="btnPatients_udSearchResource1" />

                                                                    <asp:DropDownList ID="drpSearchgvPatients_udGender" runat="server" class='input-medium' meta:resourcekey="drpSearchgvPatients_udGenderResource1">
                                                                        <asp:ListItem Value="" Text="Gender - All" meta:resourcekey="ListItemResourceKey5"> </asp:ListItem>
                                                                        <asp:ListItem Value="m" Text="Male" meta:resourcekey="ListItemResourceKey6"> </asp:ListItem>
                                                                        <asp:ListItem Value="f" Text="Female" meta:resourcekey="ListItemResourceKey7"> </asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <input id="txtPatID" runat="server" type="text" class="hide" />
                                                                    <div class="scroll scrollbig2">
                                                                        <asp:GridView ID="gvPatients_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" AllowPaging="True" OnPageIndexChanging="gvPatients_ud_PageIndexChanging" meta:resourcekey="gvPatients_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="pat_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1" />
                                                                                <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="pat_code" HeaderText="Code" meta:resourcekey="BoundFieldResource3">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="pat_balance" HeaderText="Balance" meta:resourcekey="BoundFieldResource4" />
                                                                                <asp:BoundField DataField="pat_birthdate" HeaderText="Birthdate" meta:resourcekey="BoundFieldResource5" />
                                                                                <asp:BoundField DataField="pat_address" HeaderText="Address" meta:resourcekey="BoundFieldResource6" />
                                                                                <asp:BoundField DataField="pat_gender" HeaderText="Gender" meta:resourcekey="BoundFieldResource7" />
                                                                                <asp:BoundField DataField="pat_gender" HeaderText="Gender" meta:resourcekey="BoundFieldResource19">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="pat_mobile" HeaderText="Mobile" meta:resourcekey="BoundFieldResource8" />
                                                                                <asp:BoundField DataField="pat_phone" HeaderText="Phone" meta:resourcekey="BoundFieldResource9" />
                                                                                <asp:TemplateField HeaderText="Visits" meta:resourcekey="TemplateFieldResource1" ItemStyle-CssClass="gvBtnv">
                                                                                    <ItemTemplate>
                                                                                        <i class="icon-stethoscope gvBtnv"></i>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
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
                                                            <ul class="minitiles">
                                                                <li class='grey' style="float: right"><a id="aVisits"><i class=" icon-stethoscope"></i></a></li>
                                                            </ul>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                                <div id="divVisits" runat="server" class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="h3Patients_ud_Visits" runat="server">
                                                            <i class="icon-stethoscope"></i>Patients_ud Visits</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upVisits" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblVisits" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldActions" runat="server">
                                                                            Actions:-</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnVisitNew" value="New" meta:resourcekey="btnVisitNewResource1" runat="server" class="btn btn-grey" style="width: 65px" />
                                                                            <asp:Button ID="btnVisitSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                Width="65px" OnClick="btnVisitSave_Click" ValidationGroup="v" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnVisitSaveResource1" />
                                                                            <asp:Button ID="btnVisitUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" ValidationGroup="v" OnClick="btnVisitUpdate_Click" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating';if(document.getElementById('btnVisitDelete')!= null){document.getElementById('btnVisitDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnVisitUpdateResource1" />
                                                                            <asp:Button ID="btnVisitDelete" Text="Delete" runat="server" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnVisitDelete_Click" CommandArgument="delete" meta:resourcekey="btnVisitDeleteResource1" />
                                                                            <asp:Button ID="btnVisitsRefresh" runat="server" Text="View" CssClass="hide" OnClick="btnVisitsRefresh_Click" meta:resourcekey="btnVisitsRefreshResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldVisit_ID" runat="server">
                                                                            Visit-ID:-</label>
                                                                        <div class="controls">
                                                                            <input id="txtVisitID" runat="server" type="text" meta:resourcekey="txtVisitID" placeholder="Visit ID" class="input-small"
                                                                                disabled="disabled" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldExamination" runat="server">
                                                                            Examination:-</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpVisitExam" runat="server" class="input-xlarge" meta:resourcekey="drpVisitExamResource1">
                                                                            </asp:DropDownList>
                                                                            <asp:DropDownList ID="drpExam" runat="server" class="input-medium hide" meta:resourcekey="drpExamResource1">
                                                                            </asp:DropDownList>
                                                                            <asp:RequiredFieldValidator ID="rvdrpVisitExam" runat="server" ControlToValidate="drpVisitExam"
                                                                                Display="Dynamic" ValidationGroup="v" ErrorMessage="*Required" ForeColor="#CC0000"
                                                                                SetFocusOnError="True" InitialValue="0" meta:resourcekey="rvdrpVisitExamResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldPaid" runat="server">
                                                                            Paid:-</label>
                                                                        <div class="controls">
                                                                            <input id="chkVisitPaid" runat="server" type="checkbox" data-on-label="Yes" data-off-label="NO"
                                                                                data-on="danger" data-off="primary" class="switch-medium" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldAmount" runat="server">
                                                                            Amount:-</label>
                                                                        <div class="controls">
                                                                            <input type="text" id="txtPaidAmount" runat="server" class="input-medium" disabled="disabled"
                                                                                maxlength="21" autocomplete="off" />
                                                                            &nbsp;&nbsp;<asp:RequiredFieldValidator ID="rvtxtPaidAmount" runat="server" ControlToValidate="txtPaidAmount"
                                                                                Display="Dynamic" ValidationGroup="v" ErrorMessage="*Required" ForeColor="#CC0000"
                                                                                SetFocusOnError="True" meta:resourcekey="rvtxtPaidAmountResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtPaidAmount" runat="server" ControlToValidate="txtPaidAmount"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="^\d{0,18}([\.]\d{1,2})?$" ValidationGroup="v" meta:resourcekey="retxtPaidAmountResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldDate" runat="server">
                                                                            Date:-</label>
                                                                        <div class="controls">
                                                                            <input id="txtVisitDate" runat="server" type="text" class="input-small" maxlength="10"
                                                                                autocomplete="off" />
                                                                            &nbsp;&nbsp;<asp:RequiredFieldValidator ID="rvtxtVisitDate" runat="server" ControlToValidate="txtVisitDate"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="v" meta:resourcekey="rvtxtVisitDateResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtVisitDate" runat="server" ControlToValidate="txtVisitDate"
                                                                                ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                                                Display="Dynamic" ValidationGroup="v" meta:resourcekey="retxtVisitDateResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldTime" runat="server">
                                                                            Time:-</label>
                                                                        <div class="controls">
                                                                            <div class="bootstrap-timepicker">
                                                                                <input id="txtVisitTime" runat="server" type="text" class="input-small" />
                                                                                &nbsp;
                                                                            &nbsp;
                                                                            </div>
                                                                            <asp:RequiredFieldValidator ID="rvtxtVisitTime" runat="server" ControlToValidate="txtVisitTime"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="v" meta:resourcekey="rvtxtVisitTimeResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span1">
                                                                    <div class="div_search_box">
                                                                        <asp:TextBox ID="lblPatName" runat="server" Font-Bold="True" Font-Size="Small" Enabled="False"
                                                                            ToolTip="Patient Name" CssClass="input-xxlarge" meta:resourcekey="lblPatNameResource1" />
                                                                        <asp:TextBox ID="lblBalance" runat="server" Font-Bold="True" Font-Size="Small" Enabled="False"
                                                                            ToolTip="Patient Name" CssClass="input-xxlarge" meta:resourcekey="lblBalanceResource1" />
                                                                        <ul class="minitiles">
                                                                            <li class='grey'><a id="aPatients_ud"><i class="glyphicon-parents"></i></a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <div class="span7">
                                                                    <div class="scroll scrollclc">
                                                                        <asp:GridView ID="gvVisits" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvVisitsResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="pat_visit_id" HeaderText="V.ID" meta:resourcekey="BoundFieldResource10" />
                                                                                <asp:BoundField DataField="pat_id" HeaderText="pat_id" meta:resourcekey="BoundFieldResource11">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="pat_visit_date" HeaderText="Date" meta:resourcekey="BoundFieldResource12" />
                                                                                <asp:BoundField DataField="pat_visit_time" HeaderText="Time" meta:resourcekey="BoundFieldResource13" />
                                                                                <asp:BoundField DataField="exam_full" HeaderText="Exam" meta:resourcekey="BoundFieldResource14" />
                                                                                <asp:BoundField DataField="paid_status" HeaderText="Paid" meta:resourcekey="BoundFieldResource15" />
                                                                                <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource16" />
                                                                                <asp:BoundField DataField="visit_status" HeaderText="Status" meta:resourcekey="BoundFieldResource17" />
                                                                                <asp:BoundField DataField="exam_det_id" HeaderText="exam_det_id" meta:resourcekey="BoundFieldResource18">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource19" />
                                                                                <asp:TemplateField HeaderText="<<" meta:resourcekey="TemplateFieldResource2">
                                                                                    <ItemTemplate>
                                                                                        <i class="glyphicon-parents gvBtnp"></i>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                            <HeaderStyle CssClass="gvgray" />
                                                                            <RowStyle CssClass="blue2 gvrow" />
                                                                            <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                            <EmptyDataRowStyle CssClass="gvempty" />
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="t2" class="tab-pane">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <asp:UpdatePanel ID="upDoctorDates" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <div class="box box-bordered box-color">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="h3Doctor_Appointments" runat="server">
                                                                    <i class="glyphicon-clock"></i>Doctor's Appointments</h3>
                                                                <img id="imgLoading" src="img/loading.gif" alt="Loadind" width="25" height="25px"
                                                                    class="hide" />
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div class="span12" style="background-image: url(img/dr_app2.jpg);">
                                                                    <div class="input-append input-prepend">
                                                                        <span class="add-on">
                                                                            <li class="icon-search"></li>
                                                                        </span>
                                                                    </div>
                                                                    <%-- &nbsp; Select-Day:-&nbsp;--%>
                                                                    <asp:DropDownList ID="drpSrchgvDoctorDates" runat="server" class='input-large' Style="height: 30px; text-align: center; font-size: medium;" meta:resourcekey="drpSrchgvDoctorDatesResource1">
                                                                    </asp:DropDownList>
                                                                    <asp:Button ID="btnDoctorRefresh" runat="server" CssClass="hide" OnClick="btnDoctorRefresh_Click" meta:resourcekey="btnDoctorRefreshResource1" />
                                                                    <div class="scroll scrollmedium">
                                                                        <asp:GridView ID="gvDoctorDates" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvDoctorDatesResource2">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="day_id" HeaderText="id" meta:resourcekey="BoundFieldResource20">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="day_name" HeaderText="Day" meta:resourcekey="BoundFieldResource21" />
                                                                                <asp:BoundField DataField="time_from" HeaderText="Time From" meta:resourcekey="BoundFieldResource22" />
                                                                                <asp:BoundField DataField="time_to" HeaderText="Time To" meta:resourcekey="BoundFieldResource23" />
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
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="modal-1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
            aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×</button>
                <h3 id="myModalLabel" meta:resourcekey="Deletion_Confirmation" runat="server">Deletion Confirmation</h3>
            </div>
            <div class="modal-body" meta:resourcekey="DeletionMsg" runat="server">
                <p>
                    Are you sure that you want to permanently delete this visit ?
                </p>
            </div>
            <div class="modal-footer" meta:resourcekey="DeletionMsg" runat="server">
                <button class="btn" data-dismiss="modal" aria-hidden="true">
                    No
                </button>
                <button id="btnConfirm" class="btn btn-primary" data-dismiss="modal">
                    Yes
                </button>
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
