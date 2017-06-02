<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
               
    End Sub
    
   
    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs)
        SqlDataSource1.SelectParameters("Week_Ending_Begin").DefaultValue = ddlBeginDate.SelectedValue
        SqlDataSource1.SelectParameters("Week_Ending_End").DefaultValue = ddlEndDate.SelectedValue
        SqlDataSource1.DataBind()
        'Grid2.DataBind()
    End Sub
    
    Sub GridView1_RowDataBound(Sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(5).Text = "Green" Then
                e.Row.Cells(5).BackColor = System.Drawing.Color.LightGreen
            ElseIf e.Row.Cells(5).Text = "Yellow" Then
                e.Row.Cells(5).BackColor = System.Drawing.Color.LemonChiffon
            ElseIf e.Row.Cells(5).Text = "Red" Then
                e.Row.Cells(5).BackColor = System.Drawing.Color.Tomato
            End If
        End If
    End Sub
    
   
    Protected Sub ddlDateRange_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        SqlDataSource1.SelectParameters("Week_Ending_Begin").DefaultValue = ddlBeginDate.SelectedValue
        SqlDataSource1.SelectParameters("Week_Ending_End").DefaultValue = ddlEndDate.SelectedValue
        SqlDataSource1.DataBind()
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Dashboard Reporting</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
        <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
        <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />	
		<script type="text/javascript">
		    $(function () {

		        // Tabs
		        $('#tabs').tabs();
		        $('#tabs').tabs({ selected: 0 });

		        //hover states on the static widgets
		        $('#dialog_link, ul#icons li').hover(
					function () { $(this).addClass('ui-state-hover'); },
					function () { $(this).removeClass('ui-state-hover'); }
				);
		    });
		</script>

        
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
         
    
    <fieldset class="fieldset">
    <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		                <img src="images/fSA_logo_dashboard.gif" alt="Federal Student Aid - Dashboard Reports" /> 
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">TPD Processing</a></li>                               
                            </ul>
                            <br /><br />
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                        Select Begin Date:
                                        <asp:DropDownList ID="ddlBeginDate" runat="server" Width="100px" 
                                            onselectedindexchanged="ddlDateRange_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="11/20/11" Value="11/20/11" Selected="True" />
                                            <asp:ListItem Text="11/27/11" Value="11/27/11" />
                                            <asp:ListItem Text="12/04/11" Value="12/04/11" />
                                            <asp:ListItem Text="12/11/11" Value="12/11/11" />
                                            <asp:ListItem Text="12/18/11" Value="12/18/11" />
                                            <asp:ListItem Text="12/25/11" Value="12/25/11" />
                                            <asp:ListItem Text="01/01/12" Value="01/01/12" />
                                        </asp:DropDownList>
                                        &nbsp;| Select End Date:
                                        <asp:DropDownList ID="ddlEndDate" runat="server" Width="100px"
                                        onselectedindexchanged="ddlDateRange_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="11/20/11" Value="11/20/11" />
                                            <asp:ListItem Text="11/27/11" Value="11/27/11" />
                                            <asp:ListItem Text="12/04/11" Value="12/04/11" />
                                            <asp:ListItem Text="12/11/11" Value="12/11/11" />
                                            <asp:ListItem Text="12/18/11" Value="12/18/11" Selected="True" />
                                            <asp:ListItem Text="12/25/11" Value="12/25/11" />
                                            <asp:ListItem Text="01/01/12" Value="01/01/12" />
                                        </asp:DropDownList> <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                            CssClass="button" onclick="btnSearch_Click" />
                                        <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
            SelectCommand="p_TPDProcessing" SelectCommandType="StoredProcedure"            
            InsertCommand="INSERT INTO [TPD_Processing], (Week_Ending, Beginning_Inventory, Submitted_By_TPD, Approved, Ending_Inventory) 
            VALUES (@Week_Ending, @Beginning_Inventory, @Submitted_By_TPD, @Approved, @Ending_Inventory)"
            UpdateCommand="UPDATE TPD_Processing SET Week_Ending = @Week_Ending, Beginning_Inventory = @Beginning_Inventory, Submitted_By_TPD = @Submitted_By_TPD, 
            Approved = @Approved, Ending_Inventory = @Ending_Inventory WHERE ID = @ID">
             <SelectParameters>
                <asp:Parameter Name="Week_Ending_Begin" Type="DateTime" />
                <asp:Parameter Name="Week_Ending_End" Type="DateTime" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="Week_Ending" Type="DateTime" />
                <asp:Parameter Name="Beginning_Inventory" Type="Int32" />
                <asp:Parameter Name="Submitted_By_TPD" Type="Int32" />
                <asp:Parameter Name="Approved" Type="Int32" />                
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Week_Ending" Type="DateTime" />
                <asp:Parameter Name="Beginning_Inventory" Type="Int32" />
                <asp:Parameter Name="Submitted_By_TPD" Type="Int32" />
                <asp:Parameter Name="Approved" Type="Int32" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsWeekEnding" runat="server" ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
            SelectCommand="p_Week_Ending" SelectCommandType="StoredProcedure" />

    
    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" Height="356px" Width="870px">
        <Series>
            <asp:Series ChartType="Line" Name="seriesBeginning_Inventory" XValueMember="Week_Ending"
                YValueMembers="Beginning_Inventory" IsVisibleInLegend="true" LegendText="Beginning Inventory">
            </asp:Series>
             <asp:Series ChartType="Line" Name="seriesSubmitted_By_TPD" XValueMember="Week_Ending" 
                YValueMembers="Submitted_By_TPD" IsVisibleInLegend="true" LegendText="Submitted By TPD">
            </asp:Series>
            <asp:Series ChartType="Line" Name="seriesApproved" XValueMember="Week_Ending" 
                YValueMembers="Approved" IsVisibleInLegend="true" LegendText="Approved">
            </asp:Series>
             <asp:Series ChartType="Line" Name="seriesEnding_Inventory" XValueMember="Week_Ending" 
                YValueMembers="Ending_Inventory" LegendText="Ending Inventory">
            </asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1">
                <AxisX Crossing="Min">
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
         <Legends> 
           <asp:Legend></asp:Legend> 
         </Legends> 

    </asp:Chart>
    </div>
    
    <asp:GridView ID="Grid2" runat="server" AutoGenerateColumns="False"
        DataSourceID="SqlDataSource1" Width="870px" AllowSorting="True" CellPadding="4" ForeColor="#333333" 
                                        GridLines="None" OnRowDataBound="GridView1_RowDataBound">        
        <AlternatingRowStyle BackColor="White" />
        <Columns>                                            
            <asp:BoundField DataField="Week_Ending" SortExpression="Week_Ending" 
                HeaderText="Week Ending" DataFormatString="{0:d}" 
                ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="Beginning_Inventory" 
                SortExpression="Beginning_Inventory" HeaderText="Beginning Inventory" 
                ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="Submitted_By_TPD" SortExpression="Submitted_By_TPD" 
                HeaderText="Submitted By TPD" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="Approved" SortExpression="Approved" 
                HeaderText="Approved" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="Ending_Inventory" SortExpression="Ending_Inventory" 
                HeaderText="Ending Inventory" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="Status" SortExpression="Status" 
                HeaderText="Status" ItemStyle-HorizontalAlign="Right" />
           
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>

    <asp:GridView ID="GridViewComments" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" Width="870px" AllowSorting="True" CellPadding="4" ForeColor="#333333" 
                                        GridLines="None">        
        <AlternatingRowStyle BackColor="White" />
        <Columns>                                            
             <asp:BoundField DataField="Week_Ending" SortExpression="Week_Ending" 
                HeaderText="Week Ending" DataFormatString="{0:d}" 
                ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="Comments" HeaderText="Comments" />           
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    </ContentTemplate>
    </asp:UpdatePanel>

     </div>    
            </td>
        </tr>
      </table>
     </div>                
     </fieldset> 

    </form>
</body>
</html>
