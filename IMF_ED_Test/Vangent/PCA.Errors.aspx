<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            
            CheckPCALogin()
          
            If Not IsNothing(Request.QueryString("AgencyID")) Then
                Dim intAG As String = Request.QueryString("AgencyID").ToString()
                lblAgency.Text = intAG
            Else
                If Not IsNothing(Request.Cookies("IMF")) Then
                    lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
                End If
            End If
            
            If lblAgency.Text Is Nothing OrElse lblAgency.Text.Length = 0 Then
                Response.Redirect("../not.logged.in.aspx")
            End If
        End If
    End Sub
  
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMFs Submitted By PCA In Error</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
   <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="../js/default.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">
                      <!--This one populates the main Gridview-->
                      <asp:SqlDataSource ID="dsIMFs_Submitted_Report" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_PCA_Errors" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter Name="AG" ControlID="lblAgency" />
                            </SelectParameters>                            
                            </asp:SqlDataSource> 
                                                 
                      <fieldset>
                        <legend class="fieldsetLegend">IMFs Submitted By PCA In Error</legend><br />                       
                      
                      <p> </p>
                        <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsIMFs_Submitted_Report" AutoGenerateColumns="false" CellPadding="4" 
                            Width="100%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal"  
                            AllowSorting="true">                           
                            
                            <EmptyDataTemplate>
                                    There are no rejected IMFs for this agency
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                            <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="IMF ID" 
                                    DataNavigateUrlFields="Id" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="imf.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>                            
                                    
                                    <asp:BoundField 
                                    DataField="DateSubmitted" 
                                    HeaderText="Submitted" 
                                    SortExpression="DateSubmitted" />
                                    
                                    <asp:BoundField 
                                    DataField="IMF_Type" 
                                    HeaderText="Type" 
                                    SortExpression="IMF_Type" />
                                    
                                    <asp:BoundField 
                                    DataField="DebtID" 
                                    HeaderText="Debt ID"
                                    SortExpression="DebtID" />
                                                                       
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName" />
                                    
                                    <asp:BoundField 
                                    DataField="PCA_Employee" 
                                    HeaderText="PCA Name" />
                                    
                                    <asp:BoundField 
                                    DataField="DateClosed" 
                                    HeaderText="Date Completed" 
                                    SortExpression="DateClosed" DataFormatString="{0:d}" /> 
                                    
                                    <asp:TemplateField HeaderText="Rejected By DRG?" SortExpression="Rejected">
                                    <ItemTemplate>
                                              <asp:Label ID="lblRejected" runat="server" Text='<%# TrueFalse(Eval("Rejected"))%>' />                         
                                    </ItemTemplate>                                    
                                    </asp:TemplateField>                       
                            </Columns>
                            </asp:GridView>
                            </div>                            

                    </fieldset>
                       
    <asp:Label ID="lblAgency" runat="server" Visible="false" />
    </form>
</body>
</html>
