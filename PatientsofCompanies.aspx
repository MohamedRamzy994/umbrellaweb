<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientsofCompanies.aspx.cs"
    Inherits="PatientsofCompanies_ud" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Src="~/ucReception.ascx" TagPrefix="uc1" TagName="ucReception" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Patients_ud of Compaies</title>
    <!-- Bootstrap -->
    <link id="Link2" rel="stylesheet" href="css/bootstrap.min.css" meta:resourcekey="bootstrap" runat="server" />
    <!-- Bootstrap responsive -->
    <link id="Link1" rel="stylesheet" href="css/bootstrap-responsive.min.css" meta:resourcekey="bootstrapresponsive" runat="server" />
    <!-- jQuery UI -->
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
    <!-- Theme CSS -->
    <link id="Link3" rel="stylesheet" href="css/style.css" meta:resourcekey="styleResource1" runat="server" />
    <!-- Color CSS -->
    <link rel="stylesheet" href="css/themes.css" />
    <!-- GridView CSS -->
    <link href="css/gridview.css" rel="stylesheet" />
    <!-- Datepicker -->
    <link rel="stylesheet" href="css/plugins/datepicker/datepicker.css" />
    <!-- Select2 CSS-->
    <link rel="stylesheet" href="css/plugins/select2/select2.css" />
    <!-- jQuery -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- My Library -->
    <script type="text/javascript" src="js/FQuery.js"></script>
    <!-- Datepicker -->
    <script type="text/javascript" src="js/plugins/datepicker/bootstrap-datepicker.js"></script>
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
    <!-- Select2 -->
    <script type="text/javascript" src="js/plugins/select2/select2.min.js"></script>
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
            $('a[href="PatientsofCompanies_ud.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };
        function DoWork() {
            $('#brand').on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });
            $(".gvpagination").find("span").addClass("gvcurrentrow");
            $(".gvpagination").find("a").addClass("gvnumbtn");
            $(".gvpagination table").first().css("width", "auto");


            /////////////////////////////////////////////////
            /////// Patients_ud of Companies_ud Tab////////////////
            /////////////////////////////////////////////////
            $('#drpCompanies_ud').select2();  //("chosen-select");
            $('#btnPatComAdd').attr('disabled', true);
            $('#btnPatComRemove').attr('disabled', true);
            $('#txtCompanyPatID').val('');
            $('#txtCompanyPatDetId').val('');
            $("#gvPatCompanies_ud .gvrow").click(function () {
                $("#gvPat .gvrow").removeClass("blue3");
                $("#gvPatCompanies_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var c = $(this).find("td");
                $('#txtCompanyPatDetId').val($(c[2]).text());
                $('#txtCompanyPatID').val('');
                $('#btnPatComAdd').attr('disabled', true);
                $('#btnPatComRemove').attr('disabled', false);
                $("html, body").animate({ scrollTop: "75px" }, "normal");
            });
            $("#gvPat .gvrow").click(function () {
                $("#gvPatCompanies_ud .gvrow").removeClass("blue3");
                $("#gvPat .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var c = $(this).find("td");
                $('#txtCompanyPatID').val($(c[0]).text());
                $('#txtCompanyPatDetId').val('');
                $('#btnPatComAdd').attr('disabled', false);
                $('#btnPatComRemove').attr('disabled', true);
                $("html, body").animate({ scrollTop: "75px" }, "normal");
            });
            $('#txtCompanyPatDetSearch').keyup(function () {
                $('#txtCompanyPatDetId').val('');
                $("#gvPatCompanies_ud .gvrow").removeClass("blue3");
                $('#btnPatComRemove').attr('disabled', true);
                var searchKey = $.trim($('#txtCompanyPatDetSearch').val().toLowerCase());
                $("#gvPatCompanies_ud tr td:nth-child(2)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $('#txtCompanyPatSearch').keyup(function () {
                $('#txtCompanyPatID').val('');
                $("#gvPat .gvrow").removeClass("blue3");
                $('#btnPatComAdd').attr('disabled', true);
                var searchKey = $.trim($('#txtCompanyPatSearch').val().toLowerCase());
                $("#gvPat tr td:nth-child(2)").each(function () {
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
            //////// End of Patients_ud of Companies_ud Tab////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
    </script>
</head>
<body class='<%= this.UserTheme%>'>
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
                            <h2 meta:resourcekey="h2Patients_ud_of_Companies_ud" runat="server">Patients_ud of Companies_ud</h2>
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
                                    <h3  meta:resourcekey="liPatients_ud_Settings" runat="server">
                                        <i class="glyphicon-settings"></i>Patients_ud Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li><a href="PatientsSettings.aspx" meta:resourcekey="liPatients_ud" runat="server">Patients_ud</a> </li>
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="liPatients_ud_of_Companies_ud" runat="server">Patients_ud of Companies_ud</a></li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <asp:UpdatePanel ID="upPatCompanies_ud" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <div class="box box-bordered box-color">
                                                            <div class="box-title">
                                                                <h3 meta:resourcekey="iPatients_ud_of_Companies_ud" runat="server">
                                                                    <i class="glyphicon-building" ></i>Patients_ud of Companies_ud</h3>
                                                            </div>
                                                            <div class="box-content nopadding">
                                                                <div id="divComp" class="span12">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblCompanies_ud" runat="server">
                                                                            Companies_ud :</label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="drpCompanies_ud" runat="server" CssClass='input-xlarge' AutoPostBack="True"
                                                                                OnSelectedIndexChanged="drpCompanies_ud_SelectedIndexChanged" meta:resourcekey="drpCompanies_udResource1">
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions :</label>
                                                                        <div class="controls">
                                                                            <asp:Button ID="btnPatComAdd" runat="server" Text="Add" CssClass="btn btn-darkblue"
                                                                                Style="width: 75px" OnClick="btnPatComAdd_Click" OnClientClick="this.disabled = true; this.value = 'Adding'; if(document.getElementById('btnPatComRemove')!= null){document.getElementById('btnPatComRemove').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnPatComAddResource1" />
                                                                            <asp:Button ID="btnPatComRemove" runat="server" Text="Remove" CssClass="btn btn-lightred"
                                                                                Style="width: 75px" OnClick="btnPatComRemove_Click" OnClientClick="this.disabled = true; this.value = 'Removing'; if(document.getElementById('btnPatComAdd')!= null){document.getElementById('btnPatComAdd').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="delete" meta:resourcekey="btnPatComRemoveResource1" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="span6">
                                                                    <div class="div_search_box">
                                                                        <h5 meta:resourcekey="h5Patients_ud_of_selected_Company" runat="server">&nbsp; Patients_ud of selected Company :</h5>
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                        </div>
                                                                        <input id="txtCompanyPatDetSearch" type="text" value="" runat="server" class="input-xlarge" meta:resourcekey="txtCompanyPatDetSearchPlh1" placeholder="Search By Patient Name..."
                                                                            autocomplete="off" />
                                                                        <input id="txtCompanyPatDetId" runat="server" type="text" class="hide" />
                                                                    &nbsp;</div>
                                                                    <div class="scroll scrolltall">
                                                                        <asp:GridView ID="gvPatCompanies_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvPatCompanies_udResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="pat_id" HeaderText="ID" meta:resourcekey="BoundFieldResource1" />
                                                                                <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource2" />
                                                                                <asp:BoundField DataField="Company_Pat_Det_ud_id" HeaderText="Company_Pat_Det_ud_id" meta:resourcekey="BoundFieldResource3" >
                                                                                <HeaderStyle CssClass="hide" />
                                                                                <ItemStyle CssClass="hide" />
                                                                                </asp:BoundField>
                                                                            </Columns>
                                                                            <HeaderStyle CssClass="gvgray" />
                                                                            <RowStyle CssClass="blue2 gvrow" />
                                                                            <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                            <EmptyDataRowStyle CssClass="gvempty" />
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                                <div class="span6">
                                                                    <div class="div_search_box">
                                                                        <h5 meta:resourcekey="h5All_Other_Patients_ud" runat="server">&nbsp; All Other Patients_ud :</h5>
                                                                        <div class="input-append input-prepend">
                                                                            <span class="add-on">
                                                                                <li class="icon-search"></li>
                                                                            </span>
                                                                        </div>
                                                                        <input id="txtCompanyPatSearch" type="text" value="" class="input-xlarge" runat="server" meta:resourcekey="txtCompanyPatSearchplh2" placeholder="Search By Patient Name..."
                                                                            autocomplete="off" />
                                                                        <input id="txtCompanyPatID" runat="server" type="text" class="hide" />
                                                                    &nbsp;</div>
                                                                    <div class="scroll scrolltall">
                                                                        <asp:GridView ID="gvPat" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found" meta:resourcekey="gvPatResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="pat_id" HeaderText="ID" meta:resourcekey="BoundFieldResource4" />
                                                                                <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource5" />
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
                <h3 id="myModalLabel" meta:resourcekey="Deletion_Confirmation" runat="server">Deletion Confirmation</h3>
            </div>
            <div class="modal-body">
                <p  meta:resourcekey="DeleteMsg" runat="server">
                    Are you sure that you want to permanently delete this record ?
                </p>
            </div>
            <div class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true"  meta:resourcekey="btnNo" runat="server">
                    No
                </button>
                <button id="btnConfirm" class="btn btn-primary" data-dismiss="modal"  meta:resourcekey="btnYes" runat="server">
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
