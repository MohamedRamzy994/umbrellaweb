<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeesSettings.aspx.cs"
    Inherits="EmployeesSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

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
    <title>Employee_uds Settings</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('#btnEmpUpdate').attr('disabled', true);
            $('#btnEmpDelete').attr('disabled', true);
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();

        };
        function DoWork() {
            /////////////////////////////////////////////////
            ///////////// Emp Tab///////////////////////////
            /////////////////////////////////////////////////

            $('#txtBirthdate').datepicker({ format: 'dd/mm/yyyy', autoclose: true });
            $('#txtHiredate').datepicker({ format: 'dd/mm/yyyy', autoclose: true });

            $('#btnEmpNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvEmployee_ud .gvrow").removeClass("blue3");
                $('#btnEmpSave').attr('disabled', false);
                $('#btnEmpUpdate').attr('disabled', true);
                $('#btnEmpDelete').attr('disabled', true);
                $('#tblEmp').fClear();
            });

            $('#btnEmpDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnEmpDelete').attr('disabled', true);
                    $('#btnEmpUpdate').attr('disabled', true);
                    $('#btnEmpDelete').attr('value', 'Deleting');
                    __doPostBack('btnEmpDelete', '');
                });
            });

            $('#txtSearchgvEmp').keyup(function SearchtxtgvEmp() {
                ClearEmptbl();
                $('#drpSearchgvEmp').val('');
                var searchKey = $.trim($('#txtSearchgvEmp').val().toLowerCase());
                $("#gvEmployee_ud tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });

            });
            $('#drpSearchgvEmp').change(function SearchdrpgvEmp() {
                ClearEmptbl();
                $('#txtSearchgvEmp').val('');
                var searchKey = $.trim($('#drpSearchgvEmp').val().toLowerCase());
                $("#gvEmployee_ud tr td:nth-child(11)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvEmployee_ud .gvrow").click(function () {
                $("#gvEmployee_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtEmpID").val($(cells[0]).text());
                $("#txtEmpName").val($(cells[1]).text());
                $("#txtAddress").val($(cells[2]).text());
                $("#txtJob").val($(cells[3]).text());
                $("#txtIdentityNo").val($(cells[4]).text());
                $("#txtMobile").val($(cells[5]).text());
                $("#txtPhone").val($(cells[6]).text());
                $("#txtBirthdate").val($(cells[7]).text());
                $("#txtHiredate").val($(cells[8]).text());
                $("#txtSalary").val($(cells[9]).text());
                $("#drpEmpStatus").val($(cells[10]).text());
                $('#btnEmpSave').attr('disabled', true);
                $('#btnEmpUpdate').attr('disabled', false);
                $('#btnEmpDelete').attr('disabled', false);
                Page_ClientValidate("e");
            });
            /////////////////////////////////////////////////
            ///////////// End of Emp Tab/////////////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
        function ClearEmptbl() {
            $("#gvEmployee_ud .gvrow").removeClass("blue3");
            $('#tblEmp').fClear();
            $('#btnEmpSave').attr('disabled', false);
            $('#btnEmpUpdate').attr('disabled', true);
            $('#btnEmpDelete').attr('disabled', true);
        };
        function ClearSearchAttr() {
            $('#txtSearchgvEmp').val('');
            $('#drpSearchgvEmp').val('');
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
                            <h2 meta:resourcekey="hEmpSett" runat="server">Employee_uds Settings</h2>
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
                                    <h3 meta:resourcekey="hEmpSettings" runat="server">
                                        <i class="glyphicon-settings"></i>Employee_uds Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="aEmp" runat="server">Employee_uds</a></li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <asp:UpdatePanel ID="upEmp" runat="server">
                                                    <ContentTemplate>
                                                        <div class="box box-bordered box-color">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hEmpSe" runat="server">
                                                                    <i class="glyphicon-parents"></i>Employee_uds</h3>
                                                            </div>
                                                            <div id="tblEmp" class="box-content nopadding">
                                                                <div class="span6">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnEmpNew" value="New" class="btn btn-grey" style="width: 70px" meta:resourcekey="btnEmpNew" runat="server" />
                                                                            <asp:Button ID="btnEmpSave" Text="Save" runat="server" CssClass="btn btn-blue" Width="70px"
                                                                                OnClick="btnEmpSave_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnEmpSaveResource1" />
                                                                            <asp:Button ID="btnEmpUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnEmpUpdate_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnEmpDelete')!= null){document.getElementById('btnEmpDelete').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="update" meta:resourcekey="btnEmpUpdateResource1" />
                                                                            <asp:Button ID="btnEmpDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnEmpDelete_Click" CommandArgument="delete" meta:resourcekey="btnEmpDeleteResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblId" runat="server">
                                                                            ID:</label>
                                                                        <div class="controls">
                                                                            <input id="txtEmpID" runat="server" type="text" placeholder="Emp ID" class="input-xlarge"
                                                                                disabled="disabled" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblName" runat="server">
                                                                            Name:</label>
                                                                        <div class="controls">
                                                                            <input id="txtEmpName" runat="server" type="text" placeholder="Emp Name" class="input-xlarge txtFocus"
                                                                                maxlength="50" autocomplete="off" validationgroup="e" meta:resourcekey="txtEmpName"/>
                                                                            <asp:RequiredFieldValidator ID="rvTxtEmpName" runat="server" ControlToValidate="txtEmpName"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvTxtEmpNameResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblAddress" runat="server">
                                                                            Address:</label>
                                                                        <div class="controls">
                                                                            <input id="txtAddress" runat="server" type="text" placeholder="Emp Address" class="input-xlarge" meta:resourcekey="txtAddress"
                                                                                maxlength="50" autocomplete="off" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblJob" runat="server">
                                                                            Job:</label>
                                                                        <div class="controls">
                                                                            <input id="txtJob" runat="server" type="text" placeholder="Emp Job" class="input-xlarge" meta:resourcekey="txtJob"
                                                                                maxlength="50" autocomplete="off" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblIdentity" runat="server">
                                                                            Identity-No:</label>
                                                                        <div class="controls">
                                                                            <input id="txtIdentityNo" runat="server" type="text" placeholder="Emp Identity Number" meta:resourcekey="txtIdentityNo"
                                                                                class="input-xlarge" maxlength="20" autocomplete="off" />
                                                                            <asp:RegularExpressionValidator ID="retxtIdentityNo" runat="server" ControlToValidate="txtIdentityNo"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="\s*[ 0-9 ]+\s*" ValidationGroup="e" meta:resourcekey="retxtIdentityNoResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span6">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblMobile" runat="server">
                                                                            Mobile:</label>
                                                                        <div class="controls">
                                                                            <input id="txtMobile" runat="server" type="text" placeholder="Emp Mobile" class="input-xlarge"
                                                                                maxlength="20" autocomplete="off" meta:resourcekey="txtMobile"/>
                                                                            <asp:RegularExpressionValidator ID="retxtMobile" runat="server" ControlToValidate="txtMobile"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="\s*[ 0-9 ]+\s*" ValidationGroup="e" meta:resourcekey="retxtMobileResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblPhone" runat="server">
                                                                            Phone:</label>
                                                                        <div class="controls">
                                                                            <input id="txtPhone" runat="server" type="text" placeholder="Emp Phone" class="input-xlarge" meta:resourcekey="txtPhone"/>
                                                                            <asp:RegularExpressionValidator ID="retxtPhone" runat="server" ControlToValidate="txtPhone"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="\s*[ 0-9 ]+\s*" ValidationGroup="e" meta:resourcekey="retxtPhoneResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblBirthdate" runat="server">
                                                                            Birthdate:</label>
                                                                        <div class="controls">
                                                                            <input id="txtBirthdate" runat="server" type="text" placeholder="Emp Birthdate" class="input-xlarge"
                                                                                maxlength="10" autocomplete="off" meta:resourcekey="txtBirthdate"/>
                                                                            <asp:RegularExpressionValidator ID="retxtBirthdate" runat="server" ControlToValidate="txtBirthdate"
                                                                                ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                                                Display="Dynamic" ValidationGroup="e" meta:resourcekey="retxtBirthdateResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblHiredate" runat="server">
                                                                            Hiredate:</label>
                                                                        <div class="controls">
                                                                            <input id="txtHiredate" runat="server" type="text" placeholder="Emp Hiredate" class="input-xlarge"
                                                                                maxlength="10" autocomplete="off" meta:resourcekey="txtHiredate"/>
                                                                            <asp:RegularExpressionValidator ID="retxtHiredate" runat="server" ControlToValidate="txtHiredate"
                                                                                ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                                                Display="Dynamic" ValidationGroup="e" meta:resourcekey="retxtHiredateResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblSalary" runat="server">
                                                                            Salary:</label>
                                                                        <div class="controls">
                                                                            <input id="txtSalary" runat="server" type="text" placeholder="Emp Salary" class="input-xlarge"
                                                                                maxlength="20" autocomplete="off" meta:resourcekey="txtSalary"/>
                                                                            <asp:RegularExpressionValidator ID="retxtSalary" runat="server" ControlToValidate="txtSalary"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="\s*[ 0-9 ]+\s*" ValidationGroup="e" meta:resourcekey="retxtSalaryResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblStatus" runat="server">
                                                                            Status:</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpEmpStatus" runat="server" CssClass='input-xlarge' meta:resourcekey="drpEmpStatusResource1">
                                                                                <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                                <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box box-bordered box-color">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hSrchEmp" runat="server">
                                                                    <i class="icon-search"></i>Search Employee_uds</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div class="span12">
                                                                    <div class="div_search_box">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSearchgvEmp" type="text" value="" class="input-large" placeholder="Search by Emp Name..."
                                                                                autocomplete="off" meta:resourcekey="txtSearchgvEmp" runat="server"/>
                                                                        </div>
                                                                        <asp:DropDownList ID="drpSearchgvEmp" runat="server" CssClass='input-medium'>
                                                                            <asp:ListItem Value="" Text="All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvEmployee_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvEmployee_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="emp_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" />
                                                                                <asp:BoundField DataField="emp_name" HeaderText="Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="emp_address" HeaderText="Address" meta:resourcekey="BoundFieldResource3" />
                                                                                <asp:BoundField DataField="emp_job" HeaderText="Job" meta:resourcekey="BoundFieldResource4" />
                                                                                <asp:BoundField DataField="emp_identity_no" HeaderText="Identity No." meta:resourcekey="BoundFieldResource5" />
                                                                                <asp:BoundField DataField="emp_mobile" HeaderText="Mobile" meta:resourcekey="BoundFieldResource6" />
                                                                                <asp:BoundField DataField="emp_phone" HeaderText="Phone" meta:resourcekey="BoundFieldResource7" />
                                                                                <asp:BoundField DataField="emp_birthdate" HeaderText="Birthdate" meta:resourcekey="BoundFieldResource8" />
                                                                                <asp:BoundField DataField="emp_hiredate" HeaderText="Hiredate" meta:resourcekey="BoundFieldResource9" />
                                                                                <asp:BoundField DataField="emp_salary" HeaderText="Salary" meta:resourcekey="BoundFieldResource10" />
                                                                                <asp:BoundField DataField="active" HeaderText="Status" meta:resourcekey="BoundFieldResource11">
                                                                                    <HeaderStyle CssClass="hide" />
                                                                                    <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:TemplateField HeaderText="Status" meta:resourcekey="BoundFieldResource11">
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
