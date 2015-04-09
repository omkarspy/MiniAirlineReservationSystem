<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MiniAirlineeservationSystem.Models.Table>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CreateTable
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>DO NOT TOUCH THIS PAGE. THIS PAGE IS NOT A PART OF THE APPLICATION. (USED TO CREATE TABLES ON THE SERVER)</h2>
    <form method = "post" action = "Create">
        <%: Html.Label("Enter Query : ")%> &nbsp <%: Html.TextBoxFor(model => model.Query)%>
        <input type = "submit" value = "Submit Query"/>
    </form>
</asp:Content>
