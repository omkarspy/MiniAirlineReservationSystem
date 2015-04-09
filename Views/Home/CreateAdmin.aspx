<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod()]
    [System.Web.Script.Services.ScriptMethod()]
    public static string Message()
    {
        return "Hello from the server-side World!";
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CreateAdmin
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<form id= "form1" runat = "server">
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
<script type="text/javascript">
    function GetMessage() {
        PageMethods.Message(OnGetMessageSuccess, OnGetMessageFailure);
    }
    function OnGetMessageSuccess(result, userContext, methodName) {
        alert("In here");
        //alert(result);
    }

    function OnGetMessageFailure(error, userContext, methodName) {
        //alert("Error");
        alert(error.get_message());
    }
</script>
    <div>
        <h2>Enter system password : <input type = "text" value = "" /></h2> 
        <input type = "submit" value = "Submit" onclick = ""/>
        <input onclick="GetMessage(); return false;" type="submit" value="Get Message" />
    </div>
</form>
</asp:Content>
