<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucMenuControlPanel.ascx.cs" Inherits="ucMenuControlPanel" %>
<div id="navigation" class="navbar-fixed-top">
    <!-- Header -->
    <div class="container-fluid">
        <a href="javascript:void(0)" id="brand" meta:resourcekey="Umrella" runat="server" class="brand">Umbrella</a>
        <ul class='main-nav'>
            <li><a href="Home.aspx" meta:resourcekey="Home" runat="server"><span>Home</span> </a></li>
            <li><a href="ControlPanel.aspx" meta:resourcekey="ControlPanel" runat="server"><span>Control Panel</span> </a></li>
            <li><a href="#" data-toggle="dropdown" class='dropdown-toggle' meta:resourcekey="GeneralSettings" runat="server"><span>General Settings</span>
                <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="Clinic_udSettings.aspx" meta:resourcekey="Clinic_ud" runat="server"><span>Clinic_ud</span> </a></li>
                    <li><a href="Examinations_udSettings.aspx" meta:resourcekey="Examinations_ud" runat="server"><span>Examinations_ud</span> </a></li>
                    <li><a href="Days_udSettings.aspx" meta:resourcekey="Appointments" runat="server"><span>Appointments</span> </a></li>
                </ul>
            </li>
            <li><a href="#" data-toggle="dropdown" class='dropdown-toggle' meta:resourcekey="MedicalSettings" runat="server"><span>Medical Settings</span> <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="MedicinesSettings.aspx" meta:resourcekey="Medicines_ud" runat="server"><span>Medicines_ud</span> </a></li>
                    <li><a href="DosesSettings.aspx" meta:resourcekey="Doses_ud" runat="server"><span>Doses_ud</span> </a></li>
                    <li><a href="DiagnosisSettings.aspx" meta:resourcekey="Diagnosis_ud" runat="server"><span>Diagnosis_ud</span> </a></li>
                    <li><a href="TestsSettings.aspx" meta:resourcekey="Tests" runat="server"><span>Tests</span> </a></li>
                </ul>
            </li>
            <li><a id="a1" href="#" data-toggle="dropdown" class='dropdown-toggle' meta:resourcekey="IndividualsSettings" runat="server"><span>Individuals Settings</span>
                <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="UsersSettings.aspx" meta:resourcekey="Users_ud" runat="server"><span>Users_ud</span> </a></li>
                    <li><a href="PermissionsSettings.aspx" meta:resourcekey="Permissions" runat="server"><span>Permissions</span> </a></li>
                    <li><a href="EmployeesSettings.aspx" meta:resourcekey="Employee_uds" runat="server"><span>Employee_uds</span> </a></li>
                    <li><a href="PatientsSettings.aspx" meta:resourcekey="Patients_ud" runat="server"><span>Patients_ud</span> </a></li>
                </ul>
            </li>
            <li><a href="Companies_udSettings.aspx" meta:resourcekey="Companies_ud" runat="server"><span>Companies_ud</span> </a></li>
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
