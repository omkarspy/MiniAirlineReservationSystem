<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MiniAirlineeservationSystem.Models.Flight>>"%>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	BookFlight
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type ="text/javascript">
        function submitVisible() {
            document.getElementById("submit").style.visibility = "visible";
        }
    </script>
    <h2>Select your flight here.</h2>
    <div>Click on the radio button in the first column of the table below to select corresponding flight. Select one of the flights listed below and then proceed to booking. </div>
    <br />
    <form action = "CustomerDetails" method = "post">
    <table class = "displaySearchedFlights">
        <tr>
            <th><%: Html.Label("Select") %></th>
            <th><%: Html.Label("Flight number") %></th>
            <th><%: Html.Label("Price in $ (First)") %></th>
            <th><%: Html.Label("Price in $ (Economy)") %></th>
            <th><%: Html.Label("Departure From") %></th>
            <th><%: Html.Label("Arrival To") %></th>
            <th><%: Html.Label("Departure Time") %></th>
            <th><%: Html.Label("Arrival Time") %></th>
            <th><%: Html.Label("Availability") %></th>
        </tr>
        <% foreach(MiniAirlineeservationSystem.Models.Flight item in Model) { %>
        <tr>
            <td>
                <input type="radio" name="Book_FlightNo_Departure_Date" id="<%: item.FlightNo%>, <%:item.DepartureDate%>" value="<%: item.FlightNo %>, <%:item.DepartureDate %>" onclick = "submitVisible()"/>
            </td>
            <td>
                <%: item.FlightNo %>
            </td>
            <td>
                <%: item.PriceFirstClass %>
            </td>
            <td>
                <%: item.PriceEconomyClass %>
            </td>
            <td>
                <%: item.DepartureAirport %>
            </td>
            <td>
                <%: item.ArrivalAirport %>
            </td>
            <td>
                <%: String.Format("{0:g}", item.DepartureTime) %>
            </td>
            <td>
                <%: String.Format("{0:g}", item.ArrivalTime) %>
            </td>
            <td>
                <%: item.Availability %>
            </td>
            
        </tr>
        <% } %>
    </table>
    <br />
    <div id = "submit" style = "visibility:hidden">
        <input type = "submit" value = "Proceed to booking"/>
    </div>
    </form>
    <br />
    <div>Click <%: Html.ActionLink("here", "SearchFlight", "Flight") %> to start your new search for flights or click on the Customer tab to the right top corner of the window.</div>  
</asp:Content>