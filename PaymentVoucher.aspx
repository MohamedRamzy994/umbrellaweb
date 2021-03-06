<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaymentVoucher.aspx.cs" Inherits="PaymentVoucher" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Src="~/ucFinancials.ascx" TagPrefix="uc1" TagName="ucFinancials" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Payment Voucher</title>
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
    <!-- mQuery -->
    <script src="js/mQuery.js"></script>
    <!-- persianumber -->
    <script src="js/persianumber.min.js"></script>
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
            $('a[href="PaymentVoucher.aspx"]').parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };
        function DoWork() {
            $(".gvrow2").click(function () {
                $(this).toggleClass("blue3");
            });
            /////////////////////////////////////////////////
            ///////////// Companies_ud Tab /////////////////////
            /////////////////////////////////////////////////
            $('#btnCompSave').attr('disabled', true);
            $('#btnCompSave').unbind("click").bind("click", function (event) {
                event.preventDefault();
                if (!Page_ClientValidate('c')) { return false; }
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnCompSave').attr('disabled', true);
                    $('#btnCompNew').attr('disabled', true);
                    $('#btnCompSave').attr('value', 'Saving');
                    __doPostBack('btnCompSave', '');
                });
            });
            $('#btnCompNew').click(function () {
                ClearComptbl();
            });
            $("#gvCompanies_ud .gvrow").click(function () {
                $("#gvCompanies_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtCompId").val($(cells[0]).text());
                $("#txtCompCode").val($(cells[2]).text());
                $("#txtCompBalance").val($(cells[3]).text());
                $('#btnCompSave').attr('disabled', false);
                //Page_ClientValidate("c");
            });

            $('#txtSrchgvCompanies_ud').keyup(function () {
                ClearComptbl();
                $('#drpSrchgvCompanies_ud').val('');
                var searchKey = $.trim($('#txtSrchgvCompanies_ud').val().toLowerCase());
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
            $('#drpSrchgvCompanies_ud').change(function () {
                ClearComptbl();
                $('#txtSrchgvCompanies_ud').val('');
                var searchKey = $.trim($('#drpSrchgvCompanies_ud').val().toLowerCase());
                $("#gvCompanies_ud tr td:nth-child(5)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });

            $('#txtSrchDategvCompTrans').keyup(function () {
                $('#txtSrchCodegvCompTrans').val('');
                $("#gvCompTransaction .gvrow").removeClass("blue3");
                var searchKey = $.trim($('#txtSrchDategvCompTrans').val().toLowerCase());
                $("#gvCompTransaction tr td:nth-child(1)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });

            $('#txtSrchCodegvCompTrans').keyup(function () {
                $('#txtSrchDategvCompTrans').val('');
                $("#gvCompTransaction .gvrow").removeClass("blue3");
                var searchKey = $.trim($('#txtSrchCodegvCompTrans').val().toLowerCase());
                $("#gvCompTransaction tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            /////////////////////////////////////////////////
            //////////// End Companies_ud Tab //////////////////
            /////////////////////////////////////////////////

            /////////////////////////////////////////////////
            ///////////// Patients_ud Tab //////////////////////
            /////////////////////////////////////////////////
            $("#divPatients_ud").defaultButton("#btnPatients_udSearch");
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

            $('#btnPatSave').attr('disabled', true);
            $('#btnPatSave').unbind("click").bind("click", function (event) {
                event.preventDefault();
                if (!Page_ClientValidate('p')) { return false; }
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnPatSave').attr('disabled', true);
                    $('#btnPatNew').attr('disabled', true);
                    $('#btnPatSave').attr('value', 'Saving');
                    __doPostBack('btnPatSave', '');
                });
            });
            $('#btnPatNew').click(function () {
                ClearPatients_udtbl();
            });
            $("#gvPatients_ud .gvrow").click(function () {
                $("#gvPatients_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtPatId").val($(cells[0]).text());
                $("#txtPatCode").val($(cells[2]).text());
                $("#txtPatBalance").val($(cells[3]).text());
                $('#btnPatSave').attr('disabled', false);
                //Page_ClientValidate("p");
            });
            $('#txtSrchDategvPatTrans').keyup(function () {
                $('#txtSrchCodegvPatTrans').val('');
                $("#gvPatTransaction .gvrow").removeClass("blue3");
                var searchKey = $.trim($('#txtSrchDategvPatTrans').val().toLowerCase());
                $("#gvPatTransaction tr td:nth-child(1)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });

            $('#txtSrchCodegvPatTrans').keyup(function () {
                $('#txtSrchDategvPatTrans').val('');
                $("#gvPatTransaction .gvrow").removeClass("blue3");
                var searchKey = $.trim($('#txtSrchCodegvPatTrans').val().toLowerCase());
                $("#gvPatTransaction tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            /////////////////////////////////////////////////
            //////////// End Patients_ud Tab ///////////////////
            /////////////////////////////////////////////////

            /////////////////////////////////////////////////
            ///////////// Examinations_ud Tab /////////////////////
            /////////////////////////////////////////////////
            $('#btnExpSave').attr('disabled', true);
            $('#btnExpSave').unbind("click").bind("click", function (event) {
                event.preventDefault();
                if (!Page_ClientValidate('e')) { return false; }
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnExpSave').attr('disabled', true);
                    $('#btnExpNew').attr('disabled', true);
                    $('#btnExpSave').attr('value', 'Saving');
                    __doPostBack('btnExpSave', '');
                });
            });
            $('#btnExpNew').click(function () {
                ClearExptbl();
            });
            $("#gvExaminations_ud .gvrow").click(function () {
                $("#gvExaminations_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtExpId").val($(cells[0]).text());
                $("#txtExpCode").val($(cells[2]).text());
                $("#txtExpBalance").val($(cells[3]).text());
                $('#btnExpSave').attr('disabled', false);
                //Page_ClientValidate("e");
            });

            $('#txtSrchgvExaminations_ud').keyup(function () {
                ClearExptbl();
                var searchKey = $.trim($('#txtSrchgvExaminations_ud').val().toLowerCase());
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
            $('#txtSrchDategvExpTrans').keyup(function () {
                $('#txtSrchCodegvExpTrans').val('');
                $("#gvExpTransaction .gvrow").removeClass("blue3");
                var searchKey = $.trim($('#txtSrchDategvExpTrans').val().toLowerCase());
                $("#gvExpTransaction tr td:nth-child(1)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });

            $('#txtSrchCodegvExpTrans').keyup(function () {
                $('#txtSrchDategvExpTrans').val('');
                $("#gvExpTransaction .gvrow").removeClass("blue3");
                var searchKey = $.trim($('#txtSrchCodegvExpTrans').val().toLowerCase());
                $("#gvExpTransaction tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            /////////////////////////////////////////////////
            //////////// End Examinations_ud Tab //////////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        }
        function ClearComptbl() {
            $('#btnCompSave').attr('disabled', true);
            $("#gvCompanies_ud .gvrow").removeClass("blue3");
            $('#tblCompany').fClear();
        }
        function ClearCompSrch() {
            $('#txtSrchDategvCompTrans').val('');
            $('#txtSrchCodegvCompTrans').val('');
        }
        function ClearPatients_udtbl() {
            $('#btnPatSave').attr('disabled', true);
            $("#gvPatients_ud .gvrow").removeClass("blue3");
            $('#tblPatients_ud').fClear();
        }
        function ClearPatSrch() {
            $('#txtSrchDategvPatTrans').val('');
            $('#txtSrchCodegvPatTrans').val('');
        }
        function ClearExptbl() {
            $('#btnExpSave').attr('disabled', true);
            $("#gvExaminations_ud .gvrow").removeClass("blue3");
            $('#tblExpense').fClear();
        }
        function ClearExpSrch() {
            $('#txtSrchDategvExpTrans').val('');
            $('#txtSrchCodegvExpTrans').val('');
        }

    </script>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide"  />
        <uc1:ucFinancials runat="server" ID="ucFinancials" />
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="hPV" runat="server">Payment Voucher</h2>
                        </div>
                        <div class="pull-right NoAr">
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
                                    <h3 meta:resourcekey="hPVS" runat="server">
                                        <i class="glyphicon-cart_out"></i>Payment Voucher
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="aCompanies_ud" runat="server">Companies_ud</a></li>
                                        <li><a href="#t2" data-toggle="tab" meta:resourcekey="aPatients_ud" runat="server">Patients_ud</a></li>
                                        <li><a href="#t3" data-toggle="tab" meta:resourcekey="aExaminations_ud" runat="server">Examinations_ud</a></li>
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
                                                                <h3 meta:resourcekey="hCompanies_ud" runat="server">
                                                                    <i class="glyphicon-building"></i>Companies_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div class="span7">
                                                                    <div class="div_search_box">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSrchgvCompanies_ud" type="text" value="" class="input-large" placeholder="Search By Company Name..."
                                                                                autocomplete="off" meta:resourcekey="txtSrchgvCompanies_ud" runat="server"/>
                                                                        </div>
                                                                            <asp:DropDownList ID="drpSrchgvCompanies_ud" runat="server" CssClass='input-medium'>
                                                                            <asp:ListItem Value="" Text="Status - All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvCompanies_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvCompanies_udResource2">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="company_id" HeaderText="Comp.ID" meta:resourcekey="BoundFieldResource1"/>
                                                                                <asp:BoundField DataField="company_name" HeaderText="Company Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="company_code" HeaderText="Code" meta:resourcekey="BoundFieldResource3">
                                                                                <HeaderStyle CssClass="hide" />
                                                                                <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="company_balance" HeaderText="Balance" meta:resourcekey="BoundFieldResource4" />
                                                                                <asp:BoundField DataField="active" HeaderText="Status" meta:resourcekey="BoundFieldResource5" >
                                                                                  <HeaderStyle CssClass="hide" />
                                                                                <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                  <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource1">
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
                                                                <div id="tblCompany" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnCompNew" value="New" class="btn btn-grey" style="width: 75px" meta:resourcekey="btnNew" runat="server"/>
                                                                            <asp:Button ID="btnCompSave" Text="Save" runat="server" CssClass="btn btn-blue" Width="75px"
                                                                                OnClick="btnCompSave_Click" ValidationGroup="c" CommandArgument="save" meta:resourcekey="btnCompSaveResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblCode" runat="server">
                                                                            Code:</label>
                                                                        <div class="controls">
                                                                            <input id="txtCompCode" runat="server" type="text" placeholder="Company Code" class="input-xlarge"
                                                                                disabled="disabled" />
                                                                            <asp:RequiredFieldValidator ID="rvtxtCompCode" runat="server" ControlToValidate="txtCompCode"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="c" meta:resourcekey="rvtxtCompCodeResource1"></asp:RequiredFieldValidator>
                                                                            <input id="txtCompId" runat="server" type="text" placeholder="Company ID" class="hide"
                                                                                disabled="disabled" />
                                                                            <asp:RequiredFieldValidator ID="rvtxtCompId" runat="server" ControlToValidate="txtCompId"
                                                                                Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="c" meta:resourcekey="rvtxtCompIdResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblBalance" runat="server">
                                                                            Balance:</label>
                                                                        <div class="controls">
                                                                            <input id="txtCompBalance" runat="server" type="text" placeholder="Company Balance"
                                                                                class="input-xlarge" disabled="disabled" meta:resourcekey="txtCompBalance"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblAmount" runat="server">
                                                                            Amount:</label>
                                                                        <div class="controls">
                                                                            <input id="txtCompAmount" runat="server" type="text" placeholder="Paid Amount" maxlength="21"
                                                                                autocomplete="off" class="input-xlarge txtFocus" meta:resourcekey="txtAmount"/>
                                                                            <asp:RequiredFieldValidator ID="rvtxtCompAmount" runat="server" ControlToValidate="txtCompAmount"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="c" meta:resourcekey="rvtxtCompAmountResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtCompAmount" runat="server" ControlToValidate="txtCompAmount"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="^\d{0,18}([\.]\d{1,2})?$" ValidationGroup="c" meta:resourcekey="retxtCompAmountResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblNote" runat="server">
                                                                            Note:</label>
                                                                        <div class="controls">
                                                                            <input id="txtCompNote" runat="server" type="text" placeholder="Note" maxlength="50"
                                                                                autocomplete="off" class="input-xlarge" meta:resourcekey="txtNote"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box box-color box-bordered">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hTransactions_ud" runat="server">
                                                                    <i class="icon-money"></i>Transactions_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div class="span12">
                                                                    <div class="div_search_box">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSrchDategvCompTrans" type="text" value="" class="input-large" placeholder="Search By DateTime..."
                                                                                autocomplete="off" meta:resourcekey="txtSrchDate" runat="server"/>
                                                                        </div>
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSrchCodegvCompTrans" type="text" value="" class="input-large" placeholder="Search By Comp.ID..."
                                                                                autocomplete="off" meta:resourcekey="txtSrchCodegvCompTrans" runat="server"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="scroll scrollbig2">
                                                                        <asp:GridView ID="gvCompTransaction" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvCompTransactionResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="transact_date" HeaderText="Date" meta:resourcekey="BoundFieldResource6" />
                                                                                <asp:BoundField DataField="account_id" HeaderText="Comp.ID" meta:resourcekey="BoundFieldResource7" />
                                                                                <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource8" />
                                                                                <asp:BoundField DataField="last_acc_balance" HeaderText="Last Bal." meta:resourcekey="BoundFieldResource9" />
                                                                                <asp:BoundField DataField="last_clc_balance" HeaderText="Last Cash" meta:resourcekey="BoundFieldResource10" />
                                                                                <asp:BoundField DataField="transact_note" HeaderText="Note" meta:resourcekey="BoundFieldResource11" />
                                                                                <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource12" />
                                                                            </Columns>
                                                                            <HeaderStyle CssClass="gvgray" />
                                                                            <RowStyle CssClass="blue2 gvrow2" />
                                                                            <SelectedRowStyle CssClass="blue3 gvrow2" />
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
                                                <asp:UpdatePanel ID="upPatients_ud" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <div class="box box-bordered box-color">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hPatients_ud" runat="server">
                                                                    <i class="glyphicon-parents"></i>Patients_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div id="divPatients_ud" class="span7">
                                                                    <div class="input-append input-prepend">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <asp:DropDownList ID="drpSearchgvPatients_udCol" runat="server" CssClass='input-small'>
                                                                                <asp:ListItem Value="0" Text="All" meta:resourcekey="drpPatAll" />
                                                                                <asp:ListItem Value="1" Text="ID" meta:resourcekey="drpID" />
                                                                                <asp:ListItem Value="2" Text="Name" meta:resourcekey="drpName" />
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                        <input id="txtSearchgvPatients_ud" runat="server" type="text" class="input-large"
                                                                            placeholder="Search Here..." autocomplete="off" maxlength="30" meta:resourcekey="txtSearchgvPatients_ud"/>
                                                                          <asp:DropDownList ID="drpSearchgvPatients_udGender" runat="server" CssClass='input-medium'>
                                                                            <asp:ListItem Value="" Text="Gender - All" meta:resourcekey="drpGender" />
                                                                            <asp:ListItem Value="m" Text="Male" meta:resourcekey="drpMale" />
                                                                            <asp:ListItem Value="f" Text="Female" meta:resourcekey="drpFemale" />
                                                                        </asp:DropDownList>
                                                                         <asp:DropDownList ID="drpSearchgvPatients_udStatus" runat="server" CssClass='input-medium'>
                                                                            <asp:ListItem Value="" Text="Status - All" meta:resourcekey="drpAll" />
                                                                            <asp:ListItem Value="1" Text="Active" meta:resourcekey="drpactive" />
                                                                            <asp:ListItem Value="0" Text="Inactive" meta:resourcekey="drpinactive" />
                                                                        </asp:DropDownList>
                                                                        <asp:Button ID="btnPatients_udSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                                                                            Width="77px" OnClick="btnPatients_udSearch_Click" OnClientClick="this.disabled = true; this.value = 'Searching';"
                                                                            UseSubmitBehavior="False" meta:resourcekey="btnPatients_udSearchResource1" />
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvPatients_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" AllowPaging="True" PageSize="11" OnPageIndexChanging="gvPatients_ud_PageIndexChanging" meta:resourcekey="gvPatients_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="pat_id" HeaderText="Pat.ID" meta:resourcekey="BoundFieldResource13" />
                                                                                <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource14" />
                                                                                <asp:BoundField DataField="pat_code" HeaderText="Code" meta:resourcekey="BoundFieldResource15">
                                                                                <HeaderStyle CssClass="hide" />
                                                                                <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="pat_balance" HeaderText="Balance" meta:resourcekey="BoundFieldResource16" />
                                                                                <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource2">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("status")%>
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
                                                                <div id="tblPatients_ud" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnPatNew" value="New" class="btn btn-grey" style="width: 75px" meta:resourcekey="btnNew" runat="server"/>
                                                                            <asp:Button ID="btnPatSave" Text="Save" runat="server" CssClass="btn btn-blue" Width="75px"
                                                                                OnClick="btnPatSave_Click" ValidationGroup="p" CommandArgument="save" meta:resourcekey="btnPatSaveResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblCode" runat="server">
                                                                            Code:</label>
                                                                        <div class="controls">
                                                                            <input id="txtPatCode" runat="server" type="text" placeholder="Patient Code" class="input-xlarge"
                                                                                disabled="disabled" />
                                                                            <asp:RequiredFieldValidator ID="rvtxtPatCode" runat="server" ControlToValidate="txtPatCode"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="p" meta:resourcekey="rvtxtPatCodeResource1"></asp:RequiredFieldValidator>
                                                                            <input id="txtPatId" runat="server" type="text" placeholder="Patient ID" class="hide"
                                                                                disabled="disabled" />
                                                                            <asp:RequiredFieldValidator ID="rvtxtPatId" runat="server" ControlToValidate="txtPatId"
                                                                                Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="p" meta:resourcekey="rvtxtPatIdResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblBalance" runat="server">
                                                                            Balance:</label>
                                                                        <div class="controls">
                                                                            <input id="txtPatBalance" runat="server" type="text" placeholder="Patient Balance"
                                                                                class="input-xlarge" disabled="disabled" meta:resourcekey="txtPatBalance"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblAmount" runat="server">
                                                                            Amount:</label>
                                                                        <div class="controls">
                                                                            <input id="txtPatAmount" runat="server" type="text" placeholder="Paid Amount" maxlength="21"
                                                                                autocomplete="off" class="input-xlarge txtFocus" meta:resourcekey="txtAmount"/>
                                                                            <asp:RequiredFieldValidator ID="rvtxtPatAmount" runat="server" ControlToValidate="txtPatAmount"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="p" meta:resourcekey="rvtxtPatAmountResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtPatAmount" runat="server" ControlToValidate="txtPatAmount"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="^\d{0,18}([\.]\d{1,2})?$" ValidationGroup="p" meta:resourcekey="retxtPatAmountResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblNote" runat="server">
                                                                            Note:</label>
                                                                        <div class="controls">
                                                                            <input id="txtPatNote" runat="server" type="text" placeholder="Note" maxlength="50"
                                                                                autocomplete="off" class="input-xlarge" meta:resourcekey="txtNote"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box box-color box-bordered">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hTransactions_ud" runat="server">
                                                                    <i class="icon-money"></i>Transactions_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div class="span12">
                                                                    <div class="div_search_box">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSrchDategvPatTrans" type="text" value="" class="input-large" placeholder="Search By DateTime..."
                                                                                autocomplete="off" meta:resourcekey="txtSrchDate" runat="server"/>
                                                                        </div>
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSrchCodegvPatTrans" type="text" value="" class="input-large" placeholder="Search By Pat.ID..."
                                                                                autocomplete="off" meta:resourcekey="txtSrchCodegvPatTrans" runat="server"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="scroll scrollbig2">
                                                                        <asp:GridView ID="gvPatTransaction" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvPatTransactionResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="transact_date" HeaderText="Date" meta:resourcekey="BoundFieldResource17" />
                                                                                <asp:BoundField DataField="account_id" HeaderText="Pat.ID" meta:resourcekey="BoundFieldResource18" />
                                                                                <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource19" />
                                                                                <asp:BoundField DataField="last_acc_balance" HeaderText="Last Bal." meta:resourcekey="BoundFieldResource20" />
                                                                                <asp:BoundField DataField="last_clc_balance" HeaderText="Last Cash" meta:resourcekey="BoundFieldResource21" />
                                                                                <asp:BoundField DataField="transact_note" HeaderText="Note" meta:resourcekey="BoundFieldResource22" />
                                                                                <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource23" />
                                                                            </Columns>
                                                                            <HeaderStyle CssClass="gvgray" />
                                                                            <RowStyle CssClass="blue2 gvrow2" />
                                                                            <SelectedRowStyle CssClass="blue3 gvrow2" />
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
                                        <div id="t3" class="tab-pane">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <asp:UpdatePanel ID="upExaminations_ud" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <div class="box box-bordered box-color">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hExaminations_ud" runat="server">
                                                                    <i class="glyphicon-calculator"></i>Examinations_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div class="span7">
                                                                    <div class="input-append input-prepend">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSrchgvExaminations_ud" type="text" value="" class="input-large" placeholder="Search By Expense Name..."
                                                                                autocomplete="off" meta:resourcekey="txtSrchgvExaminations_ud" runat="server"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="scroll scrollsmall">
                                                                        <asp:GridView ID="gvExaminations_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvExaminations_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="Expense_id" HeaderText="Expense ID" meta:resourcekey="BoundFieldResource24" />
                                                                                <asp:BoundField DataField="Expense_name" HeaderText="Expense Name" meta:resourcekey="BoundFieldResource25" />
                                                                                <asp:BoundField DataField="Expense_code" HeaderText="Code" meta:resourcekey="BoundFieldResource26">
                                                                                <HeaderStyle CssClass="hide" />
                                                                                <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="Expense_balance" HeaderText="Balance" meta:resourcekey="BoundFieldResource27" />
                                                                            </Columns>
                                                                            <HeaderStyle CssClass="gvgray" />
                                                                            <RowStyle CssClass="blue2 gvrow" />
                                                                            <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                            <EmptyDataRowStyle CssClass="gvempty" />
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                                <div id="tblExpense" class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <input type="button" id="btnExpNew" value="New" class="btn btn-grey" style="width: 75px" meta:resourcekey="btnNew" runat="server"/>
                                                                            <asp:Button ID="btnExpSave" Text="Save" runat="server" CssClass="btn btn-blue" Width="75px"
                                                                                OnClick="btnExpSave_Click" ValidationGroup="e" CommandArgument="save" meta:resourcekey="btnExpSaveResource1" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group hidden">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblCode" runat="server">
                                                                            Code:</label>
                                                                        <div class="controls">
                                                                            <input id="txtExpCode" runat="server" type="text" placeholder="Expense Code" class="input-xlarge"
                                                                                disabled="disabled" />
                                                                            <asp:RequiredFieldValidator ID="rvtxtExpCode" runat="server" ControlToValidate="txtExpCode"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtExpCodeResource1"></asp:RequiredFieldValidator>
                                                                            <input id="txtExpId" runat="server" type="text" placeholder="Expense ID" class="hide"
                                                                                disabled="disabled" />
                                                                            <asp:RequiredFieldValidator ID="rvtxtExpId" runat="server" ControlToValidate="txtExpId"
                                                                                Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtExpIdResource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblBalance" runat="server">
                                                                            Balance:</label>
                                                                        <div class="controls">
                                                                            <input id="txtExpBalance" runat="server" type="text" placeholder="Expense Balance"
                                                                                class="input-xlarge" disabled="disabled" meta:resourcekey="txtExpBalance"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblAmount" runat="server">
                                                                            Amount:</label>
                                                                        <div class="controls">
                                                                            <input id="txtExpAmount" runat="server" type="text" placeholder="Paid Amount" maxlength="21"
                                                                                autocomplete="off" class="input-xlarge txtFocus" meta:resourcekey="txtAmount"/>
                                                                            <asp:RequiredFieldValidator ID="rvtxtExpAmount" runat="server" ControlToValidate="txtExpAmount"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtExpAmountResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtExpAmount" runat="server" ControlToValidate="txtExpAmount"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="^\d{0,18}([\.]\d{1,2})?$" ValidationGroup="e" meta:resourcekey="retxtExpAmountResource1"></asp:RegularExpressionValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblNote" runat="server">
                                                                            Note:</label>
                                                                        <div class="controls">
                                                                            <input id="txtExpNote" runat="server" type="text" placeholder="Note" maxlength="50"
                                                                                autocomplete="off" class="input-xlarge" meta:resourcekey="txtNote"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box box-color box-bordered">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="hTransactions_ud" runat="server">
                                                                    <i class="icon-money"></i>Transactions_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div class="span12">
                                                                    <div class="input-append input-prepend">
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSrchDategvExpTrans" type="text" value="" class="input-large" placeholder="Search By DateTime..."
                                                                                autocomplete="off" meta:resourcekey="txtSrchDate" runat="server"/>
                                                                        </div>
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                            <input id="txtSrchCodegvExpTrans" type="text" value="" class="input-large" placeholder="Search By Expense ID..."
                                                                                autocomplete="off" meta:resourcekey="txtSrchCodegvExpTrans" runat="server"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="scroll scrollbig2">
                                                                        <asp:GridView ID="gvExpTransaction" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvExpTransactionResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="transact_date" HeaderText="Date" meta:resourcekey="BoundFieldResource28" />
                                                                                <asp:BoundField DataField="account_id" HeaderText="Expense ID" meta:resourcekey="BoundFieldResource29" />
                                                                                <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource30" />
                                                                                <asp:BoundField DataField="last_acc_balance" HeaderText="Last Bal." meta:resourcekey="BoundFieldResource31" />
                                                                                <asp:BoundField DataField="last_clc_balance" HeaderText="Last Cash" meta:resourcekey="BoundFieldResource32" />
                                                                                <asp:BoundField DataField="transact_note" HeaderText="Note" meta:resourcekey="BoundFieldResource33" />
                                                                                <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource34" />
                                                                            </Columns>
                                                                            <HeaderStyle CssClass="gvgray" />
                                                                            <RowStyle CssClass="blue2 gvrow2" />
                                                                            <SelectedRowStyle CssClass="blue3 gvrow2" />
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
                <h3 id="myModalLabel" meta:resourcekey="myModalLabel" runat="server">Saving Confirmation</h3>
            </div>
            <div class="modal-body">
                <p meta:resourcekey="pSave" runat="server">
                    Are you sure that you want to save this operation ?
                </p>
                <p meta:resourcekey="pNote" runat="server">
                    <b>Note: There is no undo for this operation</b>
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
