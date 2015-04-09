<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MiniAirlineeservationSystem.Models.Flight>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	DisplayFlights
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>List of all flights available.</h2>
    <form id="form1" runat="server">
    <table>
        <tr>
            <th>
                Capacity
            </th>
            <th>
                PriceFirstClass
            </th>
            <th>
                PriceEconomyClass
            </th>
            <th>
                DepartureAirport
            </th>
            <th>
                ArrivalAirport
            </th>
            <th>
                DepartureTime
            </th>
            <th>
                ArrivalTime
            </th>
            <th>
                FlightNo
            </th>
            <th>
                Availability
            </th>
        </tr>

    <% foreach (MiniAirlineeservationSystem.Models.Flight flight in Model) { %>
    
        <tr>
            <td>
                <%: flight.Capacity%>
            </td>
            <td>
                <%: flight.PriceFirstClass%>
            </td>
            <td>
                <%: flight.PriceEconomyClass%>
            </td>
            <td>
                <%: flight.DepartureAirport%>
            </td>
            <td>
                <%: flight.ArrivalAirport%>
            </td>
            <td>
                <%: String.Format("{0:g}", flight.DepartureTime)%>
            </td>
            <td>
                <%: String.Format("{0:g}", flight.ArrivalTime)%>
            </td>
            <td>
                <%: flight.FlightNo%>
            </td>
            <td>
                <%: flight.Availability%>
            </td>
        </tr>
    
    <% } %>

    </table>
    </form>
    <br />
    <%: Html.ActionLink("Create New Flight", "CreateFlight", "Flight")%>
</asp:Content>
