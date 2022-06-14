<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExaminationsSettings.aspx.cs"
    Inherits="Examinations_udSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

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
    <title>Examinations_ud Settings</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="Examinations_udSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            $('#btnExaminationUpdate').attr('disabled', true);
            $('#btnExaminationDelete').attr('disabled', true);
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();

        };
        function DoWork() {

            /////////////////////////////////////////////////
            ///////////// Examination Tab////////////////////
            /////////////////////////////////////////////////

            //$(".gvrow td:nth-child(5)").each(function () {
            //    var cellText = $(this).html().trim();
            //    if ($('#ucMenuControlPanel_lnklang').html() == "EN") {
            //        if (cellText == '<span class="badge badge-success">Active</span>') {
            //            $(this).html('<span class="badge badge-success">مفعـل</span>');
            //        }
            //        else {
            //            $(this).html('<span class="badge badge-important">غير مفعـل</span>');
            //        }
            //    }
            //});
            $('#btnExaminationNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvExaminations_ud .gvrow").removeClass("blue3");
                $('#btnExaminations_udave').attr('disabled', false);
                $('#btnExaminationUpdate').attr('disabled', true);
                $('#btnExaminationDelete').attr('disabled', true);
                $('#tblExamination').fClear();
            });

            $('#btnExaminationDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnExaminationDelete').attr('disabled', true);
                    $('#btnExaminationUpdate').attr('disabled', true);
                    $('#btnExaminationDelete').attr('value', 'Deleting');
                    __doPostBack('btnExaminationDelete', '');
                    //$('#btnExaminationDelete').trigger('click');
                    //$('#btnExaminationDelete').click();
                });
            });

            $('#txtSearchgvExamination').keyup(function SearchtxtgvExamination() {
                ClearExaminationtbl();
                $('#drpSearchgvExamination').val('');
                var searchKey = $.trim($('#txtSearchgvExamination').val().toLowerCase());
                $("#gvExaminations_ud tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });

            });
            $('#drpSearchgvExamination').change(function SearchdrpgvExamination() {
                ClearExaminationtbl();
                $('#txtSearchgvExamination').val('');
                var searchKey = $.trim($('#drpSearchgvExamination').val().toLowerCase());
                $("#gvExaminations_ud tr td:nth-child(4)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvExaminations_ud .gvrow").click(function () {
                $("#gvExaminations_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtExaminationID").val($(cells[0]).text());
                $("#txtExaminationName").val($(cells[1]).text());
                $("#txtExaminationCost").val($(cells[2]).text());
                $("#drpExaminations_udtatus").val($(cells[3]).text());
                $('#btnExaminations_udave').attr('disabled', true);
                $('#btnExaminationUpdate').attr('disabled', false);
                $('#btnExaminationDelete').attr('disabled', false);
                Page_ClientValidate("e");
            });

            /////////////////////////////////////////////////
            ///////////// End of Examination Tab//////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
        function ClearExaminationtbl() {
            $("#gvExaminations_ud .gvrow").removeClass("blue3");
            $('#tblExamination').fClear();
            $('#btnExaminations_udave').attr('disabled', false);
            $('#btnExaminationUpdate').attr('disabled', true);
            $('#btnExaminationDelete').attr('disabled', true);
        };
        function ClearSearchAttr() {
            $('#txtSearchgvExamination').val('');
            $('#drpSearchgvExamination').val('');
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
                            <h2 meta:resourcekey="hExaminations_udSettings2" runat="server">Examinations_ud Settings</h2>
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
                                    <h3 meta:resourcekey="hExaminations_udSettings" runat="server">
                                        <i class="glyphicon-settings"></i>Examinations_ud Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="hExaminations_ud2" runat="server">Examinations_ud</a> </li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hExaminations_ud" runat="server">
                                                            <i class="glyphicon-pen"></i>Examinations_ud</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upExamination" runat="server">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblExamination" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnExaminationNew" value="New" class="btn btn-grey" style="width: 70px" meta:resourcekey="btnDemoNew" runat="server" />
                                                                            &nbsp;<asp:Button ID="btnExaminations_udave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                Width="70px" OnClick="btnExaminations_udave_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnDemoSave" />
                                                                            <asp:Button ID="btnExaminationUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnExaminationUpdate_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnExaminationDelete')!= null){document.getElementById('btnExaminationDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnDemoUpdate" />
                                                                            <asp:Button ID="btnExaminationDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnExaminationDelete_Click" CommandArgument="delete" meta:resourcekey="btnDemoDelete" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblId" runat="server">
                                                                            Exam-ID:</label>
                                                                        <div class="controls">
                                                                            <input id="txtExaminationID" runat="server" type="text" placeholder="Examination ID"
                                                                                class="input-xlarge" disabled="disabled" meta:resourcekey="txtExaminationID" />
                                                                            &nbsp;
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblName" runat="server">
                                                                            Exam-Name:</label>
                                                                        <div class="controls">
                                                                            <input id="txtExaminationName" runat="server" type="text" placeholder="Examination Name"
                                                                                class="input-xlarge txtFocus" maxlength="50" autocomplete="off" validationgroup="e" meta:resourcekey="txtExaminationName" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvTxtExaminationName" runat="server" ControlToValidate="txtExaminationName"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvTxtExaminationNameResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblCost" runat="server">
                                                                            Exam-Cost:</label>
                                                                        <div class="controls">
                                                                            <input id="txtExaminationCost" runat="server" type="text" placeholder="Examination Cost"
                                                                                class="input-xlarge" maxlength="50" autocomplete="off" validationgroup="e" meta:resourcekey="txtExaminationCost" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvtxtExaminationCost" runat="server" ControlToValidate="txtExaminationCost"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtExaminationCostResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtExaminationCost" runat="server" ControlToValidate="txtExaminationCost"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="^\d{0,18}(\.\d{1,2})?$" ValidationGroup="e" meta:resourcekey="retxtExaminationCostResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblStatus" runat="server">
                                                                            Status:</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpExaminations_udtatus" runat="server" CssClass='input-xlarge'>
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
                                                                            <input id="txtSearchgvExamination" type="text" class="input-large" placeholder="Search Here..."
                                                                                autocomplete="off" meta:resourcekey="txtSearchgvDemo" runat="server" />
                                                                        </div>
                                                                        <asp:DropDownList ID="drpSearchgvExamination" runat="server" CssClass='input-medium' meta:resourcekey="drpSearchgvExaminationResource1">
                                                                            <asp:ListItem Value="" Text="All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvExaminations_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvExaminations_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="exam_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="exam_name" HeaderText="Examination Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="exam_cost" HeaderText="Cost" meta:resourcekey="BoundFieldResource3" HeaderStyle-Width="16%"/>
                                                                                <asp:BoundField DataField="active" HeaderText="Status" meta:resourcekey="BoundFieldResource4">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                  <asp:TemplateField HeaderText="Status" meta:resourcekey="BoundFieldResource4" HeaderStyle-Width="14%">
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
