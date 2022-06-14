<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucGeneralClinicsReports.ascx.cs" Inherits="ucReception" %>

<div id="navigation" class="navbar-fixed-top">
    <!-- Header -->
    <div class="container-fluid">
        <a href="javascript:void(0)" id="brand" meta:resourcekey="Umrella" runat="server" class="brand">Umbrella</a>
      
        <%--<ul id="divDailyDet" runat="server" visible="false" class='main-nav'>
                <li>
                    <asp:LinkButton ID="lbSummary" runat="server" OnClick="lbSummary_Click" meta:resourcekey="lbSummaryResource1">Summary</asp:LinkButton></li>
                <li>
                    <asp:LinkButton ID="lbVisits" runat="server" OnClick="lbVisits_Click" meta:resourcekey="lbVisitsResource1">Visits</asp:LinkButton></li>
                <li><a href="" data-toggle="dropdown" class='dropdown-toggle'><span meta:resourcekey="Encashment_Vouchers" runat="server">Encashment Vouchers</span>
                    <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <asp:LinkButton ID="lbFromCompanies_ud" runat="server" OnClick="lbFromCompanies_ud_Click" meta:resourcekey="lbFromCompanies_udResource1">From Companies_ud</asp:LinkButton></li>
                        <li>
                            <asp:LinkButton ID="lbFromPatients_ud" runat="server" OnClick="lbFromPatients_ud_Click" meta:resourcekey="lbFromPatients_udResource1">From Patients_ud</asp:LinkButton></li>
                    </ul>
                </li>
                <li>
                    <asp:LinkButton ID="lbReturnedVisits" runat="server" OnClick="lbReturnedVisits_Click" meta:resourcekey="lbReturnedVisitsResource1">Returned Visits</asp:LinkButton></li>
                <li><a href="" data-toggle="dropdown" class='dropdown-toggle'><span meta:resourcekey="Payment_Vouchers" runat="server">Payment Vouchers</span><span
                    class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <asp:LinkButton ID="lbForCompanies_ud" runat="server" OnClick="lbForCompanies_ud_Click" meta:resourcekey="lbForCompanies_udResource1">For Companies_ud</asp:LinkButton></li>
                        <li>
                            <asp:LinkButton ID="lbForPatients_ud" runat="server" OnClick="lbForPatients_ud_Click" meta:resourcekey="lbForPatients_udResource1">For Patients_ud</asp:LinkButton></li>
                        <li>
                            <asp:LinkButton ID="lbForExaminations_ud" runat="server" OnClick="lbForExaminations_ud_Click" meta:resourcekey="lbForExaminations_udResource1">For Examinations_ud</asp:LinkButton></li>
                    </ul>
                </li>
                <li>
                    <asp:LinkButton ID="lbWithdrawals" runat="server" OnClick="lbWithdrawals_Click" meta:resourcekey="lbWithdrawalsResource1">Withdrawals</asp:LinkButton></li>
            </ul>--%>
            <ul id="divDailyPeriod" runat="server" class='main-nav'>
                <li>
                    <asp:LinkButton ID="lbPatientVisits" runat="server" OnClick="lbPatientVisits_Click" meta:resourcekey="lbDailySummaryResource1">Patient Visits Report</asp:LinkButton></li>
                <li>
                    <asp:LinkButton ID="lbPatientDetails" runat="server" OnClick="lbPatientDetails_Click" meta:resourcekey="lbDailyDetailResource1">Patient Details Report</asp:LinkButton></li>
                <li>
                    <asp:LinkButton ID="lbPatientAccount" runat="server" OnClick="lbPatientAccount_Click" meta:resourcekey="lbDailyDetailResource12">Patient Account Report</asp:LinkButton></li>
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