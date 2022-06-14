<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucGeneralClinicReports.ascx.cs" Inherits="ucReception" %>

<div id="navigation" class="navbar-fixed-top">
    <!-- Header -->
    <div class="container-fluid">
        <a href="javascript:void(0)" id="brand" meta:resourcekey="Umrella" runat="server" class="brand">Umbrella</a>
        <ul id="divVisit" runat="server" visible="true" class='main-nav'>
            <li>
                <asp:LinkButton ID="lbVisit" runat="server" OnClick="lbVisit_Click" meta:resourcekey="lbVisitResource1">Visit Summary</asp:LinkButton></li>
            <li>
                <asp:LinkButton ID="lbVitalSigns" runat="server" OnClick="lbVitalSigns_Click" meta:resourcekey="lbVitalSignsResource1">Vital Sings</asp:LinkButton></li>
            <li>
                <asp:LinkButton ID="lbComplaintDiagnosis_ud" runat="server" OnClick="lbComplaintDiagnosis_ud_Click" meta:resourcekey="lbComplaintDiagnosis_udResource1">Complaints & Diagnosis_ud</asp:LinkButton>
            </li>
            <li>
                <asp:LinkButton ID="lbPrescription" runat="server" OnClick="lbPrescription_Click" meta:resourcekey="lbPrescriptionResource1">Prescription</asp:LinkButton>
            </li>
            <li>
                <asp:LinkButton ID="lbRequest" runat="server" OnClick="lbRequest_Click" meta:resourcekey="lbRequestResource1">Request</asp:LinkButton></li>
        </ul>
        <ul id="divPast_history" runat="server" visible="false" class='main-nav'>
            <li>
                <asp:LinkButton ID="lbFamily" runat="server" OnClick="lbFamily_Click" meta:resourcekey="lbFamilyResource1">Family History</asp:LinkButton></li>
            <li>
                <asp:LinkButton ID="lbChronic" runat="server" OnClick="lbChronic_Click" meta:resourcekey="lbChronicResource1">Chronic Diseases</asp:LinkButton>
            </li>
            <li>
                <asp:LinkButton ID="lbDrugs" runat="server" OnClick="lbDrugs_Click" meta:resourcekey="lbDrugsResource1">Drugs</asp:LinkButton>
            </li>
            <li>
                <asp:LinkButton ID="lbSurgeries" runat="server" OnClick="lbSurgeries_Click" meta:resourcekey="lbSurgeriesResource1">Surgeries</asp:LinkButton></li>
            <li>
                <asp:LinkButton ID="lbTransfusion" runat="server" OnClick="lbTransfusion_Click" meta:resourcekey="lbTransfusionResource1">Transfusion</asp:LinkButton></li>
            <li>
                <asp:LinkButton ID="lbHospital" runat="server" OnClick="lbHospital_Click" meta:resourcekey="lbHospitalResource1">Hospital Admission</asp:LinkButton></li>
            <li>
                <asp:LinkButton ID="lbImages" runat="server" OnClick="lbImages_Click" meta:resourcekey="lbImagesResource1">Images</asp:LinkButton></li>
        </ul>
        <div class="user">
            <ul class="icon-nav">
                <li id="drpColors" class='dropdown colo'><a href="#" class='dropdown-toggle' data-toggle="dropdown">
                    <i class="icon-umbrella" meta:resourcekey="iconumbrella" runat="server"></i></a>
                    <ul class="dropdown-menu pull-right theme-colors" style="width: 240px;">
                        <li class="subtitle colors" id="colors" meta:resourcekey="colors" runat="server" style="text-align: center">Favorite colors</li>
                        <li class="colors"><span class="grey"></span><span class='lightgrey'></span><span class="lightred"></span><span class="darkblue"></span>
                            <span class="blue"></span><span class="satblue"></span></li>
                    </ul>
                </li>
                <li>
                    <asp:LinkButton ID="lnkSounds" runat="server" OnClick="lnkSounds_Click" meta:resourcekey="lnkSounds" CssClass="lnkSounds"><i class='<%= this.user!=null?this.user.msounds:"icon-volume-down"%>'></i></asp:LinkButton></li>
                <li>
                    <asp:LinkButton ID="lnklang" Text="EN" runat="server" OnClick="lnklang_Click" meta:resourcekey="lnklang" CssClass="lnklang" /></li>
            </ul>
            <div class="dropdown pull-right">
                <a href="#" class='dropdown-toggle' data-toggle="dropdown" style="margin-top: 4px;">
                    <asp:Label ID="lblUserName" Text="Moustafa Ebrahem" runat="server" meta:resourcekey="lblUserName" CssClass="lblUserName" />
                    <i class="icon-user"></i></a>
                <ul class="dropdown-menu pull-right">
                    <li><a href="AccountSettings.aspx" id="aAccountSettings" meta:resourcekey="aAccountSettings" runat="server">Account Settings</a></li>
                    <li>
                        <asp:LinkButton ID="lbSignOut" runat="server" OnClick="lbSignOut_Click" meta:resourcekey="lbSignOut">Sign Out</asp:LinkButton>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- End of Header -->
</div>
<asp:PlaceHolder runat="server" ID="phBottomScripts" />
