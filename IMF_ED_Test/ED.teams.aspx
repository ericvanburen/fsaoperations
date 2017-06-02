<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" EnableEventValidation = "false" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                lblEDUserName.Text = (Request.Cookies("IMF")("EDUserName").ToString())
            End If
        End If
    End Sub
               
    Protected Sub ddlAllTeams_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
       
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_TeamMembers"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@Id_Team", SqlDbType.VarChar).Value = ddlAllTeams.SelectedValue
         
        Try
            con.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "SearchResults")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "This team contains " & intRecordCount & " members"

            GridView1.DataSource = ds.Tables("SearchResults").DefaultView
            GridView1.DataBind()
            
        Finally
            con.Close()
        End Try
        
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ED Team Assignments</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
                   <!--This one populates the ddlAllTeams dropdown-->
                      <asp:SqlDataSource ID="dsAllTeams" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllTeams" SelectCommandType="StoredProcedure" />              
     <fieldset>
    <legend class="fieldsetLegend">Team Assignments</legend><br />
    <div align="left">
    <table border="0">
    <tr>
            <td class ="formLabelForm">Select Team Name:</td>
            <td>  
                <asp:DropDownList id="ddlAllTeams" Runat="Server"
                                DataSourceID="dsAllTeams"
                                DataTextField="Team_Name" 
                                DataValueField="Id_Team" 
                                CssClass="formLabel" AppendDataBoundItems="true" 
                                AutoPostBack="true" onselectedindexchanged="ddlAllTeams_SelectedIndexChanged">                            
                                <asp:ListItem Value=""></asp:ListItem>
       </asp:DropDownList></td>            
        </tr>
        </table>
        
                       <div class="grid" align="center"> 
                       <asp:Label ID="lblRowCount" runat="server" />
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="Userid" AutoGenerateColumns="false" CellPadding="4" 
                            CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal">
                            <RowStyle CssClass="row" />
                            <Columns>
                                <asp:HyperLinkField 
                                    DataTextField="Username" 
                                    HeaderText="User Name" 
                                    DataNavigateUrlFields="UserId" 
                                    ItemStyle-CssClass="first" 
                                    DataNavigateUrlFormatString="ED.user.admin.aspx?UserId={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>
                                    
                                <asp:BoundField 
                                    DataField="IsActive" 
                                    HeaderText="Is Active User?" 
                                    SortExpression="IsActive" />
                                    
                                </Columns>                
                            </asp:GridView>
                            </div>
                             </div>
        </fieldset>                                           
    
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblEDUserName" runat="server" Visible="false" />
    </form>
</body>
</html>
