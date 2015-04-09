<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MiniAirlineeservationSystem.Models.Customer>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	BookingDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>BookingDetails</h2>
    <form method = "post" action = "">
        <table>
            <tr>
                <th>
                    FlightNo
                </th>
                <th>
                    FirstName
                </th>
                <th>
                    LastName
                </th>
                <th>
                    Age
                </th>
                <th>
                    SeatNo
                </th>
                <th>
                    DepartureDate
                </th>
            </tr>
            <tr>
                <td>
                    <%: Model.FlightNo %>
                </td>
                <td>
                    <%: Model.FirstName%>
                </td>
                <td>
                    <%: Model.LastName%>
                </td>
                <td>
                    <%: Model.Age%>
                </td>
                <td>
                    <%: Model.SeatNo%>
                </td>
                <td>
                    <%: String.Format("{0:g}", Model.DepartureDate)%>
                </td>
            </tr>
        </table>
        <input type = "submit" value = "Edit Details" />
    </form>
</asp:Content>
