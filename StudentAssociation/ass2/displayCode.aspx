<%@ Page Language="C#" runat="server" Debug="true" %>
<%@ Import Namespace="System.IO" %>
<script language="C#" runat="server">
    void Page_Load()
    {
        string filePath = Server.MapPath(Request.QueryString["filename"]);
        fileName.Text = Request.QueryString["filename"];
        if (File.Exists(filePath))
        {
            if (fileName.Text.Equals("index.aspx"))
            {
                code1.Text = ReadFile(filePath);
                fileName2.Text = "advertisement.xml";
                string filePath2 = Server.MapPath("advertisement.xml");
                code2.Text = ReadFile(filePath2);
            }
            else if (fileName.Text.Equals("locked/aboutUs.aspx"))
            {
                code1.Text = ReadFile(filePath);
                fileName2.Text = "locked/history.aspx";
                string filePath3 = Server.MapPath("locked/history.aspx");
                code2.Text = ReadFile(filePath3);
                fileName3.Text = "locked/FAQ.aspx";
                string filePath4 = Server.MapPath("locked/FAQ.aspx");
                code3.Text = ReadFile(filePath4);
            }
            else if (fileName.Text.Equals("~/login.aspx"))
            {
                code1.Text = ReadFile(filePath);
                fileName2.Text = "Web.config";
                string filePath3 = Server.MapPath("~/Web.config");
                code2.Text = ReadFile(filePath3);
                fileName3.Text = "locked/Web.config";
                string filePath4 = Server.MapPath("locked/Web.config");
                code3.Text = ReadFile(filePath4);
            }
            else
            {
                code1.Text = ReadFile(filePath);
            }
        }
        else
        {
            code1.Text = "Sorry the file doen't exist";
        }
    }

    private string ReadFile(string filepath)
    {
        string fileOutput = "";
        try
        {
            File.SetAttributes(filepath, FileAttributes.Normal);
            StreamReader FileReader = new StreamReader(filepath);
            while (FileReader.Peek() > -1)
            {
                fileOutput += FileReader.ReadLine().Replace("<", "&lt;").
                Replace(" ", "&nbsp;&nbsp;")
                            + "<br />";
            }
            FileReader.Close();
        }
        catch (FileNotFoundException e)
        {
            fileOutput = e.Message;
        }
        return fileOutput;
    }
</script>
<html>
<head>
    <title>Display Code</title>
    <link rel="stylesheet" href="Style.css" type="text/css" />
</head>
<body>
    <h1 class="displayCodeHeader">Source Code</h1>
    <asp:Label ID="fileName" CssClass="codeHeader" runat="server" />
    <asp:Panel ID="pnl1" CssClass="code" runat="server" Width="80%">
        <asp:Label ID="code1" runat="server" />
    </asp:Panel>
    <asp:Label ID="fileName2" CssClass="codeHeader" runat="server" />
    <asp:Panel ID="pnl2" CssClass="code" runat="server" Width="80%">
        <asp:Label ID="code2" runat="server" />
    </asp:Panel>
    <asp:Label ID="fileName3" CssClass="codeHeader" runat="server" />
    <asp:Panel ID="pnl3" CssClass="code" runat="server" Width="80%">
        <asp:Label ID="code3" runat="server" />
    </asp:Panel>
</body>
</html>
