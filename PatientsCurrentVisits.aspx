<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientsCurrentVisits.aspx.cs"
    Inherits="PatientsCurrentVisits" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<%@ Register Src="~/ucReception.ascx" TagPrefix="uc1" TagName="ucReception" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Current Visits</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css" meta:resourcekey="bootStrap" runat="server"/>
    <!-- Bootstrap responsive -->
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" meta:resourcekey="bootStrapResposive" runat="server"/>
    <!-- jQuery UI -->
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/style.css" meta:resourcekey="Style" runat="server"/>
    <!-- Color CSS -->
    <link rel="stylesheet" href="css/themes.css" />
    <!-- GridView CSS -->
    <link rel="stylesheet" href="css/gridview.css" />
    <!-- select2 CSS-->
    <link rel="stylesheet" href="css/plugins/select2/select2.css" />
    <!-- Datepicker -->
    <link rel="stylesheet" href="css/plugins/datepicker/datepicker.css" />
    <!-- Switch CSS-->
    <link rel="stylesheet" href="css/plugins/switch/switch.min.css" />
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
    <!-- Datepicker -->
    <script type="text/javascript" src="js/plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- Bootstrap -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <!-- NiceScroll -->
    <script type="text/javascript" src="js/plugins/nicescroll/jquery.nicescroll.min.js"></script>
    <!-- select2 -->
    <script type="text/javascript" src="js/plugins/select2/select2.min.js"></script>
     <!-- mNotification -->
    <link href="css/toastr.css" rel="stylesheet" />
    <script src="js/toastr.js"></script>
    <!-- ion.sound -->
    <script type="text/javascript" src="js/ion.sound.min.js"></script>
    <%--    <!-- persianumber -->
    <script src="js/persianumber.min.js"></script>--%>
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
            $('a[href="PatientsCurrentVisits.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };

        function DoWork() {
            $('#txtCost').val('');
            $('#chkVisitPaid').bootstrapSwitch();
            $('#chkVisitPaid').bootstrapSwitch('setState', false); // true || false
            $('#chkVisitPaid').attr("disabled", true);
            $('#btnVisitDelete').attr('disabled', true);
            $('#btnVisitUpdate').attr('disabled', true);
            $('#txtCost').attr("disabled", true);
            $("#imgLoading").hide();
            //            $('#txtCurrentDate').datepicker({
            //                format: 'dd/mm/yyyy',
            //                autoclose: true
            //            });
            $('#txtCurrentDate').datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
            }).on('changeDate', function (ev) {
                $("#imgLoading").show();
                __doPostBack('btnCurrentRefresh', '');
            });
            $('#txtCurrentDate').attr('readonly', 'readonly');
            $('#txtCurrentDate').on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });
            $("#gvCurrentVisits .gvrow").click(function () {
                $("#gvCurrentVisits .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $('#txtVisitID').val($(cells[3]).text());
                $('#chkVisitPaid').bootstrapSwitch('setState', false);
                $('#chkVisitPaid').attr("disabled", true);
                $('#btnVisitDelete').attr('disabled', true);
                $('#btnVisitUpdate').attr('disabled', true);

                if ($(cells[9]).text().toLowerCase() == "new") {
                    $('#btnVisitDelete').attr('disabled', false);
                }
                if ($(cells[7]).text().toLowerCase() == "yes") {
                    $('#chkVisitPaid').bootstrapSwitch('setState', true);
                    $('#txtCost').attr("disabled", true);
                }
                if ($(cells[7]).text().toLowerCase() == "no") {
                    $('#chkVisitPaid').attr("disabled", false);
                    $('#chkVisitPaid').bootstrapSwitch('setState', false);
                    $('#txtCost').attr("disabled", false);
                    $('#btnVisitUpdate').attr('disabled', false);
                }
                var discount = $(cells[14]).text().trim();
                if (discount != "") {
                    var examcost = parseFloat($(cells[11]).text());
                    var dis = parseFloat($(cells[14]).text());
                    var cost = examcost - (examcost * (dis / 100));
                    $('#txtCost').val(cost);
                }
                else {
                    $('#txtCost').val($(cells[11]).text());
                }
            });
            //            $('#chkVisitPaid').change(function () {
            //                var chk = $('#chkVisitPaid').is(':checked') ? "1" : "0";
            //                if (chk == "1") {
            //                    
            //                }
            //                else if (chk == "0") {
            //                    
            //                }
            //            });
            $('#btnVisitDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $("#imgLoading").show();
                    $('#btnVisitDelete').attr('disabled', true);
                    $('#btnVisitUpdate').attr('disabled', true);
                    $('#btnVisitDelete').attr('value', 'Deleting');
                    __doPostBack('btnVisitDelete', '');
                });
            });
            $('#btnVisitUpdate').unbind("click").bind("click", function (event) {
                event.preventDefault();
                if (!Page_ClientValidate()) { return false; }
                $('#modal-2').modal('show');
                $('#modal-2 #btnConfirmUpdate').unbind("click").bind("click", function () {
                    $("#imgLoading").show();
                    $('#btnVisitUpdate').attr('disabled', true);
                    $('#btnVisitDelete').attr('disabled', true);
                    $('#btnVisitUpdate').attr('value', 'Updating');
                    __doPostBack('btnVisitUpdate', '');
                });
            });
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
        function ClearVisitsTbl() {
            $('#chkVisitPaid').bootstrapSwitch('setState', false);
            $('#txtVisitID').val('');
            $('#txtVisitDate').val('');
            $('#txtCost').val('');
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
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="h2Current_Patients_ud_Visits" runat="server">Current Patients_ud Visits</h2>
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
                                    <h3 meta:resourcekey="h3Current_Patients_ud_Visits" runat="server">
                                        <i class="glyphicon-group"></i>Current Patients_ud Visits
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="Current_Visits" runat="server">Current Visits</a> </li>
                                        <li><a href="WaitingList.aspx" meta:resourcekey="Waiting_List" runat="server">Waiting List</a></li>
                                        <li><a href="PatientsVisits.aspx" meta:resourcekey="New_Visits" runat="server">New Visits</a></li>
                                        <li><a href="VisitsViaCompany.aspx" meta:resourcekey="Visits_Via_Company" runat="server">Visits Via Company</a></li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="h3Current_Visits" runat="server">
                                                            <i class="icon-stethoscope"></i>Current Visits
                                                        </h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upCurrentVisits" runat="server">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div class="span3">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldDate" runat="server">
                                                                            Date:-</label>
                                                                        <div class="controls">
                                                                            <input id="txtCurrentDate" runat="server" type="text" class="input-small" maxlength="10"
                                                                                autocomplete="off" style="width: 75px" />
                                                                            &nbsp;<asp:Button ID="btnCurrentRefresh" runat="server" OnClick="btnCurrentRefresh_Click"
                                                                                CssClass="hide" meta:resourcekey="btnCurrentRefreshResource1" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span5">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldPaid" runat="server">
                                                                            Paid:-</label>
                                                                        <div class="controls">
                                                                            <input id="chkVisitPaid" runat="server" type="checkbox" data-on-label="Yes" data-off-label="NO"
                                                                                data-on="danger" data-off="primary" />
                                                                            &nbsp;<input id="txtCost" meta:resourcekey="textfieldCost" runat="server" type="text" class="input-small" autocomplete="off"
                                                                                disabled="disabled" placeholder="Cost" />
                                                                            <asp:RequiredFieldValidator ID="rvtxtCost" runat="server" ControlToValidate="txtCost"
                                                                                Display="Dynamic" ValidationGroup="v" ErrorMessage="*Required" ForeColor="#CC0000"
                                                                                SetFocusOnError="True" meta:resourcekey="rvtxtCostResource1"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="retxtCost" runat="server" ControlToValidate="txtCost"
                                                                                ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationExpression="^\d{0,18}([\.]\d{1,2})?$" ValidationGroup="v" meta:resourcekey="retxtCostResource1"></asp:RegularExpressionValidator>
                                                                            <img id="imgLoading" src="img/loading.gif" alt="Loadind" width="25" height="25px" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span4">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="textfieldActions" runat="server">
                                                                            Actions:-</label>
                                                                        <div class="controls">
                                                                            <asp:Button ID="btnVisitUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                Width="70px" OnClick="btnVisitUpdate_Click" ValidationGroup="v" CommandArgument="update" meta:resourcekey="btnVisitUpdateResource1" />
                                                                            <asp:Button ID="btnVisitDelete" Text="Delete" runat="server" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnVisitDelete_Click" CommandArgument="delete" meta:resourcekey="btnVisitDeleteResource1" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span12">
                                                                    <div class="scroll scrollbig">
                                                                        <input id="txtVisitID" runat="server" type="text" class="hide" />
                                                                        &nbsp;<asp:GridView ID="gvCurrentVisits" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvCurrentVisitsResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="pat_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1" />
                                                                                <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="pat_balance" HeaderText="Bal." meta:resourcekey="BoundFieldResource3" />
                                                                                <asp:BoundField DataField="pat_visit_id" HeaderText="V.ID" meta:resourcekey="BoundFieldResource4" />
                                                                                <asp:BoundField DataField="pat_visit_date" HeaderText="Date" meta:resourcekey="BoundFieldResource5" />
                                                                                <asp:BoundField DataField="pat_visit_time" HeaderText="Time" meta:resourcekey="BoundFieldResource6" />
                                                                                <asp:BoundField DataField="exam_full" HeaderText="Exam" meta:resourcekey="BoundFieldResource7" />
                                                                                <asp:BoundField DataField="paid_status" HeaderText="Paid" meta:resourcekey="BoundFieldResource8" />
                                                                                <asp:BoundField DataField="transact_amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource9" />
                                                                                <asp:BoundField DataField="visit_status" HeaderText="Status" meta:resourcekey="BoundFieldResource10" />
                                                                                <asp:BoundField DataField="exam_det_id" HeaderText="exam_det_id" meta:resourcekey="BoundFieldResource11" >
                                                                                <HeaderStyle CssClass="hide" />
                                                                                <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="exam_cost" HeaderText="Cost" meta:resourcekey="BoundFieldResource12" >
                                                                                <HeaderStyle CssClass="hide" />
                                                                                <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="company_name" HeaderText="Company" meta:resourcekey="BoundFieldResource13" />
                                                                                <asp:BoundField DataField="contract_id" HeaderText="C.ID" meta:resourcekey="BoundFieldResource14" />
                                                                                <asp:BoundField DataField="contract_discount" HeaderText="Dis %" meta:resourcekey="BoundFieldResource15" />
                                                                                <asp:BoundField DataField="user_name" HeaderText="User" meta:resourcekey="BoundFieldResource16" />
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
                <h3 id="myModalLabel" meta:resourcekey="Deletion_Confirmation" runat="server">Deletion Confirmation</h3>
            </div>
            <div class="modal-body">
                <p meta:resourcekey="ConfirmationMsg" runat="server">
                    Are you sure that you want to permanently delete this visit ?
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
        <div id="modal-2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
            aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×</button>
                <h3 id="H1" meta:resourcekey="Updating_Confirmation" runat="server">Updating Confirmation</h3>
            </div>
            <div class="modal-body">
                <p meta:resourcekey="Updating_ConfirmationMsg" runat="server">
                    Are you sure that you want to update this visit ?
                </p>
            </div>
            <div class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true" meta:resourcekey="btnUpdatingNo" runat="server">
                    No
                </button>
                <button id="btnConfirmUpdate" class="btn btn-primary" data-dismiss="modal" meta:resourcekey="btnUpdatingYes" runat="server">
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
