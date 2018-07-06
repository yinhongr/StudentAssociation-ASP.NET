<%@ Page Language="C#" MasterPageFile="../MasterPage.master" StylesheetTheme="default" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<asp:Content ID="registrationContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script runat="server">
        void submit(object Sender, EventArgs e)
        {
            if (!(Page.IsValid))
            {
                return;
            }
            else
            {
                Label14.Text = "";
                Label1.Text = "";
            }
            if (Page.IsPostBack)
            {
                Label2.Text = "Your user name is " + tb1.Text + " ";
                Label3.Text = "and your age is " + tb2.Text + ". ";
                Label4.Text = "Your gender is " + rb1.Text + " ";
                Label5.Text = "and your country is " + dropDL.SelectedItem.Text + ". ";
                Label6.Text = "Your password is " + tb3.Text + " ";
                Label7.Text = "and the confirmed password is " + tb4.Text + ". ";
                Label8.Text = "Your email address number is " + tb7.Text + " ";
                Label9.Text = "and you want to visit " + listBox1.SelectedItem.Text + ". ";
                Label10.Text = "Your departure date is " + tb5.Text + " ";
                Label11.Text = "and your return date is " + tb6.Text + ". ";
                if (cb1.Checked || cb2.Checked || cb3.Checked)
                {
                    String temp = "Your interested type of scenery is/are ";
                    if (cb1.Checked && !cb2.Checked && !cb3.Checked)
                    {
                        temp += cb1.Text + ". ";
                    }
                    else if (cb1.Checked && cb2.Checked && !cb3.Checked)
                    {
                        temp += cb1.Text + " and " + cb2.Text + ". ";
                    }
                    else if (cb1.Checked && cb2.Checked && cb3.Checked)
                    {
                        temp += cb1.Text + ", " + cb2.Text + " and " + cb3.Text + ". ";
                    }
                    else if (!cb1.Checked && cb2.Checked && !cb3.Checked)
                    {
                        temp += cb2.Text + ". ";
                    }
                    else if (!cb1.Checked && cb2.Checked && cb3.Checked)
                    {
                        temp += cb2.Text + " and " + cb3.Text + ". ";
                    }
                    else if (!cb1.Checked && !cb2.Checked && cb3.Checked)
                    {
                        temp += cb3.Text + ". ";
                    }
                    Label13.Text = temp;
                }
            }
            CustomerDS.InsertParameters.Add("cust_name", tb1.Text.Trim());
            CustomerDS.InsertParameters.Add("cust_age", tb2.Text);
            CustomerDS.InsertParameters.Add("cust_gender", rb1.Text);
            CustomerDS.InsertParameters.Add("cust_country", dropDL.SelectedItem.Text);
            CustomerDS.InsertParameters.Add("cust_pwd", tb3.Text.Trim());
            CustomerDS.InsertParameters.Add("cust_email", tb7.Text);
            string imgSrc = "<img src=\"../../App_Data/pix/" + listBox1.SelectedValue.ToString() + ".jpg\"/>";
            CustomerDS.InsertParameters.Add("cust_prefer_city", imgSrc);
            CustomerDS.InsertParameters.Add("cust_depart_date", tb5.Text);
            CustomerDS.InsertParameters.Add("cust_return_date", tb6.Text);
            string[] interest = Regex.Split(Label13.Text, "are ");
            CustomerDS.InsertParameters.Add("cust_interest", interest[1]);
            string cityURL = "../../App_Data/pix/" +　listBox1.SelectedValue.ToString() + ".jpg";
            CustomerDS.InsertParameters.Add("city_url", cityURL);
            CustomerDS.InsertCommand = "INSERT INTO " +
                                        "[customer] ([cust_name], [cust_age], [cust_gender], " +
                                                    "[cust_country], [cust_pwd], " +
                                                    "[cust_email], [cust_prefer_city], " +
                                                    "[cust_depart_date], [cust_return_date], " +
                                                    "[cust_interest], [city_url]) VALUES " + 
                                                    "(@cust_name, @cust_age, @cust_gender," +
                                                     "@cust_country, @cust_pwd, @cust_email, " +
                                                     "@cust_prefer_city, @cust_depart_date, " +
                                                     "@cust_return_date, @cust_interest, @city_url)";
            CustomerDS.Insert();
        }
        
        void validateDate(object source,
                         System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            DateTime departDate, returnDate;
            args.IsValid = false;

            departDate = DateTime.Parse(tb5.Text);
            returnDate = DateTime.Parse(tb6.Text);
            // Verify that the departure date is not in the past or today!
            if (departDate < DateTime.Now)
            {
                Label1.Text = "The Departure Date cannot be in the past or today!";
                return;
            }
            // Verify that the departure date is earlier than the return date!
            if (departDate >= returnDate)
            {
                Label1.Text = "Departure Date must be earlier than the Return Date " +
                            "and no same-day returns for this travel package!";
                return;
            }

            args.IsValid = true;
        }
        void validateName(object source,
                         System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = false;
            DataSet objDS = new DataSet();
            string strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + (string)Server.MapPath("~/App_Data/customer.accdb");
            string strSQL = "select cust_id from customer where cust_name=" + "'" + tb1.Text.Trim() + "'";
            
            OleDbConnection objConn = new OleDbConnection(strConn);
            OleDbDataAdapter objDataAdapter = new OleDbDataAdapter(strSQL, strConn);
            if (objDataAdapter.Fill(objDS) == 1)
            {
                Label14.Text = "The username is already used!";
                return;
            }
            args.IsValid = true;
        }
        void validateEmail(object source,
                         System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = false;
            DataSet objDS = new DataSet();
            string strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + (string)Server.MapPath("~/App_Data/customer.accdb");
            string strSQL = "select cust_id from customer where cust_email=" + "'" + tb7.Text + "'";

            OleDbConnection objConn = new OleDbConnection(strConn);
            OleDbDataAdapter objDataAdapter = new OleDbDataAdapter(strSQL, strConn);
            if (objDataAdapter.Fill(objDS) == 1)
            {
                Label14.Text = "the email address is already used!";
                return;
            }
            args.IsValid = true;
        }
    </script>
    <div class="registrationPage">
        <p class="formBanner"><b>Registration Form</b></p>
        <table class="table2">

            <tr>
                <td class="formC1">
                    <asp:Label ID="lb1" runat="server" Text="username:"></asp:Label></td>
                <td>
                    <asp:TextBox CssClass="textbox" ID="tb1" runat="server"></asp:TextBox></td>
                <td class="formC1">
                    <asp:Label ID="lb2" runat="server" Text="age:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="tb2" CssClass="textbox" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:RequiredFieldValidator ID="vldUserName" runat="server"
                        ErrorMessage="Please enter a username"
                        ControlToValidate="tb1" CssClass="errorMessage" />
                    <asp:CustomValidator ID="validateCustName" runat="server"
                        ControlToValidate="tb1"
                        OnServerValidate="validateName" />
                <td></td>
                <td>
                    <asp:RequiredFieldValidator ID="vldAge" runat="server"
                        ErrorMessage="Please enter your age"
                        ControlToValidate="tb2" CssClass="errorMessage" /><br />
                    <asp:RangeValidator ID="rngAge" runat="server"
                        ControlToValidate="tb2"
                        ErrorMessage="The age should between 1 - 99"
                        MinimumValue="1" MaximumValue="99" Type="Integer" CssClass="errorMessage" /></td>
            </tr>
            <tr>
                <td class="formC1">
                    <asp:Label ID="lb3" runat="server" Text="gender:"></asp:Label></td>
                <td>
                    <asp:RadioButton ID="rb1" runat="server" Text="male" GroupName="1" Checked="true" /><asp:RadioButton runat="server" Text="female" GroupName="1" />
                </td>
                <td class="formC1">
                    <asp:Label ID="lb4" runat="server" Text="country:"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="dropDL" runat="server">
                        <asp:ListItem Text="China" Value="China"></asp:ListItem>
                        <asp:ListItem Text="Australia" Value="Australia" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="United states" Value="USA"></asp:ListItem>
                        <asp:ListItem Text="Italy" Value="Italy"></asp:ListItem>
                        <asp:ListItem Text="Germany" Value="Germany"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formC1">
                    <asp:Label ID="lb5" runat="server" Text="password:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="tb3" CssClass="textbox" TextMode="Password" runat="server"></asp:TextBox></td>
                <td class="formC1">
                    <asp:Label ID="lb6" runat="server" Text="confirm password:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="tb4" CssClass="textbox" TextMode="Password" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:RequiredFieldValidator ID="vldPassword" runat="server"
                        ErrorMessage="Please enter a password"
                        ControlToValidate="tb3" CssClass="errorMessage" /></td>
                <td></td>
                <td>
                    <asp:RequiredFieldValidator ID="vldConfirmPwd" runat="server"
                        ErrorMessage="Please enter the pass word again"
                        ControlToValidate="tb4" CssClass="errorMessage" /><br />
                    <asp:CompareValidator ID="cmpPassword" runat="server"
                        ControlToValidate="tb4"
                        ControlToCompare="tb3"
                        ErrorMessage="password does not match" CssClass="errorMessage" /></td>
            </tr>
            <tr>
                <td class="formC1">
                    <asp:Label ID="Label12" runat="server" Text="email address:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="tb7" CssClass="textbox" runat="server"></asp:TextBox></td>
                <td class="formC1">
                    <asp:Label ID="lb7" runat="server" Text="city want to go:"></asp:Label></td>
                <td>
                    <asp:ListBox ID="listBox1" SelectionMode="Single" runat="server">
                        <asp:ListItem Text="Beijing" Value="Beijing" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Shanghai" Value="Shanghai"></asp:ListItem>
                        <asp:ListItem Text="Guangzhou" Value="Guangzhou"></asp:ListItem>
                        <asp:ListItem Text="Shenzhen" Value="Shenzhen"></asp:ListItem>
                        <asp:ListItem Text="Xi'an" Value="Xi'an"></asp:ListItem>
                    </asp:ListBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:RequiredFieldValidator ID="vldEmailAddr" runat="server"
                        ErrorMessage="Please enter your email address"
                        ControlToValidate="tb7" CssClass="errorMessage" /><br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                        runat="server" ControlToValidate="tb7"
                        ValidationExpression="([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,5})"
                        ErrorMessage="Invalid email address(x@x.x)" Display="dynamic" CssClass="errorMessage" />
                    <asp:CustomValidator ID="validateEmails" runat="server"
                        ControlToValidate="tb1"
                        OnServerValidate="validateEmail" />
                </td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td class="formC1">
                    <asp:Label ID="lb9" runat="server" Text="departure date:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="tb5" CssClass="textbox" runat="server"></asp:TextBox></td>
                <td class="formC1">
                    <asp:Label ID="lb10" runat="server" Text="return date:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="tb6" CssClass="textbox" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:RequiredFieldValidator ID="vldDepartDate" runat="server"
                        ErrorMessage="Please enter your departure date"
                        ControlToValidate="tb5" CssClass="errorMessage" />
                    <asp:CustomValidator ID="validateDates" runat="server"
                        ControlToValidate="tb5"
                        OnServerValidate="validateDate" /><br />
                    <asp:RegularExpressionValidator ID="vldDepartDate1" runat="server" CssClass="errorMessage"
                        ControlToValidate="tb5" ErrorMessage="Invalid date e.g. dd-mm-yyyy"
                        ValidationExpression="([0][1-9]|[12][0-9]|[3][01])-([0][1-9]|[1][012])-([0-9][0-9][0-9][0-9])"
                        Display="Dynamic" />

                </td>
                <td></td>
                <td>
                    <asp:RequiredFieldValidator ID="vldReturnDate" runat="server"
                        ErrorMessage="Please enter your return date"
                        ControlToValidate="tb6" CssClass="errorMessage" /><br />
                    <asp:RegularExpressionValidator ID="vldReturnDate1" runat="server" CssClass="errorMessage"
                        ControlToValidate="tb6" ErrorMessage="Invalid date e.g. dd-mm-yyyy"
                        ValidationExpression="([0][1-9]|[12][0-9]|[3][01])-([0][1-9]|[1][012])-([0-9][0-9][0-9][0-9])"
                        Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="formC1" colspan="1">
                    <asp:Label ID="lb8" runat="server" Text="interested type of the scenery:"></asp:Label></td>
                <td colspan="3">
                    <asp:CheckBox ID="cb1" runat="server" Text="Natural Scenery"  Checked="true"/>
                    <asp:CheckBox ID="cb2" runat="server" Text="Acient Architecture" />
                    <asp:CheckBox ID="cb3" runat="server" Text="Museum" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <br />
                    <asp:Label runat="server" Text="Quick link to google:">   
                    </asp:Label><a href="https://www.google.com" rel="google" target="_blank">Google</a></td>
            </tr>
            <tr>
                <td colspan="2" class="tdButton">
                    <asp:Button runat="server" CssClass="button1" OnClick="submit" Text="submit" />
                </td>
                <td colspan="2" class="tdButton">
                    <input type="reset" class="button1" />
                </td>
            </tr>
        </table>
    </div>
    <asp:Panel CssClass="panel1" runat="server">
        <asp:Label runat="server" Text="Please fill in the form and click submit button..."></asp:Label><br />
        <asp:Label ID="Label1" runat="server" CssClass="errorMessage"></asp:Label><br />
        <asp:Label ID="Label14" runat="server" CssClass="errorMessage"></asp:Label><br />
        <asp:Label ID="Label2" runat="server"></asp:Label>
        <asp:Label ID="Label3" runat="server"></asp:Label><br />
        <asp:Label ID="Label4" runat="server"></asp:Label>
        <asp:Label ID="Label5" runat="server"></asp:Label><br />
        <asp:Label ID="Label6" runat="server"></asp:Label>
        <asp:Label ID="Label7" runat="server"></asp:Label><br />
        <asp:Label ID="Label8" runat="server"></asp:Label>
        <asp:Label ID="Label9" runat="server"></asp:Label><br />
        <asp:Label ID="Label10" runat="server"></asp:Label>
        <asp:Label ID="Label11" runat="server"></asp:Label><br />
        <asp:Label ID="Label13" runat="server"></asp:Label>
    </asp:Panel>
    <div class="displayLink">
        <a href="displayRecords.aspx" target="_blank">click here to see all the customers</a>
    </div>
    <div class="searchLink">
        <a href="searchRecords.aspx" target="_blank">click here to search for a single record</a>
    </div>
    <div class="addImg">
        <a href="../displayCode.aspx?filename=locked/registration.aspx" target="_blank">
            <asp:Image runat="server" ImageUrl="~/App_Data/pix/addRecords.png" /></a>
    </div>
    <div class="searchImg">
        <a href="../displayCode.aspx?filename=locked/searchRecords.aspx" target="_blank">
            <asp:Image runat="server" ImageUrl="~/App_Data/pix/searchRecords.png" /></a>
    </div>
    <div class="displayImg">
        <a href="../displayCode.aspx?filename=locked/displayRecords.aspx" target="_blank">
            <asp:Image runat="server" ImageUrl="~/App_Data/pix/displayRecords.png" /></a>
    </div>
    <asp:AccessDataSource runat="server" DataFile="~/App_Data/customer.accdb" ID="CustomerDS" >
    </asp:AccessDataSource>

</asp:Content>
