<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MiniAirlineeservationSystem.Models.Table>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CreateTable
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>CreateTable</h2>
    <form method = "post" action = "CreateTable">
        <%: Html.Label("Enter Query : ")%> &nbsp <%: Html.TextBoxFor(model => model.Query)%>
        <input type = "submit" value = "Submit Query"/>
    </form>

</asp:Content>
