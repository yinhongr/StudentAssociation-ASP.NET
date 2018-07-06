<%@ Page Language="C#" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<!DOCTYPE html>

<script runat="server">
    void displaySingleCustomer(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Page")
        {
            return;
        }
        lblDisplayCustomer.Text = "<table><tr><td><img src=\"" + 
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[12].Text + 
            "\"/> </td><td><b>Selected Customer: </b><p /><b>Id: </b>" +
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[1].Text +
            " <b>Name: </b>" +
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[2].Text +
            " <b>Age: </b>" +
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[3].Text +
            "<br /><b>Gender: </b>" +
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[4].Text +
            " <b>Country: </b>" +
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[5].Text +
            "<br /><b>Email: </b>" +
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[7].Text +
            "<br /><b>Depart Date: </b>" +
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[9].Text +
            "<br /><b>Return Date: </b>" +
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[10].Text +
            "<br /><b>Interested Scenery: </b>" +
            gvCustomers.Rows[Convert.ToInt32(e.CommandArgument)].
            Cells[11].Text +
            "</td></tr></table>";
        
    }
    void Page_Load()
    {
        CustomerDS.SelectCommand = "Select cust_id, cust_name, cust_age, cust_gender, " +
                                                    "cust_country, '*****' as cust_pwd, " +
                                                    "cust_email, cust_prefer_city, " +
                                                    "cust_depart_date, cust_return_date, " +
                                                    "cust_interest, city_url from customer order by cust_id";
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Display Records</title>
    <link rel="stylesheet" href="../Style.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
            <h1>Customer Records</h1>
            <asp:Label ID="lblDisplayCustomer" runat="server"
                CssClass="displayCustLabel" />
            <asp:GridView ID="gvCustomers"
                runat="server"
                DataSourceID="CustomerDS"
                HeaderStyle-CssClass="customersHeader"
                CssClass="customersGrid"
                AlternatingRowStyle-CssClass="customersAlternate"
                RowStyle-CssClass="customersRow"
                AutoGenerateColumns="false"
                OnRowCommand="displaySingleCustomer" 
                AllowPaging="true" PageSize="5">
                <Columns>
                    <asp:ButtonField ButtonType="Button" Text="Display" 
                        ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_id" HeaderText="Id"
                        ReadOnly="True" ItemStyle-CssClass="customerItem" />
                    <asp:BoundField DataField="cust_name"
                        HeaderText="UserName"
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
    </form>
</body>
</html>
