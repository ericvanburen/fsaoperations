<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
   
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                'ED employee is looking at the IMF
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                lblED_AG_Security.Text = "ED"
                lblGA_ID.Text = Request.QueryString("GA_ID")
            End If
                
            If (lblEDUserID Is Nothing AndAlso lblEDUserID.Text.Length = 0) Then
                Response.Redirect("not.logged.in.aspx")
            End If
           
        End If
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Agency Contact Information</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
                            
 <!--This one populates the GA Contacts Gridview-->
    <asp:SqlDataSource ID="dsGAContacts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
        SelectCommand="p_GAContacts" SelectCommandType="StoredProcedure">
        <SelectParameters>
                <asp:ControlParameter ControlID="lblGA_ID" Name="GA_ID" Type="Int32" DefaultValue="1" />                
        </SelectParameters>                            
    </asp:SqlDataSource>                         
   
                     
    <fieldset>
    <legend class="fieldsetLegend">Agency Contact Information</legend><br />
    <div align="left">     
    
       <div class="grid" align="center"> 
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="dsGAContacts" DataKeyNames="ID" Visible="true"
        CellPadding="4" Width="95%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal">
        <RowStyle CssClass="row" />
        <EmptyDataTemplate>No contact information is available for this agency</EmptyDataTemplate>
        <Columns>		       
            <asp:BoundField DataField="ID" HeaderText="Contact Name" Visible="false" />
            <asp:BoundField DataField="Contact_Name" HeaderText="Contact Name" ItemStyle-CssClass="first" />
		    <asp:BoundField DataField="Contact_Email" HeaderText="Contact Email" />
		    <asp:BoundField DataField="Contact_Telephone" HeaderText="Contact Telephone" />
        </Columns>
        </asp:GridView>
        </div> 
                        
    </div>
    </fieldset>
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
    <asp:Label ID="lblGA_ID" runat="server" Visible="false" />
    </form>
</body>
</html>
