<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MiniAirlineeservationSystem.Models.SystemAdmin>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	SignIn
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>SignIn</h2>
    <% if (ViewData["ErrMsg"] != null && !String.IsNullOrEmpty(ViewData["ErrMsg"].ToString()))
       { %>
           <div><font color = "red"><%: ViewData["ErrMsg"]%></font></div>
    <% }%>
    <p>
        Please enter your username and password to SignIn. <%: Html.ActionLink("Register", "Admin") %> if you do not have a System Admin account yet.
    </p>
    <form method = "post" action = "SignIn">
        <div><%: Html.LabelFor(model => model.UserName)%></div>
        <div><%: Html.TextBoxFor(model => model.UserName)%><%: Html.ValidationMessageFor(model => model.UserName) %></div>
        
        <div><%: Html.LabelFor(model => model.Password)%></div>
        <div><%: Html.PasswordFor(model => model.Password)%><%: Html.ValidationMessageFor(model => model.Password) %></div>

        

        <input type = "submit" value = "Submit"/>
    </form>
</asp:Content>
