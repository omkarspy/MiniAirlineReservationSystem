<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MiniAirlineeservationSystem.Models.Flight>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CreateFlight
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Create your flight here.</h2>
    <div>Click <%: Html.ActionLink("here", "DisplayFlights", "Flight")%> to see all the flights.</div>
    <div>Enter seating capacity, availaility, price (first/economy) in integers. Seating capacity should be greater than or equal to availability. Make sure arrival date is after departure date. Also, the source and destination should not be same.</div>
    <br />
    <% if (ViewData["ErrMsg"] != null && !String.IsNullOrEmpty(ViewData["ErrMsg"].ToString()))
       { %>
           <div><font color = "red"><%: ViewData["ErrMsg"]%></font></div>
    <% }%>
    <br />
    <form method = "post" action = "CreateFlight">
        <table>
            <tr></tr>
            <tr>
                <td><%: Html.Label("Flight Number (Eg: AA111) ")%></td>
                <td><%: Html.TextBoxFor(model => model.FlightNo)%><%: Html.ValidationMessageFor(model => model.FlightNo) %></td>
            </tr>
            <tr>
                <td><%: Html.Label("Seating Capacity (Eg: 70) ")%></td>
                <td><%: Html.TextBoxFor(model => model.Capacity)%><%: Html.ValidationMessageFor(model => model.Capacity) %></td>
            </tr>
            <tr>
                <td><%: Html.Label("First Class Price($) (Eg: 100) ")%></td>
                <td><%: Html.TextBoxFor(model => model.PriceFirstClass)%><%: Html.ValidationMessageFor(model => model.PriceFirstClass) %></td>
            </tr>
            <tr>
                <td><%: Html.Label("Economy Class Price($) (Eg: 100) ")%></td>
                <td><%: Html.TextBoxFor(model => model.PriceEconomyClass)%><%: Html.ValidationMessageFor(model => model.PriceEconomyClass) %></td>
            </tr>
            <tr>
                <td><%: Html.Label("Departure Airport (Eg: LAX) ")%></td>
                <td><%: Html.TextBoxFor(model => model.DepartureAirport)%><%: Html.ValidationMessageFor(model => model.DepartureAirport) %></td>
            </tr>
            <tr>
                <td><%: Html.Label("Arrival Airport (Eg: LAX) ")%></td>
                <td><%: Html.TextBoxFor(model => model.ArrivalAirport)%><%: Html.ValidationMessageFor(model => model.ArrivalAirport) %></td>
            </tr>
            <tr>
                <td><%: Html.Label("Departure Time (Eg: 01-23-2015 16:37:00) ")%></td>
                <td><%: Html.TextBoxFor(model => model.DepartureTime)%><%: Html.ValidationMessageFor(model => model.DepartureTime) %></td>
            </tr>
            <tr>
                <td><%: Html.Label("Arrival Time (Eg: 01-23-2015 16:37:00) ")%></td>
                <td><%: Html.TextBoxFor(model => model.ArrivalTime)%><%: Html.ValidationMessageFor(model => model.ArrivalTime) %></td>
            </tr>
            <tr>
                <td><%: Html.Label("Availability (Seats available) (Eg: 70) ")%></td>
                <td><%: Html.TextBoxFor(model => model.Availability)%><%: Html.ValidationMessageFor(model => model.Availability) %></td>
            </tr>
            <tr>
                <td><%: Html.Label("Departure Date (Eg: 01-23-2015) ")%></td>
                <td><%: Html.TextBoxFor(model => model.DepartureDate)%><%: Html.ValidationMessageFor(model => model.DepartureDate) %></td>
            </tr>
        </table>
        <input type = "submit" value = "Submit"/>
    </form>
</asp:Content>
