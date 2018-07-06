<%@ Page Language="C#" MasterPageFile="../MasterPage.master" StylesheetTheme="default" %>

<asp:Content ID="documentationContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="mainPage">
        <h3>Details of the author</h3>
        <p>
            <br />
            name: Zhenyu Liu
            <br />
            student ID: 26373181<br />
            unit name: FIT5032 Internet applications development<br />
            unit provider:Monash University, The Caulfield School of Information Technology<br />
            assignment number: 2<br />
            date of submission: 09/10/2015
            <br />
            tutors name: Julian Li
            <br />
            Author's E-mail: <a href="mailto:zliu191@student.monash.edu" rel="Author's E-mail">Author</a><br />
            assignment specification: <a href="http://moodle.vle.monash.edu/mod/page/view.php?id=2639835" rel="assignment details" target="_blank">file location</a>
        </p>
    </div>
    <div class="CSSImg">
        <a href="../displayCode.aspx?filename=Style.css" target="_blank">
            <asp:Image runat="server" ImageUrl="~/App_Data/pix/CSS.png" /></a>
    </div>
    <div class="skinImg">
        <a href="../displayCode.aspx?filename=~/App_Themes/default/default.skin" target="_blank">
            <asp:Image runat="server" ImageUrl="~/App_Data/pix/skin.png" /></a>
    </div>
</asp:Content>
