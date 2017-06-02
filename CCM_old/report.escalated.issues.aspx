<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="CheckLogin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
                        
            'First check for a valid, logged in user
            Dim chkLogin As New CheckLogin
            lblUserID.Text = chkLogin.CheckLogin()
        End If
    End Sub
    
    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As EventArgs)
        If GridView1.Rows.Count > 0 Then
            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub
    
    
    

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Center Monitor Escalated Issues</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

     <style type="text/css">
     .highlite {
        background-color: Yellow;
    }
    </style>

     <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
     <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
     <script src="Scripts/menu.js" type="text/javascript"></script>
             
     <script type="text/javascript">
            $(function () {
                $("#tabs").tabs();
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
		                 <img src="images/fSA_logo.gif" alt="Federal Student Aid - Call Center Monitoring" />                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Escalated Issues</a></li>                                
                            </ul>
                            <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
                                 <ul id="nav">
                                    <li><a href="logout.aspx">Log Out</a></li> 
                                    <li><a href="#">Reports</a>
                                    <ul>
                                       <li><a href="report.calls.monitored.aspx">Calls Monitored</a></li> 
                                       <li><a href="report.failed.calls.aspx">Failed Calls</a></li>
                                       <li><a href="report.accuracy.report.aspx">Accuracy Report</a></li>
                                    </ul>
                                    </li>                                                          
                                    <li><a href="search.aspx">Search</a></li>
                                 <li><a href="#">Administration</a>
                                <ul>
                                    <li><a href="admin/call.centers.aspx">Call Centers</a></li>
                                    <li><a href="admin/call.reasons.aspx">Call Reasons</a></li>
                                    <li><a href="admin/concerns.aspx">Concerns</a></li>
                                    <li><a href="admin/user.manager.aspx">User Manager</a></li>
                                </ul></li>
                                
                                <li><a href="#">Monitoring</a>
                                <ul>
                                    <li><a href="FormB.aspx">Enter Call</a></li>
                                    <li><a href="my.reviews.aspx">My Reviews</a></li>
                                </ul></li>                           
                          </ul>
                            </div>
                            <br /><br />
                            
                            <div id="Div1">                          
                                                                                                              
                                    <!--GridView1-->
                                    <asp:SqlDataSource ID="dsEscalatedIssues" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_EscalatedIssues" SelectCommandType="StoredProcedure" />

                                   
                                <div align="left" style="padding-top: 10px" id="tabs-1">
                                <h3>Escalated Issues</h3>
                                <div id="dvGrid" class="grid" align="center">
              <asp:GridView ID="GridView1" runat="server" 
                        AutoGenerateColumns="false" 
                        DataSourceID="dsEscalatedIssues" 
                        AllowSorting="true"                         
                        AllowPaging="true"                         
                        PageSize="50"                        
                        CssClass="datatable" 
			            BorderWidth="1px" 
			            DataKeyNames="ReviewID"
			            BackColor="White" 
                        OnPreRender="GridView1_PreRender" 
			            GridLines="Horizontal"
                        CellPadding="3" 
                        BorderColor="#E7E7FF"
			            Width="90%" 
			            BorderStyle="None" 
			            ShowFooter="false">
			            <EmptyDataTemplate>
			                No records matched your search
			            </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                                <ItemTemplate>
                    
                                   <asp:hyperlink id="HyperLink2" runat="server" navigateurl='<%# Eval("ReviewID", "formB.detail.aspx?ReviewID={0}") %>'
                                    text='<%# Eval("ReviewID") %>' />

                                </ItemTemplate>                            
                            </asp:TemplateField>                                                       
                            <asp:BoundField DataField="CallCenter" HeaderText="Call Center" SortExpression="CallCenter" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Username" HeaderText="Evaluator" SortExpression="Username" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="DateofReview" HeaderText="Date of Review" SortExpression="DateofReview" DataFormatString="{0:d}" HtmlEncode="false" />
                            <asp:BoundField DataField="AgentID" HeaderText="Agent ID" SortExpression="AgentID" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="BorrowerAccountNumber" HeaderText="Acct #" SortExpression="BorrowerAccountNumber" ItemStyle-HorizontalAlign="Left" />                            
                            <asp:TemplateField HeaderText="Passed?" SortExpression="OverallScore">
                            <ItemTemplate>
                                <asp:Label id="lblOverallScore" runat="server" text='<%# IIF(Eval("OverallScore"),"Yes","No") %>'></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Escalated?" SortExpression="OverallScore">
                            <ItemTemplate>
                                <asp:Label id="lblEscalationIssue" runat="server" text='<%# IIF(Eval("EscalationIssue"),"Yes","No") %>'></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Issue1" HeaderText="Issue1" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Issue2" HeaderText="Issue2" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Issue3" HeaderText="Issue3" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Concern1" HeaderText="Concern1" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Concern2" HeaderText="Concern2" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Concern3" HeaderText="Concern3" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />                            
                            <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-HorizontalAlign="Left" />     
                            
                           
                        </Columns>
                        <RowStyle CssClass="row" />
                        <AlternatingRowStyle CssClass="rowalternate" />
                        <FooterStyle CssClass="gridcolumnheader" />
                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                        <HeaderStyle CssClass="gridcolumnheader" />
                        <EditRowStyle CssClass="gridEditRow" />       
                    </asp:GridView><br />     
                    </div>
                                </div>
                    </div>
                    
                    </div>
                    
                         </td>
                </tr>
            </table>
             </div>
    
    <br />   
    
          
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
    </form>
</body>
</html>
