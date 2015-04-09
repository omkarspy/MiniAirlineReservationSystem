<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" ClientIDMode="Static" Inherits="System.Web.Mvc.ViewPage<dynamic>"%>
<%@ Import namespace = "System.Data.SqlClient" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        string connectionString = null;
        SqlCommand command;
        string sql = null;
        connectionString = "Data Source=OMKAR-PC\\OMKAR;Initial Catalog=airline;Integrated Security=True";
        sql = "INSERT INTO SystemAdmin VALUES('Harsh', 'secondaryAdmin');";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            command = new SqlCommand(sql, connection);
            command.Connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
        }
    }

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Login
</asp:Content>

<asp:Content ClientIDMode="Static" ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <form id="form1" runat="server" method="post">
    <center><h2>Enter credentials below. (Click <a href = "CreateAdmin">here</a> to register as a new system administrator)</h2><br />
    <div>
        <h2>Enter username : 
            <asp:TextBox ID="TextBox1" ClientIDMode="Static" runat="server"></asp:TextBox>
        </h2>
        <h2>Enter password : 
            <asp:TextBox ID="TextBox2" ClientIDMode="Static" runat="server"></asp:TextBox>
        </h2>
    </div>
    &nbsp;
    <input type="submit"  id="create_admin" value="Submit" />
    </center>
    </form>
</asp:Content>
