<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Report_Final.aspx.vb" Inherits="PCAReviews_Report_Final" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PCA Final Report</title>
    <link href="../../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        div.datatable{
            margin-left:10px; 
            margin-right:10px;
        font-size: 11.5px;  
        }

      .pageBreak {
        page-break-after: always;
      }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="pnlWholeReport" runat="server">
        <div align="center">
       <table width="95%">
           <tr>
               <td align="center"><asp:ImageButton ID="btnEDLogo" runat="server" ImageUrl="../../Images/ED_Logo.jpg" height="60" width="60" style="margin-top: 30px" OnClick="btnExportPDF_Click" />
               </td>
           </tr>
           <tr>
               <td><hr /></td>
           </tr>           
           <tr>
               <td align="left"><strong>Comprehensive Phone Call Review - Final</strong></td>
           </tr>
           <tr>
               <td align="left"><strong>PCA:</strong> <asp:Label ID="lblPCAName" runat="server" /></td>
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
                <td align="left">FSA selected phone calls from a list provided by the PCA of all incoming and outgoing calls made for the purpose of collecting on debts under the ED contract during the month of <asp:Label ID="lblReviewPeriod2" runat="server" />.
                     For the phone calls selected, we asked the PCA to provide us with recordings of the calls and copies of notepads for the accounts.
                </td>
            </tr>
            <tr>
                <td align="left"><br /><strong>TESTING</strong>
                    <p>Based on the recordings and notepads selected, FSA selected specific accounts to test whether or not:</p>
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
        
        <div class="datatable" align="left">
            <asp:Chart ID="chtGeneralCallReview0" runat="server" DataSourceID="dsTotalErrors" Width="950px" Visible="false">
                <Titles>
                    <asp:Title ShadowColor="32, 0, 0, 0" Font="Calibri, 13.25pt, style=Bold" 
                        Text="GENERAL CALL REVIEW INCORRECT ACTIONS" ForeColor="Black">
                    </asp:Title>
                </Titles>
                <Series>
                    <asp:Series Name="Series1" XValueMember="PCA" YValueMembers="General_Review_Total_Incorrect" IsValueShownAsLabel="true">
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
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>

            <asp:SqlDataSource ID="dsTotalErrors" runat="server" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" 
                SelectCommand="p_ReportCountCorrectIncorrectPerSection" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <br />
            <br />
            <strong>Number of Reviews: </strong><asp:Label ID="lblPopulationSize4" runat="server" /></div>

        <div class="datatable">
        <table class="table" width="95%" cellpadding="4">
        <thead>
            <tr>
                <th>Metric</th>        
                <th class="text-right">Total Actions</th>
                <th class="text-right">Incorrect Actions</th>
                <th class="text-right">% Incorrect In Category</th>
            </tr>
        </thead>
        <tr>
            <th class="alert-info" colspan="4">Phone Review Rating Data</th> 
        </tr>
        <tr>
            <td>Correct ID: Right Party Authentication</td>
            <td class="text-right"><asp:Label ID="lblScore_CorrectID_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_CorrectID_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_CorrectID_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>Properly Idenitified Itself</td>
            <td class="text-right"><asp:Label ID="lblScore_ProperlyIdentified_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_ProperlyIdentified_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_ProperlyIdentified_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>Mini-Miranda Provided</td>
            <td class="text-right"><asp:Label ID="lblScore_MiniMiranda_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_MiniMiranda_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_MiniMiranda_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>PCA Used Professional Tone</td>
            <td class="text-right"><asp:Label ID="lblScore_Tone_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Tone_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Tone_Percent" runat="server" /></td>
        </tr>    
        <tr>
            <td>Accurate Information Provided</td>
            <td class="text-right"><asp:Label ID="lblScore_Accuracy_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Accuracy_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Accuracy_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>Accurate Notepad</td>
            <td class="text-right"><asp:Label ID="lblScore_Notepad_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Notepad_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Notepad_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>PCA Was Responsive to the Borrower</td>
            <td class="text-right"><asp:Label ID="lblScore_PCAResponsive_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_PCAResponsive_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_PCAResponsive_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>PCA Provided Accurate AWG Info</td>
            <td class="text-right"><asp:Label ID="lblScore_AWGInfo_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_AWGInfo_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_AWGInfo_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>PCA Disconnected Borrower</td>
            <td class="text-right">N/A</td>
            <td class="text-right"><asp:Label ID="lblScore_Disconnect_Borrower_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Disconnect_Borrower_Percent" runat="server" Text="N/A" /></td>
        </tr>
        <tr>
            <td>PCA Received a Complaint</td>
            <td class="text-right"><asp:Label ID="lblScore_Complaint_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Complaint_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Complaint_Percent" runat="server" /></td>
        </tr>
        <tr>
                <td>Exceeded Hold Time</td>
                <td class="text-right"><asp:Label ID="lblScore_ExceededHoldTime_Total" runat="server" /></td>
                <td class="text-right"><asp:Label ID="lblScore_ExceededHoldTime_Incorrect" runat="server" /></td>
                <td class="text-right"><asp:Label ID="lblScore_ExceededHoldTime_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td class="pageBreak" colspan="4"></td>
        </tr>
         <tr>
                <th>Metric</th>        
                <th class="text-right">Total Actions</th>
                <th class="text-right">Incorrect Actions</th>
                <th class="text-right">% Incorrect In Category</th>
        </tr> 
        <tr>
           <th class="alert-danger" colspan="4">Rehab Ratings - Collector MUST say these things</th> 
        </tr>
        
        <tr>
            <td>The borrower can only rehab once</td>
            <td class="text-right"><asp:Label ID="lblScore_Rehab_Once_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Rehab_Once_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Rehab_Once_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>Requires 9 pymts over 10 mos, except Perkins (9 consec pymts)</td>
            <td class="text-right"><asp:Label ID="lblScore_Nine_Payments_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Nine_Payments_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Nine_Payments_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>After 6th pymt borr may regain Title IV eligibility</td>
            <td class="text-right"><asp:Label ID="lblScore_TitleIV_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_TitleIV_Incorrect" runat="server" /></td> 
            <td class="text-right"><asp:Label ID="lblScore_TitleIV_Percent" runat="server" /></td>   
        </tr>
        <tr>
            <td>CBR removes the record of default</td>
            <td class="text-right"><asp:Label ID="lblScore_Credit_Reporting_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Credit_Reporting_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Credit_Reporting_Percent" runat="server" /></td>    
        </tr>
         <tr>
            <td>TOP stops only after loans are transferred</td>
            <td class="text-right"><asp:Label ID="lblScore_TOP_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_TOP_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_TOP_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>Can prevent AWG but cannot stop current garnishment</td>
            <td class="text-right"><asp:Label ID="lblScore_AWG_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_AWG_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_AWG_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>Must continue making pymts until transferred</td>
            <td class="text-right"><asp:Label ID="lblScore_Continue_Payments_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Continue_Payments_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Continue_Payments_Percent" runat="server" /></td>    
        </tr>        
        <tr>
            <td>At transfer remaining collection charges are waived</td>
            <td class="text-right"><asp:Label ID="lblScore_Collection_Charges_Waived_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Collection_Charges_Waived_Incorrect" runat="server" /></td> 
            <td class="text-right"><asp:Label ID="lblScore_Collection_Charges_Waived_Percent" runat="server" /></td>   
        </tr>
        <tr>
            <td>Explained borrower must supply financial documents for payment amount</td>
            <td class="text-right"><asp:Label ID="lblScore_Financial_Documents_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Financial_Documents_Incorrect" runat="server" /></td> 
            <td class="text-right"><asp:Label ID="lblScore_Financial_Documents_Percent" runat="server" /></td>
     </tr>
     <tr>
        <td>Explained borrower must sign rehab agreement letter (RAL)</td>
        <td class="text-right"><asp:Label ID="lblScore_Rehab_Agreement_Letter_Total" runat="server" /></td>
        <td class="text-right"><asp:Label ID="lblScore_Rehab_Agreement_Letter_Incorrect" runat="server" /></td> 
        <td class="text-right"><asp:Label ID="lblScore_Rehab_Agreement_Letter_Percent" runat="server" /></td>
    </tr>
    <tr>
            <td>Contact Us</td>
            <td class="text-right"><asp:Label ID="lblScore_Contact_Us_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Contact_Us_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Contact_Us_Percent" runat="server" /></td>    
        </tr>
    <tr>
           <th class="alert-success" colspan="4">Rehab Ratings - Collector MAY say these things</th> 
   </tr>
    <tr>
            <td>After transfer eligible for pre-default pymt plans</td>
            <td class="text-right"><asp:Label ID="lblScore_Eligible_Payment_Plans_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Eligible_Payment_Plans_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Eligible_Payment_Plans_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>After transfer borr may qualify for deferment or forbearance</td>
            <td class="text-right"><asp:Label ID="lblScore_Deferment_Forb_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Deferment_Forb_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Deferment_Forb_Percent" runat="server" /></td>    
        </tr>  
        <tr>
            <td>Must work out new pymt schedule with servicer</td>
            <td class="text-right"><asp:Label ID="lblScore_New_Payment_Schedule_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_New_Payment_Schedule_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_New_Payment_Schedule_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>Reversed or NSF pymts can jeopardize rehab</td>
            <td class="text-right"><asp:Label ID="lblScore_Reversed_Payments_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Reversed_Payments_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Reversed_Payments_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>Loan(s) will be transferred to servicer approx 60 days after rehab</td>
            <td class="text-right"><asp:Label ID="lblScore_Loans_Transferred_After_60_Days_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Loans_Transferred_After_60_Days_Incorrect" runat="server" /></td> 
            <td class="text-right"><asp:Label ID="lblScore_Loans_Transferred_After_60_Days_Percent" runat="server" /></td>
        </tr>        
        <tr>
            <td>Encourage Electronic Payments</td>
            <td class="text-right"><asp:Label ID="lblScore_Electronic_Payments_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Electronic_Payments_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Electronic_Payments_Percent" runat="server" /></td>    
        </tr>
        <tr>
           <th class="alert-danger" colspan="4">Rehab Ratings - Collector MUST NOT say these things</th> 
        </tr>
        <tr>
            <td>Advise the borr to delay filing tax return</td>
            <td class="text-right"><asp:Label ID="lblScore_Delay_Tax_Reform_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Delay_Tax_Reform_Incorrect" runat="server" /></td> 
            <td class="text-right"><asp:Label ID="lblScore_Delay_Tax_Reform_Percent" runat="server" /></td>   
        </tr>
        <tr>
            <td>Tell the borr that he/she will be eligible for TIV, defers, forbs</td>
            <td class="text-right"><asp:Label ID="lblScore_More_Aid_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_More_Aid_Incorrect" runat="server" /></td> 
            <td class="text-right"><asp:Label ID="lblScore_More_Aid_Percent" runat="server" /></td>   
        </tr>
        <tr>
            <td>Quote an exact amt for the collection costs that will be waived</td>
            <td class="text-right"><asp:Label ID="lblScore_Collection_Costs_Waived_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Collection_Costs_Waived_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Collection_Costs_Waived_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>Impose requirements that are not required</td>
            <td class="text-right"><asp:Label ID="lblScore_False_Requirements_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_False_Requirements_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_False_Requirements_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>Talk them out of PIF or SIF if they are able and willing.  (Can see the credit benefit of rehab.)</td>
            <td class="text-right"><asp:Label ID="lblScore_Avoid_PIF_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Avoid_PIF_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Avoid_PIF_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>Tell a disabled borr that he/she should rehab first then apply for TPD.</td>
            <td class="text-right"><asp:Label ID="lblScore_Rehab_Then_TPD_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Rehab_Then_TPD_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Rehab_Then_TPD_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>Tell the borr that pymt amounts and dates are final and cannot be changed</td>
            <td class="text-right"><asp:Label ID="lblScore_Payments_Are_Final_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Payments_Are_Final_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Payments_Are_Final_Percent" runat="server" /></td>    
        </tr>
        <tr>
            <td>State anything that is not factual including attributing to ED things that are not ED policy</td>
            <td class="text-right"><asp:Label ID="lblScore_Not_Factual_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Not_Factual_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Not_Factual_Percent" runat="server" /></td>    
        </tr>
        <!--Section Added-->
        <tr>
           <th class="alert-success" colspan="4">Consolidation Ratings - Collector MAY say these things</th> 
        </tr>
        <tr>
            <td>This is a new loan</td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_New_Loan_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_New_Loan_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_New_Loan_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>Credit reporting</td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Credit_Reporting_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Credit_Reporting_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Credit_Reporting_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>Fixed interest rates</td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Interest_Rates_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Interest_Rates_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Interest_Rates_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>Capitalization</td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Capitalization_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Capitalization_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Capitalization_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>Title IV Eligibility</td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_TitleIV_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_TitleIV_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_TitleIV_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>Repayment Options</td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Repayment_Options_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Repayment_Options_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Repayment_Options_Percent" runat="server" /></td>
        </tr>
        <tr>
            <td>Default</td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Default_Total" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Default_Incorrect" runat="server" /></td>
            <td class="text-right"><asp:Label ID="lblScore_Consol_Default_Percent" runat="server" /></td>
        </tr>
</table>
            <table width="95%">
              <tr>
               <td><i>This presentation, document or report and analyses are provided for Internal-Use Only and may not be shared outside of Federal Student Aid without the permission of FSA-Operations Services. This presentation, document, report or analysis was created to aid the Department of Education comply with its legal obligation to collect federal student loan debt. 
                    These work products may also be used to inform the creation of future Department and FSA policies.</i></td>
            </tr>
            </table>
        </div>
    </div>
    </asp:Panel>   
        <asp:Label ID="lblPDFUrl" runat="server" Visible="false" />
    </form>
</body>
</html>
