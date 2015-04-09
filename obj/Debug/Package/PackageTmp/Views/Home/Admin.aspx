<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Login
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <center><h2>Enter credentials below. (Click <a href = "CreateAdmin">here</a> to register as a new system administrator)</h2><br />
    <div>
        <h2>Enter username : <input type = "text" value = ""/></h2>
        <h2>Enter password : <input type = "text" value = ""/></h2>
    </div>
    <input type = "submit" id = "submit" value = "Submit" />
    </center>
</asp:Content>
