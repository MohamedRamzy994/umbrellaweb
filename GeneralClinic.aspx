<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GeneralClinic.aspx.cs" Inherits="GeneralClinic" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>General Clinic_ud</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <!-- Bootstrap responsive -->
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
    <!-- jQuery UI -->
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/plugins/jquery-ui/smoothness/jquery.ui.theme.css" />
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/style.css" />
    <!-- Color CSS -->
    <link rel="stylesheet" href="css/themes.css" />
    <!-- GridView CSS -->
    <link rel="stylesheet" href="css/gridview.css" />
    <!-- Datepicker -->
    <link rel="stylesheet" href="css/plugins/datepicker/datepicker.css" />
    <!-- Notify CSS -->
    <link rel="stylesheet" href="css/plugins/gritter/jquery.gritter.css" />
    <!-- Image Gallery CSS -->
    <link rel="stylesheet" href="css/plugins/imagegallery/blueimp-gallery.min.css" />
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
    <!-- Notify -->
    <script type="text/javascript" src="js/plugins/gritter/jquery.gritter.min.js"></script>
    <!-- Image Gallery -->
    <script type="text/javascript" src="js/plugins/imagegallery/jquery.blueimp-gallery.min.js"></script>
    <!-- Select2 -->
    <script type="text/javascript" src="js/plugins/select2/select2.min.js"></script>
    <!-- ion.sound -->
    <script type="text/javascript" src="js/ion.sound.min.js"></script>
    <!-- Theme framework -->
    <script type="text/javascript" src="js/eakroko.min.js"></script>
    <!-- Theme scripts -->
    <script type="text/javascript" src="js/application.min.js"></script>
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

            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();
        };
        function DoWork() {
           // $('#lbServices').select2({ placeholder: "Select Services", title: "Services" });
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

            //            $(window).on('beforeunload', function () {
            //                return ':( ?';
            //            });
            //#region Patients_ud Info
            /////////////////////////////////////////////////
            /////////////Patients_ud Info Tab///////////////////
            /////////////////////////////////////////////////
            clearTimeout(timeout);
            timeout = setTimeout(function () {
                //code goes here that will be run every 2 minutes.
                $('#aWlRefresh').hide();
                __doPostBack('btnWlRefresh', '');
            }, 120000);
            $('#aWlRefresh').fadeIn();
            $('#aWlRefresh').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $(this).hide();
                __doPostBack('btnWlRefresh', '');
            });
            $('#aSrchPatients_ud').unbind("click").bind("click", function (event) {
                event.preventDefault();
                var active = $('.s');
                var inactive = $('.h')
                $(active).hide().removeClass('s').addClass('h');
                $(inactive).fadeIn().removeClass('h').addClass('s');
            });

            $('.aWl').unbind('click').bind('click', function () {
                $('#divPatInfo').toggleClass('hide');
                if ($('#Clinic_ud').hasClass('span10') && $('#Patients_ud').hasClass('span10')) {
                    $('#Clinic_ud').removeClass('span10').addClass('span12');
                    $('#Patients_ud').removeClass('span10').addClass('span12');
                    return;
                }
                if ($('#Clinic_ud').hasClass('span12') && $('#Patients_ud').hasClass('span12')) {
                    $('#Clinic_ud').removeClass('span12').addClass('span10');
                    $('#Patients_ud').removeClass('span12').addClass('span10');
                }
                //Patients_ud
                //Clinic_ud
            });
            //$("#divPatInfo").width(800).height(200);
            /////////////////////////////////////////////////
            //////////End of Patients_ud Info Tab///////////////
            /////////////////////////////////////////////////
            //#endregion Patients_ud Info

            //#region Patients_ud Visits
            /////////////////////////////////////////////////
            ///////////Patients_ud Visits Tab///////////////////
            /////////////////////////////////////////////////

            $("#imgLoading").hide();
            if ($('#hfVisitFinish').val() != "") {
                $('#btnVisitFinish').attr('disabled', false);
            }
            else {
                $('#btnVisitFinish').attr('disabled', true);
            }
            if ($('#hfVisitDelete').val() != "") {
                $('#btnVisitDelete').attr('disabled', false);
            }
            else {
                $('#btnVisitDelete').attr('disabled', true);
            }
            $("#gvPatientsVisits .gvrow").unbind("click").bind("click", function () {
                $("#imgLoading").show();
                $("#gvPatientsVisits .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#hfVisitId").val($(cells[0]).text());

                $('#btnVisitView').attr('disabled', false);
                $('#btnVisitPrint').attr('disabled', false);
                if ($(cells[11]).text().toLowerCase() == "new") {
                    $('#btnVisitDelete').attr('disabled', false);
                    $("#hfVisitDelete").val('delete');
                }
                else {
                    $('#btnVisitDelete').attr('disabled', true);
                    $("#hfVisitDelete").val('');
                }
                if ($(cells[11]).text().toLowerCase() == "finished") {
                    $('#btnVisitFinish').attr('disabled', true);
                    $("#hfVisitFinish").val('');
                }
                else {
                    $('#btnVisitFinish').attr('disabled', false);
                    $("#hfVisitFinish").val('finished');
                }
                ClearVitaltbl();
                ClearComplaintDiagnosis_udtbl();
                ClearPrescriptiontbl();
                ClearRequesttbl();
                __doPostBack('btnVisitView', '');
            });

            $('#txtSrchgvPatientsVisits').keyup(function SearchtxtgvDose() {
                $('#drpSrchSrchgvPatientsVisits').val('');
                var searchKey = $.trim($('#txtSrchgvPatientsVisits').val().toLowerCase());
                $("#gvPatientsVisits tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $('#drpSrchSrchgvPatientsVisits').change(function SearchdrpgvDose() {
                $('#txtSrchgvPatientsVisits').val('');
                var searchKey = $.trim($('#drpSrchSrchgvPatientsVisits').val().toLowerCase());
                $("#gvPatientsVisits tr td:nth-child(12)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });

            $('#btnVisitFinish').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-2').modal('show');
                $('#modal-2 #btnConfirm2').unbind("click").bind("click", function () {
                    $('#btnVisitFinish').attr('disabled', true);
                    $('#btnVisitDelete').attr('disabled', true);
                    $('#btnVisitFinish').attr('value', 'Finishing');
                    __doPostBack('btnVisitFinish', '');
                });
            });

            $('#btnVisitDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-3').modal('show');
                $('#modal-3 #btnConfirm3').unbind("click").bind("click", function () {
                    $('#btnVisitDelete').attr('disabled', true);
                    $('#btnVisitFinish').attr('disabled', true);
                    $('#btnVisitDelete').attr('value', 'Deleting');
                    __doPostBack('btnVisitDelete', '');
                });
            });
            $('#btnVisitPrint').unbind("click").bind("click", function (event) {
                event.preventDefault();
                if ($('#hfVisitId').val() == "") {
                    $('#t1').mShowStatus(3, ' You must select a visit first');
                    return;
                }
                var str = "ReportView.aspx?data=visit," + $('#hfVisitId').val();
                // $.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });

            /////////////////////////////////////////////////
            ///////// End of PatientsVisits Tab//////////////
            /////////////////////////////////////////////////
            //#endregion Patients_ud Visits

            //#region Search Patients_ud
            /////////////////////////////////////////////////
            ////////// Search Patients_ud Tab //////////////////
            /////////////////////////////////////////////////
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
            $("#gvPatients_ud .gvrow").unbind("click").bind("click", function () {
                $("#gvPatients_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $('#hfPatId').val($(cells[0]).text());
                var active = $('.s');
                var inactive = $('.h')
                $(active).hide().removeClass('s').addClass('h');
                $(inactive).fadeIn('slow').removeClass('h').addClass('s');
                __doPostBack('btnLoadPatInfo', '');
            });
            /////////////////////////////////////////////////
            ////////// End Search Patients_ud Tab //////////////
            /////////////////////////////////////////////////
            //#endregion Search Patients_ud

            //#region Past History
            /////////////////////////////////////////////////
            //////////// Past History Tabs //////////////////
            /////////////////////////////////////////////////

            if ($('#hfPatId').val() != "") {
                // Disable all Save & Print Buttons in Past History Tabs
                // Because no patient is selected
                $('#btnHospitalSave').attr('disabled', false);
                $('#btnHospitalPrint').attr('disabled', false);
                $('#btnTransfusionSave').attr('disabled', false);
                $('#btnTransfusionPrint').attr('disabled', false);
                $('#btnSurgerySave').attr('disabled', false);
                $('#btnSurgeryPrint').attr('disabled', false);
                $('#btnDrugSave').attr('disabled', false);
                $('#btnDrugPrint').attr('disabled', false);
                $('#btnChronicSave').attr('disabled', false);
                $('#btnChronicPrint').attr('disabled', false);
                $('#btnFamilySave').attr('disabled', false);
                $('#btnFamilyPrint').attr('disabled', false);
                $('#btnImageSave').attr('disabled', false);
                $('#btnImagePrint').attr('disabled', false);
                // Disable all New Buttons in Past History Tabs
                $('#btnHospitalNew').attr('disabled', false);
                $('#btnTransfusionNew').attr('disabled', false);
                $('#btnSurgeryNew').attr('disabled', false);
                $('#btnDrugNew').attr('disabled', false);
                $('#btnChronicNew').attr('disabled', false);
                $('#btnFamilyNew').attr('disabled', false);
                $('#btnImageNew').attr('disabled', false);
            }
            else {
                // Enable all Save  & Print Buttons in Past History Tabs
                // Because a patient is selected
                $('#btnHospitalSave').attr('disabled', true);
                $('#btnHospitalPrint').attr('disabled', true);
                $('#btnTransfusionSave').attr('disabled', true);
                $('#btnTransfusionPrint').attr('disabled', true);
                $('#btnSurgerySave').attr('disabled', true);
                $('#btnSurgeryPrint').attr('disabled', true);
                $('#btnDrugSave').attr('disabled', true);
                $('#btnDrugPrint').attr('disabled', true);
                $('#btnChronicSave').attr('disabled', true);
                $('#btnChronicPrint').attr('disabled', true);
                $('#btnFamilySave').attr('disabled', true);
                $('#btnFamilyPrint').attr('disabled', true);
                $('#btnImageSave').attr('disabled', true);
                $('#btnImagePrint').attr('disabled', true);
                // Enable all New Buttons in Past History Tabs
                $('#btnHospitalNew').attr('disabled', true);
                $('#btnTransfusionNew').attr('disabled', true);
                $('#btnSurgeryNew').attr('disabled', true);
                $('#btnDrugNew').attr('disabled', true);
                $('#btnChronicNew').attr('disabled', true);
                $('#btnFamilyNew').attr('disabled', true);
                $('#btnImageNew').attr('disabled', true);
            }

            /////////////////////////////////////////////////
            ///////// End of Past History Tabs //////////////
            /////////////////////////////////////////////////
            //#endregion Past History



            //#region Vital & Complaints & Diagnosis_ud & Requests
            ///////////////////////////////////////////////////////////////////
            ////////// Vital & Complaints & Diagnosis_ud & Request Tab ///////////
            //////////////////////////////////////////////////////////////////
            $('#lbDiagnosis_ud').select2({ placeholder: "Select Diagnosis_ud", title: "Diagnosis_ud" });
            $('#lbRequestBlood').select2({ placeholder: "Select Blood Tests", title: "Blood Tests" });
            $('#lbRequestScan').select2({ placeholder: "Select Scans", title: "Scans" });
            if ($('#hfVisitId').val() != "") {
                $('#btnVisitPrint').attr('disabled', false);
                $('#btnVitalSave').attr('disabled', false);
                $('#btnVitalPrint').attr('disabled', false);
                $('#btnComplaintDiagnosis_udSave').attr('disabled', false);
                $('#btnComplaintDiagnosis_udPrint').attr('disabled', false);
                $('#btnRequestBloodSave').attr('disabled', false);
                $('#btnRequestScanSave').attr('disabled', false);
                $('#btnPrescriptionPrint').attr('disabled', false);
                $('.btnRequestPrint').attr('disabled', false);
            }
            else {
                $('#btnVisitPrint').attr('disabled', true);
                $('#btnVitalSave').attr('disabled', true);
                $('#btnVitalPrint').attr('disabled', true);
                $('#btnComplaintDiagnosis_udSave').attr('disabled', true);
                $('#btnComplaintDiagnosis_udPrint').attr('disabled', true);
                $('#btnRequestBloodSave').attr('disabled', true);
                $('#btnRequestScanSave').attr('disabled', true);
                $('#btnPrescriptionPrint').attr('disabled', true);
                $('.btnRequestPrint').attr('disabled', true);
            }

            $('#btnRequestBloodPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfVisitId').val() == "") {
                    $('#t7').mShowStatus(3, ' You must select a visit first');
                    return;
                }
                var str = "ReportView.aspx?data=request," + $('#hfVisitId').val();
                // $.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            $('#btnRequestScanPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfVisitId').val() == "") {
                    $('#t7').mShowStatus(3, ' You must select a visit first');
                    return;
                }
                var str = "ReportView.aspx?data=request," + $('#hfVisitId').val();
                //$.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });

            $('#btnComplaintDiagnosis_udPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfVisitId').val() == "") {
                    $('#t5').mShowStatus(3, ' You must select a visit first');
                    return;
                }
                var str = "ReportView.aspx?data=Diagnosis_ud," + $('#hfVisitId').val();
                //$.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            $('#btnVitalPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfVisitId').val() == "") {
                    $('#t4').mShowStatus(3, ' You must select a visit first');
                    return;
                }
                var str = "ReportView.aspx?data=vital," + $('#hfVisitId').val();
                // $.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });

            //////////////////////////////////////////////////////////////////
            /////// End Vital & Complaints & Diagnosis_ud & Request Tab /////////
            //////////////////////////////////////////////////////////////////
            //#endregion Vital & Complaints & Diagnosis_ud & Requests

            //#region Prescriptions
            /////////////////////////////////////////////////
            ////////// Prescriptions Tab ////////////////////
            /////////////////////////////////////////////////
            $('#drpPrescriptonDose').select2();
            $(".gvpagination").find("span").addClass("gvcurrentrow");
            $(".gvpagination").find("a").addClass("gvnumbtn");
            $(".gvpagination table").first().css("width", "auto");

            if ($('#hfVisitId').val() != "" && $('#hfPrescriptionMedId').val() != "" && $('#hfPresciptionDetId').val() == "") {
                $('#btnPrescriptionSave').attr('disabled', false);
            }
            else {
                $('#btnPrescriptionSave').attr('disabled', true);
            }
            if ($('#hfPresciptionDetId').val() != "") {
                $('#btnPrescriptionNew').attr('disabled', false);
                $('#btnPrescriptionUpdate').attr('disabled', false);
                $('#btnPrescriptionDelete').attr('disabled', false);
            }
            else {
                $('#btnPrescriptionNew').attr('disabled', true);
                $('#btnPrescriptionUpdate').attr('disabled', true);
                $('#btnPrescriptionDelete').attr('disabled', true);
            }
            $('#btnPrescriptionNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                ClearPrescriptiontbl();
            });

            $('#btnPrescriptionDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnPrescriptionDelete').attr('disabled', true);
                    $('#btnPrescriptionUpdate').attr('disabled', true);
                    $('#btnPrescriptionDelete').attr('value', 'Deleting');
                    __doPostBack('btnPrescriptionDelete', '');
                });
            });

            $("#gvMedicines_ud .gvrow").click(function () {
                $("#gvMedicines_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#hfPrescriptionMedId").val($(cells[0]).text());
                $("#txtPrescriptionMedName").val($(cells[1]).text());
                if ($('#hfPresciptionDetId').val() == "" && $('#hfVisitId').val() != "") {
                    $('#btnPrescriptionSave').attr('disabled', false);
                }
            });
            $("#gvPrescription .gvrow").click(function () {
                $("#gvPrescription .gvrow").removeClass("blue3");
                $("#gvMedicines_ud .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#hfPresciptionDetId").val($(cells[0]).text());
                $("#hfPrescriptionMedId").val($(cells[2]).text());
                $("#txtPrescriptionMedName").val($(cells[3]).text());
                $("#drpPrescriptonDose").select2("val", $(cells[4]).text());
                if ($("#drpPrescriptonDose").val() == null) {
                    $("#drpPrescriptonDose").select2("val", $("#drpPrescriptonDose option:first").val());
                }
                $("#txtPrescriptionNote").val($(cells[6]).text());
                $('#btnPrescriptionNew').attr('disabled', false);
                $('#btnPrescriptionSave').attr('disabled', true);
                $('#btnPrescriptionUpdate').attr('disabled', false);
                $('#btnPrescriptionDelete').attr('disabled', false);
            });

            $('#btnPrescriptionPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfVisitId').val() == "") {
                    $('#t6').mShowStatus(3, ' You must select a visit first');
                    return;
                }
                var str = "ReportView.aspx?data=prescription," + $('#hfVisitId').val();
                window.open(str, '_blank');
            });
            /////////////////////////////////////////////////
            ////////// End Prescriptions Tab ////////////////
            /////////////////////////////////////////////////
            //#endregion Prescriptions

            //#region Family History
            /////////////////////////////////////////////////
            ////////// Family History Tab ///////////////////
            /////////////////////////////////////////////////

            if ($('#txtFamilyId').val() != "") {
                $('#btnFamilySave').attr('disabled', true);
                $('#btnFamilyUpdate').attr('disabled', false);
                $('#btnFamilyDelete').attr('disabled', false);
            }
            else {
                $('#btnFamilyUpdate').attr('disabled', true);
                $('#btnFamilyDelete').attr('disabled', true);
            }
            $('#btnFamilyNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvFamily .gvrow").removeClass("blue3");
                $('#btnFamilySave').attr('disabled', false);
                $('#btnFamilyUpdate').attr('disabled', true);
                $('#btnFamilyDelete').attr('disabled', true);
                $('#tblFamily').fClear();
            });

            $('#btnFamilyDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnFamilyDelete').attr('disabled', true);
                    $('#btnFamilyUpdate').attr('disabled', true);
                    $('#btnFamilyDelete').attr('value', 'Deleting');
                    __doPostBack('btnFamilyDelete', '');
                });
            });

            $('#txtSrchgvFamily').keyup(function SearchtxtgvDose() {
                ClearFamilytbl();
                var searchKey = $.trim($('#txtSrchgvFamily').val().toLowerCase());
                $("#gvFamily tr td:nth-child(4)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });

            $("#gvFamily .gvrow").click(function () {
                $("#gvFamily .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtFamilyId").val($(cells[0]).text());
                $("#drpFamilyRelationship").val($(cells[2]).text());
                $("#txtFamilyDiseaseName").val($(cells[3]).text());
                $('#btnFamilySave').attr('disabled', true);
                $('#btnFamilyUpdate').attr('disabled', false);
                $('#btnFamilyDelete').attr('disabled', false);
                Page_ClientValidate("f");
            });

            $('#btnFamilyPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfPatId').val() == "") {
                    $('#t8').mShowStatus(3, ' You must select a patient first');
                    return;
                }
                var str = "ReportView.aspx?data=family," + $('#hfPatId').val();
                //$.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            /////////////////////////////////////////////////
            ///////// End of Family History Tab /////////////
            /////////////////////////////////////////////////
            //#endregion Family History

            //#region Chronic Diseases
            /////////////////////////////////////////////////
            ///////// Chronic Diseases Tab //////////////////
            /////////////////////////////////////////////////

            if ($("#txtChronicId").val() != "") {
                $('#btnChronicSave').attr('disabled', true);
                $('#btnChronicUpdate').attr('disabled', false);
                $('#btnChronicDelete').attr('disabled', false);
            }
            else {
                $('#btnChronicUpdate').attr('disabled', true);
                $('#btnChronicDelete').attr('disabled', true);
            }
            $('#btnChronicNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvChronic .gvrow").removeClass("blue3");
                $('#btnChronicSave').attr('disabled', false);
                $('#btnChronicUpdate').attr('disabled', true);
                $('#btnChronicDelete').attr('disabled', true);
                $('#tblChronic').fClear();
            });

            $('#btnChronicDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnChronicDelete').attr('disabled', true);
                    $('#btnChronicUpdate').attr('disabled', true);
                    $('#btnChronicDelete').attr('value', 'Deleting');
                    __doPostBack('btnChronicDelete', '');
                });
            });

            $('#txtSrchgvChronic').keyup(function SearchtxtgvDose() {
                ClearChronictbl();
                var searchKey = $.trim($('#txtSrchgvChronic').val().toLowerCase());
                $("#gvChronic tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvChronic .gvrow").click(function () {
                $("#gvChronic .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtChronicId").val($(cells[0]).text());
                $("#txtChronicName").val($(cells[2]).text());
                $('#btnChronicSave').attr('disabled', true);
                $('#btnChronicUpdate').attr('disabled', false);
                $('#btnChronicDelete').attr('disabled', false);
                Page_ClientValidate("c");
            });

            $('#btnChronicPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfPatId').val() == "") {
                    $('#t9').mShowStatus(3, ' You must select a patient first');
                    return;
                }
                var str = "ReportView.aspx?data=chronic," + $('#hfPatId').val();
                //$.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            /////////////////////////////////////////////////
            ///////// End of Chronic Diseases Tab ///////////
            /////////////////////////////////////////////////
            //#endregion Chronic Diseases

            //#region Drugs
            /////////////////////////////////////////////////
            ////////////// Drugs Tab ////////////////////////
            /////////////////////////////////////////////////

            if ($("#txtDrugId").val() != "") {
                $('#btnDrugSave').attr('disabled', true);
                $('#btnDrugUpdate').attr('disabled', false);
                $('#btnDrugDelete').attr('disabled', false);
            }
            else {
                $('#btnDrugUpdate').attr('disabled', true);
                $('#btnDrugDelete').attr('disabled', true);
            }
            $('#btnDrugNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvDrug .gvrow").removeClass("blue3");
                $('#btnDrugSave').attr('disabled', false);
                $('#btnDrugUpdate').attr('disabled', true);
                $('#btnDrugDelete').attr('disabled', true);
                $('#tblDrug').fClear();
            });

            $('#btnDrugDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnDrugDelete').attr('disabled', true);
                    $('#btnDrugUpdate').attr('disabled', true);
                    $('#btnDrugDelete').attr('value', 'Deleting');
                    __doPostBack('btnDrugDelete', '');
                });
            });

            $('#txtSrchgvDrug').keyup(function SearchtxtgvDose() {
                ClearDrugtbl();
                var searchKey = $.trim($('#txtSrchgvDrug').val().toLowerCase());
                $("#gvDrug tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvDrug .gvrow").click(function () {
                $("#gvDrug .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtDrugId").val($(cells[0]).text());
                $("#txtDrugName").val($(cells[2]).text());
                $('#btnDrugSave').attr('disabled', true);
                $('#btnDrugUpdate').attr('disabled', false);
                $('#btnDrugDelete').attr('disabled', false);
                Page_ClientValidate("d");
            });
            $('#btnDrugPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfPatId').val() == "") {
                    $('#t10').mShowStatus(3, ' You must select a patient first');
                    return;
                }
                var str = "ReportView.aspx?data=drugs," + $('#hfPatId').val();
                // $.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            /////////////////////////////////////////////////
            ////////////// End of Drugs Tab /////////////////
            /////////////////////////////////////////////////
            //#endregion Drugs

            //#region Surgeries
            /////////////////////////////////////////////////
            ////////////// Surgeries Tab ////////////////////
            /////////////////////////////////////////////////
            if ($("#txtSurgeryId").val() != "") {
                $('#btnSurgerySave').attr('disabled', true);
                $('#btnSurgeryUpdate').attr('disabled', false);
                $('#btnSurgeryDelete').attr('disabled', false);
            }
            else {
                $('#btnSurgeryUpdate').attr('disabled', true);
                $('#btnSurgeryDelete').attr('disabled', true);
            }
            $('#txtSurgeryDate').datepicker({ format: 'dd/mm/yyyy', autoclose: true });

            $('#btnSurgeryNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvSurgery .gvrow").removeClass("blue3");
                $('#btnSurgerySave').attr('disabled', false);
                $('#btnSurgeryUpdate').attr('disabled', true);
                $('#btnSurgeryDelete').attr('disabled', true);
                $('#tblSurgery').fClear();
            });

            $('#btnSurgeryDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnSurgeryDelete').attr('disabled', true);
                    $('#btnSurgeryUpdate').attr('disabled', true);
                    $('#btnSurgeryDelete').attr('value', 'Deleting');
                    __doPostBack('btnSurgeryDelete', '');
                });
            });

            $('#txtSrchgvSurgery').keyup(function SearchtxtgvDose() {
                ClearSurgerytbl();
                var searchKey = $.trim($('#txtSrchgvSurgery').val().toLowerCase());
                $("#gvSurgery tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvSurgery .gvrow").click(function () {
                $("#gvSurgery .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtSurgeryId").val($(cells[0]).text());
                $("#txtSurgeryName").val($(cells[2]).text());
                $("#txtSurgeryDate").val($(cells[3]).text());
                $('#btnSurgerySave').attr('disabled', true);
                $('#btnSurgeryUpdate').attr('disabled', false);
                $('#btnSurgeryDelete').attr('disabled', false);
                Page_ClientValidate("s");
            });

            $('#btnSurgeryPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfPatId').val() == "") {
                    $('#t11').mShowStatus(3, ' You must select a patient first');
                    return;
                }
                var str = "ReportView.aspx?data=surgeries," + $('#hfPatId').val();
                // $.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            /////////////////////////////////////////////////
            ////////// End of Surgeries Tab /////////////////
            /////////////////////////////////////////////////
            //#endregion Surgeries

            //#region Transfusion
            /////////////////////////////////////////////////
            ////////////// Transfusion Tab //////////////////
            /////////////////////////////////////////////////

            if ($("#txtTransfusionId").val() != "") {
                $('#btnTransfusionSave').attr('disabled', true);
                $('#btnTransfusionUpdate').attr('disabled', false);
                $('#btnTransfusionDelete').attr('disabled', false);
            }
            else {
                $('#btnTransfusionUpdate').attr('disabled', true);
                $('#btnTransfusionDelete').attr('disabled', true);
            }

            $('#txtTransfusionDate').datepicker({ format: 'dd/mm/yyyy', autoclose: true });

            $('#btnTransfusionNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvTransfusion .gvrow").removeClass("blue3");
                $('#btnTransfusionSave').attr('disabled', false);
                $('#btnTransfusionUpdate').attr('disabled', true);
                $('#btnTransfusionDelete').attr('disabled', true);
                $('#tblTransfusion').fClear();
            });

            $('#btnTransfusionDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnTransfusionDelete').attr('disabled', true);
                    $('#btnTransfusionUpdate').attr('disabled', true);
                    $('#btnTransfusionDelete').attr('value', 'Deleting');
                    __doPostBack('btnTransfusionDelete', '');
                });
            });

            $('#txtSrchgvTransfusion').keyup(function SearchtxtgvDose() {
                ClearTransfusiontbl();
                var searchKey = $.trim($('#txtSrchgvTransfusion').val().toLowerCase());
                $("#gvTransfusion tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvTransfusion .gvrow").click(function () {
                $("#gvTransfusion .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtTransfusionId").val($(cells[0]).text());
                $("#txtTransfusionDate").val($(cells[2]).text());
                $('#btnTransfusionSave').attr('disabled', true);
                $('#btnTransfusionUpdate').attr('disabled', false);
                $('#btnTransfusionDelete').attr('disabled', false);
                Page_ClientValidate("t");
            });

            $('#btnTransfusionPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfPatId').val() == "") {
                    $('#t12').mShowStatus(3, ' You must select a patient first');
                    return;
                }
                var str = "ReportView.aspx?data=transfusion," + $('#hfPatId').val();
                // $.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            /////////////////////////////////////////////////
            ////////// End of Transfusion Tab ///////////////
            /////////////////////////////////////////////////
            //#endregion Transfusion

            //#region Hospital
            /////////////////////////////////////////////////
            ////////////// Hospital Tab /////////////////////
            /////////////////////////////////////////////////

            if ($("#txtHospitalId").val() != "") {
                $('#btnHospitalSave').attr('disabled', true);
                $('#btnHospitalUpdate').attr('disabled', false);
                $('#btnHospitalDelete').attr('disabled', false);
            }
            else {
                $('#btnHospitalUpdate').attr('disabled', true);
                $('#btnHospitalDelete').attr('disabled', true);
            }

            $('#btnHospitalNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvHospital .gvrow").removeClass("blue3");
                $('#btnHospitalSave').attr('disabled', false);
                $('#btnHospitalUpdate').attr('disabled', true);
                $('#btnHospitalDelete').attr('disabled', true);
                $('#tblHospital').fClear();
            });

            $('#btnHospitalDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnHospitalDelete').attr('disabled', true);
                    $('#btnHospitalUpdate').attr('disabled', true);
                    $('#btnHospitalDelete').attr('value', 'Deleting');
                    __doPostBack('btnHospitalDelete', '');
                });
            });

            $('#txtSrchgvHospital').keyup(function SearchtxtgvDose() {
                ClearHospitaltbl();
                var searchKey = $.trim($('#txtSrchgvHospital').val().toLowerCase());
                $("#gvHospital tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $("#gvHospital .gvrow").click(function () {
                $("#gvHospital .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                var cells = $(this).find("td");
                $("#txtHospitalId").val($(cells[0]).text());
                $("#txtHospitalReason").val($(cells[2]).text());
                $('#btnHospitalSave').attr('disabled', true);
                $('#btnHospitalUpdate').attr('disabled', false);
                $('#btnHospitalDelete').attr('disabled', false);
                Page_ClientValidate("h");
            });

            $('#btnHospitalPrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfPatId').val() == "") {
                    $('#t13').mShowStatus(3, ' You must select a patient first');
                    return;
                }
                var str = "ReportView.aspx?data=hospital," + $('#hfPatId').val();
                //$.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            /////////////////////////////////////////////////
            /////////// End of Hospital Tab /////////////////
            /////////////////////////////////////////////////
            //#endregion Hospital

            //#region Images
            /////////////////////////////////////////////////
            /////////////// Images Tab //////////////////////
            /////////////////////////////////////////////////
            var Startindex = 0;
            if ($("#txtImageId").val() != "") {
                $('#btnImageSave').attr('disabled', false);
                $('#btnImageUpdate').attr('disabled', false);
                $('#btnImageDelete').attr('disabled', false);
                $('#btnImageView').attr('disabled', false);
            }
            else {
                $('#btnImageSave').attr('disabled', true);
                $('#btnImageUpdate').attr('disabled', true);
                $('#btnImageDelete').attr('disabled', true);
                $('#btnImageView').attr('disabled', true);
            }
            $('#AsyncFileUpload1_ctl01').css("height", "0px");

            $('#btnImageNew').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $("#gvImage .gvrow").removeClass("blue3");
                $('#btnImageSave').attr('disabled', false);
                $('#btnImageUpdate').attr('disabled', true);
                $('#btnImageDelete').attr('disabled', true);
                $('#btnImageView').attr('disabled', true);
                document.getElementById("AsyncFileUpload1_ctl02").disabled = false;
                $('#tblImage').fClear();
            });

            $('#btnImageDelete').unbind("click").bind("click", function (event) {
                event.preventDefault();
                $('#modal-1').modal('show');
                $('#modal-1 #btnConfirm').unbind("click").bind("click", function () {
                    $('#btnImageDelete').attr('disabled', true);
                    $('#btnImageUpdate').attr('disabled', true);
                    $('#btnImageDelete').attr('value', 'Deleting');
                    __doPostBack('btnImageDelete', '');
                });
            });

            $("#gvImage .gvrow").click(function () {
                $("#gvImage .gvrow").removeClass("blue3");
                $(this).addClass("blue3");
                document.getElementById("AsyncFileUpload1_ctl02").disabled = true;
                var cells = $(this).find("td");
                Startindex = $(this).index() - 1;
                $("#txtImageId").val($(cells[0]).text());
                $("#txtImageDesc").val($(cells[2]).text());
                $("#txtImageDate").val($(cells[3]).text());
                $('#btnImageSave').attr('disabled', true);
                $('#btnImageUpdate').attr('disabled', false);
                $('#btnImageDelete').attr('disabled', false);
                $('#btnImageView').attr('disabled', false);
                Page_ClientValidate("i");
            });

            $('#btnImageView').unbind("click").bind("click", function (event) {
                event.preventDefault();
                var AllTitles = [];
                var AllSrc = [];
                var rows = $("#gvImage tr:gt(0)"); // skip the header row
                rows.each(function () {
                    $("td:nth-child(3)", this).each(function () { //get all third tds in current row
                        var title = $(this).text();
                        AllTitles.push(title);

                    });
                    $("td:nth-child(5)", this).each(function () { //get all fifth tds in current row
                        var src = $(this).find('img').attr('src');
                        AllSrc.push(src);

                    });
                });
                var images = '[';
                for (var i = 0; i < AllTitles.length; ++i) {
                    images = images + '{"title":"' + AllTitles[i] + '","href":"' + AllSrc[i] + '"},';
                }
                AllTitles = undefined;
                AllSrc = undefined;
                images = images.substr(0, images.length - 1);
                images = images + ']';
                var options = {
                    // The Id, element or querySelector of the gallery widget:
                    container: '#blueimp-gallery',
                    // The tag name, Id, element or querySelector of the slides container:
                    slidesContainer: 'div',
                    // The tag name, Id, element or querySelector of the title element:
                    titleElement: 'h3',
                    // The class to add when the gallery is visible:
                    displayClass: 'blueimp-gallery-display',
                    // The class to add when the gallery controls are visible:
                    controlsClass: 'blueimp-gallery-controls',
                    // The class to add when the gallery only displays one element:
                    singleClass: 'blueimp-gallery-single',
                    // The class to add when the left edge has been reached:
                    //leftEdgeClass: 'blueimp-gallery-left',
                    // The class to add when the right edge has been reached:
                    //rightEdgeClass: 'blueimp-gallery-right',
                    // The class to add when the automatic slideshow is active:
                    playingClass: 'blueimp-gallery-playing',
                    // The class for all slides:
                    slideClass: 'slide',
                    // The slide class for loading elements:
                    slideLoadingClass: 'slide-loading',
                    // The slide class for elements that failed to load:
                    slideErrorClass: 'slide-error',
                    // The class for the content element loaded into each slide:
                    slideContentClass: 'slide-content',
                    // The class for the "toggle" control:
                    toggleClass: 'toggle',
                    // The class for the "prev" control:
                    prevClass: 'prev',
                    // The class for the "next" control:
                    nextClass: 'next',
                    // The class for the "close" control:
                    closeClass: 'close',
                    // The class for the "play-pause" toggle control:
                    playPauseClass: 'play-pause',
                    // The list object property (or data attribute) with the object type:
                    typeProperty: 'type',
                    // The list object property (or data attribute) with the object title:
                    titleProperty: 'title',
                    // The list object property (or data attribute) with the object URL:
                    urlProperty: 'href',
                    // The gallery listens for transitionend events before triggering the
                    // opened and closed events, unless the following option is set to false:
                    displayTransition: false,
                    // Defines if the gallery slides are cleared from the gallery modal,
                    // or reused for the next gallery initialization:
                    clearSlides: true,
                    // Defines if images should be stretched to fill the available space,
                    // while maintaining their aspect ratio (will only be enabled for browsers
                    // supporting background-size="contain", which excludes IE < 9).
                    // Set to "cover", to make images cover all available space (requires
                    // support for background-size="cover", which excludes IE < 9):
                    stretchImages: true,
                    // Toggle the controls on pressing the Return key:
                    toggleControlsOnReturn: true,
                    // Toggle the automatic slideshow interval on pressing the Space key:
                    toggleSlideshowOnSpace: true,
                    // Navigate the gallery by pressing left and right on the keyboard:
                    enableKeyboardNavigation: true,
                    // Close the gallery on pressing the ESC key:
                    closeOnEscape: true,
                    // Close the gallery when clicking on an empty slide area:
                    closeOnSlideClick: false,
                    // Close the gallery by swiping up or down:
                    closeOnSwipeUpOrDown: false,
                    // Emulate touch events on mouse-pointer devices such as desktop browsers:
                    emulateTouchEvents: true,
                    // Stop touch events from bubbling up to ancestor elements of the Gallery:
                    stopTouchEventsPropagation: false,
                    // Hide the page scrollbars: 
                    hidePageScrollbars: true,
                    // Stops any touches on the container from scrolling the page:
                    disableScroll: true,
                    // Carousel mode (shortcut for carousel specific options):
                    carousel: false,
                    // Allow continuous navigation, moving from last to first
                    // and from first to last slide:
                    continuous: true,
                    // Remove elements outside of the preload range from the DOM:
                    unloadElements: true,
                    // Start with the automatic slideshow:
                    startSlideshow: false,
                    // Delay in milliseconds between slides for the automatic slideshow:
                    slideshowInterval: 5000,
                    // The starting index as integer.
                    // Can also be an object of the given list,
                    // or an equal object with the same url property:
                    index: Startindex,
                    // The number of elements to load around the current index:
                    preloadRange: 1,
                    // The transition speed between slide changes in milliseconds:
                    transitionSpeed: 500
                }
                var gallery = blueimp.Gallery(jQuery.parseJSON(images), options);
            });

            $('#txtSrchgvImage').keyup(function SearchtxtgvDose() {
                ClearImagetbl();
                var searchKey = $.trim($('#txtSrchgvImage').val().toLowerCase());
                $("#gvImage tr td:nth-child(3)").each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.indexOf(searchKey) >= 0) {
                        $(this).parent().show();
                    }
                    else {
                        $(this).parent().hide();
                    }
                });
            });
            $('#btnImagePrint').unbind('click').bind('click', function (event) {
                event.preventDefault();
                if ($('#hfPatId').val() == "") {
                    $('#t14').mShowStatus(3, ' You must select a patient first');
                    return;
                }
                var str = "ReportView.aspx?data=images," + $('#hfPatId').val();
                //$.post('ReportView.aspx', { data: str });
                window.open(str, '_blank');
            });
            /////////////////////////////////////////////////
            //////////// End of Images Tab //////////////////
            /////////////////////////////////////////////////
            //#endregion Images
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            //Enable sidebar toggle
            $("[data-toggle='offcanvas']").click(function (e) {
                e.preventDefault();

                //If window is small enough, enable sidebar push menu
                if ($(window).width() <= 992) {
                    $('.row-offcanvas').toggleClass('active');
                    $('.right-side').removeClass("collapse-left");
                    $(".left-side").removeClass("strech");
                    $('.row-offcanvas').toggleClass("relative");
                } else {
                    //Else, enable content streching
                    $('.right-side').toggleClass("collapse-left");
                    $(".left-side").toggleClass("strech");
                }
            });
            $('body').keypress(function (event) {
                if (event.which == '109' || event.which == '77') {
                    if ($(window).width() <= 992) {
                        $('.row-offcanvas').toggleClass('active');
                        $('.right-side').removeClass("collapse-left");
                        $(".left-side").removeClass("strech");
                        $('.row-offcanvas').toggleClass("relative");
                    } else {
                        //Else, enable content streching
                        $('.right-side').toggleClass("collapse-left");
                        $(".left-side").toggleClass("strech");
                    }
                }
            });
        };

        //#region Other Functions
        function WlPatNew(pat_count) {
            $.gritter.add({
                // (string | mandatory) the heading of the notification
                title: 'Alert!',
                // (string | mandatory) the text inside the notification
                text: pat_count + ' Patient(s) has been added to the waiting list',
                // (bool | optional) if you want it to fade out on its own or just sit there
                sticky: false,
                // (int | optional) the time you want it to be alive for before fading out (milliseconds)
                time: 5000
            });
            $.ionSound({ sounds: ["jubilation"] });
            $.ionSound.play("jubilation");
        };
        function UpdateVisitStatus() {
            var status = $("#gvPatientsVisits .blue3 td:eq(11)").text().toLowerCase();
            if (status == 'new') {
                $("#gvPatientsVisits .blue3 td:eq(11)").text('Pending');
                $('#hfVisitDelete').val('');
                $('#btnVisitDelete').attr('disabled', true);
            }
        }
        function ClearPrescriptiontbl() {
            $("#gvMedicines_ud .gvrow").removeClass("blue3");
            $("#gvPrescription .gvrow").removeClass("blue3");
            $('#tblPrescription').fClear();
            $("#drpPrescriptonDose").select2("val", $('#drpPrescriptonDose option:eq(0)').val());
            $('#hfPresciptionDetId').val('');
            $('#hfPrescriptionMedId').val('');
            $('#btnPrescriptionNew').attr('disabled', true);
            $('#btnPrescriptionSave').attr('disabled', true);
            $('#btnPrescriptionPrint').attr('disabled', true);
            $('#btnPrescriptionUpdate').attr('disabled', true);
            $('#btnPrescriptionDelete').attr('disabled', true);
        };
        function ClearComplaintDiagnosis_udtbl() {
            $('#tblComplaintDiagnosis_ud').fClear();
            $("#lbDiagnosis_ud option:selected").removeAttr("selected");
            $('#btnComplaintDiagnosis_udSave').attr('disabled', false);
        };
        function ClearVitaltbl() {
            $('#tblVital').fClear();
            $('#btnVitalSave').attr('disabled', false);
        };
        function ClearRequesttbl() {
            $("#lbRequestBlood option:selected").removeAttr("selected");
            $("#lbRequestScan option:selected").removeAttr("selected");
        }
        function ClearFamilytbl() {
            $("#gvFamily .gvrow").removeClass("blue3");
            $('#tblFamily').fClear();
            $('#btnFamilySave').attr('disabled', false);
            $('#btnFamilyUpdate').attr('disabled', true);
            $('#btnFamilyDelete').attr('disabled', true);
        };
        function ClearChronictbl() {
            $("#gvChronic .gvrow").removeClass("blue3");
            $('#tblChronic').fClear();
            $('#btnChronicSave').attr('disabled', false);
            $('#btnChronicUpdate').attr('disabled', true);
            $('#btnChronicDelete').attr('disabled', true);
        };
        function ClearDrugtbl() {
            $("#gvDrug .gvrow").removeClass("blue3");
            $('#tblDrug').fClear();
            $('#btnDrugSave').attr('disabled', false);
            $('#btnDrugUpdate').attr('disabled', true);
            $('#btnDrugDelete').attr('disabled', true);
        };
        function ClearSurgerytbl() {
            $("#gvSurgery .gvrow").removeClass("blue3");
            $('#tblSurgery').fClear();
            $('#btnSurgerySave').attr('disabled', false);
            $('#btnSurgeryUpdate').attr('disabled', true);
            $('#btnSurgeryDelete').attr('disabled', true);
        };
        function ClearTransfusiontbl() {
            $("#gvTransfusion .gvrow").removeClass("blue3");
            $('#tblTransfusion').fClear();
            $('#btnTransfusionSave').attr('disabled', false);
            $('#btnTransfusionUpdate').attr('disabled', true);
            $('#btnTransfusionDelete').attr('disabled', true);
        };
        function ClearHospitaltbl() {
            $("#gvHospital .gvrow").removeClass("blue3");
            $('#tblHospital').fClear();
            $('#btnHospitalSave').attr('disabled', false);
            $('#btnHospitalUpdate').attr('disabled', true);
            $('#btnHospitalDelete').attr('disabled', true);
        };
        function ClearImagetbl() {
            $("#gvImage .gvrow").removeClass("blue3");
            $('#tblImage').fClear();
            $('#btnImageSave').attr('disabled', true);
            $('#btnImageUpdate').attr('disabled', true);
            $('#btnImageDelete').attr('disabled', true);
            $('#btnImageView').attr('disabled', true);
        }
        function OnClientStart(sender, args) {
            //$('#btnImageSave').attr('disabled', true);

            // make sure user has permission to save
            if (document.getElementById('btnImageSave') == null) {
                ClearContents();
                var err = new Error();
                err.name = "Access Denied";
                err.message = '\n \n Access Denied';
                throw (err);
                return false;
            }
            // make sure that user select a patient
            if ($('#hfPatId').val() == "") {
                $get("<%=lblSuccess.ClientID %>").innerHTML = "";
                $get("<%=lblError.ClientID %>").innerHTML = "You must select a patient first";
                // Reset AsyncFileUpload1 contrl
                // because if you don't reset it may cause a upload in some browsers
                // you can use the code below
                // var fileInputElement = sender.get_inputFile();
                //fileInputElement.value = "";
                // or you can use this code for that task
                //jQuery(sender.get_element()).find("input[type='file']")[0].form.reset();
                // or call ClearContents method
                ClearContents();
                ClearImagetbl();
                var err = new Error();
                err.name = "patient Error";
                err.message = '\n \n You must select a patient first';
                throw (err);
                return false;
            }
            // make sure that user write a description fro the image
            if ($('#txtImageDesc').val() == "") {
                $get("<%=lblSuccess.ClientID %>").innerHTML = "";
                $get("<%=lblError.ClientID %>").innerHTML = "You must write a description for the image";
                // Reset AsyncFileUpload1 contrl
                // because if you don't reset it may cause a upload in some browsers
                // you can use the code below
                // var fileInputElement = sender.get_inputFile();
                //fileInputElement.value = "";
                // or you can use this code for that task
                //jQuery(sender.get_element()).find("input[type='file']")[0].form.reset();
                // or call ClearContents method
                ClearContents();
                ClearImagetbl();
                var err = new Error();
                err.name = "description Error";
                err.message = '\n \n Please write a description for the image';
                throw (err);
                return false;
            }
            //Validation for file extension
            var filename = args.get_fileName().toLowerCase();
            var filext = filename.substring(filename.lastIndexOf(".") + 1);
            if (filext == "jpg" || filext == "jpeg" || filext == "png" || filext == "bmp" || filext == "gif" || filext == "tif") {
                $get("<%=lblError.ClientID %>").innerHTML = "";
                $get("<%=lblSuccess.ClientID %>").innerHTML = "Please Wait...<br/> Uploading image in progress"
                return true;
            }
            else {
                //there is no way to cancel the upload usin set_cancel(true)
                //cause an error
                //will also automatically call function UploadError
                $get("<%=lblSuccess.ClientID %>").innerHTML = "";
                $get("<%=lblError.ClientID %>").innerHTML = "Allowed image extentions are: <br/> (.jpg, .jpeg, .png, .bmp, .gif, .tif)";
                // Reset AsyncFileUpload1 contrl
                // because if you don't reset it may cause a upload in some browsers
                // you can use the code below
                // var fileInputElement = sender.get_inputFile();
                //fileInputElement.value = "";
                // or you can use this code for that task
                //jQuery(sender.get_element()).find("input[type='file']")[0].form.reset();
                // or call ClearContents method
                ClearContents();
                ClearImagetbl();
                var err = new Error();
                err.name = "File extention error";
                err.message = '\n \n Allowed file extentions are : \n .jpg, .jpeg, .png, .bmp, .gif, .tif';
                throw (err);
                return false;
            }

            // Note
            // when user select an image with size greater than 4MB the fileupload throw an error
            //so you should handle that exeption otherwise fileupload wouldn't work correctly
            // till now i don't khnow how to do that

        }
        function ClientUploadComplete(sender, args) {
            if (parseInt(args.get_length()) > 3145728) {
                $get("<%=lblSuccess.ClientID %>").innerHTML = "";
                $get("<%=lblError.ClientID%>").innerHTML = "Image size should not be greater than 3MB";
                return;
            }
            $get("<%=lblSuccess.ClientID %>").innerHTML = "Image uploaded successfully"
            //$('#btnImageSave').attr('disabled', false);
            __doPostBack('btnImageSave', '');
        }
        function OnClientError(sender, args) {
            //document.getElementById('AsyncFileUpload1_ctl00').value = "";
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        }
        function ClearContents() {
            var AsyncFileUpload = $get("<%=AsyncFileUpload1.ClientID%>");
            var txts = AsyncFileUpload.getElementsByTagName("input");
            for (var i = 0; i < txts.length; i++) {
                if (txts[i].type == "file") {
                    txts[i].form.reset();
                    //txts[i].style.backgroundColor = "transparent";
                }
            }
        }
        //#endregion Other Functions
    </script>
</head>
<body class='<%= this.UserTheme%>'>
    <form id="form1" runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" EnablePartialRendering="true"
            CombineScripts="false" />
        <asp:Button ID="btnDefault" runat="server" OnClientClick="return false;" CssClass="hide" />
        <div id="navigation" class="navbar-fixed-top">
            <!-- Header -->
            <div class="container-fluid">
                <a id="brand">Umbrella</a> <a href="#" class="toggle-nav" rel="tooltip" data-placement="bottom"
                    title="Toggle navigation"><i class="icon-reorder"></i></a>
                <ul class='main-nav'>
                    <li><a href="Home.aspx" target="_blank"><span>Home</span> </a></li>
                    <li class='active'><a href="GeneralClinic.aspx"><span>General Clinic_ud</span> </a>
                    </li>
                </ul>
                <div class="user">
                    <div class="dropdown">
                        <a href="#" class='dropdown-toggle' data-toggle="dropdown">
                            <asp:Label ID="lblUserName" Text="Moustafa Ebrahem" runat="server" />
                            <img src="img/demo/user-img-s.png" alt="" /></a>
                        <ul class="dropdown-menu pull-right">
                            <li><a href="AccountSettings.aspx" target="_blank">Account Settings</a></li>
                            <li>
                                <asp:LinkButton ID="lbSignOut" runat="server" OnClick="lbSignOut_Click">Sign Out</asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- End of Header -->
        </div>
        <style>
        </style>
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid body-style">
                    <div class="row-fluid wrapper row-offcanvas row-offcanvas-left">
                        <div id="divPatInfo" class="right-side sidebar-offcanvas ">
                            <div id="wl" class="sidebar box box-bordered box-color">
                                <asp:UpdatePanel ID="upPatients_udInfo" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <div class="box-title">
                                            <h3>
                                                <i class="icon-pushpin" title="Patient Information"></i>Info.
                                            </h3>
                                            <div class="actions">
                                                <a id="aWlRefresh" title="Refresh Waiting List" class="btn btn-mini"><i class="icon-refresh"></i></a><a id="aSrchPatients_ud" title="Search Patients_ud" class="btn btn-mini"><i class="icon-search"></i></a><a title="Collapse Menu" class="btn btn-mini" data-toggle="collapse" data-target=".wl">
                                                    <i class="icon-sort"></i></a>
                                                <asp:Button ID="btnWlRefresh" runat="server" OnClick="btnWlRefresh_Click" CssClass="hide" />
                                                <asp:Button ID="btnLoadPatInfo" runat="server" OnClick="btnLoadPatInfo_Click" CssClass="hide" />
                                                <asp:HiddenField ID="hfPatId" runat="server" ClientIDMode="Static" Value="" />
                                                <asp:HiddenField ID="hfWlSelected" runat="server" ClientIDMode="Static" Value="0" />
                                                <asp:HiddenField ID="hfPatCount" runat="server" ClientIDMode="Static" Value="0" />
                                            </div>
                                        </div>
                                        <div id="Patients_udtbl" class="box-content nopadding wl in collapse" style="background-color: #eee;">
                                            <div class="leftside_control_bg">
                                                <label title="Waiting List">
                                                    Waiting-List:</label>
                                                <div class="ls_control_bg">
                                                    <asp:DropDownList ID="drpWaitingList" runat="server"
                                                        ToolTip="Waiting List" AutoPostBack="true" OnSelectedIndexChanged="drpWaitingList_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="leftside_control_bg">
                                                <label title="Patient ID">
                                                    ID:</label>
                                                <div class="ls_control_bg">
                                                    <input id="txtPatId" runat="server" type="text" class="input-small" autocomplete="off"
                                                        disabled="disabled" title="Patient ID" />
                                                </div>
                                            </div>
                                            <div class="leftside_control_bg">
                                                <label title="Patient Name">
                                                    Patient-Name:</label>
                                                <div class="ls_control_bg">
                                                    <asp:TextBox ID="txtPatName" runat="server" TextMode="multiline" class="input-medium"
                                                        disabled="disabled" ToolTip="Patient Name" />
                                                </div>
                                            </div>
                                            <div class="leftside_control_bg">
                                                <label title="Patient Age">
                                                    Age:</label>
                                                <div class="ls_control_bg">
                                                    <input id="txtPatAge" runat="server" type="text" class="input-small" autocomplete="off"
                                                        title="Patient Age" disabled="disabled" />
                                                </div>
                                            </div>
                                            <div class="leftside_control_bg">
                                                <label title="Patient Gender">
                                                    Gender:</label>
                                                <div class="ls_control_bg">
                                                    <select id="drpPatGender" runat="server" class="input-small" disabled="disabled"
                                                        title="Patient Gender" style="height: 27px">
                                                        <option value="m">Male</option>
                                                        <option value="f">Female</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="leftside_control_bg">
                                                <label title="Marital Status">
                                                    Marital:</label>
                                                <div class="ls_control_bg">
                                                    <select id="drpPatMarital" runat="server" class='input-small' disabled="disabled"
                                                        title="Marital Status" style="height: 27px">
                                                        <option value="1">Single</option>
                                                        <option value="2">Engaged</option>
                                                        <option value="3">Married</option>
                                                        <option value="4">Divorced</option>
                                                        <option value="5">Widower</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="leftside_control_bg">
                                                <label title="Blood Group">
                                                    Blood:</label>
                                                <div class="ls_control_bg">
                                                    <select id="drpPatBlood" runat="server" class="input-small" disabled="disabled" style="height: 27px"
                                                        title="Blood Group">
                                                        <option value="1">A+</option>
                                                        <option value="2">B+</option>
                                                        <option value="3">AB+</option>
                                                        <option value="4">O+</option>
                                                        <option value="5">A-</option>
                                                        <option value="6">B-</option>
                                                        <option value="7">AB-</option>
                                                        <option value="8">O-</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="leftside_control_bg">
                                                <label title="Smoker ?">
                                                    Smoker:</label>
                                                <div class="ls_control_bg">
                                                    <select id="drpPatSmoker" runat="server" class="input-small" disabled="disabled"
                                                        title="Smoker ?" style="height: 27px">
                                                        <option value="0">No</option>
                                                        <option value="1">Yes</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="leftside_control_bg">
                                                <label title="Has DM ?">
                                                    DM:</label>
                                                <div class="ls_control_bg">
                                                    <select id="drpPatDm" runat="server" class="input-small" disabled="disabled" style="height: 27px"
                                                        title="Has DM ?">
                                                        <option value="0">No</option>
                                                        <option value="1">Yes</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="leftside_control_bg">
                                                <label title="Has HTN ?">
                                                    HTN:</label>
                                                <div class="ls_control_bg">
                                                    <select id="drpPatHtn" runat="server" class="input-small" disabled="disabled" style="height: 27px"
                                                        title="Has HTN ?">
                                                        <option value="0">No</option>
                                                        <option value="1">Yes</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <div id="Clinic_ud" class="left-side s">
                            <div class="box box-color">
                                <div class="box-title">
                                    <h3>
                                        <i class="icon-hospital" title="General Clinic_ud"></i>General Clinic_ud
                                    </h3>
                                    <div class="actions" style="float: left;">
                                        &nbsp;<a title="Toggle information tab" class="aWl btn btn-mini sidebar-toggle" data-toggle="offcanvas" role="button"><i class="icon-bolt"></i></a>
                                    </div>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" title="Patients_ud Visits">Patients_ud
                                        Visits</a> </li>
                                        <li><a href="#t2" data-toggle="tab" title="Current Visit">Current Visit</a> </li>
                                        <li><a href="#t3" data-toggle="tab" title="Past History">Past History</a> </li>
                                    </ul>
                                </div>
                                <div id="divGeneral">
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3>
                                                            <i class=" icon-stethoscope" title="Patients_ud Visits"></i>Patients_ud Visits</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upPatientsVisits" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblPatientsVisits" class="span12">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" title="Actions">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <asp:Button ID="btnVisitFinish" Text="Finish" runat="server" CssClass="btn btn-grey"
                                                                                Width="70px" OnClick="btnVisitFinish_Click" CommandArgument="save" ToolTip="Finishing Visit" />
                                                                            <asp:Button ID="btnVisitDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                Width="70px" OnClick="btnVisitDelete_Click" CommandArgument="delete" ToolTip="Deleting Visit" />
                                                                            <asp:Button ID="btnVisitPrint" runat="server" Text="Print" CssClass="btn btn-satblue"
                                                                                Width="70px" CommandArgument="print" ToolTip="Print Visit Summary - A5 Paper Size" />

                                                                            <img id="imgLoading" src="img/loading.gif" alt="Loadind" width="30" height="30" />
                                                                            <div class="div_search_box">
                                                                                <div class="input-append input-prepend">
                                                                                    <span class="add-on">
                                                                                        <li class="icon-search" title="Search Visits"></li>
                                                                                    </span>
                                                                                    <input id="txtSrchgvPatientsVisits" type="text" value="" class="input-large" placeholder="Search By Visit Date..."
                                                                                        autocomplete="off" title="Search By Visit Date" />
                                                                                </div>
                                                                                <select id="drpSrchSrchgvPatientsVisits" runat="server" class="input-medium" title="Visit Status">
                                                                                    <option value="">Status - All</option>
                                                                                    <option value="New">New</option>
                                                                                    <option value="Pending">Pending</option>
                                                                                    <option value="Finished">Finished</option>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <%--<div class="control-group">
                                                                        <label for="textfield" class="control-label" title="Actions">
                                                                            Services:</label>
                                                                        <div class="controls">
                                                                            <asp:ListBox ID="lbServices" runat="server" CssClass="input-block-level" SelectionMode="Multiple"
                                                                                ToolTip="Services">
                                                                                <asp:ListItem Text="حشو عصب" />
                                                                                <asp:ListItem Text="حشو عادي" />
                                                                                <asp:ListItem Text="تنظيف dfsdfsd" />
                                                                                <asp:ListItem Text="تنظيف ddddddddd" />
                                                                                <asp:ListItem Text="تنظيف ddddddddddddddddddddd" />
                                                                            </asp:ListBox>
                                                                        </div>
                                                                    </div>--%>
                                                                </div>

                                                                <div class="span12">
                                                                    <asp:HiddenField ID="hfVisitId" runat="server" ClientIDMode="Static" Value="" />
                                                                    <asp:HiddenField ID="hfVisitFinish" runat="server" ClientIDMode="Static" Value="" />
                                                                    <asp:HiddenField ID="hfVisitDelete" runat="server" ClientIDMode="Static" Value="" />
                                                                    <div class="scroll scrollclc">
                                                                        <asp:GridView ID="gvPatientsVisits" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                            EmptyDataText="No Results Found">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="pat_visit_id" HeaderText="V.ID" />
                                                                                <asp:BoundField DataField="pat_id" HeaderText="pat_id" HeaderStyle-CssClass="hide"
                                                                                    ItemStyle-CssClass="hide" />
                                                                                <asp:BoundField DataField="pat_visit_date" HeaderText="Date" />
                                                                                <asp:BoundField DataField="pat_visit_time" HeaderText="Time" />
                                                                                <asp:BoundField DataField="exam_full" HeaderText="Exam" />
                                                                                <asp:BoundField DataField="viacompany" HeaderText="ViaC." />
                                                                                <asp:BoundField DataField="company_name" HeaderText="Company" />
                                                                                <asp:BoundField DataField="contract_id" HeaderText="Cont.ID" />
                                                                                <asp:BoundField DataField="contract_discount" HeaderText="Dis. %" />
                                                                                <asp:BoundField DataField="paid_status" HeaderText="Paid" />
                                                                                <asp:BoundField DataField="transact_amount" HeaderText="Amount" />
                                                                                <asp:BoundField DataField="visit_status" HeaderText="V.Status" />
                                                                                <asp:BoundField DataField="user_name" HeaderText="User" />

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
                                            <br />
                                        </div>
                                        <div id="t2" class="tab-pane">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3>
                                                            <i class="glyphicon-paperclip" title="Current Visit"></i>Current Visit</h3>
                                                        <ul class="tabs">
                                                            <li class="active"><a href="#t4" data-toggle="tab" title="Vital Signs">Vital Signs</a>
                                                            </li>
                                                            <li><a href="#t5" data-toggle="tab" title="Complaints & Diagnosis_ud">Complaints & Diagnosis_ud</a>
                                                            </li>
                                                            <li><a href="#t6" data-toggle="tab" title="Prescriptions">Prescriptions</a> </li>
                                                            <li><a href="#t7" data-toggle="tab" title="Requests">Requests</a> </li>
                                                        </ul>
                                                    </div>
                                                    <div class="box-content nopadding">
                                                        <div class="tab-content">
                                                            <asp:UpdatePanel ID="VisitView" runat="server" UpdateMode="Conditional">
                                                                <ContentTemplate>
                                                                    <asp:Button ID="btnVisitView" Text="View" runat="server" CssClass="hide" Width="70px"
                                                                        OnClick="btnVisitView_Click" OnClientClick="this.disabled = true; this.value = 'Loadind';"
                                                                        UseSubmitBehavior="false" />
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                            <div id="t4" class="tab-pane active">
                                                                <asp:UpdatePanel ID="upVitslSigns" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Actions">
                                                                                Actions:</label>
                                                                            <div class="controls">
                                                                                &nbsp;<asp:Button ID="btnVitalSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                    ToolTip="Save Vital Signs" Width="70px" ValidationGroup="v" OnClientClick="if (!Page_ClientValidate('v')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                    UseSubmitBehavior="false" OnClick="btnVitalSave_Click" CommandArgument="save" />
                                                                                <asp:Button ID="btnVitalPrint" runat="server" Text="Print" CssClass="btn btn-satblue"
                                                                                    Width="70px" CommandArgument="print" ToolTip="Print Vital Signs - A5 Paper Size" />
                                                                            </div>
                                                                        </div>
                                                                        <div id="tblVital">
                                                                            <div class="span6">
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Weight in kg">
                                                                                        Weight:</label>
                                                                                    <div class="controls">
                                                                                        <div class="input-append">
                                                                                            <input id="txtVitalWeight" runat="server" type="text" placeholder="Weight in kg"
                                                                                                class="input-large" maxlength="7" autocomplete="off" title="Weight in kg" />
                                                                                            <span class="add-on">KG</span>
                                                                                        </div>
                                                                                        <asp:RegularExpressionValidator ID="retxtVitalWeight" runat="server" ControlToValidate="txtVitalWeight"
                                                                                            ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                            ValidationExpression="^\s*\d{0,3}([\.,]\d{1,2})?\s*$" ValidationGroup="v"></asp:RegularExpressionValidator>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Height in cm">
                                                                                        Height:</label>
                                                                                    <div class="controls">
                                                                                        <div class="input-append">
                                                                                            <input id="txtVitalHeight" runat="server" type="text" placeholder="Height in cm"
                                                                                                class="input-large" maxlength="7" autocomplete="off" title="Height in cm" />
                                                                                            <span class="add-on">CM</span>
                                                                                        </div>
                                                                                        <asp:RegularExpressionValidator ID="retxtVitalHeight" runat="server" ControlToValidate="txtVitalHeight"
                                                                                            ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                            ValidationExpression="^\s*\d{0,3}([\.,]\d{1,2})?\s*$" ValidationGroup="v"></asp:RegularExpressionValidator>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Temperature in °C">
                                                                                        Temp:</label>
                                                                                    <div class="controls">
                                                                                        <div class="input-append">
                                                                                            <input id="txtVitalTemp" runat="server" type="text" placeholder="Temperature in °C"
                                                                                                class="input-large" maxlength="7" autocomplete="off" title="Temperature in °C" />
                                                                                            <span class="add-on">°C</span>
                                                                                        </div>
                                                                                        <asp:RegularExpressionValidator ID="retxtVitalTemp" runat="server" ControlToValidate="txtVitalTemp"
                                                                                            ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                            ValidationExpression="^\s*\d{0,3}([\.,]\d{1,2})?\s*$" ValidationGroup="v"></asp:RegularExpressionValidator>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Pulse Rate in minutes - BPM">
                                                                                        Pulse:</label>
                                                                                    <div class="controls">
                                                                                        <div class="input-append">
                                                                                            <input id="txtVitalPulse" runat="server" type="text" placeholder="Pulse Rate in minutes"
                                                                                                class="input-large" maxlength="10" autocomplete="off" title="Pulse Rate in minutes - BPM" />
                                                                                            <span class="add-on">BPM</span>
                                                                                        </div>
                                                                                        <asp:RegularExpressionValidator ID="retxtVitalPulse" runat="server" ControlToValidate="txtVitalPulse"
                                                                                            ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                            ValidationExpression="(\s*[0-9]|[\-/])+\s*" ValidationGroup="v"></asp:RegularExpressionValidator>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Respiratory Rate in minutes - BPM">
                                                                                        Respiratory:</label>
                                                                                    <div class="controls">
                                                                                        <div class="input-append">
                                                                                            <input id="txtVitalRespiratory" runat="server" type="text" placeholder="Respiratory Rate in minutes"
                                                                                                class="input-large" maxlength="10" autocomplete="off" title="Respiratory Rate in minutes - BPM" />
                                                                                            <span class="add-on">BPM</span>
                                                                                        </div>
                                                                                        <asp:RegularExpressionValidator ID="retxtVitalRespiratory" runat="server" ControlToValidate="txtVitalRespiratory"
                                                                                            ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                            ValidationExpression="(\s*[0-9]|[\-/])+\s*" ValidationGroup="v"></asp:RegularExpressionValidator>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Blood Pressure in mmHg">
                                                                                        Blood:</label>
                                                                                    <div class="controls">
                                                                                        <div class="input-append">
                                                                                            <input id="txtVitalBlood" runat="server" type="text" placeholder="Blood Pressure"
                                                                                                class="input-large" maxlength="10" autocomplete="off" title="Blood Pressure in mmHg" />
                                                                                            <span class="add-on">mmHg</span>
                                                                                        </div>
                                                                                        <asp:RegularExpressionValidator ID="retxtVitalBlood" runat="server" ControlToValidate="txtVitalBlood"
                                                                                            ErrorMessage="*Error" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                            ValidationExpression="(\s*[0-9]|[\-/])+\s*" ValidationGroup="v"></asp:RegularExpressionValidator>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="span6">
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Pupil State">
                                                                                        Pupil:</label>
                                                                                    <div class="controls">
                                                                                        <select id="drpVitalPupil" runat="server" class="input-large" title="Pupil State">
                                                                                            <option value="1">Ordinary</option>
                                                                                            <option value="2">Mydriasis</option>
                                                                                            <option value="3">Miosis</option>
                                                                                            <option value="4">Anisocoria</option>
                                                                                            <option value="5">Heterochromia</option>
                                                                                            <option value="6">Plosis</option>
                                                                                            <option value="7">Exophthalmos</option>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Skin Color">
                                                                                        Skin-Color:</label>
                                                                                    <div class="controls">
                                                                                        <select id="drpVitalSkin" runat="server" class="input-large" title="Skin Color">
                                                                                            <option value="1">Ordinary</option>
                                                                                            <option value="2">Pallor</option>
                                                                                            <option value="3">Yellow</option>
                                                                                            <option value="4">Cyanosis</option>
                                                                                            <option value="5">Red</option>
                                                                                            <option value="6">Albinism</option>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Notes">
                                                                                        Notes:</label>
                                                                                    <div class="controls">
                                                                                        <textarea id="txtVitalNotes" rows="9" runat="server" placeholder="Notes" class="input-xlarge"
                                                                                            maxlength="500" autocomplete="off" title="Notes" />
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </div>
                                                            <div id="t5" class="tab-pane">
                                                                <asp:UpdatePanel ID="upComplaintDiagnosis_ud" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div class="control-group">
                                                                            <label for="textfield" class="control-label" title="Actions">
                                                                                Actions:</label>
                                                                            <div class="controls">
                                                                                &nbsp;<asp:Button ID="btnComplaintDiagnosis_udSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                    ToolTip="Save Complaints & Diagnosis_ud" Width="70px" ValidationGroup="m" OnClientClick="if (!Page_ClientValidate('m')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                    UseSubmitBehavior="false" OnClick="btnComplaintDiagnosis_udSave_Click" CommandArgument="save" />
                                                                                <asp:Button ID="btnComplaintDiagnosis_udPrint" runat="server" Text="Print" CssClass="btn btn-satblue"
                                                                                    Width="70px" CommandArgument="print" ToolTip="Print Complaints & Diagnosis_ud - A5 Paper Size" />
                                                                            </div>
                                                                        </div>
                                                                        <div id="tblComplaintDiagnosis_ud">
                                                                            <div class="span12">
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Patient's Complaint">
                                                                                        Complaint:</label>
                                                                                    <div class="controls">
                                                                                        <textarea id="txtComplaintName" runat="server" rows="4" placeholder="Patient's Complaint"
                                                                                            class="input-block-level" maxlength="150" autocomplete="off" title="Patient's Complaint" />
                                                                                        <asp:RequiredFieldValidator ID="rvtxtComplaintName" runat="server" ControlToValidate="txtComplaintName"
                                                                                            Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                            ValidationGroup="m"></asp:RequiredFieldValidator>
                                                                                    </div>
                                                                                </div>
                                                                                    <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Diagnosis_ud">
                                                                                        Diagnosis_ud:</label>
                                                                                    <div class="controls">
                                                                                        <asp:ListBox ID="lbDiagnosis_ud" runat="server" CssClass="input-block-level" SelectionMode="Multiple"
                                                                                            ToolTip="Diagnosis_ud"></asp:ListBox>
                                                                                        <asp:RequiredFieldValidator ID="rvlbDiagnosis_ud" runat="server" ControlToValidate="lbDiagnosis_ud"
                                                                                            Display="Dynamic" ValidationGroup="m" ErrorMessage="*Required" ForeColor="#CC0000"
                                                                                            SetFocusOnError="True" InitialValue=""></asp:RequiredFieldValidator>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Doctor's Notes">
                                                                                        Notes:</label>
                                                                                    <div class="controls">
                                                                                        <textarea id="txtComplaintNote" runat="server" rows="10" placeholder="Doctor's Notes"
                                                                                            class="input-block-level" autocomplete="off" title="Doctor's Notes" />
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </div>
                                                            <div id="t6" class="tab-pane">
                                                                <div class="span5">
                                                                    <asp:UpdatePanel ID="upMedicines_ud" runat="server" UpdateMode="Conditional">
                                                                        <ContentTemplate>
                                                                            <div class="input-append input-prepend">
                                                                                <span class="add-on">
                                                                                    <li class="icon-search" title="Search Medicines_ud"></li>
                                                                                </span>
                                                                            </div>
                                                                            <select id="drpSrchgvMedicines_udCommon" runat="server" class="input-small" title="Medicines_ud Commonly used">
                                                                                <option value="1">Common</option>
                                                                                <option value="">All</option>
                                                                            </select>
                                                                            <input id="txtSrchgvMedicines_ud" runat="server" type="text" value="" class="input-medium"
                                                                                placeholder="Medicine Name" autocomplete="off" maxlength="20" title="Search By Medicine Name" />
                                                                            <asp:Button ID="btnMedicines_udSrch" runat="server" Text="Search" CssClass="btn btn-primary"
                                                                                Width="80px" OnClick="btnMedicines_udSrch_Click" OnClientClick="this.disabled = true; this.value = 'Searching';"
                                                                                UseSubmitBehavior="false" ToolTip="Search Medicines_ud" />
                                                                            <div class="scroll scrollbig2">
                                                                                <asp:GridView ID="gvMedicines_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                                    EmptyDataText="No Results Found" AllowPaging="true" PageSize="10" OnPageIndexChanging="gvMedicines_ud_PageIndexChanging">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="medicine_id" HeaderText="ID" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="medicine_name" HeaderText="Medicine Name" />
                                                                                    </Columns>
                                                                                    <PagerSettings Mode="NumericFirstLast" />
                                                                                    <PagerStyle CssClass="gvpagination" />
                                                                                    <HeaderStyle CssClass="gvgray" />
                                                                                    <RowStyle CssClass="blue2 gvrow" />
                                                                                    <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                                    <EmptyDataRowStyle CssClass="gvempty" />
                                                                                </asp:GridView>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                    </asp:UpdatePanel>
                                                                </div>
                                                                <div class="span7">
                                                                    <asp:UpdatePanel ID="upPrescription" runat="server" UpdateMode="Conditional">
                                                                        <ContentTemplate>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    <input type="button" id="btnPrescriptionNew" value="New" class="btn btn-grey" style="width: 70px"
                                                                                        title="New Record" />
                                                                                    <asp:Button ID="btnPrescriptionSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                        Width="70px" OnClientClick="this.disabled = true; this.value = 'Saving';" UseSubmitBehavior="false"
                                                                                        OnClick="btnPrescriptionSave_Click" CommandArgument="save" ToolTip="Save Record" />
                                                                                    <asp:Button ID="btnPrescriptionUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                        Width="70px" OnClientClick="this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnPrescriptionDelete')!= null){document.getElementById('btnPrescriptionDelete').disabled=true;}"
                                                                                        UseSubmitBehavior="false" OnClick="btnPrescriptionUpdate_Click" CommandArgument="update"
                                                                                        ToolTip="Update Record" />
                                                                                    <asp:Button ID="btnPrescriptionDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                        Width="70px" OnClick="btnPrescriptionDelete_Click" CommandArgument="delete" ToolTip="Delete Record" />
                                                                                    <asp:Button ID="btnPrescriptionPrint" runat="server" Text="Print" CssClass="btn btn-satblue"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Prescription - A5 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div id="tblPrescription">
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Medicine Name">
                                                                                        Medicine:</label>
                                                                                    <div class="controls">
                                                                                        <asp:HiddenField ID="hfPresciptionDetId" runat="server" ClientIDMode="Static" Value="" />
                                                                                        <asp:HiddenField ID="hfPrescriptionMedId" runat="server" ClientIDMode="Static" Value="" />
                                                                                        <input id="txtPrescriptionMedName" runat="server" type="text" placeholder="Medicine Name"
                                                                                            class="input-xlarge" maxlength="100" autocomplete="off" disabled="disabled" title="Medicine Name" />
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Dose">
                                                                                        Dose:</label>
                                                                                    <div class="controls">
                                                                                        <select id="drpPrescriptonDose" runat="server" class="input-xlarge" title="Dose">
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="control-group">
                                                                                    <label for="textfield" class="control-label" title="Note">
                                                                                        Note:</label>
                                                                                    <div class="controls">
                                                                                        <input id="txtPrescriptionNote" runat="server" type="text" placeholder="Note" class="input-xlarge"
                                                                                            maxlength="50" autocomplete="off" title="Note" />
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="scroll scrollsmall2">
                                                                                <asp:GridView ID="gvPrescription" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                                    EmptyDataText="No Results Found" AllowPaging="false">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="pat_prescription_det_id" HeaderText="pat_prescription_det_id"
                                                                                            HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_prescription_id" HeaderText="pat_prescription_id"
                                                                                            HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="medicine_id" HeaderText="ID" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="medicine_name" HeaderText="Medicine Name" />
                                                                                        <asp:BoundField DataField="dose_id" HeaderText="dose_id" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="dose_name" HeaderText="Dose" />
                                                                                        <asp:BoundField DataField="note" HeaderText="Note" />
                                                                                    </Columns>
                                                                                    <HeaderStyle CssClass="gvgray" />
                                                                                    <RowStyle CssClass="blue2 gvrow" />
                                                                                    <SelectedRowStyle CssClass="blue3 gvrow" />
                                                                                    <EmptyDataRowStyle CssClass="gvempty" />
                                                                                </asp:GridView>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                    </asp:UpdatePanel>
                                                                </div>
                                                            </div>
                                                            <div id="t7" class="tab-pane">
                                                                <asp:UpdatePanel ID="upRequests" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div class="span6">
                                                                            <div class="control-group">
                                                                                <div class="controls">
                                                                                    <h4>Blood Tests</h4>
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    &nbsp;<asp:Button ID="btnRequestBloodSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                        ToolTip="Save Blood Tests" Width="70px" ValidationGroup="b" OnClientClick="if (!Page_ClientValidate('b')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                        UseSubmitBehavior="false" OnClick="btnRequestBloodSave_Click" CommandArgument="save" />
                                                                                    <asp:Button ID="btnRequestBloodPrint" runat="server" Text="Print" CssClass="btn btn-satblue btnRequestPrint"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Requests - A5 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Blood Test">
                                                                                    Blood:</label>
                                                                                <div class="controls">
                                                                                    <asp:ListBox ID="lbRequestBlood" runat="server" CssClass="input-xlarge" SelectionMode="Multiple"
                                                                                        ToolTip="Blood Test"></asp:ListBox>
                                                                                    <asp:RequiredFieldValidator ID="rvlbRequestBlood" runat="server" ControlToValidate="lbRequestBlood"
                                                                                        Display="Dynamic" ValidationGroup="b" ErrorMessage="*Required" ForeColor="#CC0000"
                                                                                        SetFocusOnError="True" InitialValue=""></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="span6">
                                                                            <div class="control-group">
                                                                                <div class="controls">
                                                                                    <h4>Scans</h4>
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    &nbsp;<asp:Button ID="btnRequestScanSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                        ToolTip="Save Scans" Width="70px" ValidationGroup="n" OnClientClick="if (!Page_ClientValidate('n')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                        UseSubmitBehavior="false" OnClick="btnRequestScanSave_Click" CommandArgument="save" />
                                                                                    <asp:Button ID="btnRequestScanPrint" runat="server" Text="Print" CssClass="btn btn-satblue btnRequestPrint"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Requests - A5 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Scans">
                                                                                    Scans:</label>
                                                                                <div class="controls">
                                                                                    <asp:ListBox ID="lbRequestScan" runat="server" CssClass="input-xlarge" SelectionMode="Multiple"
                                                                                        ToolTip="Scans"></asp:ListBox>
                                                                                    <asp:RequiredFieldValidator ID="rvlbRequestScan" runat="server" ControlToValidate="lbRequestScan"
                                                                                        Display="Dynamic" ValidationGroup="n" ErrorMessage="*Required" ForeColor="#CC0000"
                                                                                        SetFocusOnError="True" InitialValue=""></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br />
                                                </div>
                                                <br />
                                            </div>
                                        </div>
                                        <div id="t3" class="tab-pane">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3>
                                                            <i class="glyphicon-adress_book" title="Past History"></i>Past History</h3>
                                                        <ul class="tabs">
                                                            <li class="active"><a href="#t8" data-toggle="tab" title="Family History">Family History</a>
                                                            </li>
                                                            <li><a href="#t9" data-toggle="tab" title="Chronic Diseases">Chronic Diseases</a>
                                                            </li>
                                                            <li><a href="#t10" data-toggle="tab" title="Drugs">Drugs</a> </li>
                                                            <li><a href="#t11" data-toggle="tab" title="Surgeries">Surgeries</a> </li>
                                                            <li><a href="#t12" data-toggle="tab" title="Transfusion">Transfusion</a> </li>
                                                            <li><a href="#t13" data-toggle="tab" title="Hospital Admission">Hospital Admission</a>
                                                            </li>
                                                            <li><a href="#t14" data-toggle="tab" title="Images">Images</a> </li>
                                                        </ul>
                                                    </div>
                                                    <div class="box-content nopadding">
                                                        <div class="tab-content">
                                                            <div id="t8" class="tab-pane active">
                                                                <asp:UpdatePanel ID="upFamilyHistory" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div id="tblFamily" class="span6">
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    <input type="button" id="btnFamilyNew" value="New" class="btn btn-grey" style="width: 70px"
                                                                                        title="New Record" />
                                                                                    <asp:Button ID="btnFamilySave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                        ToolTip="Save Record" Width="70px" ValidationGroup="f" OnClientClick="if (!Page_ClientValidate('f')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                        UseSubmitBehavior="false" OnClick="btnFamilySave_Click" CommandArgument="save" />
                                                                                    <asp:Button ID="btnFamilyUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                        ToolTip="Update Record" Width="70px" ValidationGroup="f" OnClientClick="if (!Page_ClientValidate('f')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnFamilyDelete')!= null){document.getElementById('btnFamilyDelete').disabled=true;}"
                                                                                        UseSubmitBehavior="false" OnClick="btnFamilyUpdate_Click" CommandArgument="update" />
                                                                                    <asp:Button ID="btnFamilyDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                        Width="70px" OnClick="btnFamilyDelete_Click" CommandArgument="delete" ToolTip="Delete Record" />
                                                                                    <asp:Button ID="btnFamilyPrint" runat="server" Text="Print" CssClass="btn btn-satblue fhPrint"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Family History - A4 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Disease ID">
                                                                                    ID:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtFamilyId" runat="server" type="text" placeholder="Disease ID" class="input-xlarge"
                                                                                        disabled="disabled" title="Disease ID" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Relationship">
                                                                                    Relationship:</label>
                                                                                <div class="controls">
                                                                                    <select id="drpFamilyRelationship" runat="server" class="input-xlarge" title="Relationship">
                                                                                        <option value="1">Father</option>
                                                                                        <option value="2">Mother</option>
                                                                                        <option value="3">Son</option>
                                                                                        <option value="4">Daughter</option>
                                                                                        <option value="5">Brother</option>
                                                                                        <option value="6">Sister</option>
                                                                                        <option value="7">Uncle</option>
                                                                                        <option value="8">Aunt</option>
                                                                                        <option value="9">Nephew</option>
                                                                                        <option value="10">Niece</option>
                                                                                        <option value="11">Cousin</option>
                                                                                        <option value="12">Grandfather</option>
                                                                                        <option value="13">Grandmother</option>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Disease Name">
                                                                                    Disease:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtFamilyDiseaseName" runat="server" type="text" placeholder="Disease Name"
                                                                                        title="Disease Name" class="input-xlarge" maxlength="50" autocomplete="off" validationgroup="f" />
                                                                                    <asp:RequiredFieldValidator ID="rvtxtFamilyDiseaseName" runat="server" ControlToValidate="txtFamilyDiseaseName"
                                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                        ValidationGroup="f"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="span1">
                                                                        </div>
                                                                        <div class="span6">
                                                                            <div class="input-append input-prepend">
                                                                                <span class="add-on">
                                                                                    <li class="icon-search" title="Search Family History"></li>
                                                                                </span>
                                                                                <input id="txtSrchgvFamily" type="text" value="" class="input-xlarge" placeholder="Search By Disease Name..."
                                                                                    autocomplete="off" title="Search By Disease Name" />
                                                                            </div>
                                                                            <div class="scroll scrollclc">
                                                                                <asp:GridView ID="gvFamily" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                                    EmptyDataText="No Results Found">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="pat_family_id" HeaderText="ID" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_id" HeaderText="pat_id" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="relationship" HeaderText="Relationship" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_family_disease_name" HeaderText="Disease Name" />
                                                                                        <asp:BoundField DataField="rel_name" HeaderText="Relationship" />
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
                                                            <div id="t9" class="tab-pane">
                                                                <asp:UpdatePanel ID="upChronicDiseases" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div id="tblChronic" class="span6">
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    <input type="button" id="btnChronicNew" value="New" class="btn btn-grey" style="width: 70px"
                                                                                        title="New Record" />
                                                                                    <asp:Button ID="btnChronicSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                        Width="70px" ValidationGroup="c" OnClientClick="if (!Page_ClientValidate('c')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                        UseSubmitBehavior="false" OnClick="btnChronicSave_Click" CommandArgument="save"
                                                                                        ToolTip="Save Record" />
                                                                                    <asp:Button ID="btnChronicUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                        Width="70px" ValidationGroup="c" OnClientClick="if (!Page_ClientValidate('c')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnChronicDelete')!= null){document.getElementById('btnChronicDelete').disabled=true;}"
                                                                                        UseSubmitBehavior="false" OnClick="btnChronicUpdate_Click" CommandArgument="update"
                                                                                        ToolTip="Update Record" />
                                                                                    <asp:Button ID="btnChronicDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                        Width="70px" OnClick="btnChronicDelete_Click" CommandArgument="delete" ToolTip="Delete Record" />
                                                                                    <asp:Button ID="btnChronicPrint" runat="server" Text="Print" CssClass="btn btn-satblue fhPrint"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Chronic Diseases - A4 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Chronic Disease ID">
                                                                                    ID:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtChronicId" runat="server" type="text" placeholder="Chronic Disease ID"
                                                                                        class="input-xlarge" disabled="disabled" title="Chronic Disease ID" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Chronic Disease Name">
                                                                                    Disease:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtChronicName" runat="server" type="text" placeholder="Chronic Disease Name"
                                                                                        title="Chronic Disease Name" class="input-xlarge" maxlength="50" autocomplete="off"
                                                                                        validationgroup="c" />
                                                                                    <asp:RequiredFieldValidator ID="rvtxtChronicName" runat="server" ControlToValidate="txtChronicName"
                                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                        ValidationGroup="c"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="span1">
                                                                        </div>
                                                                        <div class="span6">
                                                                            <div class="input-append input-prepend">
                                                                                <span class="add-on">
                                                                                    <li class="icon-search" title="Search Chronic Diseases"></li>
                                                                                </span>
                                                                                <input id="txtSrchgvChronic" type="text" value="" class="input-xlarge" placeholder="Search By Chronic Disease Name..."
                                                                                    autocomplete="off" title="Search By Chronic Disease Name" />
                                                                            </div>
                                                                            <div class="scroll scrollclc">
                                                                                <asp:GridView ID="gvChronic" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                                    EmptyDataText="No Results Found">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="pat_chronic_id" HeaderText="ID" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_id" HeaderText="pat_id" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_chronic_name" HeaderText="Chronic Disease Name" />
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
                                                            <div id="t10" class="tab-pane">
                                                                <asp:UpdatePanel ID="upDrug" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div id="tblDrug" class="span6">
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    <input type="button" id="btnDrugNew" value="New" class="btn btn-grey" style="width: 70px"
                                                                                        title="New Record" />
                                                                                    <asp:Button ID="btnDrugSave" Text="Save" runat="server" CssClass="btn btn-blue" Width="70px"
                                                                                        ValidationGroup="d" OnClientClick="if (!Page_ClientValidate('d')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                        UseSubmitBehavior="false" OnClick="btnDrugSave_Click" CommandArgument="save"
                                                                                        ToolTip="Save Record" />
                                                                                    <asp:Button ID="btnDrugUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                        Width="70px" ValidationGroup="d" OnClientClick="if (!Page_ClientValidate('d')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnDrugDelete')!= null){document.getElementById('btnDrugDelete').disabled=true;}"
                                                                                        UseSubmitBehavior="false" OnClick="btnDrugUpdate_Click" CommandArgument="update"
                                                                                        ToolTip="Update Record" />
                                                                                    <asp:Button ID="btnDrugDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                        Width="70px" OnClick="btnDrugDelete_Click" CommandArgument="delete" ToolTip="Delete Record" />
                                                                                    <asp:Button ID="btnDrugPrint" runat="server" Text="Print" CssClass="btn btn-satblue fhPrint"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Drugs - A4 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Drug ID">
                                                                                    ID:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtDrugId" runat="server" type="text" placeholder="Drug ID" class="input-xlarge"
                                                                                        disabled="disabled" title="Drug ID" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Drug Name">
                                                                                    Drug:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtDrugName" runat="server" type="text" placeholder="Drug Name" class="input-xlarge"
                                                                                        title="Drug Name" maxlength="50" autocomplete="off" validationgroup="d" />
                                                                                    <asp:RequiredFieldValidator ID="rvtxtDrugName" runat="server" ControlToValidate="txtDrugName"
                                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                        ValidationGroup="d"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="span1">
                                                                        </div>
                                                                        <div class="span6">
                                                                            <div class="input-append input-prepend">
                                                                                <span class="add-on">
                                                                                    <li class="icon-search" title="Search Drugs"></li>
                                                                                </span>
                                                                                <input id="txtSrchgvDrug" type="text" value="" class="input-xlarge" placeholder="Search By Drug Name..."
                                                                                    title="Search By Drug Name" autocomplete="off" />
                                                                            </div>
                                                                            <div class="scroll scrollclc">
                                                                                <asp:GridView ID="gvDrug" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                                    EmptyDataText="No Results Found">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="pat_drug_id" HeaderText="ID" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_id" HeaderText="pat_id" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_drug_name" HeaderText="Drug Name" />
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
                                                            <div id="t11" class="tab-pane">
                                                                <asp:UpdatePanel ID="upSurgery" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div id="tblSurgery" class="span6">
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    <input type="button" id="btnSurgeryNew" value="New" class="btn btn-grey" style="width: 70px"
                                                                                        title="New Record" />
                                                                                    <asp:Button ID="btnSurgerySave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                        Width="70px" ValidationGroup="s" OnClientClick="if (!Page_ClientValidate('s')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                        UseSubmitBehavior="false" OnClick="btnSurgerySave_Click" CommandArgument="save"
                                                                                        ToolTip="Save Record" />
                                                                                    <asp:Button ID="btnSurgeryUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                        Width="70px" ValidationGroup="s" OnClientClick="if (!Page_ClientValidate('s')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnSurgeryDelete')!= null){document.getElementById('btnSurgeryDelete').disabled=true;}"
                                                                                        UseSubmitBehavior="false" OnClick="btnSurgeryUpdate_Click" CommandArgument="update"
                                                                                        ToolTip="Update Record" />
                                                                                    <asp:Button ID="btnSurgeryDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                        Width="70px" OnClick="btnSurgeryDelete_Click" CommandArgument="delete" ToolTip="Delete Record" />
                                                                                    <asp:Button ID="btnSurgeryPrint" runat="server" Text="Print" CssClass="btn btn-satblue fhPrint"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Surgeries - A4 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Surgery ID">
                                                                                    ID:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtSurgeryId" runat="server" type="text" placeholder="Surgery ID" class="input-xlarge"
                                                                                        title="Surgery ID" disabled="disabled" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Surgery Name">
                                                                                    Surgery:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtSurgeryName" runat="server" type="text" placeholder="Surgery Name"
                                                                                        title="Surgery Name" class="input-xlarge" maxlength="50" autocomplete="off" validationgroup="d" />
                                                                                    <asp:RequiredFieldValidator ID="rvtxtSurgeryName" runat="server" ControlToValidate="txtSurgeryName"
                                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                        ValidationGroup="s"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label class="control-label" title="Surgery Date">
                                                                                    Date:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtSurgeryDate" runat="server" type="text" placeholder="Surgery Date"
                                                                                        title="Surgery Date" maxlength="10" autocomplete="off" name="textfield" class="input-xlarge"
                                                                                        data-date-format="dd/mm/yyyy" />
                                                                                    <asp:RequiredFieldValidator ID="rvtxtSurgeryDate" runat="server" ControlToValidate="txtSurgeryDate"
                                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                        ValidationGroup="s"></asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="retxtSurgeryDate" runat="server" ControlToValidate="txtSurgeryDate"
                                                                                        ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                                                        Display="Dynamic" ValidationGroup="s"></asp:RegularExpressionValidator>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="span1">
                                                                        </div>
                                                                        <div class="span6">
                                                                            <div class="input-append input-prepend">
                                                                                <span class="add-on">
                                                                                    <li class="icon-search" title="Search Surgeries"></li>
                                                                                </span>
                                                                                <input id="txtSrchgvSurgery" type="text" value="" class="input-xlarge" placeholder="Search By Surgery Name..."
                                                                                    title="Search By Surgery Name" autocomplete="off" />
                                                                            </div>
                                                                            <div class="scroll scrollclc">
                                                                                <asp:GridView ID="gvSurgery" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                                    EmptyDataText="No Results Found">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="pat_surgery_id" HeaderText="ID" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_id" HeaderText="pat_id" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_surgery_name" HeaderText="Surgery Name" />
                                                                                        <asp:BoundField DataField="pat_surgery_date" HeaderText="Surgery Date" />
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
                                                            <div id="t12" class="tab-pane">
                                                                <asp:UpdatePanel ID="upTransfusion" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div id="tblTransfusion" class="span6">
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    <input type="button" id="btnTransfusionNew" value="New" class="btn btn-grey" style="width: 70px"
                                                                                        title="New Record" />
                                                                                    <asp:Button ID="btnTransfusionSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                        Width="70px" ValidationGroup="t" OnClientClick="if (!Page_ClientValidate('t')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                        UseSubmitBehavior="false" OnClick="btnTransfusionSave_Click" CommandArgument="save"
                                                                                        ToolTip="Save Record" />
                                                                                    <asp:Button ID="btnTransfusionUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                        Width="70px" ValidationGroup="t" OnClientClick="if (!Page_ClientValidate('t')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnTransfusionDelete')!= null){document.getElementById('btnTransfusionDelete').disabled=true;}"
                                                                                        UseSubmitBehavior="false" OnClick="btnTransfusionUpdate_Click" CommandArgument="update"
                                                                                        ToolTip="Update Record" />
                                                                                    <asp:Button ID="btnTransfusionDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                        Width="70px" OnClick="btnTransfusionDelete_Click" CommandArgument="delete" ToolTip="Delete Record" />
                                                                                    <asp:Button ID="btnTransfusionPrint" runat="server" Text="Print" CssClass="btn btn-satblue fhPrint"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Transfusion - A4 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Transfusion ID">
                                                                                    ID:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtTransfusionId" runat="server" type="text" placeholder="Transfusion ID"
                                                                                        title="Transfusion ID" class="input-xlarge" disabled="disabled" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label class="control-label" title="Transfusion Date">
                                                                                    Date:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtTransfusionDate" runat="server" type="text" placeholder="Transfusion Date"
                                                                                        title="Transfusion Date" maxlength="10" autocomplete="off" name="textfield" class="input-xlarge"
                                                                                        data-date-format="dd/mm/yyyy" />
                                                                                    <asp:RequiredFieldValidator ID="rvtxtTransfusionDate" runat="server" ControlToValidate="txtTransfusionDate"
                                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                        ValidationGroup="t"></asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="retxtTransfusionDate" runat="server" ControlToValidate="txtTransfusionDate"
                                                                                        ErrorMessage="*Error" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"
                                                                                        Display="Dynamic" ValidationGroup="t"></asp:RegularExpressionValidator>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="span1">
                                                                        </div>
                                                                        <div class="span6">
                                                                            <div class="input-append input-prepend">
                                                                                <span class="add-on">
                                                                                    <li class="icon-search" title="Search Transfusion"></li>
                                                                                </span>
                                                                                <input id="txtSrchgvTransfusion" type="text" value="" class="input-xlarge" placeholder="Search By Transfusion Date..."
                                                                                    title="Search By Transfusion Date" autocomplete="off" />
                                                                            </div>
                                                                            <div class="scroll scrollclc">
                                                                                <asp:GridView ID="gvTransfusion" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                                    EmptyDataText="No Results Found">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="Pat_Transfusion_ud_id" HeaderText="ID" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_id" HeaderText="pat_id" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="Pat_Transfusion_ud_date" HeaderText="Transfusion Date" />
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
                                                            <div id="t13" class="tab-pane">
                                                                <asp:UpdatePanel ID="upHospital" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div id="tblHospital" class="span6">
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    <input type="button" id="btnHospitalNew" value="New" class="btn btn-grey" style="width: 70px"
                                                                                        title="New Record" />
                                                                                    <asp:Button ID="btnHospitalSave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                        Width="70px" ValidationGroup="h" OnClientClick="if (!Page_ClientValidate('h')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                        UseSubmitBehavior="false" OnClick="btnHospitalSave_Click" CommandArgument="save"
                                                                                        ToolTip="Save Record" />
                                                                                    <asp:Button ID="btnHospitalUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                        Width="70px" ValidationGroup="h" OnClientClick="if (!Page_ClientValidate('h')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnHospitalDelete')!= null){document.getElementById('btnHospitalDelete').disabled=true;}"
                                                                                        UseSubmitBehavior="false" OnClick="btnHospitalUpdate_Click" CommandArgument="update"
                                                                                        ToolTip="Update Record" />
                                                                                    <asp:Button ID="btnHospitalDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                        Width="70px" OnClick="btnHospitalDelete_Click" CommandArgument="delete" ToolTip="Delete Record" />
                                                                                    <asp:Button ID="btnHospitalPrint" runat="server" Text="Print" CssClass="btn btn-satblue fhPrint"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Hospital Admission - A4 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="ID">
                                                                                    ID:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtHospitalId" runat="server" type="text" placeholder="Reason ID" class="input-xlarge"
                                                                                        title="ID" disabled="disabled" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Reason">
                                                                                    Reason:</label>
                                                                                <div class="controls">
                                                                                    <textarea id="txtHospitalReason" runat="server" type="text" placeholder="Reason"
                                                                                        title="Reason" class="input-xlarge" rows="8" cols="5" maxlength="250" autocomplete="off"
                                                                                        validationgroup="h" />
                                                                                    <asp:RequiredFieldValidator ID="rvtxtHospitalReason" runat="server" ControlToValidate="txtHospitalReason"
                                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                        ValidationGroup="h"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="span1">
                                                                        </div>
                                                                        <div class="span6">
                                                                            <div class="input-append input-prepend">
                                                                                <span class="add-on">
                                                                                    <li class="icon-search" title="Search Hospital Admission"></li>
                                                                                </span>
                                                                                <input id="txtSrchgvHospital" type="text" value="" class="input-xlarge" placeholder="Search By Reason..."
                                                                                    title="Search By Reason" autocomplete="off" />
                                                                            </div>
                                                                            <div class="scroll scrollclc">
                                                                                <asp:GridView ID="gvHospital" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                                    EmptyDataText="No Results Found">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="pat_hospital_id" HeaderText="ID" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_id" HeaderText="pat_id" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_hospital_reason" HeaderText="Reason" />
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
                                                            <div id="t14" class="tab-pane">
                                                                <asp:UpdatePanel ID="upImage" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div id="tblImage" class="span6">
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Actions">
                                                                                    Actions:</label>
                                                                                <div class="controls">
                                                                                    <input type="button" id="btnImageNew" value="New" class="btn btn-grey" style="width: 70px"
                                                                                        title="New Image" />
                                                                                    <asp:Button ID="btnImageSave" Text="Save" runat="server" CssClass="btn btn-blue hide"
                                                                                        Width="70px" ValidationGroup="i" OnClientClick="if (!Page_ClientValidate('i')){ return false; } this.disabled = true; this.value = 'Saving';"
                                                                                        UseSubmitBehavior="false" OnClick="btnImageSave_Click" CommandArgument="save"
                                                                                        ToolTip="Save Image" />
                                                                                    <asp:Button ID="btnImageUpdate" Text="Update" runat="server" CssClass="btn btn-darkblue"
                                                                                        Width="70px" ValidationGroup="i" OnClientClick="if (!Page_ClientValidate('i')){ return false; } this.disabled = true; this.value = 'Updating'; if(document.getElementById('btnImageDelete')!= null){document.getElementById('btnImageDelete').disabled=true;}"
                                                                                        UseSubmitBehavior="false" OnClick="btnImageUpdate_Click" CommandArgument="update"
                                                                                        ToolTip="Update Image Description" />
                                                                                    <asp:Button ID="btnImageDelete" runat="server" Text="Delete" CssClass="btn btn-lightred"
                                                                                        Width="70px" OnClick="btnImageDelete_Click" CommandArgument="delete" ToolTip="Delete Image" />
                                                                                    <input id="btnImageView" type="button" value="View" class="btn btn-green" style="width: 70px"
                                                                                        title="View Images" />
                                                                                    <asp:Button ID="btnImagePrint" runat="server" Text="Print" CssClass="btn btn-satblue fhPrint"
                                                                                        Width="70px" CommandArgument="print" ToolTip="Print Images - A4 Paper Size" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Image ID">
                                                                                    ID:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtImageId" runat="server" type="text" placeholder="Image ID" class="input-xlarge"
                                                                                        title="Image ID" disabled="disabled" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Saved Date">
                                                                                    Date:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtImageDate" runat="server" type="text" placeholder="Saved Date" class="input-xlarge"
                                                                                        title="Saved Date" disabled="disabled" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Image Description">
                                                                                    Description:</label>
                                                                                <div class="controls">
                                                                                    <input id="txtImageDesc" runat="server" type="text" placeholder="Image Description"
                                                                                        class="input-xlarge" title="Image Description" maxlength="50" autocomplete="off"
                                                                                        validationgroup="i" value="" />
                                                                                    <asp:RequiredFieldValidator ID="rvtxtImageDesc" runat="server" ControlToValidate="txtImageDesc"
                                                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                        ValidationGroup="i"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                            <div class="control-group">
                                                                                <label for="textfield" class="control-label" title="Upload Image">
                                                                                    Image:</label>
                                                                                <div class="controls">
                                                                                    <asp:AsyncFileUpload runat="server" ID="AsyncFileUpload1" UploaderStyle="Modern"
                                                                                        ToolTip="Upload Image" CompleteBackColor="White" UploadingBackColor="#9dc6e8"
                                                                                        OnClientUploadStarted="OnClientStart" OnUploadedComplete="FileUploadComplete"
                                                                                        OnClientUploadComplete="ClientUploadComplete"/>
                                                                                    <br />
                                                                                    <br />
                                                                                    <asp:Label ID="lblSuccess" runat="server" Style="color: Green" Font-Bold="true" />
                                                                                    <asp:Label ID="lblError" runat="server" Style="color: Red" Font-Bold="true" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="span1">
                                                                        </div>
                                                                        <div class="span6">
                                                                            <div class="input-append input-prepend">
                                                                                <span class="add-on">
                                                                                    <li class="icon-search" title="Search Images"></li>
                                                                                </span>
                                                                                <input id="txtSrchgvImage" type="text" value="" class="input-xlarge" placeholder="Search By Description..."
                                                                                    title="Search By Description" autocomplete="off" />
                                                                            </div>
                                                                            <div class="scroll scrollclc">
                                                                                <asp:GridView ID="gvImage" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                                                    EmptyDataText="No Results Found">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="pat_img_id" HeaderText="ID" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_id" HeaderText="pat_id" HeaderStyle-CssClass="hide"
                                                                                            ItemStyle-CssClass="hide" />
                                                                                        <asp:BoundField DataField="pat_img_desc" HeaderText="Description" />
                                                                                        <asp:BoundField DataField="pat_img_date" HeaderText="Date" />
                                                                                        <asp:TemplateField HeaderText="Image">
                                                                                            <ItemTemplate>
                                                                                                <asp:Image runat="server" ImageUrl='<%# Eval("pat_img_url") %>' Width="50px" Height="50px" />
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
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
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
                        </div>
                        <div id="Patients_ud" class="span10 hide h" style="margin-left: 220px;">
                            <div class="box box-color box-bordered">
                                <div class="box-title">
                                    <h3>
                                        <i class="icon-search" title="Search Patients_ud"></i>Search Patients_ud</h3>
                                    <div class="actions" style="float: left;">
                                        &nbsp;<a title="Toggle information tab" class="aWl btn btn-mini"><i class="icon-bolt"></i></a>
                                    </div>
                                </div>
                                <div id="divSearch" class="box-content nopadding">
                                    <div class='form-horizontal'>
                                        <asp:UpdatePanel ID="upSrchPatients_ud" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <div class="span12">
                                                    <div class="input-append input-prepend">
                                                        <span class="add-on">
                                                            <li class="icon-search" title="Search Patients_ud"></li>
                                                        </span>
                                                    </div>
                                                    <select id="drpSearchgvPatients_udCol" runat="server" class="input-medium" title="Search Attribute">
                                                        <option value="0">All Patients_ud</option>
                                                        <option value="1">ID</option>
                                                        <option value="2">Name</option>
                                                        <option value="3">Birthdate</option>
                                                        <option value="4">Mobile or Phone</option>
                                                    </select>
                                                    <input id="txtSearchgvPatients_ud" runat="server" type="text" value="" class="input-large"
                                                        placeholder="Search Here..." autocomplete="off" maxlength="30" title="Search Text" />
                                                    &nbsp;<asp:Button ID="btnPatients_udSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                                                        Width="100px" ToolTip="Search Patients_ud" OnClick="btnPatients_udSearch_Click" OnClientClick="this.disabled = true; this.value = 'Searching';"
                                                        UseSubmitBehavior="false" />
                                                    &nbsp;Gender:&nbsp;
                                                <select id="drpSearchgvPatients_udGender" runat="server" class="input-small" title="Search by gender">
                                                    <option value="">All</option>
                                                    <option value="m">Male</option>
                                                    <option value="f">Female</option>
                                                </select>
                                                    &nbsp;Status:&nbsp;
                                                <select id="drpSearchgvPatients_udStatus" runat="server" class="input-small" title="Search by status">
                                                    <option value="">All</option>
                                                    <option value="1">Active</option>
                                                    <option value="0">Inactive</option>
                                                </select>
                                                    <div class="scroll scrollbig">
                                                        <asp:GridView ID="gvPatients_ud" runat="server" CssClass="tblbordered" Width="100%" AutoGenerateColumns="False"
                                                            EmptyDataText="No Results Found" AllowPaging="true" PageSize="10" OnPageIndexChanging="gvPatients_ud_PageIndexChanging">
                                                            <Columns>
                                                                <asp:BoundField DataField="pat_id" HeaderText="No." />
                                                                <asp:BoundField DataField="pat_name" HeaderText="Patient Name" />
                                                                <asp:BoundField DataField="pat_birthdate" HeaderText="Birthdate" />
                                                                <asp:BoundField DataField="pat_address" HeaderText="Address" />
                                                                <asp:BoundField DataField="pat_gender" HeaderText="Gender" />
                                                                <asp:BoundField DataField="pat_mobile" HeaderText="Mobile" />
                                                                <asp:BoundField DataField="pat_phone" HeaderText="Phone" />
                                                                <asp:BoundField DataField="pat_job" HeaderText="Job" />
                                                                <asp:BoundField DataField="marital_id" HeaderText="marital_id" HeaderStyle-CssClass="hide"
                                                                    ItemStyle-CssClass="hide" />
                                                                <asp:BoundField DataField="blood_id" HeaderText="blood_id" HeaderStyle-CssClass="hide"
                                                                    ItemStyle-CssClass="hide" />
                                                                <asp:BoundField DataField="pat_smoker" HeaderText="Smoker" HeaderStyle-CssClass="hide"
                                                                    ItemStyle-CssClass="hide" />
                                                                <asp:BoundField DataField="pat_dm" HeaderText="DM" HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide" />
                                                                <asp:BoundField DataField="pat_htn" HeaderText="HTN" HeaderStyle-CssClass="hide"
                                                                    ItemStyle-CssClass="hide" />
                                                                <asp:BoundField DataField="created_date" HeaderText="Created Date" HeaderStyle-CssClass="hide"
                                                                    ItemStyle-CssClass="hide" />
                                                                <asp:BoundField DataField="created_by" HeaderText="Created By" HeaderStyle-CssClass="hide"
                                                                    ItemStyle-CssClass="hide" />
                                                                <asp:BoundField DataField="modified_date" HeaderText="Modified Date" HeaderStyle-CssClass="hide"
                                                                    ItemStyle-CssClass="hide" />
                                                                <asp:BoundField DataField="modified_by" HeaderText="Modified By" HeaderStyle-CssClass="hide"
                                                                    ItemStyle-CssClass="hide" />
                                                                <asp:BoundField DataField="active" HeaderText="Status" HeaderStyle-CssClass="hide"
                                                                    ItemStyle-CssClass="hide" />
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
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                    </div>
                </div>

                <style>
                    .leftside_control_bg label {
                        background-color: #888;
                        padding: 10px;
                        text-align: center;
                        color: #fff;
                        font-size: 14px;
                    }

                    .leftside_control_bg .ls_control_bg input, .leftside_control_bg .ls_control_bg textarea, .leftside_control_bg .ls_control_bg select {
                        width: 195px;
                        margin-right: 5px;
                        margin-left: 5px;
                    }
                    /* Define 2 column template */
                    .right-side,
                    .left-side {
                        min-height: 100%;
                        display: block;
                    }
                    /*left side*/
                    .left-side {
                        background-color: #f9f9f9;
                        margin-left: 220px;
                    }
                    /*right side*/
                    .right-side {
                        position: absolute;
                        width: 220px;
                        top: 0;
                        left: 15px;
                    }

                    @media screen and (min-width: 992px) {
                        .right-side {
                            top: 40px;
                        }
                        /*Right side strech mode*/
                        .left-side.strech {
                            margin-left: 0;
                        }

                            .left-side.strech > .content-header {
                                margin-top: 0px;
                            }
                        /* Left side collapse */
                        .right-side.collapse-left {
                            left: -220px;
                        }
                    }
                    /*Give content full width on xs screens*/
                    @media screen and (max-width: 992px) {
                        .left-side {
                            margin-left: 5px;
                        }
                    }

                    @media screen and (max-width: 560px) {


                        .body-style.fixed > .wrapper,
                        .body-style.fixed .sidebar-offcanvas {
                            margin-top: 100px !important;
                        }
                    }


                    /*
 * Off Canvas
 * --------------------------------------------------
 *  Gives us the push menu effect
 */
                    @media screen and (max-width: 992px) {
                        .relative {
                            position: relative;
                        }

                        .row-offcanvas-right .sidebar-offcanvas {
                            left: -220px;
                        }

                        .row-offcanvas-left .sidebar-offcanvas {
                            left: -220px;
                            overflow: hidden;
                        }

                        .row-offcanvas-right.active {
                            right: 220px;
                        }

                        .row-offcanvas-left.active {
                            left: 220px;
                        }

                        .sidebar-offcanvas {
                            left: 0;
                        }

                        .body-style.fixed .sidebar-offcanvas {
                            margin-top: 50px;
                            left: -220px;
                        }

                        .body-style.fixed .row-offcanvas-left.active .navbar {
                            left: 220px !important;
                            right: 0;
                        }

                        .body-style.fixed .row-offcanvas-left.active .sidebar-offcanvas {
                            left: 0px;
                        }
                    }

                    .sidebar-toggle {
                        /*margin-left: -220px;*/
                    }

                    .sidebar {
                        width: 220px;
                        height: 100%;
                        margin-bottom: 60px;
                        -webkit-transition: all 0.3s ease-in-out;
                        -moz-transition: all 0.3s ease-in-out;
                        -o-transition: all 0.3s ease-in-out;
                        -ms-transition: all 0.3s ease-in-out;
                        transition: all 0.3s ease-in-out;
                        z-index: 100;
                    }
                </style>
                <script>


                    $(function () {



                    });

                </script>
            </div>
        </div>
        <div id="modal-1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
            aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×</button>
                <h3 id="myModalLabel">Deletion Confirmation</h3>
            </div>
            <div class="modal-body">
                <p>
                    Are you sure that you want to permanently delete this record ?
                </p>
            </div>
            <div class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true">
                    No
                </button>
                <button id="btnConfirm" class="btn btn-primary" data-dismiss="modal">
                    Yes
                </button>
            </div>
        </div>
        <div id="modal-2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2"
            aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×</button>
                <h3 id="myModalLabel2">Finishing Confirmation For Visit</h3>
            </div>
            <div class="modal-body">
                <p>
                    Are you sure that you want to finish this visit ?
                </p>
                <p>
                    <b>Note :<br />
                        if this visit is unpaid, it will be automatically paid</b>
                </p>
            </div>
            <div class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true">
                    No
                </button>
                <button id="btnConfirm2" class="btn btn-primary" data-dismiss="modal">
                    Yes
                </button>
            </div>
        </div>
        <div id="modal-3" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3"
            aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×</button>
                <h3 id="myModalLabel3">Deletion Confirmation For Visit</h3>
            </div>
            <div class="modal-body">
                <p>
                    Are you sure that you want to permanently delete this visit ?
                </p>
                <p>
                    <b>Note :<br />
                        if this visit is already paid,its cost will be automatically discounted from the
                    cash account and the other accounts associated to it</b>
                </p>
            </div>
            <div class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true">
                    No
                </button>
                <button id="btnConfirm3" class="btn btn-primary" data-dismiss="modal">
                    Yes
                </button>
            </div>
        </div>
        <!-- The Bootstrap Image Gallery lightbox -->
        <div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
            <!-- The container for the modal slides -->
            <div class="slides">
            </div>
            <!-- Controls for the borderless lightbox -->
            <h3 class="title"></h3>
            <a class="prev">‹</a> <a class="next">›</a> <a class="close">×</a> <a class="play-pause"></a>
            <ol class="indicator">
            </ol>
            <!-- The modal dialog, which will be used to wrap the lightbox content -->
            <div class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" aria-hidden="true">
                                &times;</button>
                            <h4 class="modal-title"></h4>
                        </div>
                        <div class="modal-body next">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left prev">
                                <i class="glyphicon glyphicon-chevron-left"></i>Previous
                            </button>
                            <button type="button" class="btn btn-primary next">
                                Next <i class="glyphicon glyphicon-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
