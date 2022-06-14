<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucStyle_Scripts.ascx.cs" Inherits="WebUserControl" %>

<%-- START OF REPORT STYLE SCRIPTS REPORT--%>
<!-- Bootstrap -->
<link id="Link1" rel="stylesheet" href="css/bootstrap.min.css" meta:resourcekey="bootStrap" runat="server" />
<!-- Bootstrap responsive -->
<link id="Link2" rel="stylesheet" href="css/bootstrap-responsive.min.css" meta:resourcekey="bootStrapResposive" runat="server" />
<!-- jQuery UI -->
<link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
<!-- Theme CSS -->
<link id="Link3" rel="stylesheet" href="css/style.css" meta:resourcekey="Style" runat="server" />
<!-- Color CSS -->
<link rel="stylesheet" href="css/themes.css" />
<!-- GridView CSS -->
<link href="css/gridview.css" rel="stylesheet" type="text/css" />
<!-- jQuery -->
<script type="text/javascript" src="js/jquery.min.js"></script>
<!-- switch-->
<link href="css/plugins/switch/switch.css" rel="stylesheet" />
<!-- timePicker-->
<link href="css/plugins/timepicker/bootstrap-timepicker.min.css" rel="stylesheet" />
<!--DateRangePicker -->
<link href="css/plugins/daterangepicker/daterangepicker.css" rel="stylesheet" />
<!-- My Library -->
<script src="js/FQuery.js" type="text/javascript"></script>
<!-- jQuery UI -->
<script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.core.min.js"></script>
<script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.widget.min.js"></script>
<script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.mouse.min.js"></script>
<script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.resizable.min.js"></script>
<script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.sortable.min.js"></script>
<!-- Bootstrap -->
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<!-- Datepicker -->
<script type="text/javascript" src="js/plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- NiceScroll -->
<script type="text/javascript" src="js/plugins/nicescroll/jquery.nicescroll.min.js"></script>
<!-- mNotification -->
<link href="css/toastr.css" rel="stylesheet" />
<!-- select2 CSS-->
<link rel="stylesheet" href="css/plugins/select2/select2.css" />
<script src="js/toastr.js"></script>

<!-- ion.sound -->
<script type="text/javascript" src="js/ion.sound.min.js"></script>
<%--<!-- persianumber -->
<script src="js/persianumber.min.js"></script>--%>
<!-- mQuery -->
<script src="js/mQuery.js"></script>
<%--    <!-- mSounds -->
    <script src="js/mSounds.js"></script>--%>
<!-- default button -->
<script src="js/jquery-defaultButton.min.js"></script>
<!-- select2 -->
<script type="text/javascript" src="js/plugins/select2/select2.min.js"></script>
<!-- Theme framework -->
<script type="text/javascript" src="js/eakroko.min.js"></script>
<!-- Theme scripts -->
<script type="text/javascript" src="js/application.min.js"></script>
<!-- Just for demonstration -->
<script type="text/javascript" src="js/demonstration.min.js"></script>
<!-- switch-->
<script src="js/plugins/switch/bootstrap-switch.js"></script>
<!--timePicker-->
<script src="js/plugins/timepicker/bootstrap-timepicker.min.js"></script>
<!--DateRangePicker -->
<script src="js/plugins/daterangepicker/daterangepicker.js"></script>
<script src="js/plugins/daterangepicker/moment.min.js"></script>
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
<%-- END OF STYLE AND SCRIPTS --%>
<%--<script type="text/javascript">
    var timeout;
    $(document).ready(function () {
        /// Eng.Moustafa Ebrahem
        /// Eng.Moustafa20@Gmail.com
        $('a[href="PatientsVisits.aspx"]').parent().addClass('active').parent().parent().addClass('active');
        $('#divVisits').hide();
        DoWork();
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
    });
    function requestHandler(sender, args) {
        // this code is excected after the first postback
        DoWork();
    };
</script>--%>
