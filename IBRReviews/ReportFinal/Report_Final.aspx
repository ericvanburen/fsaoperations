<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Report_Final.aspx.vb" Inherits="PCAReviews_Report_Final" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IDR Final Report</title>
    <link href="../../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        div.datatable {
            margin-left:10px; 
            margin-right:10px;
            font-size: 11.5px;  
        }

      .pageBreak {
        page-break-after: always;
      }

      .datatable {
          font-size: 11.5px;
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
               <td align="left"><strong>IDR Monitoring Report - Final</strong></td>
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
                <td align="left"><strong> REVIEW OBJECTIVES</strong></td>
            </tr>
            <tr>
               <td align="left">The purpose of this review is to:
                <ol>
                    <li>To ensure the Private Collection Agency (PCA) has received a valid rehabilitation agreement and necessary financial documents to support the payment amount.</li>
                    <li>To ensure the rehabilitation agreement letter and financial documentation support the repayment calculation.</li>
                    <li>To ensure appropriate Income Driven Repayment (IDR) tag is entered into the Debt Management Collection System (DMCS).</li>
                </ol>
                <br /></td> 
            </tr>
            <tr>
                <td align="left"><strong>STANDARDS</strong></td>
            </tr>
            <tr>
                <td align="left"><strong>Regulatory</strong></td>
            </tr>
            <tr>
                <td align="left">The regulations governing Loan Rehabilitation: Reasonable and Affordable Payments standards are found at 34 CFR 682.405(b) and 34 CFR 685.211(f).</td>
            </tr>
            <tr>
                <td align="left"><br /><strong>Contractual</strong>
                    <p>The U.S. Department of Education Federal Student Aid requires the Servicer to meet all requirements outlined in PCA Procedures Manual: 2016 ED Collection Contract.</p>
                </td>
            </tr>            
            <tr>
                <td align="left"><br /><strong>METHODOLOGY</strong></td>
            </tr>
            <tr>
                <td align="left"><strong>Sampling</strong></td>
            </tr>
            <tr>
                <td align="left"><asp:Label ID="lblPopulationSize2" runat="server" /> high balance IDR accounts were randomly selected from the population of IDR rehabilitation sales processed during review period.<br /><br /></td>
            </tr>
            <tr>
                <td align="left"><strong>Materials Reviewed</strong></td>
            </tr>
            <tr>
                <td align="left">The following documents were reviewed and received from PCA:
                    <ul>
                        <li>Copy of each borrower’s 15% rehab formula calculation</li>
                        <li>Agreement Letter (if applicable)</li>
                        <li>Alternative Document of Income (ADOI)</li>
                        <li>Insert any additional documents requested from  the PCA (if applicable)</li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td align="left"><strong>Testing</strong></td>
            </tr>
            <tr>
                <td align="left">The following tests were performed to meet review objectives:
                    <ol>
                        <li>Reviewed and analyzed each rehabilitation agreement to ensure all required information, signature, and date is included to validate the legitimacy of the agreement.</li>
                        <li>Reviewed, analyzed and certify that the PCA’s payment calculation and the borrower’s financial documentation is correctly represented and corresponds to the payment calculation and  payment amount provided on rehabilitation agreement. </li>
                        <li>Analyzed DMCS system to ensure each borrower’s eligible loan debts were tagged for rehabilitation.</li>
                    </ol>
                </td>
            </tr>
             <tr>
                <td align="left"><strong>OBSERVATIONS</strong></td>
            </tr>
             <tr>
                <td align="left">A representative reviewed and analyzed a sample of <asp:Label ID="lblPopulationSize3" runat="server" /> accounts and the following observations are noted for each review category. See attachment A for details.<br /><br /></td>
            </tr>
            <tr>
                <td align="left"><strong><p><u>IDR Rehabilitation Agreement Letter</u></p></strong></td>
            </tr>
            <tr>
                <td align="left"><p><asp:Label ID="lblAgreementLetterResults" runat="server" /></p></td>
            </tr>
            <tr>
                <td align="left"><strong><p><u>IDR Rehabilitation Documents</u></p></strong></td>
            </tr>
            <tr>
                <td align="left"><p><asp:Label ID="lblRehabDocsResults" runat="server" /></p></td>
            </tr>
            <tr>
                <td align="left"><strong><p><u>IDR Repayment Amount Documents</u></p></strong></td>
            </tr>
            <tr>
                <td align="left"><p><asp:Label ID="lblRepaymentAmountResults" runat="server" /></p></td>
            </tr>
            <tr>
                <td align="left"><strong><p><u>IDR Tag</u></p></strong></td>
            </tr>
            <tr>
                <td align="left"><p><asp:Label ID="lblIDRTagResults" runat="server" /></p></td>
            </tr>

        </table>
        <p class="pageBreak"></p>
        
        <div class="datatable">
        
            <p><h3>Summary of Attachment A</h3></p>
            <table class="table-bordered datatable" width="90%" cellpadding="4">
            <tr>
                  <td colspan="3"><strong>Number of Reviews: </strong><asp:Label ID="lblPopulationSize" runat="server" />
           </td></tr>
            <thead>
                <tr>
                    <th>Metric</th>
                    <th class="text-right">Total</th>
                    <th class="text-right">% of Total</th>
                </tr>
            </thead>

            <tr>
                <td>Accounts With One Error or More</td>
                <td class="text-right"><asp:Label ID="lblTotal_AnyErrors" runat="server" /></td>
                <td class="text-right"><asp:Label ID="lblTotal_AnyErrors_Percent" runat="server" /></td>
            </tr>
            <tr>
                <td>Agreement Letter Errors</td>
                <td class="text-right"><asp:Label ID="lblScore_Agreement_Letter_Signed_Errors" runat="server" /></td>
                <td class="text-right"><asp:Label ID="lblScore_Agreement_Letter_Signed_Errors_Percent" runat="server" /></td>    
            </tr>
            <tr>
                <td>Documentation Errors</td>
                <td class="text-right"><asp:Label ID="lblScore_Financial_Documentation_Errors" runat="server" /></td>
                <td class="text-right"><asp:Label ID="lblScore_Financial_Documentation_Errors_Percent" runat="server" /></td>
            </tr>
            <tr>
                <td>Repayment Amount Errors</td>
                <td class="text-right"><asp:Label ID="lblScore_Repayment_Amount_Errors" runat="server" /></td>
                <td class="text-right"><asp:Label ID="lblScore_Repayment_Amount_Errors_Percent" runat="server" /></td>
            </tr>
            <tr>
                <td>Tag Errors</td>
                <td class="text-right"><asp:Label ID="lblScore_Tag_Errors" runat="server" /></td>
                <td class="text-right"><asp:Label ID="lblScore_Tag_Errors_Percent" runat="server" /></td>
            </tr>
            </table>
            <br />
            <table width="90%">
              <tr>
               <td><p><i>This presentation, document or report and analyses are provided for Internal-Use Only and may not be shared outside of Federal Student Aid without the permission of FSA-Operations Services. This presentation, document, report or analysis was created to aid the Department of Education comply with its legal obligation to collect federal student loan debt. 
                    These work products may also be used to inform the creation of future Department and FSA policies.</i></p></td>
            </tr>
            </table>
        </div>
    </div>
    </asp:Panel>   
        <asp:Label ID="lblPDFUrl" runat="server" Visible="false" />
    </form>
</body>
</html>
