<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
    <title>Recover Password</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <!-- Bootstrap responsive -->
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css"/>
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/style.css"/>
    <!-- Color CSS -->
    <link rel="stylesheet" href="css/themes.css"/>
    <!-- jQuery -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- jQuery UI -->
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.core.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.widget.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.mouse.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.resizable.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-ui/jquery.ui.sortable.min.js"></script>
    <!-- Bootstrap -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/eakroko.js"></script>
    <!-- Theme framework -->
    <script type="text/javascript" src="js/eakroko.min.js"></script>
    <!-- Theme scripts -->
    <script type="text/javascript" src="js/application.min.js"></script>
    <!--[if lte IE 9]>
		<script src="js/plugins/placeholder/jquery.placeholder.min.js"></script>
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
</head>
<body id="body" class="login theme-grey">
    <div class="wrapper">
       
            <a href="Default.aspx">
                <img src="img/Umbrella_logo.png" alt="" class='retina-ready'/></a>
        <div class="login-body">
            <h2>
                <b>Recover Password</b></h2>
            <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="control-group">
                        <div class="controls">
                            <input id="txtEmail" runat="server" type="text" name='EmailAddress' placeholder="Email Address"
                                autocomplete="off" class='input-block-level' ValidationGroup="e"/>
                            <asp:RequiredFieldValidator ID="rvtxtEmail" runat="server" ControlToValidate="txtEmail"
                                Display="Dynamic" ErrorMessage="* Required" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"
                                ValidationGroup="e"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="retxtEmail" runat="server" ControlToValidate="txtEmail"
                                Display="Dynamic" ErrorMessage="* Invalid Email Address" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"
                                ValidationGroup="e" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </div>
                        <div class="controls">
                            <asp:Label ID="lblInfo" Text="" runat="server" Font-Bold="true" Font-Size="Small"/>
                        </div>
                    </div>
                    <asp:Button ID="btnSendEmail" Text="Send Login Information" runat="server" OnClick="btnSendEmail_Click"
                        class="btn btn-primary" ValidationGroup="e" OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Sending please wait';"
                                                                            UseSubmitBehavior="false" />
                    <br /><br />
                </ContentTemplate>
            </asp:UpdatePanel>
            </form>
        </div>
    </div>
</body>
</html>
