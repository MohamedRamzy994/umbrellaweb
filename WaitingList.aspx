<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WaitingList.aspx.cs" Inherits="WaitingList" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Src="~/ucReception.ascx" TagPrefix="uc1" TagName="ucReception" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Waiting List</title>
    <!-- Bootstrap -->
    <link id="Link1" rel="stylesheet" href="css/bootstrap.min.css" meta:resourcekey="bootStrap" runat="server"/>
    <!-- Bootstrap responsive -->
     <link id="Link2" rel="stylesheet" href="css/bootstrap-responsive.min.css" meta:resourcekey="bootStrapResposive" runat="server"/>
    <!-- jQuery UI -->
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
    <!-- Theme CSS -->
    <link id="Link3" rel="stylesheet" href="css/style.css" meta:resourcekey="Style" runat="server"/>
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
        var timeout;
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="WaitingList.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };

        function DoWork() {
            $("#imgLoading").hide();
            clearTimeout(timeout);
            timeout = setTimeout(function () {
                //code goes here that will be run every 60 seconds.
                $("#imgLoading").show();
                __doPostBack('btnWaitingListRefresh', '');
            }, 60000);
            $("#gvWaitingListNew .gvrow").click(function () {
                // $("#gvWaitingListNew .gvrow").removeClass("blue3");
                $(this).toggleClass("blue3");
            });
            $("#gvWaitingListPending .gvrow").click(function () {
                // $("#gvWaitingListPending .gvrow").removeClass("blue3");
                $(this).toggleClass("blue3");
            });
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
    <uc1:ucReception runat="server" id="ucReception" />
    <div id="content" class="container-fluid nav-fixed">
        <div id="main" style="margin-left: 0px;">
            <div class="container-fluid">
                <div class="page-header">
                    <div class="pull-left">
                        <h2 meta:resourcekey="h2Patients_ud_on_Waiting_List" runat="server">
                            Patients_ud on Waiting List</h2>
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
                        <div class="box box-color box-bordered">
                            <div class="box-title">
                                <h3 meta:resourcekey="h3Waiting_List" runat="server">
                                    <i class="glyphicon-stopwatch"></i>Waiting List
                                </h3>
                                <img id="imgLoading" src="img/loading.gif" alt="Loadind" width="25" height="25px" />
                                <ul class="tabs">
                                    <li class="active"><a href="#t1" data-toggle="tab"  meta:resourcekey="aWaiting_List" runat="server">Waiting List</a></li>
                                    <li><a href="PatientsCurrentVisits.aspx" meta:resourcekey="aCurrent_Visits" runat="server">Current Visits</a></li>
                                    <li><a href="PatientsVisits.aspx" meta:resourcekey="aNew_Visits" runat="server">New Visits</a></li>
                                    <li><a href="VisitsViaCompany.aspx" meta:resourcekey="aVisits_Via_Company" runat="server">Visits Via Company</a></li>
                                </ul>
                            </div>
                            <div class="box-content nopadding">
                                <div class='form-horizontal form-column form-bordered'>
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <asp:UpdatePanel ID="upWaitingList" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <div class="span6">
                                                        <center>
                                                            <h4 meta:resourcekey="h4Waiting_List" runat="server">
                                                                Waiting List</h4>
                                                        </center>
                                                        <asp:Button ID="btnWaitingListRefresh" runat="server" OnClick="btnWaitingListRefresh_Click"
                                                            CssClass="hide" meta:resourcekey="btnWaitingListRefreshResource1" />
                                                        <div class="scroll scrollbig">
                                                            <asp:GridView ID="gvWaitingListNew" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                EmptyDataText="No Results Found" meta:resourcekey="gvWaitingListNewResource1">
                                                                <Columns>
                                                                    <asp:BoundField DataField="pat_visit_id" HeaderText="Visit ID" meta:resourcekey="BoundFieldResource1" >
                                                                    <HeaderStyle CssClass="hide" />
                                                                    <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="rnk" HeaderText="No." meta:resourcekey="BoundFieldResource2" />
                                                                    <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource3" />
                                                                    <asp:BoundField DataField="pat_visit_date" HeaderText="Date" meta:resourcekey="BoundFieldResource4" />
                                                                    <asp:BoundField DataField="pat_visit_time" HeaderText="Time" meta:resourcekey="BoundFieldResource5" />
                                                                    <asp:BoundField DataField="exam_name" HeaderText="Exam" meta:resourcekey="BoundFieldResource6" />
                                                                </Columns>
                                                                <HeaderStyle CssClass="gvgray" />
                                                                <RowStyle CssClass="blue2 gvrow" />
                                                                <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                <EmptyDataRowStyle CssClass="gvempty" />
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                    <div class="span6">
                                                        <center>
                                                            <h4 meta:resourcekey="h4Working_on" runat="server">
                                                                Working on</h4>
                                                        </center>
                                                        <div class="scroll scrollbig">
                                                            <asp:GridView ID="gvWaitingListPending" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                EmptyDataText="No Results Found" meta:resourcekey="gvWaitingListPendingResource1">
                                                                <Columns>
                                                                    <asp:BoundField DataField="pat_visit_id" HeaderText="Visit ID" meta:resourcekey="BoundFieldResource7" >
                                                                    <HeaderStyle CssClass="hide" />
                                                                    <ItemStyle CssClass="hide" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="rnk" HeaderText="No." meta:resourcekey="BoundFieldResource8" />
                                                                    <asp:BoundField DataField="pat_name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource9" />
                                                                    <asp:BoundField DataField="pat_visit_date" HeaderText="Date" meta:resourcekey="BoundFieldResource10" />
                                                                    <asp:BoundField DataField="pat_visit_time" HeaderText="Time" meta:resourcekey="BoundFieldResource11" />
                                                                    <asp:BoundField DataField="exam_name" HeaderText="Exam" meta:resourcekey="BoundFieldResource12" />
                                                                </Columns>
                                                                <HeaderStyle CssClass="gvgray" />
                                                                <RowStyle CssClass="blue2 gvrow" />
                                                                <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                <EmptyDataRowStyle CssClass="gvempty" />
                                                            </asp:GridView>
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
    <div id="footer">
        <p id="P2" meta:resourcekey="pAboutus" runat="server">
            Umbrella v2.4 - © All Rights Reserved For Delta Med It <span class="font-grey-4">
                |</span><a href="AboutUs.aspx" target="_blank"> About Us</a>
        </p>
        <a href="#" class="gototop"><i class="icon-arrow-up"></i></a>
    </div>
    </form>
    <asp:PlaceHolder runat="server" ID="phBottomScripts" />
</body>
</html>
