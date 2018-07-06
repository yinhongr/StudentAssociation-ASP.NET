<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<!DOCTYPE html>

<script runat="server">

    protected void searchRecords(object sender, EventArgs e)
    {
        errLb.Text = "";
        string strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + (string)Server.MapPath("~/App_Data/customer.accdb");
        OleDbConnection objConn = new OleDbConnection(strConn);
        DataSet objDS = new DataSet();
        if (!idTb.Text.Equals(""))
        {
            int id = Int32.Parse(idTb.Text.Trim());
            string strSQL = "Select cust_id, cust_name, cust_age, cust_gender, " +
                                                    "cust_country, '*****' as cust_pwd, " +
                                                    "cust_email, cust_prefer_city, " +
                                                    "cust_depart_date, cust_return_date, " +
                                                    "cust_interest, city_url from customer " +
                                                    "where cust_id = " + id;

            searchInDb(strSQL, strConn, objDS);
        }
        else if (!nameTb.Text.Equals("") && idTb.Text.Equals(""))
        {
            string name = nameTb.Text.Trim();
            string strSQL = "Select cust_id, cust_name, cust_age, cust_gender, " +
                                                    "cust_country, '*****' as cust_pwd, " +
                                                    "cust_email, cust_prefer_city, " +
                                                    "cust_depart_date, cust_return_date, " +
                                                    "cust_interest, city_url from customer " +
                                                    "where cust_name = '" + name + "'";

            searchInDb(strSQL, strConn, objDS);
        }
        else if (!emailTb.Text.Equals("") && idTb.Text.Equals("") && nameTb.Text.Equals(""))
        {
            string email = emailTb.Text.Trim();
            string strSQL = "Select cust_id, cust_name, cust_age, cust_gender, " +
                                                    "cust_country, '*****' as cust_pwd, " +
                                                    "cust_email, cust_prefer_city, " +
                                                    "cust_depart_date, cust_return_date, " +
                                                    "cust_interest, city_url from customer " +
                                                    "where cust_email = '" + email + "'";
            searchInDb(strSQL, strConn, objDS);
        }
        else
        {
            errLb.Text = "please enter something to search!";
        }
    }
    void searchInDb(string strSQL, string strConn, DataSet objDS)
    {
        OleDbDataAdapter objDataAdapter = new OleDbDataAdapter(strSQL, strConn);
        objDataAdapter.Fill(objDS, "customer");
        gvCustomers.DataSource = objDS;
        gvCustomers.DataBind();
        if (objDataAdapter.Fill(objDS) == 1)
        {
            errLb.Text = "";
            return;
        }
        else
        {
            errLb.Text = "No result matched!";
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search Record</title>
    <link rel="stylesheet" href="../Style.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <h1>Search Records</h1>
        <div>
            <table class="table3">
                <tr>
                    <td>
                        <asp:Label runat="server" ID="idLb" Text="Customer Id: "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="idTb" CssClass="textbox"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
                        runat="server" ControlToValidate="idTb"
                        ValidationExpression="[0-9]*"
                        ErrorMessage="Invalid customer id(123)" Display="dynamic" CssClass="errorMessage" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="nameLb" Text="User Name: "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="nameTb" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="emailLb" Text="Customer email: "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="emailTb" CssClass="textbox"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                        runat="server" ControlToValidate="emailTb"
                        ValidationExpression="([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,5})"
                        ErrorMessage="Invalid email address(x@x.x)" Display="dynamic" CssClass="errorMessage" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button runat="server" Text="Search" CssClass="buuton1" OnClick="searchRecords"/>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <asp:Label runat="server" ID="errLb" CssClass="errorMessage"></asp:Label><p></p>
            <asp:GridView ID="gvCustomers"
                runat="server"
                HeaderStyle-CssClass="customersHeader"
                CssClass="customersGrid"
                AlternatingRowStyle-CssClass="customersAlternate"
                RowStyle-CssClass="customersRow"
                AutoGenerateColumns="false" >
                <Columns>
                    <asp:BoundField DataField="cust_id" HeaderText="Id"
                        ReadOnly="True" ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_name"
                        HeaderText="Name"
                        ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_age"
                        HeaderText="Age"
                        ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_gender"
                        HeaderText="Gender"
                        ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_country"
                        HeaderText="Country" 
                        ItemStyle-CssClass="customerItem"/>
                    <asp:BoundField DataField="cust_pwd"
                        HeaderText="Password" 
                        ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_email"
                        HeaderText="Email"
                        ItemStyle-CssClass="customerItem" />
                    <asp:HyperLinkField DataTextField="cust_prefer_city"
                        HeaderText="Prefer city"
                        DataNavigateUrlFields="city_url"
                        ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_depart_date"
                        HeaderText="Depart date"
                        ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_return_date"
                        HeaderText="Return date"
                        ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_interest"
                        HeaderText="Interested scenery"
                        ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="city_url"
                        HeaderText="city image url"
                        ItemStyle-CssClass="customerItem" />
                </Columns>
            </asp:GridView>
            <asp:accessdatasource runat="server"
                DataFile="~/App_Data/customer.accdb" 
                id="CustomerDS" >
            </asp:accessdatasource>
        </div>
    </form>
</body>
</html>
