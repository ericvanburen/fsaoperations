<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace = "CSV" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            lblUserID.Text = "1"
        End If
    End Sub
    
    Sub btnReportVariablePeriod_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView_VariablePeriod()
    End Sub
    
    Sub btnReportFailedCalls_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView_FailedCalls()
    End Sub
    
    
    
    Sub btnReportAccuracy_Click(ByVal sender As Object, ByVal e As EventArgs)
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
        cmd.Parameters.AddWithValue("@BeginDateofReview", txtDateofReviewBeginAccuracy.Text)
        cmd.Parameters.AddWithValue("@EndDateofReview", txtDateofReviewEndAccuracy.Text)
        
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
                    grdFailedCalls.Visible = False
                    btnExcelExport_FailedCalls.Visible = False
                    btnExportExcel_VariablePeriod.Visible = False
                    pnlAccuracyReport.Visible = True
                    
                End If
            End With
           
            'Catch ex As Exception
        Finally
            con.Close()
        End Try
    End Sub
    
    Sub BindGridView_VariablePeriod()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Report_VariablePeriod", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@DateofReviewBegin", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
        cmd.Parameters.Add("@DateofReviewEnd", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text
               
        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)
            
            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")
              
            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCountVariablePeriod.Text = "Your search returned " & intRecordCount & " records"
                       
            grdVariablePeriod.DataSource = ds.Tables("Requests").DefaultView
            grdVariablePeriod.DataBind()
            
            'Hide the other report(s) if visible
            grdFailedCalls.Visible = False
            btnExcelExport_FailedCalls.Visible = False
            lblRowCountFailedCalls.Visible = False
            grdVariablePeriod.Visible = True
            pnlAccuracyReport.Visible = False
            
            'Make the Excel export button visible
            btnExportExcel_VariablePeriod.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Sub BindGridView_FailedCalls()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Report_FailedCalls", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@DateofReviewBegin", SqlDbType.VarChar).Value = txtDateofReviewBeginFailedCalls.Text
        cmd.Parameters.Add("@DateofReviewEnd", SqlDbType.VarChar).Value = txtDateofReviewEndFailedCalls.Text
               
        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)
            
            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")
              
            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCountFailedCalls.Text = "Your search returned " & intRecordCount & " records"
                       
            grdFailedCalls.DataSource = ds.Tables("Requests").DefaultView
            grdFailedCalls.DataBind()
            
            'Hide the other report(s) if visible
            grdVariablePeriod.Visible = False
            btnExportExcel_VariablePeriod.Visible = False
            lblRowCountVariablePeriod.Visible = False
            pnlAccuracyReport.Visible = False
            grdFailedCalls.Visible = True
            
            'Make the Excel export button visible
            btnExcelExport_FailedCalls.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Private Sub btnExportExcel_VariablePeriod_Click(ByVal sender As Object, ByVal e As EventArgs)
        Export("Calls.Monitored.by.Call.Center.xls", grdVariablePeriod)
    End Sub
    
    Private Sub btnExportExcel_FailedCalls_Click(ByVal sender As Object, ByVal e As EventArgs)
        Export("Failed.Calls.xls", grdFailedCalls)
    End Sub
    
    Public Shared Sub Export(ByVal fileName As String, ByVal gv As GridView)
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        HttpContext.Current.Response.ContentType = "application/ms-excel"
        Dim sw As StringWriter = New StringWriter
        Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        '  Create a form to contain the grid
        Dim table As Table = New Table
        table.GridLines = gv.GridLines
        '  add the header row to the table
        If (Not (gv.HeaderRow) Is Nothing) Then
            PrepareControlForExport(gv.HeaderRow)
            table.Rows.Add(gv.HeaderRow)
        End If
        '  add each of the data rows to the table
        For Each row As GridViewRow In gv.Rows
            PrepareControlForExport(row)
            table.Rows.Add(row)
        Next
        '  add the footer row to the table
        If (Not (gv.FooterRow) Is Nothing) Then
            PrepareControlForExport(gv.FooterRow)
            table.Rows.Add(gv.FooterRow)
        End If
            
        '  render the table into the htmlwriter
        table.RenderControl(htw)
        '  render the htmlwriter into the response
        HttpContext.Current.Response.Write(sw.ToString)
        HttpContext.Current.Response.End()
    End Sub

    ' Replace any of the contained controls with literals
    Private Shared Sub PrepareControlForExport(ByVal control As Control)
        Dim i As Integer = 0
        Do While (i < control.Controls.Count)
            Dim current As Control = control.Controls(i)
            If (TypeOf current Is LinkButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, LinkButton).Text))
            ElseIf (TypeOf current Is ImageButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, ImageButton).AlternateText))
            ElseIf (TypeOf current Is HyperLink) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, HyperLink).Text))
            ElseIf (TypeOf current Is DropDownList) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, DropDownList).SelectedItem.Text))
            ElseIf (TypeOf current Is CheckBox) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, CheckBox).Checked))
                'TODO: Warning!!!, inline IF is not supported ?
            End If
            If current.HasControls Then
                PrepareControlForExport(current)
            End If
            i = (i + 1)
        Loop
    End Sub
    
    Protected Sub grdFailedCalls_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Dim strSortString = Convert.ToString(e.SortExpression) & " " & GetSortDirection(e.SortDirection)
        lblSortExpression.Text = strSortString.ToString
        'Now bind the gridview with the results
        BindGridView_FailedCalls()
    End Sub
    
    Private Function GetSortDirection(ByVal column As String) As String
        ' By default, set the sort direction to ascending. 
        Dim sortDirection = "ASC"
        ' Retrieve the last column that was sorted. 
        Dim sortExpression = TryCast(ViewState("SortExpression"), String)
        If sortExpression IsNot Nothing Then
            ' Check if the same column is being sorted. 
            ' Otherwise, the default value can be returned. 
            If sortExpression = column Then
                Dim lastDirection = TryCast(ViewState("SortDirection"), String)
                If lastDirection IsNot Nothing _
                AndAlso lastDirection = "ASC" Then
                    sortDirection = "DESC"
                End If
            End If
        End If
        ' Save new values in ViewState. 
        ViewState("SortDirection") = sortDirection
        ViewState("SortExpression") = column
        Return sortDirection
    End Function
  

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Center Monitor Reports</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
       <script src="Scripts/menu.js" type="text/javascript"></script>              <script type="text/javascript" src="Scripts/jquery.zclip.js"></script>
        
        <script type="text/javascript">
            $(function () {
                $("#tabs").tabs();
            });

            function copyToClipboard(s) {
                if (window.clipboardData && clipboardData.setData) {
                    clipboardData.setData('text', s);
                }
            }
	</script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('a#copy-description').zclip({
                path: 'Scripts/ZeroClipboard.swf',
                copy: $('p#description').text()
            });            
            // The link with ID "copy-description" will copy
            // the text of the paragraph with ID "description"           
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
                                    <li><a href="#">Reports</a></li>                                                          
                                    <li><a href="search.aspx">Search</a></li>
                                 <li><a href="#">Administration</a>
                                <ul>
                                    <li><a href="admin/call.reasons.aspx">Call Reasons</a></li>
                                    <li><a href="admin/concerns.aspx">Concerns</a></li>
                                    <li><a href="admin/user.manager.aspx">User Manager</a></li>
                                </ul></li>
                                
                                <li><a href="#">Monitor Forms</a>
                                <ul>
                                    <li><a href="formB.aspx">Form B</a></li>
                                    <li><a href="formC.aspx">Form C</a></li>
                                </ul></li>                           
                          </ul>
                            </div>
                            <p>&nbsp;</p>
                            
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
                                                <td  valign="top" colspan="3">   
                                                <p><strong>Calls Monitored by Call Center for a Variable Period</strong></p>
                                                  <br /></td>
                                             </tr>  
                                                   
                                                <tr>
                                                <td valign="top">   
                                                <strong>Begin Date of Review:</strong><br />  
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender1" runat="server" targetcontrolid="txtDateofReviewBegin" />
                                                            <asp:TextBox ID="txtDateofReviewBegin" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="rfd1" runat="server" ControlToValidate="txtDateofReviewBegin" ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="VariablePeriod" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    
                                                    </td>

                                                    <td valign="top">
                                                    <strong>End Date of Review:</strong><br />
                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender2" runat="server" targetcontrolid="txtDateofReviewEnd" />
                                                            <asp:TextBox ID="txtDateofReviewEnd" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateofReviewEnd" ErrorMessage="*End Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="VariablePeriod" /> 
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>                                
                                                </td> 
                                                 <td valign="bottom">
                                                        <asp:Button ID="btnSearch" runat="server" CssClass="button" Text="Search" OnClick="btnReportVariablePeriod_Click" ValidationGroup="VariablePeriod" />                                                        
                                                    </td>
                                                </tr>
                                                </table>
                                                <hr />
                                                <table cellpadding="2" cellspacing="2" border="0" width="100%">                                                
                                                <tr>
                                                <td  valign="top" colspan="3">   
                                                <p><strong>Failed Calls</strong></p><br />
                                                  </td>
                                                 </tr>  
                                                   
                                                <tr>
                                                <td valign="top">   
                                                <strong>Begin Date of Review:</strong><br />  
                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender3" runat="server" targetcontrolid="txtDateofReviewBeginFailedCalls" />
                                                            <asp:TextBox ID="txtDateofReviewBeginFailedCalls" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateofReviewBeginFailedCalls" ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="FailedCalls" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    </td>

                                                    <td valign="top">
                                                    <strong>End Date of Review:</strong><br />
                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender4" runat="server" targetcontrolid="txtDateofReviewEndFailedCalls" />
                                                            <asp:TextBox ID="txtDateofReviewEndFailedCalls" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateofReviewEndFailedCalls" ErrorMessage="* End Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="FailedCalls" /> 
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>                                
                                                </td> 
                                                 <td valign="bottom">
                                                        <asp:Button ID="btnReportFailedCalls" runat="server" CssClass="button" Text="Search" OnClick="btnReportFailedCalls_Click" ValidationGroup="FailedCalls" />                                                        
                                                    </td>
                                                </tr>                                                
                                        </table>
                                          <hr />
                                        <div id="divAccuracyReport">
                                        <table cellpadding="2" cellspacing="2" border="0" width="100%" style="background-color: White;">
                                        <tr>
                                            <td  valign="top" colspan="3"><strong>Call Center Accuracy Report</strong><br /><br /></td>
                                        </tr>
                                        <tr>
                                            <td valign="top">  
                                            <strong>Call Center:</strong><br />
                                            <asp:ListBox ID="ddlCallCenterID" runat="server" DataSourceID="dsCallCenters" SelectionMode="Multiple" Rows="4"  
                                                  AppendDataBoundItems="true" DataTextField="CallCenter" DataValueField="CallCenterID">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:ListBox><br />
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlCallCenterID" ErrorMessage="* Call Center is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="Accuracy" />
                                                    </td>

                                           <td valign="top">   
                                                <strong>Begin Date of Review:</strong><br />  
                                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender5" runat="server" targetcontrolid="txtDateofReviewBeginAccuracy" />
                                                            <asp:TextBox ID="txtDateofReviewBeginAccuracy" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDateofReviewBeginAccuracy" ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="Accuracy" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    </td>

                                            <td valign="top">
                                                    <strong>End Date of Review:</strong><br />
                                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender6" runat="server" targetcontrolid="txtDateofReviewEndAccuracy" />
                                                            <asp:TextBox ID="txtDateofReviewEndAccuracy" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtDateofReviewBeginAccuracy" ErrorMessage="* End Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="Accuracy" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>                                
                                                </td> 

                                                <td valign="bottom">
                                                        <asp:Button ID="btnReportAccuracy" runat="server" CssClass="button" Text="Search" OnClick="btnReportAccuracy_Click" ValidationGroup="Accuracy" />                                                        
                                                    </td>

                                        </tr>
                                        </table>
                                        </div>
                                        
                                        <hr />

                                        </div>
                    </div>
                    
                    </div>
                    
                         </td>
                </tr>
            </table>
             </div>
    
    <br />

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
            <asp:Button ID="btnExportExcel_VariablePeriod" runat="server" CssClass="button" Text="Export to Excel" OnClick="btnExportExcel_VariablePeriod_Click" Visible="false" />
        </div>
        </div>
    
    <div id="dvGrid" class="grid" align="center">
    <asp:Label ID="lblRowCountFailedCalls" runat="server" CssClass="warning" />
               <asp:GridView ID="grdFailedCalls" runat="server" 
                        AutoGenerateColumns="false" 
                        AllowSorting="true" 
                        OnSorting="grdFailedCalls_Sorting"
                        CssClass="datatable" 
			            BorderWidth="1px" 
			            DataKeyNames="ReviewID"
			            BackColor="White" 
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
                            <asp:BoundField DataField="CallCenter" HeaderText="Call Center" SortExpression="CallCenter" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="AgentID" HeaderText="AgentID" SortExpression="AgentID" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="DateofReview" HeaderText="Date of Review" SortExpression="DateofReview" DataFormatString="{0:d}" HtmlEncode="false" />
                             <asp:TemplateField HeaderText="Passed?" SortExpression="OverallScore">
                            <ItemTemplate>
                                <asp:Label id="lblOverallScore" runat="server" text='<%# IIF(Eval("OverallScore"),"Yes","No") %>'></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Issue1" HeaderText="Issue1" ItemStyle-HorizontalAlign="Left"   />
                            <asp:BoundField DataField="Issue2" HeaderText="Issue2" ItemStyle-HorizontalAlign="Left"  />
                            <asp:BoundField DataField="Issue3" HeaderText="Issue3" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Concern1" HeaderText="Concern1" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Concern2" HeaderText="Concern2"  ItemStyle-HorizontalAlign="Left"/>
                            <asp:BoundField DataField="Concern3" HeaderText="Concern3" ItemStyle-HorizontalAlign="Left" />
                        </Columns>
                        <RowStyle CssClass="row" />
                        <AlternatingRowStyle CssClass="rowalternate" />
                        <FooterStyle CssClass="gridcolumnheader" />
                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                        <HeaderStyle CssClass="gridcolumnheader" />
                        <EditRowStyle CssClass="gridEditRow" />       
        </asp:GridView><br />
        <div align="center">
            <asp:Button ID="btnExcelExport_FailedCalls" runat="server" CssClass="button" Text="Export to Excel" OnClick="btnExportExcel_FailedCalls_Click" Visible="false" />
        </div>
        </div>  
        
    <asp:Panel ID="pnlAccuracyReport" runat="server" Visible="false" HorizontalAlign="Center">
    <a href="#" id="copyToClipboard"  onclick="copyToClipboard(document.getElementById('tblAccuracyReport').innerHTML)">Select All</a> - Click Alt H+V+M to paste
    <table width="900px" cellpadding="2" cellspacing="4" id="tblAccuracyReport"  
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
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" />
    </form>
</body>
</html>
