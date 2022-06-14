<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientsSettings.aspx.cs"
    Inherits="PatientsSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
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
    <title>Patients_ud Settings</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="PatientsSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            $('#btnPatients_udUpdate').attr('disabled', true);
            $('#btnPatients_udDelete').attr('disabled', true);
            $('#btnScanUpdate').attr('disabled', true);
            $('#btnScanDelete').attr('disabled', true);

            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };
        function DoWork() {
            // $("#divSett").defaultButton("#btnPatients_udSave");
            $("#divSrch").defaultButton("#btnPatients_udSearch");

            /////////////////////////////////////////////////
            /////////// Patients_ud Information Tab/////////////
            /////////////////////////////////////////////////

            $('#txtPatBirthdate').datepicker({ format: 'dd/mm/yyyy', autoclose: true });
            $('#btnPatients_udNew').click(function (event) {
                event.preventDefault();
                $("#gvPatients_ud .gvrow").removeClass("blue3");
                $('#btnPatients_udSave').attr('disabled', false);
                $('#btnPatients_udUpdate').attr('disabled', true);
                $('#btnPatients_udDelete').attr('disabled', true);
                $('.tblPatients_ud').fClear();
            });
            $('#btnPatients_udDelete').click(function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').click(function () {
                    $('#btnPatients_udDelete').attr('disabled', true);
                    $('#btnPatients_udUpdate').attr('disabled', true);
                    $('#btnPatients_udDelete').attr('value', 'Deleting');
                    __doPostBack('btnPatients_udDelete', '');
                });
            });

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
            $("#gvPatients_ud .gvrow").click(function () {
                $("#gvPatients_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtPatID").val($(cells[0]).text());
                $("#txtPatName").val($(cells[1]).text());
                $("#txtPatBirthdate").val($(cells[2]).text());
                $("#txtPatAddress").val($(cells[3]).text());
                $("#drpPatGender").val($(cells[19]).text());
                $("#txtPatMobile").val($(cells[5]).text());
                $("#txtPatPhone").val($(cells[6]).text());
                $("#txtPatJob").val($(cells[7]).text());
                $("#drpPatMarital").val($(cells[8]).text());
                $("#drpPatBlood").val($(cells[9]).text());
                $("#drpPatSmoker").val($(cells[10]).text());
                $("#drpPatDM").val($(cells[11]).text());
                $("#drpPatHTN").val($(cells[12]).text());
                $("#txtCreatedDate").val($(cells[13]).text());
                $("#txtCreatedBy").val($(cells[14]).text());
                $("#txtModifiedDate").val($(cells[15]).text());
                $("#txtModifiedBy").val($(cells[16]).text());
                $("#drpPatStatus").val($(cells[17]).text());
                $('#btnPatients_udSave').attr('disabled', true);
                $('#btnPatients_udUpdate').attr('disabled', false);
                $('#btnPatients_udDelete').attr('disabled', false);
                Page_ClientValidate("p");
                //$("html, body").animate({ scrollTop: "75px" }, "normal");
            });
            $("#gvPatients_ud tr td:nth-child(5)").each(function () {
                var cellText = $(this).text().toLowerCase();
                if ($('.lnklang').html() == "EN") {
                    if (cellText == 'male') {
                        $(this).text('ذكـر');
                    }
                    else {
                        $(this).text('أنثـى');
                    }
                }
                
            });
            /////////////////////////////////////////////////
            ////// End of Patients_ud Information Tab///////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com

        };
        //////////////// Patients_ud Tab////////////////////
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
        <uc1:ucReception runat="server" ID="ucReception" />
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="row-fluid">
                        <div class="page-header">
                            <div class="pull-left">
                                <h2 meta:resourcekey="hPatients_ud_Settings" runat="server">Patients_ud Settings</h2>
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
                                        <h3 meta:resourcekey="h3Patients_ud_Settings" runat="server">
                                            <i class="glyphicon-settings"></i>Patients_ud Settings
                                        </h3>
                                        <ul class="tabs">
                                            <li class="active" meta:resourcekey="Patients_ud" runat="server"><a href="#t1" data-toggle="tab">Patients_ud</a> </li>
                                            <li meta:resourcekey="PatientsofCompanies_ud" runat="server"><a href="PatientsofCompanies_ud.aspx">Patients_ud of Companies_ud</a> </li>
                                        </ul>
                                    </div>
                                    <div class="box-content nopadding">
                                        <div class="tab-content">
                                            <div id="t1" class="tab-pane active">
                                                <div class='form-horizontal form-column form-bordered'>
                                                    <asp:UpdatePanel ID="upPatients_ud" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <div id="divSett" class="box box-bordered box-color">
                                                                <div class="box-title">
                                                                    <h3 meta:resourcekey="Patients_ud_Information" runat="server">
                                                                        <i class="glyphicon-group"></i>Patients_ud Information</h3>
                                                                </div>
                                                                <div class="box-content nopadding">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="ActionsResource1" runat="server">
                                                                            Actions:
                                                                        </label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnPatients_udNew" meta:resourcekey="btnPatients_udNewResource1" runat="server" value="New" class="btn btn-grey" style="width: 70px" />
                                                                            <asp:Button ID="btnPatients_udSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                Width="70px" OnClick="btnPatients_udSave_Click" ValidationGroup="p" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnPatients_udSaveResource1" />
                                                                            <asp:Button ID="btnPatients_udUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnPatients_udUpdate_Click" ValidationGroup="p" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnPatients_udDelete')!= null){document.getElementById('btnPatients_udDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnPatients_udUpdateResource1" />
                                                                            <asp:Button ID="btnPatients_udDelete" Text="Delete" runat="server" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnPatients_udDelete_Click" CommandArgument="delete" meta:resourcekey="btnPatients_udDeleteResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="span6 tblPatients_ud">
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="Patient_NoResource1" runat="server">
                                                                            </label>
                                                                            <div class="controls">
                                                                                <input id="txtPatID" runat="server" type="text" meta:resourcekey="Patient_Number" placeholder="Patient Number" class="input-xlarge"
                                                                                    disabled="disabled" autocomplete="off" />

                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="NameResource1" runat="server">
                                                                                Name:</label>
                                                                            <div class="controls">
                                                                                <input id="txtPatName" runat="server" type="text" meta:resourcekey="Patient_Name" placeholder="Patient Name" class="input-xlarge txtFocus"
                                                                                    autocomplete="off" maxlength="50" validationgroup="p" />
                                                                                <asp:RequiredFieldValidator ID="rvtxtPatName" runat="server" ControlToValidate="txtPatName"
                                                                                    ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True" ValidationGroup="p" meta:resourcekey="rvtxtPatNameResource1"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="BirthdateResource1" runat="server">
                                                                                Birthdate:</label>
                                                                            <div class="controls">
                                                                                <input id="txtPatBirthdate" runat="server" type="text" meta:resourcekey="Patient_Birthdate" placeholder="Patient Birthdate"
                                                                                    maxlength="10" autocomplete="off" class="input-xlarge" data-date-format="dd/mm/yyyy" />
                                                                                <asp:RequiredFieldValidator ID="rvtxtPatBirthdate" runat="server" ControlToValidate="txtPatBirthdate"
                                                                                    Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationGroup="p" meta:resourcekey="rvtxtPatBirthdateResource1"></asp:RequiredFieldValidator>
                                                                                <asp:RegularExpressionValidator ID="retxtPatBirthdate" runat="server" ControlToValidate="txtPatBirthdate"
                                                                                    ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                                                    Display="Dynamic" ValidationGroup="p" meta:resourcekey="retxtPatBirthdateResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="AddressResource1" runat="server">
                                                                                Address:</label>
                                                                            <div class="controls">
                                                                                <input id="txtPatAddress" runat="server" meta:resourcekey="Patient_Address" type="text" placeholder="Patient Address"
                                                                                    maxlength="50" autocomplete="off" class="input-xlarge" />

                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="GenderResource1" runat="server">
                                                                                Gender:</label>
                                                                            <div class="controls">
                                                                                <asp:DropDownList ID="drpPatGender" class='input-xlarge' runat="server" meta:resourcekey="drpPatGenderResource1">
                                                                                    <asp:ListItem Text="Gender - All" Value="" meta:resourcekey="ListItemResourceKey1"></asp:ListItem>
                                                                                    <asp:ListItem Text="Male" Value="m" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                                    <asp:ListItem Value="f" Text="Female" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="MobileResource1" runat="server">
                                                                                Mobile:</label>
                                                                            <div class="controls">
                                                                                <input id="txtPatMobile" meta:resourcekey="Patient_Mobile" runat="server" type="text" placeholder="Patient Mobile"
                                                                                    maxlength="20" autocomplete="off" class="input-xlarge" />
                                                                                <asp:RegularExpressionValidator ID="retxtPatMobile" runat="server" ControlToValidate="txtPatMobile"
                                                                                    ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationExpression="\s*[ 0-9 ]+\s*" ValidationGroup="p" meta:resourcekey="retxtPatMobileResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="PhoneResource1" runat="server">
                                                                                Phone:</label>
                                                                            <div class="controls">
                                                                                <input id="txtPatPhone" runat="server" meta:resourcekey="Patient_Phone" type="text" placeholder="Patient Phone" class="input-xlarge"
                                                                                    maxlength="20" autocomplete="off" />
                                                                                <asp:RegularExpressionValidator ID="retxtPatPhone" runat="server" ControlToValidate="txtPatPhone"
                                                                                    ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationExpression="\s*[ 0-9 ]+\s*" ValidationGroup="p" meta:resourcekey="retxtPatPhoneResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="JobResource1" runat="server">
                                                                                Job:</label>
                                                                            <div class="controls">
                                                                                <input id="txtPatJob" runat="server" type="text" meta:resourcekey="Patient_Job" placeholder="Patient Job" class="input-xlarge"
                                                                                    maxlength="50" autocomplete="off" />

                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="MaritalResource1" runat="server">
                                                                                Marital:</label>
                                                                            <div class="controls">
                                                                                <asp:DropDownList ID="drpPatMarital" class='input-xlarge' runat="server" meta:resourcekey="drpPatMaritalResource1">
                                                                                    <asp:ListItem Text="Single" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                                    <asp:ListItem Text="Engaged" Value="2" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                                    <asp:ListItem Text="Married" Value="3" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                                    <asp:ListItem Text="Divorced" Value="4" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                                                    <asp:ListItem Text="Widower" Value="5" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="span6 tblPatients_ud">
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="BloodResource1" runat="server">
                                                                                Blood:</label>
                                                                            <div class="controls">
                                                                                <asp:DropDownList ID="drpPatBlood" class='input-xlarge' runat="server" meta:resourcekey="drpPatBloodResource1">
                                                                                    <asp:ListItem Text="A+" Value="1" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                                                    <asp:ListItem Text="B+" Value="2" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                                                    <asp:ListItem Text="AB+" Value="3" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                                                    <asp:ListItem Text="O+" Value="4" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                                                                    <asp:ListItem Text="A-" Value="5" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                                                                    <asp:ListItem Text="B-" Value="6" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                                                                    <asp:ListItem Text="AB-" Value="7" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                                                                    <asp:ListItem Text="O-" Value="8" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="SmokerResource1" runat="server">
                                                                                Smoker:</label>
                                                                            <div class="controls">
                                                                                <asp:DropDownList ID="drpPatSmoker" class='input-xlarge' runat="server" meta:resourcekey="drpPatSmokerResource1">
                                                                                    <asp:ListItem Text="No" Value="0" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                                                                    <asp:ListItem Text="Yes" Value="1" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="DMResource1" runat="server">
                                                                                DM:</label>
                                                                            <div class="controls">
                                                                                <asp:DropDownList ID="drpPatDM" class='input-xlarge' runat="server" meta:resourcekey="drpPatDMResource1">
                                                                                    <asp:ListItem Text="No" Value="0" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                                                                    <asp:ListItem Text="Yes" Value="1" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="HTNResource1" runat="server">
                                                                                HTN:</label>
                                                                            <div class="controls">
                                                                                <asp:DropDownList ID="drpPatHTN" class='input-xlarge' runat="server" meta:resourcekey="drpPatHTNResource1">
                                                                                    <asp:ListItem Text="No" Value="0" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                                                                    <asp:ListItem Text="Yes" Value="1" meta:resourcekey="ListItemResource21"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="Created_OnResource1" runat="server">
                                                                                Created-On:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCreatedDate" runat="server" meta:resourcekey="Created_Date" type="text" placeholder="Created Date"
                                                                                    class="input-xlarge" disabled="disabled" />

                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="Created_ByResource1" runat="server">
                                                                                Created-By:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCreatedBy" runat="server" meta:resourcekey="Created_By" type="text" placeholder="Created By" class="input-xlarge"
                                                                                    disabled="disabled" />

                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="Modified_OnResource1" runat="server">
                                                                                Modified-On:</label>
                                                                            <div class="controls">
                                                                                <input id="txtModifiedDate" meta:resourcekey="Modified_Date" runat="server" type="text" placeholder="Modified Date"
                                                                                    class="input-xlarge" disabled="disabled" />

                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="Modified_ByResource1" runat="server">
                                                                                Modified-By:</label>
                                                                            <div class="controls">
                                                                                <input id="txtModifiedBy" runat="server" meta:resourcekey="Modified_By" type="text" placeholder="Modified By" class="input-xlarge"
                                                                                    disabled="disabled" />

                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="StatusResource1" runat="server">
                                                                                Status:</label>
                                                                            <div class="controls">
                                                                                <asp:DropDownList ID="drpPatStatus" class='input-xlarge' runat="server" meta:resourcekey="drpPatStatusResource1">
                                                                                    <asp:ListItem Text="Status" Value="" meta:resourcekey="ListItemResourceKey22"></asp:ListItem>
                                                                                    <asp:ListItem Text="Inactive" Value="0" meta:resourcekey="ListItemResource22"></asp:ListItem>
                                                                                    <asp:ListItem Text="Active" Value="1" meta:resourcekey="ListItemResource23"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="divSrch" class="box box-bordered box-color">
                                                                <div class="box-title">
                                                                    <h3 meta:resourcekey="Search_Patients_ud" runat="server">
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
                                                                                    <asp:BoundField DataField="active" HeaderText="Status" HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide" meta:resourcekey="BoundFieldResource18"/>
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
        </div>
        <div id="modal-1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
            aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×</button>
                <h3 id="myModalLabel">Deletion Confirmation</h3>
            </div>
            <div class="modal-body">
                <p>
                    Are you sure that you want to permanently delete this record ?
                </p>
            </div>
            <div class="modal-footer">
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
