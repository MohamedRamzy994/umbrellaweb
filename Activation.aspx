<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Activation.aspx.cs" Inherits="Activation" %>

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
    <title>Activation</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
    <script type="text/javascript">
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
            $('#txtMachineCode').on({
                mouseenter: function () {
                    //stuff to do on mouse enter
                    $(this).css('cursor', 'pointer');
                },
                mouseleave: function () {
                    //stuff to do on mouse leave
                    $(this).css('cursor', 'auto');
                }
            });
        }
    </script>
</head>
<body id="body" class="login theme-darkblue">
    <div class="wrapper">
        <h1>
            <a href="Default.aspx">
                <img src="img/Umbrella_logo.png" alt="" class='retina-ready'/></a></h1>
        <div class="login-body">
            <h2>
                <b>Activation Process</b></h2>
            <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="control-group">
                        <label for="textfield" class="control-label">
                            Machine-Code:</label>
                        <div class="controls">
                            <input id="txtMachineCode" runat="server" type="text" placeholder="Machine Code"
                                autocomplete="off" class='input-block-level' validationgroup="e"
                                readonly="readonly" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="textfield" class="control-label">
                            Activation-Code:</label>
                        <div class="controls">
                            <input id="txtActivationCode" runat="server" type="text" placeholder="Activation Code"
                                autocomplete="off" class='input-block-level' validationgroup="e" />
                            <asp:RequiredFieldValidator ID="rvtxtEmail" runat="server" ControlToValidate="txtActivationCode"
                                Display="Dynamic" ErrorMessage="* Required" ForeColor="Red" Font-Bold="true"
                                SetFocusOnError="True" ValidationGroup="e"></asp:RequiredFieldValidator>
                        </div>
                        <div class="controls">
                            <asp:Label ID="lblInfo" Text="" runat="server" Font-Bold="true" Font-Size="Small" ForeColor="Red" />
                        </div>
                    </div>
                    <asp:Button ID="btnActivation" Text="Activate Application" runat="server" OnClick="btnActivation_Click" Width="200px"
                        class="btn btn-primary" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Activating please wait';"
                        UseSubmitBehavior="false" />
                    <br />
                    <br />
                </ContentTemplate>
            </asp:UpdatePanel>
            </form>
        </div>
    </div>
</body>
</html>
