<%@ Page Language="C#" MasterPageFile="../MasterPage.master" StylesheetTheme="default" %>

<asp:Content ID="siteMapContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:SiteMapDataSource ID="SiteMapDataSource1"
            runat="server" />
        <asp:TreeView ID="TreeView1" SkinID="TreeView" runat="server" DataSourceID="SiteMapDataSource1" ShowLines="True" />
    </div>
    <div class="sitemapImg">
        <a href="../displayCode.aspx?filename=locked/siteMap.aspx" target="_blank">
            <asp:Image runat="server" ImageUrl="~/App_Data/pix/siteMap.png" /></a>
    </div>
</asp:Content>
