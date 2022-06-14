<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DosesSettings.aspx.cs" Inherits="DosesSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

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
    <title>Doses_ud Settings</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="DosesSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            $('#btnDoseUpdate').attr('disabled', true);
            $('#btnDoseDelete').attr('disabled', true);
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();

        };
        function DoWork() {

            /////////////////////////////////////////////////
            ///////////// Dose Tab///////////////////////////
            /////////////////////////////////////////////////

            $('#btnDoseNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvDoses_ud .gvrow").removeClass("blue3");
                $('#btnDoses_udave').attr('disabled', false);
                $('#btnDoseUpdate').attr('disabled', true);
                $('#btnDoseDelete').attr('disabled', true);
                $('#tblDose').fClear();
            });

            $('#btnDoseDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnDoseDelete').attr('disabled', true);
                    $('#btnDoseUpdate').attr('disabled', true);
                    $('#btnDoseDelete').attr('value', 'Deleting');
                    __doPostBack('btnDoseDelete', '');
                });
            });

            $('#txtSearchgvDose').keyup(function SearchtxtgvDose() {
                ClearDosetbl();
                $('#drpSearchgvDose').val('');
                var searchKey = $.trim($('#txtSearchgvDose').val().toLowerCase());
                $("#gvDoses_ud tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });

            });
            $('#drpSearchgvDose').change(function SearchdrpgvDose() {
                ClearDosetbl();
                $('#txtSearchgvDose').val('');
                var searchKey = $.trim($('#drpSearchgvDose').val().toLowerCase());
                $("#gvDoses_ud tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvDoses_ud .gvrow").click(function () {
                $("#gvDoses_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtDoseID").val($(cells[0]).text());
                $("#txtDoseName").val($(cells[1]).text());
                $("#drpDoses_udtatus").val($(cells[2]).text());
                $('#btnDoses_udave').attr('disabled', true);
                $('#btnDoseUpdate').attr('disabled', false);
                $('#btnDoseDelete').attr('disabled', false);
                Page_ClientValidate("e");
            });
            /////////////////////////////////////////////////
            ///////////// End of Dose Tab////////////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com

        };
        function ClearDosetbl() {
            $("#gvDoses_ud .gvrow").removeClass("blue3");
            $('#tblDose').fClear();
            $('#btnDoses_udave').attr('disabled', false);
            $('#btnDoseUpdate').attr('disabled', true);
            $('#btnDoseDelete').attr('disabled', true);
        };
        function ClearSearchAttr() {
            $('#txtSearchgvDose').val('');
            $('#drpSearchgvDose').val('');
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
                            <h2 meta:resourcekey="hDoses_udSett" runat="server">Doses_ud Settings</h2>
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
                                    <h3 meta:resourcekey="hDosesSettings" runat="server">
                                        <i class="glyphicon-settings"></i>Doses_ud Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a id="aDoses_ud" href="#t1" data-toggle="tab" meta:resourcekey="aDoses_ud" runat="server">Doses_ud</a> </li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hDoses_ud" runat="server">
                                                            <i class="glyphicon-eyedropper"></i>Doses_ud</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upDose" runat="server">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblDose" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnDoseNew" value="New" class="btn btn-grey" style="width: 70px" meta:resourcekey="btnDoseNew" runat="server" />
                                                                            <asp:Button ID="btnDoses_udave" Text="Save" runat="server" CssClass="btn btn-blue" Width="70px"
                                                                                OnClick="btnDoses_udave_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnDoses_udaveResource1" />
                                                                            <asp:Button ID="btnDoseUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnDoseUpdate_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating';if(document.getElementById('btnDoseDelete')!= null){document.getElementById('btnDoseDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnDoseUpdateResource1" />
                                                                            <asp:Button ID="btnDoseDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnDoseDelete_Click" CommandArgument="delete" meta:resourcekey="btnDoseDeleteResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblId" runat="server">
                                                                            Dose-ID:</label>
                                                                        <div class="controls">
                                                                            <input id="txtDoseID" runat="server" type="text" placeholder="Dose ID" class="input-xlarge" meta:resourcekey="txtDoseId"
                                                                                disabled="disabled" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblName" runat="server">
                                                                            Dose-Name:</label>
                                                                        <div class="controls">
                                                                            <input id="txtDoseName" runat="server" type="text" placeholder="Dose Name" class="input-xlarge txtFocus"
                                                                                maxlength="50" autocomplete="off" validationgroup="e" meta:resourcekey="txtDoseName" />
                                                                            <asp:RequiredFieldValidator ID="rvTxtDoseName" runat="server" ControlToValidate="txtDoseName"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvTxtDoseNameResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblStatus" runat="server">
                                                                            Status:</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpDoses_udtatus" runat="server" CssClass='input-xlarge'>
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
                                                                            <input id="txtSearchgvDose" type="text" value="" class="input-xlarge" placeholder="Search Here..." meta:resourcekey="txtSearchgvDose" runat="server"
                                                                                autocomplete="off" />
                                                                        </div>
                                                                        <asp:DropDownList ID="drpSearchgvDose" runat="server" CssClass='input-medium'>
                                                                            <asp:ListItem Value="" Text="All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvDoses_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvDoses_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="dose_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="dose_name" HeaderText="Dose Name" meta:resourcekey="BoundFieldResource2" />
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
                <p meta:resourcekey="pDelete" runat="server">
                    Are you sure that you want to permanently delete this record ?
                </p>
            </div>
            <div class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true" meta:resourcekey="btnNo" runat="server">
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
