<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Report_Final_FSA_Management.aspx.vb" Inherits="PCAReviews_Report_Final" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PCA Final Report</title>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">        
        
        div.datatable{
            margin-left:10px; 
            margin-right:10px;
            margin-top: 10px;
            font-size: 12.5px; 
            font-family: Calibri;
            border:solid 1px;  
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="pnlWholeReport" runat="server">
        <div align="center" class="datatable">
       <table width="95%">
           <tr>
               <td align="center"><asp:ImageButton ID="btnEDLogo" runat="server" ImageUrl="../Images/ED_Logo.jpg" height="60" width="60" style="margin-top: 30px" OnClick="btnExportPDF_Click" />
               </td>
           </tr>
           <tr>
               <td><hr /></td>
           </tr>           
           <tr>
               <td align="left"><strong>PCA Comprehensive Phone Call Reviews</strong></td>
           </tr>
           <tr>
               <td align="left"><strong>Review Period:</strong> <asp:Label ID="lblReviewPeriod" runat="server" /></td>
           </tr>
           <tr>
               <td align="left"><strong>Report Date:</strong> <asp:Label ID="lblTodayDate" runat="server" /></td>
           </tr>
           <tr>
               <td><hr /></td>
           </tr>
       </table>
        <table width="95%">
            <tr>
                <td align="left"><strong> OBJECTIVES</strong></td>
            </tr>
            <tr>
               <td align="left">The purpose of this review is to:
                <ol>
                    <li>Confirm PCAs are placing and answering calls in compliance with the Federal Fair Debt Collection Practices Act, the Privacy Act of 1974, and the contract with FSA.</li>
                    <li>Confirm confirmation provided to borrowers and others is accurate and appropriate to the nature of the call.</li>
                    <li>Confirm PCAs are reporting complaints timely to FSA.</li>
                </ol>
                </td> 
            </tr>
            <tr>
                <td align="left"><strong>METHODOLOGY</strong></td>
            </tr>
            <tr>
                <td align="left">We selected 120 phone calls from a list provided by the PCA of all incoming and outgoing calls made for the purpose of collecting on debts under the ED
                    contract during the month of <asp:Label ID="lblReviewPeriod2" runat="server" />.
                    <p>
                    For the 120 phone calls selected, we asked the PCA to provide us with recordings of the calls and copies of notepads for the accounts.
                    </p>
                </td>
            </tr>
            <tr>
                <td align="left"><strong>TESTING</strong>
                    <p>Of the 120 recordings and notepads, we selected 70 accounts to review to test whether or not:</p>
                    <ol>
                        <li>The PCA properly identified the borrower or third party</li>
                        <li>A Mini-Miranda disclosure was made on each call</li>
                        <li>The collector did not violate a borrower’s privacy by speaking with a third party without the borrower’s written permission</li>
                        <li>The borrower was given accurate information and all required disclosures</li>
                        <li>The call was accurately and timely summarized in the PCA’s notepad</li>
                        <li>The collector used a professional tone with the borrower</li>
                        <li>The PCA was responsive to the borrower’s questions or concerns; and</li>
                        <li>The PCA reported any complaints received to us on a timely basis via e-IMF.</li>                        
                    </ol>
                </td>
            </tr>            
            <tr>
                <td align="left"><br /><strong>NOTES AND OBSERVATION OF ERRORS</strong> 
                    <p>Below is a summary of the results of our review.  Additional detail may be found on the attached worksheet.</p>
                </td>
            </tr>
        </table>
        <p></p>
        
        <table>
            <tr>
            <td valign="top">
            Review Period Month:
            <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" CssClass="inputBox" AutoPostBack="true" OnSelectedIndexChanged="ddlReviewPeriod_SelectedIndexChanged">
                            <asp:ListItem Text="" Value="" />        
                            <asp:ListItem Text="01" Value="01" />
                            <asp:ListItem Text="02" Value="02" />
                            <asp:ListItem Text="03" Value="03" />
                            <asp:ListItem Text="04" Value="04" />
                            <asp:ListItem Text="05" Value="05" />
                            <asp:ListItem Text="06" Value="06" />
                            <asp:ListItem Text="07" Value="07" />
                            <asp:ListItem Text="08" Value="08" />
                            <asp:ListItem Text="09" Value="09" />
                            <asp:ListItem Text="10" Value="10" Selected="True" />
                            <asp:ListItem Text="11" Value="11" />
                            <asp:ListItem Text="12" Value="12" />
                       </asp:DropDownList><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlReviewPeriodMonth" ErrorMessage="* Select a Review Period Month *" CssClass="alert-danger" Display="Dynamic" /></td>
            <td valign="top">
            Review Period Year:
            <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" CssClass="inputBox" AutoPostBack="true" OnSelectedIndexChanged="ddlReviewPeriod_SelectedIndexChanged">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="2015" Value="2015" Selected="True" />
                        <asp:ListItem Text="2016" Value="2016" />
                       </asp:DropDownList><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlReviewPeriodYear" ErrorMessage="* Select a Review Period Year *" CssClass="alert-danger" Display="Dynamic" /></td>
          </tr>
        </table> 

            <!--Chart Incorrect Actions All PCAs-->
            <asp:Chart ID="chtGeneralCallReview" runat="server" DataSourceID="dsTotalErrors" Width="950px">
                <Titles>
                    <asp:Title ShadowColor="32, 0, 0, 0" Font="Calibri, 13.25pt, style=Bold" 
                        Text="GENERAL CALL REVIEW INCORRECT ACTIONS" ForeColor="Black">
                    </asp:Title>
                </Titles>
                <Series>
                    <asp:Series Name="Series1" XValueMember="PCA" YValueMembers="Total_Incorrect_Actions" IsValueShownAsLabel="true">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                         <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                    WallWidth="0" IsClustered="False" />
                <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisY>
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="True" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
            <p></p> 
            
            <asp:ListBox ID="ddlPCAID" runat="server" CssClass="inputBox" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" SelectionMode="Multiple" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlPCAID_SelectedIndexChanged">
                    <asp:ListItem Text="" Value="" />
                 </asp:ListBox>

            <!--Chart Incorrect Actions One PCA-->
            <asp:Chart ID="Chart1" runat="server" DataSourceID="dsIncorrectPerPCA" Width="950px">
                <Titles>
                    <asp:Title ShadowColor="32, 0, 0, 0" Font="Calibri, 13.25pt, style=Bold" 
                        Text="INCORRECT ACTIONS FOR ONE PCA" ForeColor="Black">
                    </asp:Title>
                </Titles>
                <Series>
                    <asp:Series Name="Series1" XValueMember="Review Period" YValueMembers="Incorrect_Percent" IsValueShownAsLabel="true">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                         <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                    WallWidth="0" IsClustered="False" />
                <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisY>
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="True" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
            <p></p>                 

            <asp:SqlDataSource ID="dsTotalErrors" runat="server" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" 
                SelectCommand="p_ReportCountIncorrectActions_AllPCAs" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="ReportPeriodMonth" DefaultValue="10" />
                    <asp:Parameter Name="ReportPeriodYear" DefaultValue="2015" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsIncorrectPerPCA" runat="server" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" 
                SelectCommand="p_ReportPercentIncorrectPerPCA" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="PCAID" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
             SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" />

            
</div>
    </asp:Panel>   
        <asp:Label ID="lblPDFUrl" runat="server" Visible="true" />
    </form>
</body>
</html>
