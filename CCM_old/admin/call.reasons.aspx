<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace = "CSV" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
        End If
    End Sub
    
    Protected Sub grdCallReasons_OnRowCommand1(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        If e.CommandArgument = "Insert" Then
            Dim txtReasonForCall As TextBox = grdCallReasons.FooterRow.FindControl("txtReasonForCall")
            Dim ddlReasonGroup As DropDownList = grdCallReasons.FooterRow.FindControl("ddlReasonGroup")
            dsReasonCode.InsertParameters("ReasonForCall").DefaultValue = txtReasonForCall.Text
            dsReasonCode.InsertParameters("ReasonGroup").DefaultValue = ddlReasonGroup.SelectedValue
            dsReasonCode.Insert()
        End If
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Reason Administration</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>        
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
                    <td align="center">
        
		                <img src="../images/fSA_logo.gif" alt="Federal Student Aid - Call Center Monitoring" /> 
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Administration</a></li>                                
                            </ul>
                          <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
                                 <ul id="nav">
                                    <li><a href="../logout.aspx">Log Out</a></li> 
                                    <li><a href="#">Reports</a>
                                    <ul>
                                       <li><a href="../report.calls.monitored.aspx">Calls Monitored</a></li> 
                                       <li><a href="../report.failed.calls.aspx">Failed Calls</a></li>
                                       <li><a href="../report.accuracy.report.aspx">Accuracy Report</a></li>
                                    </ul>
                                    </li>                                                          
                                    <li><a href="../search.aspx">Search</a></li>
                                 <li><a href="#">Administration</a>
                                <ul>
                                    <li><a href="call.centers.aspx">Call Centers</a></li>
                                    <li><a href="call.reasons.aspx">Call Reasons</a></li>
                                    <li><a href="concerns.aspx">Concerns</a></li>
                                    <li><a href="user.manager.aspx">User Manager</a></li>
                                </ul></li>
                                
                                <li><a href="#">Monitoring</a>
                                <ul>
                                    <li><a href="../formB.aspx">Form</a></li>
                                    <li><a href="../my.reviews.aspx">My Reviews</a></li>
                                </ul></li>                           
                          </ul>
                            </div>
                            <br /><br />                      
                            <div id="Div1"> 
                            
                            <div class="pageSubHeader" align="left" style="padding-left: 20px">
                              <span>Call Reasons</span> 
                            </div>                                 

                                    <!--Call Reason / Issues-->
                                    <asp:SqlDataSource ID="dsReasonCode" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallReasons" SelectCommandType="StoredProcedure"
                                        InsertCommand="INSERT INTO CallReasons (ReasonForCall, ReasonGroup) VALUES(@ReasonForCall, @ReasonGroup)"
                                        UpdateCommand="UPDATE CallReasons SET ReasonForCall = @ReasonForCall, ReasonGroup = @ReasonGroup WHERE ReasonCode = @ReasonCode">
                                       <InsertParameters>
                                           <asp:Parameter Name="ReasonForCall" Type="String" />
                                           <asp:Parameter Name="ReasonGroup" Type="String" />
                                       </InsertParameters>
                                       <UpdateParameters>
                                           <asp:Parameter Name="ReasonForCall" Type="String" />
                                           <asp:Parameter Name="ReasonGroup" Type="String" />
                                           <asp:Parameter Name="ReasonCode" Type="Int32" />
                                       </UpdateParameters>                                    
                                    </asp:SqlDataSource>

                                    <!--ReasonGroup-->
                                    <asp:SqlDataSource ID="dsReasonGroup" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_ReasonGroup" SelectCommandType="StoredProcedure" />
                                   <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                        <ContentTemplate> 

                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        <div id="divCallReasons" class="grid" align="center">
                                         <asp:GridView ID="grdCallReasons" runat="server" 
                                                AutoGenerateColumns="false" 
                                                DataKeyNames="ReasonCode"  
                                                DataSourceID="dsReasonCode"
                                                OnRowCommand="grdCallReasons_OnRowCommand1"
                                                AllowSorting="true"                         
                                                CssClass="datatable" 
			                                    BorderWidth="1px" 
			                                    BackColor="White" 
			                                    GridLines="Horizontal"
                                                CellPadding="3" 
                                                BorderColor="#E7E7FF"
			                                    Width="98%" 
			                                    BorderStyle="None" 
			                                    ShowFooter="true">
			                                    <EmptyDataTemplate>
			                                        No records matched your search
			                                    </EmptyDataTemplate>
                                                <Columns>                                                     
                                                   <asp:CommandField ButtonType="Image" ShowDeleteButton="False"  CancelImageUrl="~/images/cancel.gif" EditImageUrl="~/images/pencil.gif"
                                                    ShowEditButton="True" UpdateImageUrl="~/images/save.gif" CausesValidation="false" HeaderText=" " ItemStyle-HorizontalAlign="Left" />                                                                    
                                                   
                                                   <asp:TemplateField HeaderText="Call Reason" SortExpression="ReasonForCall" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-CssClass="first">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblReasonForCall" runat="server" Text='<%#Eval("ReasonForCall") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                <asp:TextBox ID="txtReasonForCall" runat="server" Text='<%#Bind("ReasonForCall") %>' Width="250px" Font-Size="Small">
                                                </asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>                                                    
                                                    <asp:Button ID="btnInsert" runat="Server" Text="Add New Call Reason" CommandName="Insert" CommandArgument="Insert" UseSubmitBehavior="False" />  
                                                    Call Reason: <asp:TextBox ID="txtReasonForCall" runat="Server"  /><br />
                                                    <asp:RequiredFieldValidator ID="rf1" runat="server" ControlToValidate="txtReasonForCall" ErrorMessage="* Please enter a new Call Reason" CssClass="warning" Display="Dynamic" />                                                    
                                                </FooterTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Reason Group" SortExpression="ReasonGroup" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblReasonGroup" runat="server" Text='<%#Eval("ReasonGroup") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                <asp:DropDownList ID="ddlReasonGroup" runat="server" SelectedValue='<%#Bind("ReasonGroup")%>' Font-Size="Small" 
                                                DataSourceID="dsReasonGroup" DataTextField="ReasonGroup" DataValueField="ReasonGroup">                                         
                                                </asp:DropDownList>                                                
                                                </EditItemTemplate>
                                                 <FooterTemplate>
                                                    Reason Group: <asp:DropDownList ID="ddlReasonGroup" runat="server" Font-Size="Small"
                                                DataSourceID="dsReasonGroup" DataTextField="ReasonGroup" DataValueField="ReasonGroup">  
                                                </asp:DropDownList>  <br />
                                                      <asp:RequiredFieldValidator ID="rf2" runat="server" ControlToValidate="ddlReasonGroup" ErrorMessage="* Please select a new Reason Group" CssClass="warning" Display="Dynamic" />
                                                </FooterTemplate>
                                                </asp:TemplateField>                                                

                                                </Columns>
                                                <RowStyle CssClass="row" />
                                                <AlternatingRowStyle CssClass="rowalternate" />
                                                
                                                <HeaderStyle CssClass="gridcolumnheader" />
                                                <EditRowStyle CssClass="gridEditRow" />       
                                </asp:GridView><br />       
                            </div>
                         </div>

                                        </ContentTemplate>
                                        </asp:UpdatePanel>

                    </div>
                    
                    </div>
                    
                         </td>
                </tr>
            </table>
             </div>
    
    <br />
    
          
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" />
    </form>
</body>
</html>
