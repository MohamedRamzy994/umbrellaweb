<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

<%@ Register Src="~/ucStyle_Scripts.ascx" TagPrefix="uc1" TagName="ucStyle_Scripts" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <title>Error</title>
    <uc1:ucStyle_Scripts runat="server" ID="ucStyle_Scripts" />
</head>
<body class="error">
    <div class="wrapper">
        <div class="code">
            <span>500</span><i class="glyphicon-circle_remove"></i></div>
        <div class="desc">
            <b>Oops!<br />
                Internal Server Error</b></div>
        <form id="form1" runat="server" class='form-horizontal'>
        <div>
            <a href="Home.aspx" class="btn"><i class="icon-home"></i>Home</a>
        </div>
        </form>
    </div>
</body>
</html>
