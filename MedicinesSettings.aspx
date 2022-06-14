<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MedicinesSettings.aspx.cs"
    Inherits="MedicinesSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="~/ucMenuControlPanel.ascx" TagPrefix="uc1" TagName="ucMenuControlPanel" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Medicines_ud Settings</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css" meta:resourcekey="bootstrap" runat="server" />
    <!-- Bootstrap responsive -->
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" meta:resourcekey="bootstrapresponsive" runat="server" />
    <!-- jQuery UI -->
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/style.css" meta:resourcekey="style" runat="server" />
    <!-- Color CSS -->
    <link rel="stylesheet" href="css/themes.css" />
    <!-- GridView CSS -->
    <link rel="stylesheet" href="css/gridview.css" />
    <!-- Switch CSS-->
    <link rel="stylesheet" href="css/plugins/switch/switch.min.css" meta:resourcekey="switch" runat="server" />
    <!-- jQuery -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- My Library -->
    <script type="text/javascript" src="js/FQuery.js"></script>
    <!-- Switch -->
    <script type="text/javascript" src="js/plugins/switch/bootstrap-switch.min.js"></script>
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
    <!-- default button -->
    <script src="js/jquery-defaultButton.min.js"></script>
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
            $('a[href="MedicinesSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();

        };
        function DoWork() {
            /////////////////////////////////////////////////
            ///////////// Medicine Tab///////////////////////
            /////////////////////////////////////////////////
            $(".div_search_box").defaultButton("#btnSearchMedicine");
            $('#chkCommon').bootstrapSwitch();
            ClearMedicinetbl();
            $('#btnMedicineNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvMedicines_ud .gvrow").removeClass("blue3");
                $('#btnMedicines_udave').attr('disabled', false);
                $('#btnMedicineUpdate').attr('disabled', true);
                $('#btnMedicineDelete').attr('disabled', true);
                $('#tblMedicine').fClear();
            });

            $('#btnMedicineDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnMedicineDelete').attr('disabled', true);
                    $('#btnMedicineUpdate').attr('disabled', true);
                    $('#btnMedicineDelete').attr('value', 'Deleting');
                    __doPostBack('btnMedicineDelete', '');
                });
            });
            $("#gvMedicines_ud .gvrow").click(function () {
                $("#gvMedicines_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtMedicineID").val($(cells[0]).text());
                $("#txtMedicineName").val($(cells[1]).text());
                $("#drpMedicines_udtatus").val($(cells[2]).text());
                $("#drpMedicineCommon").val($(cells[3]).text());
                $('#btnMedicines_udave').attr('disabled', true);
                $('#btnMedicineUpdate').attr('disabled', false);
                $('#btnMedicineDelete').attr('disabled', false);
                Page_ClientValidate("e");
                //$("#txtMedicineName").focus();

            });

            /////////////////////////////////////////////////
            ///////////// End of Medicine Tab//////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
        function ClearMedicinetbl() {
            $("#gvMedicines_ud .gvrow").removeClass("blue3");
            $('#tblMedicine').fClear();
            $('#btnMedicines_udave').attr('disabled', false);
            $('#btnMedicineUpdate').attr('disabled', true);
            $('#btnMedicineDelete').attr('disabled', true);
        };

    </script>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server">
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <!-- Header -->
        <uc1:ucMenuControlPanel runat="server" ID="ucMenuControlPanel" />
        <!-- End of Header -->
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">

                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="hMedicines_udSett" runat="server">Medicines_ud Settings</h2>
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
                                    <h3 meta:resourcekey="hMedicinesSettings" runat="server">
                                        <i class="glyphicon-settings"></i>Medicines_ud Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a id="aMedicines_ud" meta:resourcekey="aMedicies" runat="server" href="#t1" data-toggle="tab">Medicines_ud</a> </li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hMedicies" runat="server">
                                                            <i class="glyphicon-hospital"></i>Medicines_ud</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upMedicine" runat="server">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblMedicine" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnMedicineNew" value="New" class="btn btn-grey" style="width: 70px" meta:resourcekey="btnMedicineNew" runat="server" />
                                                                            <asp:Button ID="btnMedicines_udave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                Width="70px" OnClick="btnMedicines_udave_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnMedicines_udaveResource1" />
                                                                            <asp:Button ID="btnMedicineUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" ValidationGroup="e" OnClick="btnMedicineUpdate_Click" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnMedicineDelete')!= null){document.getElementById('btnMedicineDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnMedicineUpdateResource1" />
                                                                            <asp:Button ID="btnMedicineDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnMedicineDelete_Click" CommandArgument="delete" meta:resourcekey="btnMedicineDeleteResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblId" runat="server">
                                                                            ID:</label>
                                                                        <div class="controls">
                                                                            <input id="txtMedicineID" runat="server" type="text" placeholder="Medicine ID" class="input-xlarge"
                                                                                disabled="disabled" meta:resourcekey="txtMedicineID" />
                                                                            &nbsp;
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblName" runat="server">
                                                                            Name:</label>
                                                                        <div class="controls">
                                                                            <input id="txtMedicineName" runat="server" type="text" placeholder="Medicine Name"
                                                                                class="input-xlarge txtFocus" maxlength="50" autocomplete="off" validationgroup="e" meta:resourcekey="txtMedicineName" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvTxtMedicineName" runat="server" ControlToValidate="txtMedicineName"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvTxtMedicineNameResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblStatus" runat="server">
                                                                            Status:</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpMedicines_udtatus" runat="server" CssClass='input-xlarge' meta:resourcekey="drpMedicines_udtatusResource1">
                                                                                <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                                <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblCommon" runat="server">
                                                                            Common:</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpMedicineCommon" runat="server" CssClass='input-xlarge' meta:resourcekey="drpMedicineCommonResource1">
                                                                                <asp:ListItem Value="1" Text="Yes" meta:resourcekey="drpCommonYes" />
                                                                                <asp:ListItem Value="0" Text="No" meta:resourcekey="drpCommonNo" />
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span7">
                                                                    <div class="div_search_box">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSearchgvMedicine" type="text" runat="server" class="input-xlarge"
                                                                                placeholder="Search Here..." autocomplete="off" meta:resourcekey="txtSearchgvMedicine" />
                                                                        </div>
                                                                        <asp:Button ID="btnSearchMedicine" runat="server" Text="Search" CssClass="btn btn-grey"
                                                                            OnClick="btnSearchMedecine_Click" OnClientClick="this.disabled = true; this.value ='Searching';"
                                                                            UseSubmitBehavior="False" Width="70px" meta:resourcekey="btnSearchMedicineResource1" />
                                                                        <input id="chkCommon" type="checkbox" runat="server" data-on-label=" <i class='icon-thumbs-up'></i>"
                                                                            data-off-label="All" data-on="danger" data-off="primary" meta:resourcekey="chkCommon" />
                                                                        <asp:DropDownList ID="drpSearchgvMedicine" runat="server" CssClass='input-large' meta:resourcekey="drpSearchgvMedicineResource1">
                                                                            <asp:ListItem Value="" Text="All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollbig3">
                                                                        <asp:GridView ID="gvMedicines_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False" PageSize="12"
                                                                            AllowPaging="True" EmptyDataText="No Results Found" OnPageIndexChanging="gvMedicines_ud_PageIndexChanging" meta:resourcekey="gvMedicines_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="medicine_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="medicine_name" HeaderText="Medicine Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="active" HeaderText="Status" meta:resourcekey="BoundFieldResource3">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="common" HeaderText="common" meta:resourcekey="BoundFieldResource4">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:TemplateField HeaderText="Status" meta:resourcekey="BoundFieldResource3" HeaderStyle-Width="12%">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("status")%>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Common" meta:resourcekey="BoundFieldResource4" HeaderStyle-Width="12%">
                                                                                    <ItemTemplate>
                                                                                        <button id="btnUpdateCommon" runat="server" class="btn btn-lightgrey" onserverclick="btnUpdateCommon_Click"><i class='<%# ReplaceField(Eval("common").ToString())%>'></i></button>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                            <PagerSettings Mode="NumericFirstLast" PageButtonCount="9" />
                                                                            <PagerStyle CssClass="gvpagination" />
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
