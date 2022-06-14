<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClinicSettings.aspx.cs" Inherits="Clinic_udSettings" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="~/ucMenuControlPanel.ascx" TagPrefix="uc1" TagName="ucMenuControlPanel" %>
<%@ Register Src="~/ucStyle_Scripts.ascx" TagPrefix="uc1" TagName="ucStyle_Scripts" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Reports Settings</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
        $(document).ready(function () {
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
            $('a[href="Clinic_udSettings.aspx"]').parent().addClass('active').parent().parent().addClass('active');
            DoWork();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(requestHandler);
        });
        function requestHandler(sender, args) {
            // this code is excected after the first postback
            DoWork();

        };
        function DoWork() {

            /////////////////////////////////////////////////
            ///////////// Clinic_ud Tab///////////////////////////
            /////////////////////////////////////////////////
           
            $('#btnClinic_udPrint').unbind("click").bind("click", function (event) {
                event.preventDefault();
                if (!Page_ClientValidate()) { return false; }
                var str = "ReportView.aspx?data=demo,Moustafa_Ebrahem";
                window.open(str, '_blank');
            });

            /////////////////////////////////////////////////
            ///////////// End of Clinic_ud Tab/////////////////
            /////////////////////////////////////////////////
            /// Eng.Moustafa Ebrahem
            /// Eng.Moustafa20@Gmail.com
        };
    </script>
    <style>
        .lblStyle {
            padding:10px 10px;
            margin-right:25%;
            margin-left:25%;
        }
    </style>
</head>
<body class='<%= this.user!=null?this.user.theme:"theme-grey"%>'>
    <form id="form1" runat="server" defaultbutton="btnClinic_udave">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
       
        <!-- Header -->
        <uc1:ucMenuControlPanel runat="server" ID="ucMenuControlPanel" />
        <!-- End of Header -->
        <div id="content" class="container-fluid nav-fixed">
            <div id="main" style="margin-left: 0px;">
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="pull-left">
                            <h2 meta:resourcekey="hClinic_udSett" runat="server">Clinic_ud Settings</h2>
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
                                    <h3 meta:resourcekey="hClinic_udSettings" runat="server">
                                        <i class="glyphicon-settings"></i>Clinic_ud Settings
                                    </h3>
                                    <ul class="tabs">
                                        <li class="active"><a href="#t1" data-toggle="tab" meta:resourcekey="aClinic_ud" runat="server">Clinic_ud</a> </li>
                                    </ul>
                                </div>
                                <div class="box-content nopadding">
                                    <div class="tab-content">
                                        <div id="t1" class="tab-pane active">
                                            <div class='form-horizontal form-column form-bordered'>
                                                <div class="box box-bordered box-color">
                                                    <div class="box-title">
                                                        <h3 meta:resourcekey="aClinic_ud2" runat="server">
                                                            <i class="icon-hospital"></i>Clinic_ud</h3>
                                                    </div>
                                                    <asp:UpdatePanel ID="upClinic_ud" runat="server">
                                                        <ContentTemplate>
                                                            <div class="box-content nopadding">
                                                                <div id="tblClinic_ud" class="span12">
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblActions" runat="server">
                                                                            Actions:</label>
                                                                        <div class="controls">
                                                                            <asp:Button ID="btnClinic_udave" Text="Save" runat="server" CssClass="btn btn-blue"
                                                                                Width="80px" OnClick="btnClinic_udSave_Click" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Saving';if(document.getElementById('btnClinic_udPrint')!= null){document.getElementById('btnClinic_udPrint').disabled=true;}"
                                                                                UseSubmitBehavior="False" CommandArgument="save" meta:resourcekey="btnDemoSave" />
                                                                            <asp:Button ID="btnClinic_udPrint" Text="Preview" runat="server" CssClass="btn btn-satblue"
                                                                                Width="80px" ValidationGroup="e" CommandArgument="print" meta:resourcekey="btnDemoPrint" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                              <asp:Label ID="lblHeader" runat="server" Font-Bold="True" meta:resourcekey="lblHeader2" Font-Size="Medium" Height="20px" CssClass="lblStyle">
                                                                        Header of The Report</asp:Label>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblLine1" runat="server">
                                                                            Line-1:</label>
                                                                        <div class="controls">
                                                                            <input id="txtHeadeLine1" runat="server" type="text" placeholder="Header Line 1"
                                                                                class="input-xxlarge" validationgroup="e" autocomplete="off" maxlength="80" meta:resourcekey="lblLine1" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvtxtHeadeLine1" runat="server" ControlToValidate="txtHeadeLine1"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtHeadeLine1Resource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblLine2" runat="server">
                                                                            Line-2:</label>
                                                                        <div class="controls">
                                                                            <input id="txtHeaderLine2" runat="server" type="text" placeholder="Header Line 2"
                                                                                class="input-xxlarge" maxlength="80" autocomplete="off" validationgroup="e" meta:resourcekey="lblLine2" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvtxtHeaderLine2" runat="server" ControlToValidate="txtHeaderLine2"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtHeaderLine2Resource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblLine3" runat="server">
                                                                            Line-3:</label>
                                                                        <div class="controls">
                                                                            <input id="txtHeaderLine3" runat="server" type="text" placeholder="Header Line 3"
                                                                                class="input-xxlarge" maxlength="80" autocomplete="off" validationgroup="e" meta:resourcekey="lblLine3" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvtxtHeaderLine3" runat="server" ControlToValidate="txtHeaderLine3"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtHeaderLine3Resource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblLine4" runat="server">
                                                                            Line-4:</label>
                                                                        <div class="controls">
                                                                            <input id="txtHeaderLine4" runat="server" type="text" placeholder="Header Line 4" meta:resourcekey="lblLine4"
                                                                                class="input-xxlarge" maxlength="80" autocomplete="off" validationgroup="e" />
                                                                            &nbsp;
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                            <asp:Label ID="lblFooter" runat="server" Font-Bold="True" meta:resourcekey="lblFooter2" Font-Size="Medium" Height="20px" CssClass="lblStyle">
                                                                        Footer of The Report  </asp:Label>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblLine1" runat="server">
                                                                            Line-1:</label>
                                                                        <div class="controls">
                                                                            <input id="txtFooterLine1" runat="server" type="text" placeholder="Footer Line 1"
                                                                                class="input-xxlarge" maxlength="80" autocomplete="off" validationgroup="e" meta:resourcekey="lblLine1" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvtxtFooterLine1" runat="server" ControlToValidate="txtFooterLine1"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtFooterLine1Resource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblLine2" runat="server">
                                                                            Line-2:</label>
                                                                        <div class="controls">
                                                                            <input id="txtFooterLine2" runat="server" type="text" placeholder="Footer Line 2" meta:resourcekey="lblLine2"
                                                                                class="input-xxlarge" maxlength="80" autocomplete="off" validationgroup="e" />
                                                                            &nbsp;<asp:RequiredFieldValidator ID="rvtxtFooterLine2" runat="server" ControlToValidate="txtFooterLine2"
                                                                                Display="Dynamic" ErrorMessage="*Required" ForeColor="#CC0000" SetFocusOnError="True"
                                                                                ValidationGroup="e" meta:resourcekey="rvtxtFooterLine2Resource1"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="control-group">
                                                                        <label for="textfield" class="control-label" meta:resourcekey="lblLine3" runat="server">
                                                                            Line-3:</label>
                                                                        <div class="controls">
                                                                            <input id="txtFooterLine3" runat="server" type="text" placeholder="Footer Line 3"
                                                                                class="input-xxlarge" maxlength="80" autocomplete="off" validationgroup="e" meta:resourcekey="lblLine3" />
                                                                            &nbsp;
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
                <h3 id="myModalLabel" meta:resourcekey="myModalLabel" runat="server">Deletion Confirmation</h3>
            </div>
            <div class="modal-body">
                <p id="P1" meta:resourcekey="pDelete" runat="server">
                    Are you sure that you want to permanently delete this record ?
                </p>
            </div>
            <div class="modal-footer">
                <button id="Button1" class="btn" data-dismiss="modal" aria-hidden="true" meta:resourcekey="btnNo" runat="server">
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
