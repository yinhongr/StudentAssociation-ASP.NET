<%@ Page Language="C#" runat="server" Debug="true" %>

<script language="C#" runat="server">
    void Login_Authenticate(object sender, AuthenticateEventArgs e)
    {
        customerDS.SelectCommand = "SELECT * FROM customer " +
            "WHERE cust_name = '" + Login.UserName +
            "' AND cust_pwd = '" + Login.Password + "'";

        customerDS.Select(DataSourceSelectArguments.Empty);
    }
    private void CheckLogin(object sender,
        SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            FormsAuthentication.RedirectFromLoginPage(Login.UserName,
            false);
        }
        else
        {
            Login.FailureText = "Invalid Login";
        }
    }
</script>
<html>
<head>
    <title>Log in</title>
    <link rel="stylesheet" href="ass2/Style.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="loginForm">
            <asp:AccessDataSource ID="customerDS" runat="server"
                DataFile="~/App_Data/customer.accdb" OnSelected="CheckLogin" />
            <asp:Login ID="Login" runat="server"
                OnAuthenticate="Login_Authenticate" CssClass="login"
                TitleText="<br />Please enter your details <br /> below to login for this site.<br /><br />"
                UserNameLabelText="User name:"
                UserNameRequiredErrorMessage="Username required<p />"
                PasswordLabelText="Password:"
                PasswordRequiredErrorMessage="Password required"
                Height="250" Width="330"
                LoginButtonText="Click to login" DisplayRememberMe="false">
                <LabelStyle CssClass="loginText" />
                <TitleTextStyle CssClass="loginText" />
                <LoginButtonStyle CssClass="button1" />
                <ValidatorTextStyle CssClass="errorMessage" />
            </asp:Login>
            <p></p>
            <asp:ValidationSummary ID="vlSummary1" Font-Names="Arial"
                Visible="true" CssClass="errorMessage"
                runat="server" ValidationGroup="Login"
                HeaderText="Please correct the following errors:" />
        </div>
        <div class="loginImg">
            <a href="ass2/displayCode.aspx?filename=~/login.aspx" target="_blank">
                <asp:Image runat="server" ImageUrl="~/App_Data/pix/login.png" /></a>
        </div>
    </form>
</body>
</html>
