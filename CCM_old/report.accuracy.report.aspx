<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace = "CSV" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'First check for a valid, logged in user
            Dim chkLogin As New CheckLogin
            lblUserID.Text = chkLogin.CheckLogin()
            
            pnlCharts.Visible = False
        End If
        
    End Sub
    
    Sub btnAccuracyReport_Click(ByVal sender As Object, ByVal e As EventArgs)
        CallCount()
    End Sub
    
    
    Sub CallCount()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim da As SqlDataAdapter
        Dim ds As DataSet
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReportCallCount", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@CallCenterID", SqlDbType.Int).Value = ddlCallCenterID.SelectedValue
        cmd.Parameters.Add("@BeginDateofReview", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
        cmd.Parameters.Add("@EndDateofReview", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text
        da = New SqlDataAdapter(cmd)
        Try
            strSQLConn.Open()
            ds = New DataSet()
            da.Fill(ds)
        
            rptCenterProfile.DataSource = ds
            rptCenterProfile.DataBind()
            
            'Create charts
            Chart_CallCount_OneCallCenter()
            Chart_CallCount_AllCenters()
             pnlCharts.Visible = True
            
            'Create all centers accuracy report
            BindAccuracyReport()
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Sub Chart_CallCount_OneCallCenter()
    
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_ChartCallCount_ByCallCenter"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@CallCenterID", SqlDbType.Int).Value = ddlCallCenterID.SelectedValue
            cmd.Parameters.Add("@BeginDateofReview", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
            cmd.Parameters.Add("@EndDateofReview", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text

            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()
            
            'Use this one as a default for each value/series in the table - remove any series value in the chart
            ChtCallCount.DataBindTable(myReader, "CallCenter")
                     
            myReader.Close()
            myConnection.Close()
            
        End Using
    End Sub
    
    Sub Chart_CallCount_AllCenters()
    
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_ChartCallCount_AllCallCenter"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@BeginDateofReview", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
            cmd.Parameters.Add("@EndDateofReview", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text

            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()
            
            'Use this one as a default for each value/series in the table - remove any series value in the chart
            ChtCallCount_AllCenters.DataBindTable(myReader, "CallCenter")
           
            ChtCallCount_AllCenters.Series(0).IsValueShownAsLabel = False
            ChtCallCount_AllCenters.Series(1).IsValueShownAsLabel = False
           
                     
            myReader.Close()
            myConnection.Close()
            
        End Using
    End Sub
    
   
    Sub BindAccuracyReport()
        BindAccuracyReport("p_AccuracyReport_G_Name")
        BindAccuracyReport("p_AccuracyReport_G_Clear")
        BindAccuracyReport("p_AccuracyReport_G_Tone")
        BindAccuracyReport("p_AccuracyReport_G_Prompt")
        BindAccuracyReport("p_AccuracyReport_V_Name")
        BindAccuracyReport("p_AccuracyReport_V_SSN")
        BindAccuracyReport("p_AccuracyReport_V_Adrs")
        BindAccuracyReport("p_AccuracyReport_V_Phon1")
        BindAccuracyReport("p_AccuracyReport_V_Phon2")
        BindAccuracyReport("p_AccuracyReport_V_Email")
        BindAccuracyReport("p_AccuracyReport_V_DOB")
        BindAccuracyReport("p_AccuracyReport_L_Interrupt")
        BindAccuracyReport("p_AccuracyReport_L_NoRepeat")
        BindAccuracyReport("p_AccuracyReport_BC_Counseling")
        BindAccuracyReport("p_AccuracyReport_S_Accuracy")
        BindAccuracyReport("p_AccuracyReport_Issue1")
        BindAccuracyReport("p_AccuracyReport_Issue2")
        BindAccuracyReport("p_AccuracyReport_Issue3")
        BindAccuracyReport("p_AccuracyReport_E_Pleasant")
        BindAccuracyReport("p_AccuracyReport_E_NonConfrontational")
        BindAccuracyReport("p_AccuracyReport_E_Timeliness")
        BindAccuracyReport("p_AccuracyReport_C_AllQuestions")
        BindAccuracyReport("p_AccuracyReport_C_Recapped")
         
    End Sub
    
    Sub BindAccuracyReport(ByVal sproc As String)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand(sproc, con)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        cmd.Parameters.AddWithValue("@BeginDateofReview", txtDateofReviewBegin.Text)
        cmd.Parameters.AddWithValue("@EndDateofReview", txtDateofReviewEnd.Text)
        
        Try
            con.Open()
            dr = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            
            'Report Title
            lblReportCallCenter.Text = ddlCallCenterID.SelectedItem.ToString()
            
            With dr
                If dr.HasRows Then
                    While dr.Read
                        Select Case sproc
                            Case "p_AccuracyReport_G_Name"
                                lblG_Name.Text = dr("G_NamePassed").ToString()
                                lblG_NameCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblG_NamePctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_G_Clear"
                                lblG_Clear.Text = dr("G_ClearPassed").ToString()
                                lblG_ClearCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblG_ClearPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_G_Tone"
                                lblG_Tone.Text = dr("G_TonePassed").ToString()
                                lblG_ToneCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblG_TonePctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_G_Prompt"
                                lblG_Prompt.Text = dr("G_PromptPassed").ToString()
                                lblG_PromptCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblG_PromptPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Name"
                                lblV_Name.Text = dr("V_NamePassed").ToString()
                                lblV_NameCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_NamePctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_SSN"
                                lblV_SSN.Text = dr("V_SSNPassed").ToString()
                                lblV_SSNCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_SSNPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Adrs"
                                lblV_Adrs.Text = dr("V_AdrsPassed").ToString()
                                lblV_AdrsCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_AdrsPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Phon1"
                                lblV_Phon1.Text = dr("V_Phon1Passed").ToString()
                                lblV_Phon1CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_Phon1PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Phon2"
                                lblV_Phon2.Text = dr("V_Phon2Passed").ToString()
                                lblV_Phon2CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_Phon2PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Email"
                                lblV_Email.Text = dr("V_EmailPassed").ToString()
                                lblV_EmailCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_EmailPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_DOB"
                                lblV_DOB.Text = dr("V_DOBPassed").ToString()
                                lblV_DOBCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_DOBPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_L_Interrupt"
                                lblL_Interrupt.Text = dr("L_InterruptPassed").ToString()
                                lblL_InterruptCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblL_InterruptPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_L_NoRepeat"
                                lblL_NoRepeat.Text = dr("L_NoRepeatPassed").ToString()
                                lblL_NoRepeatCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblL_NoRepeatPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_BC_Counseling"
                                lblBC_Counseling.Text = dr("BC_CounselingPassed").ToString()
                                lblBC_CounselingCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblBC_CounselingPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_S_Accuracy"
                                lblS_Accuracy.Text = dr("S_AccuracyPassed").ToString()
                                lblS_AccuracyCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblS_AccuracyPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_Issue1"
                                lblIssue1.Text = dr("Issue1Passed").ToString()
                                lblIssue1CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblIssue1PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_Issue2"
                                lblIssue2.Text = dr("Issue2Passed").ToString()
                                lblIssue2CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblIssue2PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_Issue3"
                                lblIssue3.Text = dr("Issue3Passed").ToString()
                                lblIssue3CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblIssue3PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_E_Pleasant"
                                lblE_Pleasant.Text = dr("E_PleasantPassed").ToString()
                                lblE_PleasantCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblE_PleasantPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_E_NonConfrontational"
                                lblE_NonConfrontational.Text = dr("E_NonConfrontationalPassed").ToString()
                                lblE_NonConfrontationalCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblE_NonConfrontationalPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_E_Timeliness"
                                lblE_Timeliness.Text = dr("E_TimelinessPassed").ToString()
                                lblE_TimelinessCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblE_TimelinessPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_C_AllQuestions"
                                lblC_AllQuestions.Text = dr("C_AllQuestionsPassed").ToString()
                                lblC_AllQuestionsCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblC_AllQuestionsPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_C_Recapped"
                                lblC_Recapped.Text = dr("C_RecappedPassed").ToString()
                                lblC_RecappedCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblC_RecappedPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                        End Select
                                                
                    End While
                    
                    grdVariablePeriod.Visible = False
                    btnExportExcel_VariablePeriod.Visible = False
                    pnlAccuracyReport.Visible = True
                    
                End If
            End With
           
            'Catch ex As Exception
        Finally
            con.Close()
        End Try
    End Sub
    
    Protected Sub chkCallCount_AllCenters_CheckedChanged(sender As Object, e As System.EventArgs)
        CallCount()
        If chkCallCount_AllCenters.Checked = True Then
            ChtCallCount_AllCenters.Series(0).IsValueShownAsLabel = True
            ChtCallCount_AllCenters.Series(1).IsValueShownAsLabel = True
        Else
            ChtCallCount_AllCenters.Series(0).IsValueShownAsLabel = False
            ChtCallCount_AllCenters.Series(1).IsValueShownAsLabel = False
        End If
    End Sub
  
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Center Monitor Reports</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
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
                                <li><a href="#tabs-1">Reports</a></li>                                
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
                                                                                                              
                                    <!--Call Centers-->
                                    <asp:SqlDataSource ID="dsCallCenters" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />

                                    <!--Call Reason / Issues-->
                                    <asp:SqlDataSource ID="dsReasonCode" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallReasons" SelectCommandType="StoredProcedure" />

                                    <!--Concerns-->
                                    <asp:SqlDataSource ID="dsConcerns" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_ConcernsAll" SelectCommandType="StoredProcedure" />

                                   <!--Users/Evaluators-->
                                    <asp:SqlDataSource ID="dsUserID" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure" />

                                    <div align="left" style="padding-top: 10px" id="tabs-1">
                                        
                                        <table cellpadding="2" cellspacing="2" border="0" width="100%">                                                                                   
                                                                                       
                                             <tr>
                                                <td  valign="top" colspan="3" class="pageSubHeader">   
                                                Calls Center Accuracy Report<br /><br />
                                                  </td>
                                                 </tr>  
                                                   
                                                <tr>
                                                 <td valign="top">  
                                            <strong>Call Center:</strong><br />
                                            <asp:DropDownList ID="ddlCallCenterID" runat="server" DataSourceID="dsCallCenters" SelectionMode="Multiple" Rows="4"  
                                                  AppendDataBoundItems="true" DataTextField="CallCenter" DataValueField="CallCenterID">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList><br />
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlCallCenterID" ErrorMessage="* Call Center is reqired" CssClass="warning" Display="Dynamic" />
                                                    </td>

                                                <td valign="top">   
                                                <strong>Begin Date of Review:</strong><br />  
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender1" runat="server" targetcontrolid="txtDateofReviewBegin" />
                                                            <asp:TextBox ID="txtDateofReviewBegin" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="rfd1" runat="server" ControlToValidate="txtDateofReviewBegin" ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic"/>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>                                                    
                                                    </td>

                                                    <td valign="top">
                                                    <strong>End Date of Review:</strong><br />
                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender2" runat="server" targetcontrolid="txtDateofReviewEnd" />
                                                            <asp:TextBox ID="txtDateofReviewEnd" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateofReviewEnd" ErrorMessage="*End Date is reqired" CssClass="warning" Display="Dynamic" /> 
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>                                
                                                </td> 
                                                 <td valign="bottom">
                                                        <asp:Button ID="btnSearch" runat="server" CssClass="button" Text="Search" OnClick="btnAccuracyReport_Click" />                                                        
                                                    </td>
                                                </tr>
                                                </table>
                                                <p>&nbsp;</p>
                                                
                                        </div>
                                        <div id="divVariablePeriod" class="grid" align="center">
    <asp:Label ID="lblRowCountVariablePeriod" runat="server" CssClass="warning" />
               <asp:GridView ID="grdVariablePeriod" runat="server" 
                        AutoGenerateColumns="false" 
                        AllowSorting="false"                         
                        CssClass="datatable" 
			            BorderWidth="1px" 
			            BackColor="White" 
			            GridLines="Horizontal"
                        CellPadding="3" 
                        BorderColor="#E7E7FF"
			            Width="900px" 
			            BorderStyle="None" 
			            ShowFooter="false">
			            <EmptyDataTemplate>
			                No records matched your search
			            </EmptyDataTemplate>
                        <Columns>                                                                             
                            <asp:BoundField DataField="CallCenter" HeaderText="Call Center" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="CountOfCallCenter" HeaderText="Call Count" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />                            
                        </Columns>
                        <RowStyle CssClass="row" />
                        <AlternatingRowStyle CssClass="rowalternate" />
                        <FooterStyle CssClass="gridcolumnheader" />
                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                        <HeaderStyle CssClass="gridcolumnheader" />
                        <EditRowStyle CssClass="gridEditRow" />       
        </asp:GridView><br />
        <div align="center">
            <asp:Button ID="btnExportExcel_VariablePeriod" runat="server" CssClass="button" Text="Export to Excel" Visible="false" />
        </div>
        </div>
     <asp:UpdatePanel ID="UpdatePanel3" runat="server">
     <ContentTemplate>
     
     
    <asp:Repeater ID="rptCenterProfile" runat="server">
    <HeaderTemplate>
     <table width="900px" cellpadding="2" cellspacing="4" 
            style="background-color: White; border-style: solid; border-width: 1px; border-color: #5C9CCC;" 
            align="center">
    </HeaderTemplate>
    <ItemTemplate>       
        <tr>
            <td align="right" width="50%">Passed Calls:</td>
            <td align="left" width="50%"><asp:Label ID="lblPassedCalls" runat="server" text='<%# Eval("PassedCalls") %>' /></td>
        </tr>
        <tr>
            <td align="right" width="50%">Failed Calls:</td>
            <td align="left" width="50%"><asp:Label ID="lblFailedCalls" runat="server" text='<%# Eval("FailedCalls") %>' /></td>
        </tr>
         <tr>
            <td align="right" width="50%">Total Calls:</td>
            <td align="left" width="50%"><asp:Label ID="lblCallCount" runat="server" text='<%# Eval("CallCount") %>' /></td>
        </tr>  
    
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
    </asp:Repeater>

    
    <!--Chart-->
    <asp:Panel ID="pnlCharts" runat="server" Visible = "false">
     <table width="900px" cellpadding="2" cellspacing="4" 
            style="background-color: White; border-style: solid; border-width: 0px; border-color: #5C9CCC;" 
            align="center">
    <tr>
        <td align="center">
                <!--Chart for one call center -->
                <asp:Chart ID="ChtCallCount" runat="server" BackColor="#D3DFF0" Width="800px" Height="450px"
                    BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
                    BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
                    <Titles>
                        <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                            Text="Call Center Accuracy" ForeColor="26, 59, 105">
                        </asp:Title>
                    </Titles>
                    <Legends>
                        <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                            Font="Trebuchet MS, 8.25pt, style=Bold">
                        </asp:Legend>
                    </Legends>
                    <BorderSkin SkinStyle="Emboss"></BorderSkin>
                    <Series>
                        <%--
								<asp:Series IsValueShownAsLabel="True" ChartArea="ChartArea1" Name="CallCount" CustomProperties="LabelStyle=Bottom" BorderColor="180, 26, 59, 105"></asp:Series> --%>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid"
                            BackSecondaryColor="White" BackColor="64, 165, 191, 228" ShadowColor="Transparent"
                            BackGradientStyle="TopBottom">
                            <AxisY2 Enabled="False">
                            </AxisY2>
                            <AxisX2 Enabled="False">
                            </AxisX2>
                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                WallWidth="0" IsClustered="False" />
                            <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisY>
                            <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False"
                                    Interval="1" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisX>
                        </asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>
                </td>
                </tr>

                <tr>
                <td align="center">
                <!--Chart for all call centers-->
                <asp:CheckBox ID="chkCallCount_AllCenters" runat="server" Text="Show values" OnCheckedChanged="chkCallCount_AllCenters_CheckedChanged" AutoPostBack="true" /><br />
                <asp:chart id="ChtCallCount_AllCenters" runat="server" BackColor="#D3DFF0" Width="800px" Height="450px" BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
							<titles>
								<asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3" Text="Calls By Call Center" ForeColor="26, 59, 105"></asp:Title>
							</titles>
							<legends>
								<asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold"></asp:Legend>
							</legends>
							<borderskin SkinStyle="Emboss"></borderskin>
							<series><%--
								<asp:Series IsValueShownAsLabel="True" ChartArea="ChartArea1" Name="CallCount" CustomProperties="LabelStyle=Bottom" BorderColor="180, 26, 59, 105"></asp:Series> --%>                               
							</series>
							<chartareas>
								<asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid" BackSecondaryColor="White" BackColor="64, 165, 191, 228" ShadowColor="Transparent" BackGradientStyle="TopBottom">
									<axisy2 Enabled="False"></axisy2>
									<axisx2 Enabled="False"></axisx2>
									<area3dstyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False" WallWidth="0" IsClustered="False" />
									<axisy LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
										<LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
										<MajorGrid LineColor="64, 64, 64, 64" />
									</axisy>
									<axisx LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
										<LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Angle="-90" Interval="1" />
										<MajorGrid LineColor="64, 64, 64, 64" />
									</axisx>
								</asp:ChartArea>                                
							</chartareas>
		</asp:chart>
        
        </td>
    </tr>
    
    </table>
    </asp:Panel>  
        
    <asp:Panel ID="pnlAccuracyReport" runat="server" Visible="false" HorizontalAlign="Center">
    <table width="900px" cellpadding="2" cellspacing="4" 
            style="background-color: White; border-style: solid; border-width: 1px; border-color: #5C9CCC;" 
            align="center">
        <tr>
            <td colspan="4" align="left" class="pageSubHeader"><strong>Accuracy Report For <asp:Label ID="lblReportCallCenter" runat="server" /></strong><br /><br /></td>
        </tr>
        <tr>
            <td align="left"><strong><u>Category</u></strong></td>
            <td align="center"><strong><u>Calls Passed</u></strong></td>
            <td align="center"><strong><u>Calls Reviewed</u></strong></td>
            <td align="center"><strong><u>Percent Passed</u></strong></td>
        </tr>
        <tr>
            <td colspan="4" align="left"><strong>Greeting</strong></td>
        </tr>
        
       <tr>
            <td align="right">Idenitified Self:</td>
            <td align="center"><asp:Label ID="lblG_Name" runat="server" /></td>
            <td align="center"><asp:Label ID="lblG_NameCallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblG_NamePctngPassed" runat="server" /></td>   
        </tr>
        <tr>
            <td align="right">Spoke Clearly:</td>
            <td align="center"><asp:Label ID="lblG_Clear" runat="server" /></td>
            <td align="center"><asp:Label ID="lblG_ClearCallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblG_ClearPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Tone:</td>
            <td align="center"><asp:Label ID="lblG_Tone" runat="server" /></td>
            <td align="center"><asp:Label ID="lblG_ToneCallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblG_TonePctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Answered Promptly:</td>
            <td align="center"><asp:Label ID="lblG_Prompt" runat="server" /></td>
            <td align="center"><asp:Label ID="lblG_PromptCallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblG_PromptPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td colspan="4" align="left"><strong>Verification</strong></td>
        </tr>
        <tr>
            <td align="right">Name:</td>
            <td align="center"><asp:Label ID="lblV_Name" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_NameCallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_NamePctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">SSN:</td>
            <td align="center"><asp:Label ID="lblV_SSN" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_SSNCallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_SSNPctngPassed" runat="server" /></td>        
        </tr>        
        <tr>
            <td align="right">Address:</td>
            <td align="center"><asp:Label ID="lblV_Adrs" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_AdrsCallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_AdrsPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Primary Phone:</td>
            <td align="center"><asp:Label ID="lblV_Phon1" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_Phon1CallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_Phon1PctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Alternate Phone:</td>
            <td align="center"><asp:Label ID="lblV_Phon2" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_Phon2CallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_Phon2PctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Email:</td>
            <td align="center"><asp:Label ID="lblV_Email" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_EmailCallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_EmailPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Date of Birth:</td>
            <td align="center"><asp:Label ID="lblV_DOB" runat="server" /></td>
            <td align="center"><asp:Label ID="lblV_DOBCallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblV_DOBPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td colspan="4" align="left"><strong>Effective Listening</strong></td>
        </tr>
        <tr>
            <td align="right">Didn't Interrupt:</td>
            <td align="center"><asp:Label ID="lblL_Interrupt" runat="server" /></td>
            <td align="center"><asp:Label ID="lblL_InterruptCallsReviewed" runat="server" /></td>
            <td align="center"><asp:Label ID="lblL_InterruptPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Didn't Ask to Repeat:</td>
            <td><asp:Label ID="lblL_NoRepeat" runat="server" /></td>
            <td><asp:Label ID="lblL_NoRepeatCallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblL_NoRepeatPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td colspan="4" align="left"><strong>Basic Counseling</strong></td>
        </tr>
        <tr>
            <td align="right">Basic Counseling:</td>
            <td><asp:Label ID="lblBC_Counseling" runat="server" /></td>
            <td><asp:Label ID="lblBC_CounselingCallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblBC_CounselingPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td colspan="4" align="left"><strong>Solution</strong></td>
        </tr>
        <tr>
            <td align="right">Correct Solution:</td>
            <td><asp:Label ID="lblS_Accuracy" runat="server" /></td>
            <td><asp:Label ID="lblS_AccuracyCallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblS_AccuracyPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td colspan="4" align="left"><strong>Accuracy</strong></td>
        </tr>
        <tr>
            <td align="right">Primary Issue:</td>
            <td><asp:Label ID="lblIssue1" runat="server" /></td>
            <td><asp:Label ID="lblIssue1CallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblIssue1PctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Secondary Issue:</td>
            <td><asp:Label ID="lblIssue2" runat="server" /></td>
            <td><asp:Label ID="lblIssue2CallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblIssue2PctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Tertiary Issue:</td>
            <td><asp:Label ID="lblIssue3" runat="server" /></td>
            <td><asp:Label ID="lblIssue3CallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblIssue3PctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td colspan="4" align="left"><strong>Phone Etiquette</strong></td>
        </tr>
        <tr>
            <td align="right">Pleasant Manner:</td>
            <td><asp:Label ID="lblE_Pleasant" runat="server" /></td>
            <td><asp:Label ID="lblE_PleasantCallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblE_PleasantPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Non-Confrontational:</td>
            <td><asp:Label ID="lblE_NonConfrontational" runat="server" /></td>
            <td><asp:Label ID="lblE_NonConfrontationalCallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblE_NonConfrontationalPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td align="right">Timeliness:</td>
            <td><asp:Label ID="lblE_Timeliness" runat="server" /></td>
            <td><asp:Label ID="lblE_TimelinessCallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblE_TimelinessPctngPassed" runat="server" /></td>        
        </tr>
        <tr>
            <td colspan="4" align="left"><strong>Closing</strong></td>
        </tr>
        <tr>
            <td align="right">All Questions Answered:</td>
            <td><asp:Label ID="lblC_AllQuestions" runat="server" /></td>
            <td><asp:Label ID="lblC_AllQuestionsCallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblC_AllQuestionsPctngPassed" runat="server" /></td>        
        </tr>
         <tr>
            <td align="right">Recapped the Call:</td>
            <td><asp:Label ID="lblC_Recapped" runat="server" /></td>
            <td><asp:Label ID="lblC_RecappedCallsReviewed" runat="server" /></td>
            <td><asp:Label ID="lblC_RecappedPctngPassed" runat="server" /></td>        
        </tr>
    
    </table>
    
    </asp:Panel>  
    
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
