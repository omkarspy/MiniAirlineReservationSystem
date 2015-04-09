<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MiniAirlineeservationSystem.Models.Customer>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	SelectSeat
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Select your seat here.</h2>
<form method = "post" action = "BookingDetails">
    <table>
        <tr>
            <th></th>
            <th>
                A
            </th>
            <th>
                B
            </th>
            <th>
                C
            </th>
            <th></th>
            <th>
                D
            </th>
            <th>
                E
            </th>
            <th>
                F
            </th>
            <th>
                G
            </th>
            <th></th>
            <th>
                H
            </th>
            <th>
                I
            </th>
            <th>
                J
            </th>
            <th></th>
        </tr>

    <% HashSet<string> set = new HashSet<string>();
       foreach(var item in Model)
       {
           if(!item.SeatNo.Equals("") && !set.Contains(item.SeatNo))
           {
               set.Add(item.SeatNo); 
           }
       }
        
       int capacity = Model.Last().Capacity;
       string firstName = Model.Last().FirstName;
       string lastName = Model.Last().LastName;
       string flightNo = Model.Last().FlightNo;
       DateTime departureDate = Model.Last().DepartureDate;
       int customerId = Model.Last().CustomerId;
       int age = Model.Last().Age;
       int r = capacity % 10;
       int newRow = capacity/10 + 1;
       for (int i = 1; i <= capacity/10; i++)
       { %>
    
        <tr>
            <td><%: i %></td>
            <td>
                <% if (set.Contains("A" + i))
                   {%>
                    <input type = "radio" id = "A<%: i %>" name = "Selected_Seat" value = "A<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "A<%: i %>" name = "Selected_Seat" value = "A<%: i %>" />
                <% } %>
            </td>
            <td>
                <% if (set.Contains("B" + i))
                   {%>
                    <input type = "radio" id = "B<%: i %>" name = "Selected_Seat" value = "B<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "B<%: i %>" name = "Selected_Seat" value = "B<%: i %>" />
                <% } %>
            </td>
            <td>
                <% if (set.Contains("C" + i))
                   {%>
                    <input type = "radio" id = "C<%: i %>" name = "Selected_Seat" value = "C<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "C<%: i %>" name = "Selected_Seat" value = "C<%: i %>" />
                <% } %>
            </td>
            <td></td>
            <td>
                <% if (set.Contains("D" + i))
                   {%>
                    <input type = "radio" id = "D<%: i %>" name = "Selected_Seat" value = "D<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "D<%: i %>" name = "Selected_Seat" value = "D<%: i %>" />
                <% } %>
            </td>
            <td>
                <% if (set.Contains("E" + i))
                   {%>
                    <input type = "radio" id = "E<%: i %>" name = "Selected_Seat" value = "E<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "E<%: i %>" name = "Selected_Seat" value = "E<%: i %>" />
                <% } %>
            </td>
            <td>
                <% if (set.Contains("F" + i))
                   {%>
                    <input type = "radio" id = "F<%: i %>" name = "Selected_Seat" value = "F<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "F<%: i %>" name = "Selected_Seat" value = "F<%: i %>" />
                <% } %>
            </td>
            <td>
                <% if (set.Contains("G" + i))
                   {%>
                    <input type = "radio" id = "G<%: i %>" name = "Selected_Seat" value = "G<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "G<%: i %>" name = "Selected_Seat" value = "G<%: i %>" />
                <% } %>
            </td>
            <td></td>
            <td>
                <% if (set.Contains("H" + i))
                   {%>
                    <input type = "radio" id = "H<%: i %>" name = "Selected_Seat" value = "H<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "H<%: i %>" name = "Selected_Seat" value = "H<%: i %>" />
                <% } %>
            </td>
            <td>
                <% if (set.Contains("I" + i))
                   {%>
                    <input type = "radio" id = "I<%: i %>" name = "Selected_Seat" value = "I<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "I<%: i %>" name = "Selected_Seat" value = "I<%: i %>" />
                <% } %>
            </td>
            <td>
                <% if (set.Contains("J" + i))
                   {%>
                    <input type = "radio" id = "J<%: i %>" name = "Selected_Seat" value = "J<%: i %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "J<%: i %>" name = "Selected_Seat" value = "J<%: i %>" />
                <% } %>
            </td>
            <td></td>
        </tr>
    <% } %>
        <tr>
        <% if(r != 0){ %>
        <td><%: newRow%></td>
        <% } %>
        <% string id = "";
            for (int i = 1; i <= r; i++)
           { if(i == 1)
             {   id = "A" + (capacity/10 + 1);
             }
             else if(i == 2)
             {   id = "B" + (capacity/10 + 1);
             }
             else if(i == 3)
             {   id = "C" + (capacity/10 + 1);
             }
             else if(i == 4)
             {   id = "D" + (capacity/10 + 1);
                 %>
                 <td></td>
                 <%
             }
             else if(i == 5)
             {   id = "E" + (capacity/10 + 1);
             }
             else if(i == 6)
             {   id = "F" + (capacity/10 + 1);
             }
             else if(i == 7)
             {   id = "G" + (capacity/10 + 1);
             }
             else if(i == 8)
             {   id = "H" + (capacity/10 + 1);
                 %>
                 <td></td>
                 <%
             }
             else if(i == 9)
             {   id = "I" + (capacity/10 + 1);
             }
            %>
           <td>
               <% if (set.Contains(id))
                   {%>
                    <input type = "radio" id = "<%: id %>" name = "Selected_Seat" value = "<%: id %>" checked = "checked" disabled = "disabled"/>
                <% }
                   else
                   {
                    %>
                    <input type = "radio" id = "<%: id %>" name = "Selected_Seat" value = "<%: id %>" />
                <% } %>
           </td>
        <% }%>
        </tr>
    </table>
    <input type = "text" value = "<%: flightNo%>" name = "Flight_No" style = "visibility:hidden" />
    <input type = "text" value = "<%: firstName%>" name = "First_Name" style = "visibility:hidden" />
    <input type = "text" value = "<%: lastName%>" name = "Last_Name" style = "visibility:hidden" />
    <input type = "text" value = "<%: departureDate%>" name = "Departure_Date" style = "visibility:hidden" />
    <input type = "text" value = "<%: age%>" name = "Age" style = "visibility:hidden" />
    <input type = "text" value = "<%: capacity%>" name = "Capacity" style = "visibility:hidden" />
    <input type = "text" value = "<%: customerId%>" name = "Customer_Id" style = "visibility:hidden" />
    <br />
    <input type = "submit" value = "Book" />
</form>
</asp:Content>
