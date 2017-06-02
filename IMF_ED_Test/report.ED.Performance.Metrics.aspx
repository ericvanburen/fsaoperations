<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"  %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
        End If
    End Sub
    
    Sub btnRunReport_Click(ByVal sender As Object, ByVal e As EventArgs)
        
    End Sub
    
    
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMF</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <!-- datePicker required styles -->
	<link rel="stylesheet" type="text/css" media="screen" href="js/datePicker.css" />

    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="js/default.js"></script>
   <script language="javascript" src="js/date.js" type="text/javascript"></script>
   <script language="javascript" src="js/jquery.datePicker.js" type="text/javascript"></script>
   <script language="javascript" type="text/javascript">
       Date.firstDayOfWeek = 0;
       Date.format = 'mm/dd/yyyy';
       $(function () {
           $('.date-pick').datePicker({ startDate: '01/01/1996' });
       });
   </script>
</head>
<body>
    <form id="form1" runat="server">

                      
                      <!--This one populates the main Gridview-->
                      <asp:SqlDataSource ID="dsDaily_Metrics_Report" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_Daily_Metrics_Report" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter Name="BeginDate" ControlID="txtBeginDate" />
                                <asp:ControlParameter Name="EndDate" ControlID="txtEndDate" />
                            </SelectParameters>                            
                            </asp:SqlDataSource> 
                      
                      <fieldset>
                        <legend class="fieldsetLegend">IMF Daily Performance Metrics Report</legend><br />
                       
                       <table>
                      <tr>
                            <td> <label for="date1">Select Begin Date: </label></td>
                            <td><asp:TextBox ID="txtBeginDate" CssClass="date-pick" runat="server" /></td>
                      </tr>
                      <tr>
                            <td> <label for="date2">Select End Date: </label></td>
                            <td><asp:TextBox ID="txtEndDate" CssClass="date-pick" runat="server" /></td>
                      </tr>
                      <tr>
                        <td><asp:Button ID="btnRunReport" OnClick="btnRunReport_Click" runat="server" Text="Run Report" /></td>
                      </tr>
                      </table> 
                      <p> </p>
                        <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsDaily_Metrics_Report" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowSorting="true">                           
                            
                            <EmptyDataTemplate>
                                    There are no IMFs for this time period
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                            <asp:BoundField DataField="IMF_Type" HeaderText="IMF Type" SortExpression="IMF_Type" />
                            <asp:BoundField DataField="TotalCompleted" HeaderText="Total Completed" SortExpression="TotalCompleted" />
                            <asp:BoundField DataField="AverageAge" HeaderText="Avg Age" SortExpression="AverageAge" />                           
                            </Columns>
                            </asp:GridView>
                    </div>
                    </fieldset>
                       
                    
                       
    
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblEDUserName" runat="server" Visible="false" />
    </form>
</body>
</html>
