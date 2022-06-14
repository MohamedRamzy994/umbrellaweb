<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucReports.ascx.cs" Inherits="ucReports" %>
<div id="navigation" class="navbar-fixed-top">
    <!-- Header -->
    <div class="container-fluid">
        <a href="javascript:void(0)" id="brand" meta:resourcekey="Umrella" runat="server" class="brand">Umbrella</a>
        <ul class='main-nav'>

            <%--  --%>
            <li><a href="Home.aspx" meta:resourcekey="Home" runat="server"><span>Home</span> </a></li>
            <li><a href="Reports.aspx" meta:resourcekey="Reports" runat="server"><span>Reports</span> </a></li>
            <%--                <li><a href="ReceptionReports.aspx"><span>Reception Reports</span></a></li>
                <li><a href="ClinicReports.aspx"><span>Clinic_ud Reports</span></a></li>
                <li><a href="SystemReports.aspx"><span>System Reports</span></a></li>--%>
            <li><a href="FinancialsReports.aspx" meta:resourcekey="Financials_Reports" runat="server"><span>Financials Reports</span></a></li>
            <li><a id="A1" href="ClinicReports.aspx" meta:resourcekey="Clinic_ud_Reports" runat="server"><span>Clinic_ud Reports</span></a></li>
        </ul>
        <div class="user">
            <ul class="icon-nav">
                <li id="drpColors" class='dropdown colo'><a href="#" class='dropdown-toggle' data-toggle="dropdown">
                    <i id="I1" class="icon-umbrella" meta:resourcekey="iconumbrella" runat="server"></i></a>
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

