<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginPage.aspx.cs" Inherits="LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            color: #008000;
            font-size: x-large;
        }
            body {
                padding: 0;
                margin: 0;
                background: #D3D4C0;
                font-size: 14px;
                font-family: Arial, sans-serif;
                text-align: center;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
  <div align="center">
    <fieldset style ="width:243px; height: 171px;">
    <legend><strong><span class="auto-style1">Login page</span>
        <br />
        </strong> </legend>
        <asp:TextBox ID="txtusername" placeholder="username" runat="server"
            Width="180px"></asp:TextBox>
        <br />
        <br />
        <asp:TextBox ID="txtpassword" placeholder="password" runat="server"
            Width="180px" TextMode="Password"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnsubmit" runat="server" Text="Login"
           Width="81px" onclick="btnsubmit_Click" Height="31px" style="font-weight: 700" />
            <br />
           
    </fieldset>
    </div>
    </form>
</body>
</html>
