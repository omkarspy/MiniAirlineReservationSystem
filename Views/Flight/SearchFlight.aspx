<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MiniAirlineeservationSystem.Models.SearchFlight>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Customer
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Search your flight here.</h2>
    <% if (ViewData["ErrMsg"] != null && !String.IsNullOrEmpty(ViewData["ErrMsg"].ToString()))
       { %>
           <div><font color = "red"><%: ViewData["ErrMsg"]%></font></div>
    <% }%>

    <form method = "post" action = "BookFlight">
        <div><%: Html.LabelFor(model => model.Source)%></div>
        <div><%: Html.TextBoxFor(model => model.Source)%><%: Html.ValidationMessageFor(model => model.Source) %></div>
        
        <div><%: Html.LabelFor(model => model.Destination)%></div>
        <div><%: Html.TextBoxFor(model => model.Destination)%></div>

        <div><%: Html.LabelFor(model => model.DateOfJourney)%></div>
        <div><%: Html.TextBoxFor(model => model.DateOfJourney)%><%: Html.ValidationMessageFor(model => model.DateOfJourney) %></div>


        <input type = "submit" value = "Search"/>
    </form>
    <br />
    <div>Click <%: Html.ActionLink("here", "Display", "Flight")%> to see all the flights available and select from them if search does not work for you.</div>
</asp:Content>
