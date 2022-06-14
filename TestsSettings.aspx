<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestsSettings.aspx.cs" Inherits="TestsSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

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
    <title>Tests Settings</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css" meta:resourcekey="bootstrap" runat="server" />
    <!-- Bootstrap responsive -->
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" meta:resourcekey="bootstrapresponsive" runat="server" />
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/style.css" meta:resourcekey="style" runat="server" />
    <!-- jQuery UI -->
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
    <!-- Color CSS -->
    <link rel="stylesheet" href="css/themes.css" />
    <!-- GridView CSS -->
    <link rel="stylesheet" href="css/gridview.css" />
    <!-- jQuery -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- My Library -->
    <script type="text/javascript" src="js/FQuery.js"></script>
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
            $('a[href="TestsSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            $('#btnBloodUpdate').attr('disabled', true);
            $('#btnBloodDelete').attr('disabled', true);
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

            /////////////////////////////////////////////////
            ///////////// Blood Test Tab//////////////////////
            /////////////////////////////////////////////////
            $('#btnBloodNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvBloodTests .gvrow").removeClass("blue3");
                $('#btnBloodSave').attr('disabled', false);
                $('#btnBloodUpdate').attr('disabled', true);
                $('#btnBloodDelete').attr('disabled', true);
                $('#tblBlood').fClear();
            });
            $('#btnBloodDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnBloodDelete').attr('disabled', true);
                    $('#btnBloodUpdate').attr('disabled', true);
                    $('#btnBloodDelete').attr('value', 'Deleting');
                    __doPostBack('btnBloodDelete', '');
                });
            });
            $('#txtSearchgvBlood').keyup(function SearchtxtgvBlood() {
                ClearBloodtbl();
                $('#drpSearchgvBlood').val('');
                var searchKey = $.trim($('#txtSearchgvBlood').val().toLowerCase());
                $("#gvBloodTests tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });

            });
            $('#drpSearchgvBlood').change(function SearchdrpgvBlood() {
                ClearBloodtbl();
                $('#txtSearchgvBlood').val('');
                var searchKey = $.trim($('#drpSearchgvBlood').val().toLowerCase());
                $("#gvBloodTests tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvBloodTests .gvrow").click(function () {
                $("#gvBloodTests .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtBloodID").val($(cells[0]).text());
                $("#txtBloodName").val($(cells[1]).text());
                $("#drpBloodStatus").val($(cells[2]).text());
                $('#btnBloodSave').attr('disabled', true);
                $('#btnBloodUpdate').attr('disabled', false);
                $('#btnBloodDelete').attr('disabled', false);
                Page_ClientValidate("b");
            });
            /////////////////////////////////////////////////
            ///////////// End of Blood Test Tab//////////////
            /////////////////////////////////////////////////

            /////////////////////////////////////////////////
            ///////////// Scans Tab//////////////////////////
            /////////////////////////////////////////////////
            $('#btnScanNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvScans .gvrow").removeClass("blue3");
                $('#btnScanSave').attr('disabled', false);
                $('#btnScanUpdate').attr('disabled', true);
                $('#btnScanDelete').attr('disabled', true);
                $('#tblScans').fClear();
            });
            $('#btnScanDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnScanDelete').attr('disabled', true);
                    $('#btnScanUpdate').attr('disabled', true);
                    $('#btnScanDelete').attr('value', 'Deleting');
                    __doPostBack('btnScanDelete', '');
                });
            });
            $('#txtSearchgvScan').keyup(function SearchgvScan() {
                ClearScantbl();
                $('#drpSearchgvScan').val('');
                var searchKey = $.trim($('#txtSearchgvScan').val().toLowerCase());
                $("#gvScans tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });

            });
            $('#drpSearchgvScan').change(function SearchgvScan() {
                ClearScantbl();
                $('#txtSearchgvScan').val('');
                var searchKey = $.trim($('#drpSearchgvScan').val().toLowerCase());
                $("#gvScans tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvScans .gvrow").click(function () {
                $("#gvScans .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtScanID").val($(cells[0]).text());
                $("#txtScanName").val($(cells[1]).text());
                $("#drpScanStatus").val($(cells[2]).text());
                $('#btnScanSave').attr('disabled', true);
                $('#btnScanUpdate').attr('disabled', false);
                $('#btnScanDelete').attr('disabled', false);
                Page_ClientValidate("s");
            });
            /////////////////////////////////////////////////
            ///////////// End of Scans Tab///////////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
        function ClearBloodtbl() {
            $("#gvBloodTests .gvrow").removeClass("blue3");
            $('#tblBlood').fClear();
            $('#btnBloodSave').attr('disabled', false);
            $('#btnBloodUpdate').attr('disabled', true);
            $('#btnBloodDelete').attr('disabled', true);
        };
        function ClearScantbl() {
            $("#gvScans .gvrow").removeClass("blue3");
            $('#tblScans').fClear();
            $('#btnScanSave').attr('disabled', false);
            $('#btnScanUpdate').attr('disabled', true);
            $('#btnScanDelete').attr('disabled', true);
        };
        function ClearSearchAttrBlood() {
            $('#txtSearchgvBlood').val('');
            $('#drpSearchgvBlood').val('');
        };
        function ClearSearchAttrScan() {
            $('#txtSearchgvScan').val('');
            $('#drpSearchgvScan').val('');
        };
    </script>
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
                            <h2 meta:resourcekey="hDemoSett" runat="server">Tests Settings</h2>
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
                                        <i class="glyphicon-settings"></i>Blood Tests & Scans Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a id="aBlood" href="#t1" data-toggle="tab" meta:resourcekey="aBlood" runat="server">Blood Tests</a> </li>
                                        <li><a id="aScan" href="#t2" data-toggle="tab" meta:resourcekey="aScan" runat="server">Scans</a> </li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hBTests" runat="server">
                                                            <i class="glyphicon-tint"></i>Blood Tests</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upBlood" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblBlood" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnBloodNew" value="New" class="btn btn-grey" style="width: 70px" meta:resourcekey="btnDemoNew" runat="server" />
                                                                            &nbsp;<asp:Button ID="btnBloodSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                Width="70px" OnClick="btnBloodSave_Click" ValidationGroup="b" OnClientClick="if (!Page_ClientValidate('b')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnDemoSave" />
                                                                            <asp:Button ID="btnBloodUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnBloodUpdate_Click" ValidationGroup="b" OnClientClick="if (!Page_ClientValidate('b')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnBloodDelete')!= null){ document.getElementById('btnBloodDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnDemoUpdate" />
                                                                            <asp:Button ID="btnBloodDelete" Text="Delete" runat="server" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnBloodDelete_Click" CommandArgument="delete" meta:resourcekey="btnDemoDelete" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblId" runat="server">
                                                                            Test-ID:</label>
                                                                        <div class="controls">
                                                                            <input id="txtBloodID" runat="server" type="text" placeholder="Blood Test ID" class="input-xlarge"
                                                                                disabled="disabled" meta:resourcekey="txtBloodID" />
                                                                            &nbsp;
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblName" runat="server">
                                                                            Test-Name:</label>
                                                                        <div class="controls">
                                                                            <input id="txtBloodName" runat="server" type="text" placeholder="Blood Test Name"
                                                                                class="input-xlarge txtFocus" maxlength="50" autocomplete="off" validationgroup="b" meta:resourcekey="txtBloodName" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvTxtBloodName" runat="server" ControlToValidate="txtBloodName"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="b" meta:resourcekey="rvTxtBloodNameResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblStatus" runat="server">
                                                                            Status:</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpBloodStatus" runat="server" CssClass='input-xlarge' meta:resourcekey="drpBloodStatusResource1">
                                                                                <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                                <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
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
                                                                            <input id="txtSearchgvBlood" type="text" value="" class="input-large" placeholder="Search Here..."
                                                                                autocomplete="off" meta:resourcekey="txtSearchgvDemo" runat="server" />
                                                                        </div>
                                                                        <asp:DropDownList ID="drpSearchgvBlood" runat="server" CssClass='input-medium' meta:resourcekey="drpSearchgvBloodResource1">
                                                                            <asp:ListItem Value="" Text="All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvBloodTests" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvBloodTestsResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="Test_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="Test_name" HeaderText="Blood Test Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="active" HeaderText="Status" meta:resourcekey="BoundFieldResource3">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:TemplateField HeaderText="Status" meta:resourcekey="BoundFieldResource3" HeaderStyle-Width="14%">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("status")%>
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
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hSTests" runat="server">
                                                            <i class="glyphicon-picture"></i>Scans</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upScans" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblScans" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnScanNew" value="New" class="btn btn-grey" style="width: 70px" meta:resourcekey="btnDemoNew" runat="server" />
                                                                            &nbsp;<asp:Button ID="btnScanSave" Text="Save" runat="server" CssClass="btn btn-blue" Width="70px"
                                                                                OnClick="btnScanSave_Click" ValidationGroup="s" OnClientClick="if (!Page_ClientValidate('s')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnDemoSave" />
                                                                            <asp:Button ID="btnScanUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnScanUpdate_Click" ValidationGroup="s" OnClientClick="if (!Page_ClientValidate('s')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnScanDelete')!= null){ document.getElementById('btnScanDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnDemoUpdate" />
                                                                            <asp:Button ID="btnScanDelete" Text="Delete" runat="server" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnScanDelete_Click" CommandArgument="delete" meta:resourcekey="btnDemoDelete" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblId" runat="server">
                                                                            Scan-ID:</label>
                                                                        <div class="controls">
                                                                            <input id="txtScanID" runat="server" type="text" placeholder="Scan Test ID" class="input-xlarge"
                                                                                disabled="disabled" meta:resourcekey="txtScanID" />
                                                                            &nbsp;
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblName" runat="server">
                                                                            Scan-Name:</label>
                                                                        <div class="controls">
                                                                            <input id="txtScanName" runat="server" type="text" placeholder="Scan Test Name" class="input-xlarge txtFocus"
                                                                                maxlength="50" autocomplete="off" validationgroup="s" meta:resourcekey="txtScanName" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvTxtScanName" runat="server" ControlToValidate="txtScanName"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="s" meta:resourcekey="rvTxtScanNameResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblStatus" runat="server">
                                                                            Status:</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpScanStatus" runat="server" CssClass='input-xlarge' meta:resourcekey="drpScanStatusResource1">
                                                                                <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                                <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
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
                                                                            <input id="txtSearchgvScan" type="text" class="input-large" placeholder="Search Here..."
                                                                                autocomplete="off" meta:resourcekey="txtSearchgvDemo" runat="server" />
                                                                            &nbsp;
                                                                        </div>
                                                                        <asp:DropDownList ID="drpSearchgvScan" runat="server" CssClass='input-medium' meta:resourcekey="drpSearchgvScanResource1">
                                                                            <asp:ListItem Value="" Text="All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvScans" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvScansResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="Test_id" HeaderText="ID" meta:resourcekey="BoundFieldResource4">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="Test_name" HeaderText="Scan Name" meta:resourcekey="BoundFieldResource5" />
                                                                                <asp:BoundField DataField="active" HeaderText="Status" meta:resourcekey="BoundFieldResource6">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:TemplateField HeaderText="Status" meta:resourcekey="BoundFieldResource3" HeaderStyle-Width="14%">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("status")%>
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
        <asp:Button ID="btnSaveTheme" runat="server" OnClick="btnSaveTheme_Click" CssClass="hide" meta:resourcekey="btnSaveThemeResource1" />
        <div id="footer">
            <p id="P2" meta:resourcekey="pAboutus" runat="server">
                Umbrella v3.4 - © All Rights Reserved For APPLET Software <span class="font-grey-4">|</span><a href="AboutUs.aspx" target="_blank"> About Us </a>
            </p>
            <a href="#" class="gototop"><i class="icon-arrow-up"></i></a>
        </div>
    </form>
</body>
</html>
