﻿<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckVangentLogin()
            
            txtEndDate.Text = Today()
        End If
    End Sub
    
    Sub btnRunReport_Click(ByVal sender As Object, ByVal e As EventArgs)
        
    End Sub
    
    
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMFs Submitted By PCA In Error</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <!-- datePicker required styles -->
	<link rel="stylesheet" type="text/css" media="screen" href="../js/datePicker.css" />

    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="../js/default.js"></script>
   <script language="javascript" src="../js/date.js" type="text/javascript"></script>
   <script language="javascript" src="../js/jquery.datePicker.js" type="text/javascript"></script>
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
                      <asp:SqlDataSource ID="dsIMFs_Submitted_Report" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_Report_Vangent_Errors" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter Name="BeginDate" ControlID="txtBeginDate" />
                                <asp:ControlParameter Name="EndDate" ControlID="txtEndDate" />
                            </SelectParameters>                            
                            </asp:SqlDataSource> 

                             <asp:SqlDataSource ID="ds_IMFs_InError" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_Report_Vangent_Errors_Detail" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter Name="BeginDate" ControlID="txtBeginDate" />
                                <asp:ControlParameter Name="EndDate" ControlID="txtEndDate" />
                            </SelectParameters>                                                       
                            </asp:SqlDataSource> 
                      
                      <fieldset>
                        <legend class="fieldsetLegend">IMFs Submitted By PCA In Error</legend><br />
                       
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
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsIMFs_Submitted_Report" AutoGenerateColumns="false" CellPadding="4" 
                            Width="100%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" Caption="Summary" 
                            AllowSorting="true">                           
                            
                            <EmptyDataTemplate>
                                    There are no rejected IMFs for this time period
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                            <asp:BoundField DataField="AG" HeaderText="AG" SortExpression="AG" />
                             <asp:BoundField DataField="IMF_Type" HeaderText="Request Type" SortExpression="IMF_Type" />
                            <asp:BoundField DataField="RejectCount" HeaderText="Submitted In Error" SortExpression="RejectCount" />                           
                            <asp:BoundField DataField="TotalCount" HeaderText="Total Submitted" SortExpression="TotalCount" />                    
                            </Columns>
                            </asp:GridView>
                            </div>
                            <br /><br />

                            <div class="grid"> 
                            <asp:GridView ID="GridView2" runat="server" DataKeyNames="id" DataSourceID="ds_IMFs_InError" AutoGenerateColumns="false" CellPadding="4" Caption="Details" 
                            Width="100%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="true" AllowSorting="true" 
                            PageSize="50">
                            <RowStyle CssClass="row" />
                            
                            <Columns>
                                
                                 <asp:HyperLinkField 
                                    DataTextField="id" 
                                    ItemStyle-CssClass="first" 
                                    HeaderText="IMF ID" 
                                    DataNavigateUrlFields="Id" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="imf.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>

                                    <asp:BoundField 
                                    DataField="AgencyID" 
                                    HeaderText="AG" 
                                    SortExpression="AgencyID"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="DateSubmitted" 
                                    HeaderText="Submitted" 
                                    SortExpression="DateSubmitted" 
                                    DataFormatString="{0:d}"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="IMF_Type" 
                                    HeaderText="Type" 
                                    SortExpression="IMF_Type"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="DebtID" 
                                    HeaderText="Debt ID"
                                    SortExpression="DebtID"
                                    ReadOnly="true" />
                                                                    
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="Borrower_FName" 
                                    HeaderText="Borrower First Name" 
                                    SortExpression="Borrower_FName"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="DateClosed" 
                                    HeaderText="Date Completed" 
                                    SortExpression="DateClosed"
                                    DataFormatString="{0:d}" /> 

                                    <asp:BoundField 
                                    DataField="QueueName" 
                                    HeaderText="Queue" 
                                    SortExpression="QueueName" />
                                                                        
                                    <asp:TemplateField HeaderText="Rejected By DRG?" SortExpression="Rejected">
                                    <ItemTemplate>
                                              <asp:Label ID="lblRejected" runat="server" Text='<%# TrueFalse(Eval("Rejected"))%>' />                         
                                    </ItemTemplate>                                    
                                    </asp:TemplateField>                                                                       
                    				                    
                                                                       
                               </Columns>                
                            </asp:GridView>
                            </div>

                    </fieldset>
                       
                    
                       
    
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblEDUserName" runat="server" Visible="false" />
    </form>
</body>
</html>