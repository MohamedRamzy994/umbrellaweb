<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="~/ucStyle_Scripts.ascx" TagPrefix="uc1" TagName="ucStyle_Scripts" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Umbrella - Clinic_uds Management System</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
        <script>
            $(document).ready(function () {
                /// Eng.Moustafa Ebrahem
                /// Eng.Moustafa20@Gmail.com
               
            });
            function LoginError() {
                $("#divState").prepend($("<div class='alert alert-error' style='width: 90%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> User Name or Password is incorrect </strong></div>"));
            };
            function Exception(error) {
                $("#divState").prepend($("<div class='alert alert-error' style='width: 90%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> " + error + "</strong></div>"));
            };
            function CookieError() {
                $("#divState").prepend($("<div class='alert alert-error' style='width: 90%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> The Cookies are disabled on your browser, Please enable it </strong></div>"));
            };
            function AccountDisabled() {
                $("#divState").prepend($("<div class='alert alert-info' style='width: 90%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> Your account has been disabled by Admin </strong></div>"));
            };
            function PasswordReset() {
                $("#divState").prepend($("<div class='alert alert-info' style='width: 90%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> Password has been reset to 'admin' </strong></div>"));
            };
            function BrowserCookie() {
                $("#divState").prepend($("<div class='alert alert-info' style='width: 90%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> Your browser doesn't support cookie </strong></div>"));
            };
            function ErrorM() {
                $("#divState").prepend($("<div class='alert alert-error' style='width: 90%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> An error has occurred </strong></div>"));
            };
    </script>
</head>
<body id="body" class="login theme-lightgrey">
    <div class="wrapper">
        <img src="img/Umbrella_logo.png" alt="" class='retina-ready' />
        <div class="login-body">
<%--            <div class="container-fluid">
                <ul class="icon-nav">
                    <li class='dropdown colo'><a href="#" class='dropdown-toggle' data-toggle="dropdown">
                        <i class="icon-umbrella"></i></a>
                        <ul id="drpColors" class="dropdown-menu theme-colors" style="padding:0px 15px 11px 2px;margin: 5px 10px;">
                           <li style=" padding-left: 10px;text-align: center;" class="subtitle colors" id="colors" meta:resourcekey="colors" runat="server">Favorite colors </li>
                        <li class="colors"><span class="grey"></span><span class='lightred'></span><span class="darkblue"></span><span class="blue"></span>
                            <span class="lightgrey"></span><span class="satblue"></span><span class="teal"></span><span class="brown"></span></li>
                        </ul>
                    </li>
                </ul>
            </div>--%>
            <div >
                <h2 style="margin:0px 0px 5px 0px">
                    <b>SIGN IN</b></h2>
            </div>
            <form id="form1" runat="server" class='form-validate'>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <%--<asp:HiddenField ID="hfTheme" runat="server" ClientIDMode="Static" Value="grey" />--%>
                <div class="control-group">
                    <div class="controls">
                        <input id="txtUserName" runat="server" type="text" name='username' placeholder="User Name"
                            autocomplete="off" class='input-block-level' data-rule-required="true" data-rule-minlength="5" />
                    </div>
                </div>
                <div class="control-group">
                    <div class="pw controls">
                        <input id="txtPassword" runat="server" type="password" name="upw" placeholder="Password"
                            autocomplete="off" class='input-block-level' data-rule-required="true" data-rule-minlength="5" />
                    </div>
                </div>
                <div class="submit">
                    <div class="remember">
                        <input id="chkRememberMe" runat="server" type="checkbox" name="remember" class='icheck-me' data-color="grey" checked="checked"
                            data-skin="square" aria-valuetext="Remember Me"/>
                        <label for="remember">
                            Remember Me</label>
                    </div>
                    <asp:Button ID="btnLogin" Text="Sign me in" runat="server" OnClick="btnLogin_Click"
                        class="btn btn-primary" />
                </div>
                <br />
                <div id="divState">
                </div>
            </form>
            <div class="forget">
                <a href="ForgotPassword.aspx"><span>Forgot Password ?</span></a>
            </div>
        </div>
    </div>

</body>
</html>
