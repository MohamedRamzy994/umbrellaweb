<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DiagnosisSettings.aspx.cs"
    Inherits="DiagnosisSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

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
    <title>Diagnosis_
         Settings</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="DiagnosisSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            $('#btnDiagnosis_udUpdate').attr('disabled', true);
            $('#btnDiagnosis_udDelete').attr('disabled', true);
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();

        };
        function DoWork() {

            /////////////////////////////////////////////////
            ///////////// Diagnosis_ud Tab//////////////////////
            /////////////////////////////////////////////////
            $('#btnDiagnosis_udNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvDiagnosis_ud .gvrow").removeClass("blue3");
                $('#btnDiagnosis_udSave').attr('disabled', false);
                $('#btnDiagnosis_udUpdate').attr('disabled', true);
                $('#btnDiagnosis_udDelete').attr('disabled', true);
                $('#tblDiagnosis_ud').fClear();
            });

            $('#btnDiagnosis_udDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnDiagnosis_udDelete').attr('disabled', true);
                    $('#btnDiagnosis_udUpdate').attr('disabled', true);
                    $('#btnDiagnosis_udDelete').attr('value', 'Deleting');
                    __doPostBack('btnDiagnosis_udDelete', '');
                });
            });

            $('#txtSearchgvDiagnosis_ud').keyup(function SearchtxtgvDiagnosis_ud() {
                ClearDiagnosis_udtbl();
                $('#drpSearchgvDiagnosis_ud').val('');
                var searchKey = $.trim($('#txtSearchgvDiagnosis_ud').val().toLowerCase());
                $("#gvDiagnosis_ud tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });

            });
            $('#drpSearchgvDiagnosis_ud').change(function SearchdrpgvDiagnosis_ud() {
                ClearDiagnosis_udtbl();
                $('#txtSearchgvDiagnosis_ud').val('');
                var searchKey = $.trim($('#drpSearchgvDiagnosis_ud').val().toLowerCase());
                $("#gvDiagnosis_ud tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvDiagnosis_ud .gvrow").click(function () {
                $("#gvDiagnosis_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtDiagnosis_udID").val($(cells[0]).text());
                $("#txtDiagnosis_udName").val($(cells[1]).text());
                $("#drpDiagnosis_udStatus").val($(cells[2]).text());
                $('#btnDiagnosis_udSave').attr('disabled', true);
                $('#btnDiagnosis_udUpdate').attr('disabled', false);
                $('#btnDiagnosis_udDelete').attr('disabled', false);
                Page_ClientValidate("e");
            });
        
            /////////////////////////////////////////////////
            ///////////// End of Diagnosis_ud Tab//////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
        function ClearDiagnosis_udtbl() {
            $("#gvDiagnosis_ud .gvrow").removeClass("blue3");
            $('#tblDiagnosis_ud').fClear();
            $('#btnDiagnosis_udSave').attr('disabled', false);
            $('#btnDiagnosis_udUpdate').attr('disabled', true);
            $('#btnDiagnosis_udDelete').attr('disabled', true);
        };
        function ClearSearchAttr() {
            $('#txtSearchgvDiagnosis_ud').val('');
            $('#drpSearchgvDiagnosis_ud').val('');
        }
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
                            <h2 meta:resourcekey="hDiagnosis_udSett" runat="server">Diagnosis_ud Settings</h2>
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
                                    <h3 meta:resourcekey="hDiagnosisSettings" runat="server">
                                        <i class="glyphicon-settings"></i>Diagnosis_ud Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" id="Diag" meta:resourcekey="Diagnosis_ud" runat="server">Diagnosis_ud</a> </li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hDiagnosis_ud" runat="server">
                                                            <i class="glyphicon-notes_2"></i>Diagnosis_ud</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upDiagnosis_ud" runat="server">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblDiagnosis_ud" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnDiagnosis_udNew" value="New" class="btn btn-grey" style="width: 70px" meta:resourcekey="btnDiagnosis_udNew" runat="server" />
                                                                            <asp:Button ID="btnDiagnosis_udSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                Width="70px" OnClick="btnDiagnosis_udSave_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnDiagnosis_udSaveResource1" />
                                                                            <asp:Button ID="btnDiagnosis_udUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnDiagnosis_udUpdate_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnDiagnosis_udDelete')!= null){document.getElementById('btnDiagnosis_udDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnDiagnosis_udUpdateResource1" />
                                                                            <asp:Button ID="btnDiagnosis_udDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnDiagnosis_udDelete_Click" CommandArgument="delete" meta:resourcekey="btnDiagnosis_udDeleteResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblId" runat="server">
                                                                            Diag-ID:</label>
                                                                        <div class="controls">
                                                                            <input id="txtDiagnosis_udID" runat="server" type="text" placeholder="Diagnosis_ud ID" meta:resourcekey="txtDiagnosis_udID"
                                                                                class="input-xlarge" disabled="disabled" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblName" runat="server">
                                                                            Diag-Name:</label>
                                                                        <div class="controls">
                                                                            <input id="txtDiagnosis_udName" runat="server" type="text" placeholder="Diagnosis_ud Name" meta:resourcekey="txtDiagnosis_udName"
                                                                                class="input-xlarge txtFocus" maxlength="50" autocomplete="off" validationgroup="e" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvTxtDiagnosis_udName" runat="server" ControlToValidate="txtDiagnosis_udName"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvTxtDiagnosis_udNameResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblStatus" runat="server">
                                                                            Status:</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpDiagnosis_udStatus" runat="server" CssClass='input-xlarge' meta:resourcekey="drpDiagnosis_udStatusResource1">
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
                                                                            <input id="txtSearchgvDiagnosis_ud" type="text" value="" class="input-xlarge" placeholder="Search Here..."
                                                                                autocomplete="off" meta:resourcekey="txtSearchgvDiagnosis_ud" runat="server" />
                                                                        </div>
                                                                        <asp:DropDownList ID="drpSearchgvDiagnosis_ud" runat="server" CssClass='input-medium'>
                                                                            <asp:ListItem Value="" Text="All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvDiagnosis_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvDiagnosis_udResource2">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="Diagnosis_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="Diagnosis_name" HeaderText="Diagnosis_ud Name" meta:resourcekey="BoundFieldResource2" />
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
