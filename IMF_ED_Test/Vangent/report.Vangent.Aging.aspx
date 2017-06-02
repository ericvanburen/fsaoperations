<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb"  %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckVangentLogin()
            
            lblReportDate.Text = "<b>Report Date: " & Today() & "</b>"
            GetOldestIMF()
            
        End If
    End Sub
    
    Private Function GetOldestIMF() As String
        Dim result As String = ""
        Dim dr As SqlDataReader
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("p_Report_Vangent_Oldest", con)
        cmd.CommandType = CommandType.StoredProcedure
        Using con
            con.Open()
            dr = cmd.ExecuteReader()
            While dr.Read()
                lblOldestDate.Text = "Oldest Date: " & dr("OldestIMF").ToString()
            End While
        End Using
        Return result
    End Function
   
      
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>WIP Aging Report – Number of Business Days Since Receipt</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <!-- datePicker required styles -->
	<link rel="stylesheet" type="text/css" media="screen" href="../js/datePicker.css" />

    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="../js/default.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">

                      
                        <!--This one populates the main Gridview-->
                        <asp:SqlDataSource ID="dsReport_Aging" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_Report_Vangent_Aging" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>

                                                 
                      <fieldset>
                        <legend class="fieldsetLegend">WIP Aging Report – Number of Business Days Since Receipt</legend><br />
                      
                      <div align="center">
                        <asp:Label ID="lblReportDate" runat="server" />
                      </div>
                        <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsReport_Aging" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowSorting="true">                           
                            
                            <EmptyDataTemplate>
                                    There are no IMFs for this time period
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                            <asp:BoundField DataField="IMF_Type" HeaderText="IMF Type" SortExpression="IMF_Type" />
                            <asp:BoundField DataField="1" HeaderText="1" SortExpression="1" />
                            <asp:BoundField DataField="2" HeaderText="2" SortExpression="2" />
                            <asp:BoundField DataField="3" HeaderText="3" SortExpression="3" />
                            <asp:BoundField DataField="4" HeaderText="4" SortExpression="4" /> 
                            <asp:BoundField DataField="5" HeaderText="5" SortExpression="5" />
                            <asp:BoundField DataField="6" HeaderText="6" SortExpression="6" />
                            <asp:BoundField DataField="7" HeaderText="7" SortExpression="7" />
                            <asp:BoundField DataField="8" HeaderText="8" SortExpression="8" />
                            <asp:BoundField DataField="9" HeaderText="9" SortExpression="9" />
                            <asp:BoundField DataField="10" HeaderText="10" SortExpression="10" />
                            <asp:BoundField DataField="10+" HeaderText="10+" SortExpression="10+" />                                   
                            </Columns>
                            </asp:GridView>
                            <br /><br />
                            <asp:Label ID="lblOldestDate" runat="server" />
                    </div>
                    </fieldset>
                       
                    
                       
    
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblEDUserName" runat="server" Visible="false" />
    </form>
</body>
</html>
