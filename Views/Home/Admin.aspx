<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MiniAirlineeservationSystem.Models.SystemAdmin>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Admin
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Register here to become a system admin.</h2>
    <% if (ViewData["ErrMsg"] != null && !String.IsNullOrEmpty(ViewData["ErrMsg"].ToString()))
       { %>
           <div><font color = "red"><%: ViewData["ErrMsg"]%></font></div>
    <% }%>
    <p>
        Please enter your username and password to register. <%: Html.ActionLink("SignIn", "SignIn") %> if you already have an account.
    </p>
    <form method = "post" action = "Admin">
        <div><%: Html.LabelFor(model => model.UserName)%></div>
        <div><%: Html.TextBoxFor(model => model.UserName)%><%: Html.ValidationMessageFor(model => model.UserName) %></div>
        
        <div><%: Html.LabelFor(model => model.Password)%></div>
        <div><%: Html.PasswordFor(model => model.Password)%><%: Html.ValidationMessageFor(model => model.Password) %></div>

        <input type = "submit" value = "Submit"/>
    </form>
</asp:Content>
