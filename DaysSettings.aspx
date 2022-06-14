<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DaysSettings.aspx.cs" Inherits="Days_udSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="~/ucMenuControlPanel.ascx" TagPrefix="uc1" TagName="ucMenuControlPanel" %>
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
    <title>Days_ud Settings</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="Days_udSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };
        function DoWork() {

            ////////////////////////////////////////
            ////////// Day Tab /////////////////////
            ///////////////////////////////////////

            $('#btnDays_udSave').attr('disabled', true);
            //$(".has-switch div:nth-child(2)").parent().remove();
            $('#chkDayAvailable').bootstrapSwitch();
            $('#chkDayAvailable').bootstrapSwitch('setState', false); // true || false

            $('#btnDays_udNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvDays_ud .gvrow").removeClass("blue3");
                $('#btnDays_udSave').attr('disabled', true);
                ClearDays_udTbl();
            });

            $("#gvDays_ud .gvrow").click(function () {
                $("#gvDays_ud .gvrow").removeClass("blue3");
                $('#btnDays_udSave').attr('disabled', false);
                $('#chkDayAvailable').bootstrapSwitch('setState', false);
                $(this).addClass("blue3");
                var c = $(this).find("td");
                $("#txtDayID").val($(c[0]).text());
                $("#txtDayName").val($(c[1]).text());
                $('#chkDayAvailable').bootstrapSwitch('setState', false);
                if ($(c[2]).text().toLowerCase() == "yes") {
                    $('#chkDayAvailable').bootstrapSwitch('setState', true);
                }
            });
            //$("#gvDays_ud .gvrow td:nth-child(4)").each(function () {
            //    var cellText = $(this).html().trim();
            //    if ($('#ucMenuControlPanel_lnklang').html() == "EN") {
            //        if (cellText == 'Yes') {
            //            $(this).html('نعـم');
            //        }
            //        else {
            //            $(this).html('لا');
            //        }
            //    }
            //});
            ////////////////////////////////////////
            ////////////End Day Tab/////////////////
            ////////////////////////////////////////

            /////////////////////////////////////////
            ///////// Appointments Tab///////////////
            /////////////////////////////////////////
            $('#drpDays_ud').select2();
            $('#txtDayDetID').val('');
            $('#btnDayDetSave').attr('disabled', false);
            $('#btnDayDetUpdate').attr('disabled', true);
            $('#btnDayDetDelete').attr('disabled', true);
            $('#txtTimeFrom').timepicker({
                minuteStep: 5,
                showInputs: false,
                disableFocus: true
            });
            $('#txtTimeTo').timepicker({
                minuteStep: 5,
                showInputs: false,
                disableFocus: true
            });
            $("#gvDayDet .gvrow").click(function () {
                $("#gvDayDet .gvrow").removeClass("blue3");
                $('#btnDayDetSave').attr('disabled', true);
                $('#btnDayDetUpdate').attr('disabled', false);
                $('#btnDayDetDelete').attr('disabled', false);
                $('#chkDayAvailable').bootstrapSwitch('setState', false);
                $(this).addClass("blue3");
                var c = $(this).find("td");
                $("#txtDayDetID").val($(c[0]).text());
                $("#txtTimeFrom").val($(c[2]).text());
                $("#txtTimeTo").val($(c[3]).text());

            });

            $('#btnDayDetNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvDayDet .gvrow").removeClass("blue3");
                $("#txtDayDetID").val('');
                $('#btnDayDetSave').attr('disabled', false);
                $('#btnDayDetUpdate').attr('disabled', true);
                $('#btnDayDetDelete').attr('disabled', true);
            });
            $('#btnDayDetDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $.ionSound.play('confirm');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnDayDetDelete').attr('disabled', true);
                    $('#btnDayDetUpdate').attr('disabled', true);
                    $('#btnDayDetDelete').attr('value', 'Deleting');
                    __doPostBack('btnDayDetDelete', '');
                });
            });
            if ($('#ucMenuControlPanel_lnklang').html() == "EN") {
                $('.bootstrap-timepicker-widget').addClass('tpStyle');
            };
            /////////////////////////////////////////
            /////////End Appointments Tab///////////
            /////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
        function ClearDays_udTbl() {
            $("#txtDayID").val('');
            $("#txtDayName").val('');
            $('#chkDayAvailable').bootstrapSwitch('setState', false); // true || false
        };
    </script>
    <style>
        .tpStyle {
            right: 0 !important;
            left: auto !important;
            float: left !important;
            direction: ltr !important;
        }
    </style>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" />
        <!-- Header -->
        <uc1:ucMenuControlPanel runat="server" ID="ucMenuControlPanel" />
        <!-- End of Header -->
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="hDemoSett" runat="server">Days_ud Settings</h2>
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
                                    <h3 meta:resourcekey="hDemoSettings" runat="server">
                                        <i class="icon-user-md"></i>Doctor's Appointments
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="aDays_ud" runat="server">Days_ud</a> </li>
                                        <li><a href="#t2" data-toggle="tab" meta:resourcekey="aAppo" runat="server">Appointments</a> </li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hDays_udSett" runat="server">
                                                            <i class="glyphicon-calendar"></i>Days_ud</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upDays_ud" runat="server">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblVisits" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:-</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnDays_udNew" value="New" class="btn btn-grey" style="width: 70px" meta:resourcekey="btnDemoNew" runat="server" />
                                                                            <asp:Button ID="btnDays_udSave" Text="Save" runat="server" CssClass="btn btn-blue" Width="70px"
                                                                                OnClick="btnDays_udSave_Click" OnClientClick="this.disabled = true; this.value ='Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnDemoSave" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblDay" runat="server">
                                                                            Day:-</label>
                                                                        <div class="controls">
                                                                            <input id="txtDayID" runat="server" type="text" class="hide" disabled="disabled" />
                                                                            <input id="txtDayName" runat="server" type="text" placeholder="Day Name" class="input-xlarge txtFocus"
                                                                                disabled="disabled" meta:resourcekey="txtDayName" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblAvailable" runat="server">
                                                                            Available:-</label>
                                                                        <div class="controls">
                                                                            <input id="chkDayAvailable" runat="server" type="checkbox" data-on-label="Yes" data-off-label="NO"
                                                                                data-on="danger" data-off="primary" />
                                                                            &nbsp;
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span7">
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvDays_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvDays_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="day_id" HeaderText="id" meta:resourcekey="BoundFieldResource1">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="day_name_ar" HeaderText="Day" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="active" HeaderText="Available" meta:resourcekey="BoundFieldResource3" HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide" />
                                                                                <asp:BoundField DataField="active" HeaderText="Available" meta:resourcekey="BoundFieldResource3" ItemStyle-CssClass="yesno"/>
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
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hDemo" runat="server">
                                                            <i class="glyphicon-clock"></i>Appointments</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upAppointments" runat="server">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div class="span6">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:-</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnDayDetNew" value="New" class="btn btn-grey" style="width: 70px" meta:resourcekey="btnDemoNew" runat="server" />
                                                                            <asp:Button ID="btnDayDetSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                Width="70px" OnClick="btnDayDetSave_Click" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" ValidationGroup="e" CommandArgument="save" meta:resourcekey="btnDemoSave" />
                                                                            <asp:Button ID="btnDayDetUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnDayDetUpdate_Click" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating';if(document.getElementById('btnDayDetDelete')!= null){document.getElementById('btnDayDetDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" ValidationGroup="e" CommandArgument="update" meta:resourcekey="btnDemoUpdate" />
                                                                            <asp:Button ID="btnDayDetDelete" Text="Delete" runat="server" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnDayDetDelete_Click" CommandArgument="delete" meta:resourcekey="btnDemoDelete" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblDay" runat="server">
                                                                            Day:-</label>
                                                                        <div class="controls">
                                                                            <input id="txtDayDetID" runat="server" type="text" class="hide"/>
                                                                            <asp:DropDownList ID="drpDays_ud" runat="server" CssClass='input-large txtFocus' OnSelectedIndexChanged="drpDays_ud_SelectedIndexChanged"
                                                                                AutoPostBack="True" meta:resourcekey="drpDays_udResource1" />
                                                                            <asp:RequiredFieldValidator ID="rvtxtDayDetID" runat="server" ControlToValidate="txtDayDetID"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" InitialValue="0" meta:resourcekey="rvtxtDayDetIDResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblTimeFrom" runat="server">
                                                                            Time-From:-</label>
                                                                        <div class="controls">
                                                                            <div class="bootstrap-timepicker">
                                                                                <input id="txtTimeFrom" runat="server" type="text" class="input-medium" />
                                                                            </div>
                                                                            <asp:RequiredFieldValidator ID="rvtxtTimeFrom" runat="server" ControlToValidate="txtTimeFrom"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtTimeFromResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblTimeTo" runat="server">
                                                                            Time-To:-</label>
                                                                        <div class="controls">
                                                                            <div class="bootstrap-timepicker">
                                                                                <input id="txtTimeTo" runat="server" type="text" class="input-medium" />
                                                                            </div>
                                                                            <asp:RequiredFieldValidator ID="rvtxtTimeTo" runat="server" ControlToValidate="txtTimeTo"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtTimeToResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span6">
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvDayDet" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvDayDetResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="day_det_id" HeaderText="day_det_id" meta:resourcekey="BoundFieldResource4">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="day_id" HeaderText="day_id" meta:resourcekey="BoundFieldResource5">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="time_from" HeaderText="Time From" meta:resourcekey="BoundFieldResource6" />
                                                                                <asp:BoundField DataField="time_to" HeaderText="Time To" meta:resourcekey="BoundFieldResource7" />
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
                <h3 id="myModalLabel" meta:resourcekey="myModalLabel" runat="server">Deletion Confirmation</h3>
            </div>
            <div class="modal-body">
                <p id="P1" meta:resourcekey="pDelete" runat="server">
                    Are you sure that you want to permanently delete this record ?
                </p>
            </div>
            <div class="modal-footer">
                <button id="Button1" class="btn" data-dismiss="modal" aria-hidden="true" meta:resourcekey="btnNo" runat="server">
                    No
                </button>
                <button id="btnConfirm" class="btn btn-primary" data-dismiss="modal" meta:resourcekey="btnYes" runat="server">
                    Yes
                </button>
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
</body>
</html>
