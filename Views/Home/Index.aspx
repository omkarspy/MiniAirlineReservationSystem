<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: ViewData["Message"] %></h2>

    <div>This is an Online Airline Reservation System by Omkar Yerunkar. Hurry and book your flights now!!! Tabs for System Admin and Customers are at the top right corner of the window.</div>
</asp:Content>
