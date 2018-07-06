<%@ Page Language="C#" MasterPageFile="MasterPage.master" StylesheetTheme="default" %>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="mainPage">
        <table class="table1">
            <tr>
                <td class="banner1">
                    <img id="image4" src="../App_Data/pix/iconLeft.png" />
                </td>
                <td class="banner">
                    <span id="homePageTitle">Great locations</span>
                </td>
                <td class="banner1">
                    <img id="image5" src="../App_Data/pix/iconRight.png" />
                </td>
            </tr>
        </table>
        <p id="homePageText">Home Page</p>
        <span>Join us and we will show you around the Chinese great locations</span>
        <script>
            for (var i = 0; i < 3; i++) {
                document.write("<br />");
            }
        </script>
        <span>Page last modified on <span id="sp1"></span></span>
        <br />
        <span>Page contents are valid utill 11 September 2015</span><br />
        <br />
        <span>This page is best viewed at resolution 1024 * 768</span><br />
        <br />
        <hr id="hr1" />
        <span><a href="http://users.monash.edu.au/~sgrose/msh/disclaimer.htm" rel="Monash course disclaimer" target="_blank">Monash disclaimer</a></span><br />
        <span>E-mail: <a href="mailto:zliu191@student.monash.edu" rel="Mail to the author">Author</a></span><br />
        <span>E-mail: <a href="mailto:zliu191@student.monash.edu" rel="Mail to the server webmaster">Webmaster</a></span><br />
        <span>Copyright notice: All texts rights reserved</span><br />
        <span>Acknowledgement: the icons used in the website is all
            <br />
            copyright free and found from 
                <a href="https://www.iconfinder.com/free_icons" rel="free icons" target="_blank">free icons website</a></span><br />
        <span>The advertisements' pictures are copyright free too</span>
        <hr id="hr2" />
        <script>
            function displayLastModifiedDate() {
                var x = new Date(document.lastModified);
                var y = x.toLocaleString();
                document.getElementById("sp1").innerHTML = y;
            }
            displayLastModifiedDate();
        </script>

    </div>
    <div class="adRotator1">
        <asp:AdRotator ID="adRotator1" runat="server" AdvertisementFile="advertisement.xml" />
    </div>
    <div class="adRotator2">
        <asp:AdRotator ID="adRotator2" runat="server" AdvertisementFile="advertisement.xml" />
    </div>

    <div class="adImg">
        <a href="displayCode.aspx?filename=index.aspx" target="_blank">
            <asp:Image runat="server" ImageUrl="~/App_Data/pix/adRotator.png" /></a>
    </div>
    <div class="masterImg">
        <a href="displayCode.aspx?filename=MasterPage.master" target="_blank">
            <asp:Image runat="server" ImageUrl="~/App_Data/pix/masterPage.png" /></a>
    </div>
</asp:Content>
