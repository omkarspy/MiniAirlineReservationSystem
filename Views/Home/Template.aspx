<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Template
</asp:Content>

<script runat="server">

    public class MyTemplate : System.Web.UI.ITemplate
    {
        System.Web.UI.WebControls.ListItemType templateType;
        public MyTemplate(System.Web.UI.WebControls.ListItemType type)
        {
            templateType = type;
        }

        public void InstantiateIn(System.Web.UI.Control container)
        {
            PlaceHolder ph = new PlaceHolder();
            Label item1 = new Label();
            Label item2 = new Label();
            item1.ID = "item1";
            item2.ID = "item2";

            switch (templateType)
            {
                case ListItemType.Header:
                    ph.Controls.Add(new LiteralControl("<table border=\"1\">" +
                        "<tr><td><b>Category ID</b></td>" + 
                        "<td><b>Category Name</b></td></tr>"));
                    break;
                case ListItemType.Item:
                    ph.Controls.Add(new LiteralControl("<tr><td>"));
                    ph.Controls.Add(item1);
                    ph.Controls.Add(new LiteralControl("</td><td>"));
                    ph.Controls.Add(item2);
                    ph.Controls.Add(new LiteralControl("</td></tr>"));
                    ph.DataBinding += new EventHandler(Item_DataBinding);
                    break;                    
                case ListItemType.AlternatingItem:
                    ph.Controls.Add(new LiteralControl("<tr bgcolor=\"lightblue\"><td>"));
                    ph.Controls.Add(item1);
                    ph.Controls.Add(new LiteralControl("</td><td>"));
                    ph.Controls.Add(item2);
                    ph.Controls.Add(new LiteralControl("</td></tr>"));
                    ph.DataBinding += new EventHandler(Item_DataBinding);
                    break;
                case ListItemType.Footer:
                    ph.Controls.Add(new LiteralControl("</table>"));
                    break;
            }
            container.Controls.Add(ph);
        }
    }

    static void Item_DataBinding(object sender, System.EventArgs e)
    {
        PlaceHolder ph = (PlaceHolder)sender;
        RepeaterItem ri = (RepeaterItem)ph.NamingContainer;
        String item1Value = (String)DataBinder.Eval(ri.DataItem, "username");
        String item2Value = (String)DataBinder.Eval(ri.DataItem, "password");
        ((Label)ph.FindControl("item1")).Text = item1Value.ToString();
        ((Label)ph.FindControl("item2")).Text = item2Value;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        string connectionString = "Data Source=OMKAR-PC\\OMKAR;Initial Catalog=airline;Integrated Security=True";
        System.Data.SqlClient.SqlConnection conn =
            new System.Data.SqlClient.SqlConnection(connectionString);

        System.Data.SqlClient.SqlDataAdapter sqlDataAdapter1;
        System.Data.DataSet dsCategories1;

        sqlDataAdapter1 = new System.Data.SqlClient.SqlDataAdapter(
            "SELECT [username], [password] FROM [SystemAdmin]", conn);
        dsCategories1 = new System.Data.DataSet();

        Repeater1.HeaderTemplate = new MyTemplate(ListItemType.Header);
        Repeater1.ItemTemplate = new MyTemplate(ListItemType.Item);
        Repeater1.AlternatingItemTemplate =
           new MyTemplate(ListItemType.AlternatingItem);
        Repeater1.FooterTemplate = new MyTemplate(ListItemType.Footer);
        sqlDataAdapter1.Fill(dsCategories1, "SystemAdmin");
        Repeater1.DataSource = dsCategories1.Tables["SystemAdmin"];
        Repeater1.DataBind();
    }


</script>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Template</h2>
    <form id="form1" runat="server">
    <div>
      <asp:Repeater id="Repeater1" runat="server"></asp:Repeater>
    </div>
    </form>
</asp:Content>
