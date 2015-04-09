<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MiniAirlineeservationSystem.Models.Flight>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CustomerDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Enter your details here.</h2>
    <% if (ViewData["ErrMsg"] != null && !String.IsNullOrEmpty(ViewData["ErrMsg"].ToString()))
       { %>
           <div><font color = "red"><%: ViewData["ErrMsg"]%></font></div>
    <% }%>
    <br />
    <form method = "post" action = "BookingConfirmation">
    <table>
        <tr><th>
                Selected
            </th>
            <th>
                FlightNo
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
                Availability
            </th>
        </tr>
        <tr>
            <td>
                <input type="radio" name="Book_FlightNo" id="<%: Model.FlightNo%>" value="<%: Model.FlightNo %>" checked = "checked"/>
            </td>
            <td>
                <%: Model.FlightNo %>
            </td>
            <td>
                <%: Model.PriceFirstClass %>
            </td>
            <td>
                <%: Model.PriceEconomyClass%>
            </td>
            <td>
                <%: Model.DepartureAirport %>
            </td>
            <td>
                <%: Model.ArrivalAirport %>
            </td>
            <td>
                <%: Model.DepartureTime %>
            </td>
            <td>
                <%: Model.ArrivalTime %>
            </td>
            <td>
                <%: Model.Availability %>
            </td>
        </tr>
    </table>
    <br /><br />
    
        <%: Html.Label("First Name : ")%><input type = "text" value = "" name = "First_Name"/>
    
        <%: Html.Label("Last Name : ")%><input type = "text" value = "" name = "Last_Name"/>

        <%: Html.Label("Age : ")%><input type = "text" value = "" name = "Age"/>

        <input type = "text" value = "<%: Model.FlightNo %>" name = "Flight_No" id = "<%: Model.FlightNo %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.PriceFirstClass %>" name = "Price_First_Class" id = "<%: Model.PriceFirstClass %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.PriceEconomyClass %>" name = "Price_Economy_Class" id = "<%: Model.PriceEconomyClass %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.DepartureAirport %>" name = "Departure_Airport" id = "<%: Model.DepartureAirport %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.ArrivalAirport %>" name = "Arrival_Airport" id = "<%: Model.ArrivalAirport %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.DepartureTime %>" name = "Departure_Time" id = "<%: Model.DepartureTime %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.ArrivalTime %>" name = "Arrival_Time" id = "<%: Model.ArrivalTime %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.Availability %>" name = "Availability" id = "<%: Model.Availability %>" style = "visibility:hidden" />    
        <input type = "text" value = "<%: Model.DepartureDate %>" name = "Departure_Date" style = "visibility:hidden"/>
        <input type = "text" value = "<%: Model.Capacity %>" name = "Capacity" style = "visibility:hidden"/>
        <br />
        <input type = "submit" value = "Submit"/>
    </form>

</asp:Content>
