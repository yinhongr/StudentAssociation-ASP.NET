<%@ Page Language="C#" MasterPageFile="../MasterPage.master" StylesheetTheme="default" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Net" %>
<asp:Content ID="registrationContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script runat="server">
        void Page_Load()
        {
            CustomerDS.SelectCommand = "Select cust_id, cust_name, cust_email from customer order by cust_name";
        }

        public void SendEmail(object sender, EventArgs e)
        {
            MailMessage newMsg = new MailMessage();

            foreach (GridViewRow gvRow in gvCustomers.Rows)
            {
                CheckBox cb = (CheckBox)gvRow.FindControl("chkEmail");

                if (cb != null && cb.Checked)
                {
                    newMsg.To.Add(new MailAddress(gvRow.Cells[2].Text,
                     gvRow.Cells[1].Text));
                }
            }

            newMsg.From = new MailAddress(from.Text);
            newMsg.Subject = subject.Text;
            newMsg.Body = emailMessage.Text;

            try
            {
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.monash.edu.au";
                smtp.Send(newMsg);
                lblMail.Text = "Mail Successfully Sent";
            }
            catch (Exception exc)
            {
                lblMail.Text = exc.Message;
            }
        }
    </script>
    <asp:accessdatasource runat="server"
                DataFile="~/App_Data/customer.accdb" 
                id="CustomerDS" >
    </asp:accessdatasource>
    <h1 class="emailPageTitle">Send email</h1>
    <asp:GridView ID="gvCustomers"
        runat="server"
        DataSourceID="CustomerDS"
        DataKeyNames="cust_id"
        HeaderStyle-CssClass="customersHeader"
        CssClass="emailGrid"
        AlternatingRowStyle-CssClass="customersAlternate"
        RowStyle-CssClass="customersRow"
        AutoGenerateColumns="false"
        AllowPaging="true" PageSize="5">
        <Columns>
            <asp:BoundField DataField="CustID" Visible="false" />
            <asp:BoundField DataField="cust_name"
                HeaderText="UserName"
                ItemStyle-CssClass="customerItem" />
            <asp:BoundField DataField="cust_email"
                HeaderText="Email"
                ItemStyle-CssClass="customerItem" />
            <asp:TemplateField HeaderText="Select">
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="chkEmail" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div class="messageIndicator">
        <asp:label ID="lblMail" runat="server" />
    </div>
    
    <p />
    <div class="emailTable">
        <table>
            <tr>
                <td></td>
                <td>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                        runat="server" ControlToValidate="from"
                        ValidationExpression="([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,5})"
                        ErrorMessage="Invalid email address(x@x.x)" Display="dynamic" CssClass="errorMessage" />
                </td>
            </tr>
            <tr>
                <td class="emailHeader">From</td>
                <td >
                    <asp:TextBox ID="from" runat="server" CssClass="emailRow"/>
                </td>
            </tr>
            <tr>
                <td class="emailHeader">Subject</td>
                <td>
                    <asp:TextBox ID="subject" runat="server" CssClass="emailRow"/>
                </td>
            </tr>
            <tr>
                <td class="emailHeader">Message</td>
                <td class="emailRow">
                    <asp:TextBox runat="server" ID="emailMessage"
                        TextMode="MultiLine" Columns="55" Rows="15" />
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="SendEmailButton" runat="server"
            OnClick="SendEmail" CssClass="button1" Text="Send Email" />
        <br />
        <br />
    </div>
    <div class="emailImg">
        <a href="../displayCode.aspx?filename=locked/email.aspx" target="_blank">
            <asp:Image runat="server" ImageUrl="~/App_Data/pix/email.png" /></a>
    </div>
</asp:Content>
