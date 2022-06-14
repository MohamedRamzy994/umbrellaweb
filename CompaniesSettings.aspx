<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CompaniesSettings.aspx.cs"
    Inherits="Companies_udSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="~/ucMenuControlPanel.ascx" TagPrefix="uc1" TagName="ucMenuControlPanel" %>
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
    <title>Companies_ud Settings</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();

        };
        function DoWork() {
            //#region Companies_ud
            /////////////////////////////////////////////////
            ///////////// Companies_ud Tab /////////////////////
            /////////////////////////////////////////////////
            $('#btnCompanySave').attr('disabled', false);
            $('#btnCompanyUpdate').attr('disabled', true);
            $('#btnCompanyDelete').attr('disabled', true);
            $('#btnCompanyNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                ClearCompanytbl();
            });

            $('#btnCompanyDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnCompanyDelete').attr('disabled', true);
                    $('#btnCompanyUpdate').attr('disabled', true);
                    $('#btnCompanyDelete').attr('value', 'Deleting');
                    __doPostBack('btnCompanyDelete', '');
                });
            });

            $('#txtSearchgvCompanies_ud').keyup(function SearchtxtgvDose() {
                ClearCompanytbl();
                $('#drpSearchgvCompanies_ud').val('');
                var searchKey = $.trim($('#txtSearchgvCompanies_ud').val().toLowerCase());
                $("#gvCompanies_ud tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });

            });
            $('#drpSearchgvCompanies_ud').change(function SearchdrpgvDose() {
                ClearCompanytbl();
                $('#txtSearchgvCompanies_ud').val('');
                var searchKey = $.trim($('#drpSearchgvCompanies_ud').val().toLowerCase());
                $("#gvCompanies_ud tr td:nth-child(10)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvCompanies_ud .gvrow").click(function () {
                $("#gvCompanies_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtCompanyId").val($(cells[0]).text());
                $("#txtCompanyName").val($(cells[1]).text());
                $("#txtCompanyAddress").val($(cells[2]).text());
                $("#txtCompanyPhone").val($(cells[3]).text());
                $("#txtCompanyMobile").val($(cells[4]).text());
                $("#txtCompanyEmail").val($(cells[5]).text());
                $("#txtCompanyWebsite").val($(cells[6]).text());
                $("#txtCreatedDate").val($(cells[7]).text());
                $("#txtCreatedBy").val($(cells[8]).text());
                $("#drpCompanyStatus").val($(cells[9]).text());
                $('#btnCompanySave').attr('disabled', true);
                $('#btnCompanyUpdate').attr('disabled', false);
                $('#btnCompanyDelete').attr('disabled', false);
                Page_ClientValidate("m");
            });
            /////////////////////////////////////////////////
            ///////////// End of Companies_ud Tab //////////////
            /////////////////////////////////////////////////
            //#endregion Companies_ud

            //#region Contracts_ud
            /////////////////////////////////////////////////
            /////////////// Contratcs Tab ///////////////////
            /////////////////////////////////////////////////
            $('#btnContractDelete').attr('disabled', true);
            $('#txtDateFrom').datepicker({ format: 'dd/mm/yyyy', startDate: '+0d', autoclose: true });
            $('#drpType').change(function () {
                var index = document.getElementById('drpType').selectedIndex;
                if (index == 0) {
                    $('#txtDateFrom').val('').attr("type", "text");
                    $('#txtDateFrom').attr('disabled', false);
                }
                else if (index == 1) {
                    $('#txtDateFrom').val('10/10/2010').attr("type", "password");
                    $('#txtDateFrom').attr('disabled', true);
                }
            });

            $('#btnContractNew').click(function () {
                ClearContracttbl();
            });

            $('#btnContractDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnContractDelete').attr('disabled', true);
                    $('#btnContractDelete').attr('value', 'Deleting');
                    __doPostBack('btnContractDelete', '');
                });
            });

            $("#gvContract .gvrow").click(function () {
                $("#gvContract .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#drpCompanies_ud").val($(cells[0]).text());
                $("#txtContractId").val($(cells[2]).text());
                $("#drpType").val($(cells[3]).text());
                $("#txtPeriod").val($(cells[4]).text());
                $("#txtDateFrom").val($(cells[5]).text());
                $("#txtDateTo").val($(cells[6]).text());
                $("#txtDiscount").val($(cells[7]).text());
                $("#txtDueDay").val($(cells[8]).text());
                $("#txtWarning").val($(cells[9]).text());
                $("#drpFlag").val($(cells[10]).text());
                $("#txtContractCreatedDate").val($(cells[11]).text());
                $("#txtContractCreatedBy").val($(cells[12]).text());
                $('#btnContracts_udave').attr('disabled', true);
                $('#btnContractDelete').attr('disabled', false);
            });
            $('#txtDateFrom').attr('readonly', 'readonly');
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
            /////////////////////////////////////////////////
            /////////// End of Contratcs Tab ////////////////
            /////////////////////////////////////////////////
            //#endregion Contracts_ud
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
        function ClearCompanytbl() {
            $("#gvCompanies_ud .gvrow").removeClass("blue3");
            $('#tblCompany').fClear();
            $('#btnCompanySave').attr('disabled', false);
            $('#btnCompanyUpdate').attr('disabled', true);
            $('#btnCompanyDelete').attr('disabled', true);
        };
        function ClearContracttbl() {
            $("#gvContract .gvrow").removeClass("blue3");
            $('#tblContract').fClear();
            $('#txtDateFrom').attr('disabled', false);
            $('#btnContracts_udave').attr('disabled', false);
            $('#btnContractDelete').attr('disabled', true);
        };
        function ClearSearchAttr() {
            $('#txtSearchgvCompanies_ud').val('');
            $('#drpSearchgvCompanies_ud').val('');
        }
    </script>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" />
        <uc1:ucMenuControlPanel runat="server" ID="ucMenuControlPanel" />
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="hCompSett" runat="server">Companies_ud Settings</h2>
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
                                    <h3 meta:resourcekey="hCompSettings" runat="server">
                                        <i class="glyphicon-settings"></i>Companies_ud Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="aComp" runat="server">Companies_ud</a></li>
                                        <li><a href="#t2" data-toggle="tab" meta:resourcekey="aCont" runat="server">Contracts_ud</a></li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <asp:UpdatePanel ID="upCompanies_ud" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <div class="box box-bordered box-color">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hComp" runat="server">
                                                                    <i class="glyphicon-building"></i>Companies_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div id="tblCompany">
                                                                    <div class="span6">
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                                Actions:</label>
                                                                            <div class="controls">
                                                                                <input type="button" id="btnCompanyNew" value="New" class="btn btn-grey" style="width: 75px" meta:resourcekey="btnNew" runat="server"/>
                                                                                <asp:Button ID="btnCompanySave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                    Width="75px" OnClick="btnCompanySave_Click" ValidationGroup="m" OnClientClick="if (!Page_ClientValidate('m')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                    UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnCompanySaveResource1" />
                                                                                <asp:Button ID="btnCompanyUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                    Width="75px" OnClick="btnCompanyUpdate_Click" ValidationGroup="m" OnClientClick="if (!Page_ClientValidate('m')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnCompanyDelete')!= null){document.getElementById('btnCompanyDelete').disabled=true;}"
                                                                                    UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnCompanyUpdateResource1" />
                                                                                <asp:Button ID="btnCompanyDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                    Width="75px" OnClick="btnCompanyDelete_Click" CommandArgument="delete" meta:resourcekey="btnCompanyDeleteResource1" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group hidden">
                                                                            <label for="textfield" class="control-label">
                                                                                ID:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCompanyId" runat="server" type="text" placeholder="Company ID" class="input-xlarge"
                                                                                    disabled="disabled" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label"  meta:resourcekey="lblCompanyName" runat="server">
                                                                                Name:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCompanyName" runat="server" type="text" placeholder="Company Name"
                                                                                    class="input-xlarge txtFocus" maxlength="50" autocomplete="off" validationgroup="m" meta:resourcekey="txtCompanyName" />
                                                                                <asp:RequiredFieldValidator ID="rvtxtCompanyName" runat="server" ControlToValidate="txtCompanyName"
                                                                                    Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationGroup="m" meta:resourcekey="rvtxtCompanyNameResource1"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblAddress" runat="server">
                                                                                Address:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCompanyAddress" runat="server" type="text" placeholder="Company Address"
                                                                                    class="input-xlarge" maxlength="50" autocomplete="off" meta:resourcekey="txtCompanyAddress"/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblPhone" runat="server">
                                                                                Phone:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCompanyPhone" runat="server" type="text" placeholder="Company Phone"
                                                                                    class="input-xlarge" maxlength="20" autocomplete="off" validationgroup="m" meta:resourcekey="txtCompanyPhone"/>
                                                                                <asp:RegularExpressionValidator ID="retxtCompanyPhone" runat="server" ControlToValidate="txtCompanyPhone"
                                                                                    ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationExpression="\s*[ 0-9 ]+\s*" ValidationGroup="m" meta:resourcekey="retxtCompanyPhoneResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblMobile" runat="server">
                                                                                Mobile:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCompanyMobile" runat="server" type="text" placeholder="Company Mobile"
                                                                                    class="input-xlarge" maxlength="20" autocomplete="off" validationgroup="m" meta:resourcekey="txtCompanyMobile"/>
                                                                                <asp:RegularExpressionValidator ID="retxtCompanyMobile" runat="server" ControlToValidate="txtCompanyMobile"
                                                                                    ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationExpression="\s*[ 0-9 ]+\s*" ValidationGroup="m" meta:resourcekey="retxtCompanyMobileResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="span6">
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblEmail" runat="server">
                                                                                Email:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCompanyEmail" runat="server" type="text" placeholder="Company Email"
                                                                                    class="input-xlarge" maxlength="50" autocomplete="off" validationgroup="m" meta:resourcekey="txtCompanyEmail"/>
                                                                                <asp:RegularExpressionValidator ID="retxtCompanyEmail" runat="server" ControlToValidate="txtCompanyEmail"
                                                                                    Display="Dynamic" ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationGroup="m" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" meta:resourcekey="retxtCompanyEmailResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblWebsite" runat="server">
                                                                                Website:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCompanyWebsite" runat="server" type="text" placeholder="Company Website"
                                                                                    class="input-xlarge" maxlength="50" autocomplete="off" validationgroup="m" meta:resourcekey="txtCompanyWebsite"/>
                                                                                <asp:RegularExpressionValidator ID="retxtCompanyWebsite" runat="server" ControlToValidate="txtCompanyWebsite"
                                                                                    Display="Dynamic" ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationGroup="m" ValidationExpression="([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?" meta:resourcekey="retxtCompanyWebsiteResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblCreatedOn" runat="server">
                                                                                Created-On:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCreatedDate" runat="server" type="text" placeholder="Created Date"
                                                                                    class="input-xlarge" maxlength="50" autocomplete="off" disabled="disabled" meta:resourcekey="txtCreatedDate"/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblCreatedBy" runat="server">
                                                                                Created-By:</label>
                                                                            <div class="controls">
                                                                                <input id="txtCreatedBy" runat="server" type="text" placeholder="Created By" class="input-xlarge"
                                                                                    maxlength="50" autocomplete="off" disabled="disabled" meta:resourcekey="txtCreatedBy"/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblStatus" runat="server">
                                                                                Status:</label>
                                                                            <div class="controls">
                                                                                <asp:DropDownList ID="drpCompanyStatus" runat="server" CssClass='input-xlarge'>
                                                                                    <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                                    <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box box-bordered box-color">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hSrchComp" runat="server">
                                                                    <i class="glyphicon-search"></i>Search in Companies_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div class="span12">
                                                                    <div class="div_search_box">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSearchgvCompanies_ud" type="text" value="" class="input-large" placeholder="Search By Company Name..."
                                                                                autocomplete="off" meta:resourcekey="txtSearchgvCompanies_ud" runat="server"/>
                                                                        </div>
                                                                        <asp:DropDownList ID="drpSearchgvCompanies_ud" runat="server" CssClass='input-medium'>
                                                                            <asp:ListItem Value="" Text="All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollbig2">
                                                                        <asp:GridView ID="gvCompanies_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvCompanies_udResource2">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="company_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="company_name" HeaderText="Company Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="company_address" HeaderText="Address" meta:resourcekey="BoundFieldResource3" />
                                                                                <asp:BoundField DataField="company_phone" HeaderText="Phone" meta:resourcekey="BoundFieldResource4" />
                                                                                <asp:BoundField DataField="company_mobile" HeaderText="Mobile" meta:resourcekey="BoundFieldResource5" />
                                                                                <asp:BoundField DataField="company_email" HeaderText="Email" meta:resourcekey="BoundFieldResource6" />
                                                                                <asp:BoundField DataField="company_website" HeaderText="Website" meta:resourcekey="BoundFieldResource7" />
                                                                                <asp:BoundField DataField="created_date" HeaderText="Created On" meta:resourcekey="BoundFieldResource8" />
                                                                                <asp:BoundField DataField="created_by" HeaderText="Created By" meta:resourcekey="BoundFieldResource9" />
                                                                                <asp:BoundField DataField="active" HeaderText="Status" meta:resourcekey="BoundFieldResource10">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="company_balance" HeaderText="Balance" meta:resourcekey="BoundFieldResource10" />
                                                                                   <asp:TemplateField HeaderText="Status" meta:resourcekey="BoundFieldResource10">
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
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </div>
                                        <div id="t2" class="tab-pane">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="hCont" runat="server">
                                                            <i class="glyphicon-notes"></i>Contracts_ud</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upContracts_ud" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblContract">
                                                                    <div class="span6">
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                                Actions:</label>
                                                                            <div class="controls">
                                                                                <input type="button" id="btnContractNew" value="New" class="btn btn-grey" style="width: 75px"
                                                                                    title="Add New Contract" meta:resourcekey="btnNew" runat="server" />
                                                                                <asp:Button ID="btnContracts_udave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                    Width="75px" ValidationGroup="c" OnClick="btnContracts_udave_Click" OnClientClick="if (!Page_ClientValidate('c')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                    UseSubmitBehavior="False" ToolTip="Save Contract" CommandArgument="save" meta:resourcekey="btnContracts_udaveResource1" />
                                                                                <asp:Button ID="btnContractDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                    Width="75px" ToolTip="Delete Contract" OnClick="btnContractDelete_Click" CommandArgument="delete" meta:resourcekey="btnContractDeleteResource1" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Contract ID" meta:resourcekey="lblContID" runat="server">
                                                                                ID:</label>
                                                                            <div class="controls">
                                                                                <input id="txtContractId" runat="server" type="text" placeholder="Contract ID" class="input-large txtFocus"
                                                                                    disabled="disabled" title="Contract ID" meta:resourcekey="txtContractId" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Company" meta:resourcekey="lblCompanyName" runat="server">
                                                                                Company:</label>
                                                                            <div class="controls">
                                                                                <select id="drpCompanies_ud" runat="server" class="input-large" title="Select a company">
                                                                                </select>
                                                                                <asp:RequiredFieldValidator ID="rvdrpCompanies_ud" runat="server" ControlToValidate="drpCompanies_ud"
                                                                                    Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationGroup="c" InitialValue="0" meta:resourcekey="rvdrpCompanies_udResource1"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Type of contract" meta:resourcekey="lblContractType" runat="server">
                                                                                Type:</label>
                                                                            <div class="controls">
                                                                                <asp:DropDownList ID="drpType" runat="server" CssClass='input-large'>
                                                                                    <asp:ListItem Text="Known Period" meta:resourcekey="drpTypeK" />
                                                                                    <asp:ListItem Text="First Visit" meta:resourcekey="drpTypeF" />
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Period of contract in months" meta:resourcekey="lblPeriod" runat="server">
                                                                                Period:</label>
                                                                            <div class="controls">
                                                                                <input id="txtPeriod" runat="server" type="text" placeholder="Period in months" class="input-large"
                                                                                    maxlength="2" autocomplete="off" title="Period of contract in months" meta:resourcekey="txtPeriod"/>
                                                                                <asp:RequiredFieldValidator ID="rvtxtPeriod" runat="server" ControlToValidate="txtPeriod"
                                                                                    Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationGroup="c" meta:resourcekey="rvtxtPeriodResource1"></asp:RequiredFieldValidator>
                                                                                <asp:RegularExpressionValidator ID="retxtPeriod" runat="server" ControlToValidate="txtPeriod"
                                                                                    ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationExpression="^[1-9][0-9]?$" ValidationGroup="c" meta:resourcekey="retxtPeriodResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="span6">
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Date From" meta:resourcekey="lblFrom" runat="server">
                                                                                From:</label>
                                                                            <div class="controls">
                                                                                <input id="txtDateFrom" runat="server" type="text" placeholder="Date From" class="input-large"
                                                                                    maxlength="10" autocomplete="off" title="Date From" meta:resourcekey="txtDateFrom"/>
                                                                                <asp:RequiredFieldValidator ID="rvtxtDateFrom" runat="server" ControlToValidate="txtDateFrom"
                                                                                    Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationGroup="c" meta:resourcekey="rvtxtDateFromResource1"></asp:RequiredFieldValidator>
                                                                                <asp:RegularExpressionValidator ID="retxtDateFrom" runat="server" ControlToValidate="txtDateFrom"
                                                                                    ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                                                    Display="Dynamic" ValidationGroup="c" meta:resourcekey="retxtDateFromResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Date To" meta:resourcekey="lblTo" runat="server">
                                                                                To:</label>
                                                                            <div class="controls">
                                                                                <input id="txtDateTo" runat="server" type="text" placeholder="Date To" class="input-large"
                                                                                    maxlength="10" autocomplete="off" disabled="disabled" title="Date To" meta:resourcekey="txtDateTo"/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Discount on contract" meta:resourcekey="lblDiscount" runat="server">
                                                                                Discount:</label>
                                                                            <div class="controls">
                                                                                <div class="input-append">
                                                                                    <input id="txtDiscount" runat="server" type="text" placeholder="Discount on contract"
                                                                                        class="input-medium" maxlength="3" autocomplete="off" title="Discount on contract" meta:resourcekey="txtDiscount"/>
                                                                                    <span class="add-on">%</span>
                                                                                </div>
                                                                                <asp:RequiredFieldValidator ID="rvtxtDiscount" runat="server" ControlToValidate="txtDiscount"
                                                                                    Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationGroup="c" meta:resourcekey="rvtxtDiscountResource1"></asp:RequiredFieldValidator>
                                                                                <asp:RegularExpressionValidator ID="retxtDiscount" runat="server" ControlToValidate="txtDiscount"
                                                                                    ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                    ValidationExpression="^[1-9][0-9]?$|^100$" ValidationGroup="c" meta:resourcekey="retxtDiscountResource1"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group hidden">
                                                                            <label for="textfield" class="control-label" title="Payment Period in Days_ud">
                                                                                Due-Day:</label>
                                                                            <div class="controls">
                                                                                <input id="txtDueDay" runat="server" type="text" placeholder="Due Day" class="input-large"
                                                                                    maxlength="2" autocomplete="off" title="Payment Period in Days_ud" />
                                                                                <%-- <asp:RequiredFieldValidator ID="rvtxtDueDay" runat="server" ControlToValidate="txtDueDay"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="c"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtDueDay" runat="server" ControlToValidate="txtDueDay"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="^[1-9][0-9]?$" ValidationGroup="c"></asp:RegularExpressionValidator>--%>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group hidden">
                                                                            <label for="textfield" class="control-label" title="warning period in Days_ud">
                                                                                Warning:</label>
                                                                            <div class="controls">
                                                                                <input id="txtWarning" runat="server" type="text" placeholder="Warning in Days_ud" class="input-large"
                                                                                    maxlength="2" autocomplete="off" title="warning period in Days_ud" />
                                                                                <%--<asp:RequiredFieldValidator ID="rvtxtWarning" runat="server" ControlToValidate="txtWarning"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="c"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtWarning" runat="server" ControlToValidate="txtWarning"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="^[1-9][0-9]?$" ValidationGroup="c"></asp:RegularExpressionValidator>--%>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group hidden">
                                                                            <label for="textfield" class="control-label" title="Allow visits after the end of the payment period">
                                                                                Flag:</label>
                                                                            <div class="controls">
                                                                                <select id="drpFlag" runat="server" class="input-large" title="Allow visits after the end of the payment period">
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Created Date" meta:resourcekey="lblCreatedOn" runat="server">
                                                                                Created-On:</label>
                                                                            <div class="controls">
                                                                                <input id="txtContractCreatedDate" runat="server" type="text" placeholder="Created Date"
                                                                                    class="input-large" maxlength="10" autocomplete="off" disabled="disabled" title="Created Date"  meta:resourcekey="txtCreatedDate" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Created By" meta:resourcekey="lblCreatedBy" runat="server">
                                                                                Created-By:</label>
                                                                            <div class="controls">
                                                                                <input id="txtContractCreatedBy" runat="server" type="text" placeholder="Created By" meta:resourcekey="txtCreatedBy"
                                                                                    class="input-large" maxlength="50" autocomplete="off" disabled="disabled" title="Created By" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span12">
                                                                    <div class="scroll scrollbig2">
                                                                        <asp:GridView ID="gvContract" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvContractResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="company_id" HeaderText="Company_id" meta:resourcekey="BoundFieldResource12">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="company_name" HeaderText="Company" meta:resourcekey="BoundFieldResource13" />
                                                                                <asp:BoundField DataField="contract_id" HeaderText="ID" meta:resourcekey="BoundFieldResource14" />
                                                                                <asp:BoundField DataField="contract_type" HeaderText="Type" meta:resourcekey="BoundFieldResource15" />
                                                                                <asp:BoundField DataField="contract_period" HeaderText="Period" meta:resourcekey="BoundFieldResource16" />
                                                                                <asp:BoundField DataField="contract_date_from" HeaderText="From" meta:resourcekey="BoundFieldResource17" />
                                                                                <asp:BoundField DataField="contract_date_to" HeaderText="To" meta:resourcekey="BoundFieldResource18" />
                                                                                <asp:BoundField DataField="contract_discount" HeaderText="Discount" meta:resourcekey="BoundFieldResource19" />
                                                                                <asp:BoundField DataField="contract_due_day" HeaderText="Due Day" meta:resourcekey="BoundFieldResource20">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="warning" HeaderText="Warning" meta:resourcekey="BoundFieldResource21">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="flag_visits" HeaderText="Flag" meta:resourcekey="BoundFieldResource22">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="created_date" HeaderText="Created On" meta:resourcekey="BoundFieldResource23" />
                                                                                <asp:BoundField DataField="user_name" HeaderText="Created By" meta:resourcekey="BoundFieldResource24" />
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
                                                <br />
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
