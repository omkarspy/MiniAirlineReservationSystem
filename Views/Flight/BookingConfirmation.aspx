<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MiniAirlineeservationSystem.Models.Customer>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	BookingConfirmation
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Booking Confirmation</h2>
    <% if (ViewData["ErrMsg"] != null && !String.IsNullOrEmpty(ViewData["ErrMsg"].ToString()))
       { %>
           <div><font color = "red"><%: ViewData["ErrMsg"]%></font></div>
    <% }%>

    <br />
    <div>You can select and/or reselect your seat. Just click on the Select Seat button below. Reselection is possible if and only if all other seats are not booked.</div>
    <br />
    <form method = "post" action = "SelectSeat">
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
                    Seat No
                </th>
                <th>
                    Departure Date
                </th>
                <th>
                    Customer Id
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
                <td>
                    <%: Model.CustomerId %>
                </td>
            </tr>
        </table>
        <div><font color = "red">Note down the customer id for future reference. (Changing seats in future)</font></div>
        <input type = "text" value = "<%: Model.FlightNo %>" name = "Flight_No" id = "<%: Model.FlightNo %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.FirstName %>" name = "First_Name" id = "<%: Model.FirstName %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.LastName %>" name = "Last_Name" id = "<%: Model.LastName %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.Age %>" name = "Age" id = "<%: Model.Age %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.SeatNo %>" name = "Seat_No" id = "<%: Model.SeatNo %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.DepartureDate %>" name = "Departure_Date" id = "<%: Model.DepartureDate %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.Capacity %>" name = "Capacity" id = "<%: Model.Capacity %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.CustomerId %>" name = "Customer_Id" id = "<%: Model.CustomerId %>" style = "visibility:hidden" />  
        <br />
        <input type = "submit" value = "Select Seat" />
        <br /><br />
        <div>Click <%: Html.ActionLink("here", "SearchFlight", "Flight") %> to start your new search for flights or click on the Customer tab to the right top corner of the window.</div>  
    </form>
</asp:Content>
