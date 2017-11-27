<%@ Page Title="New FDMS Review" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Add_New.aspx.vb" Inherits="Add_New_FDMS_Review" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>
    <script src="../../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <link href="../../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .auto-style1 {
            font-size: 11pt;
            text-align: center;
            font-family: Calibri;
            background-color: #CCCCCC;
        }
        .question-background {
            background-color: #CCCCCC;
        }

        .score-textbox {
           text-align:center;
        }
    </style>

    <%--<script type="text/javascript">
        $(document).ready(function () {
            $('.score-textbox').change(function () {
                var QCScore;
                $('#MainContent_lblQCScore').text(parseFloat("0" + $('#MainContent_txtScore_Accuracy').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_Evaluate2').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_Evaluate3').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_Evaluate4').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_MethodResolution').val()) + 
                    parseFloat("0" + $('#MainContent_txtScore_Escalated').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_Grammar').val()));
                QCScore = $('#MainContent_lblQCScore').text();
                $('#MainContent_hiddenQCScore').val(QCScore);
            });            
        });
    </script>--%>

    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
        <ul id="nav">
            <li>Menu Here</li>
        </ul>
    </div>


   <%-- <!--Users/Evaluators-->
    <asp:SqlDataSource ID="dsUserID" runat="server"
        ConnectionString="<%$ ConnectionStrings:FDMSConnectionString %>"
        SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure" />--%>

  <div style="padding-top: 40px;">
  <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">FDMS Quality Review</span>
  </div>  
    <div class="panel-body">      
        
        <table width="95%" cellpadding="3" cellspacing="3" border="1" style="table-layout: fixed;">
            <tr>
                <th class="auto-style1" width="20%">Key Data Fields</th>
                <th class="auto-style1" colspan="1">Criteria (5 points total)</th>
                <th class="auto-style1" width="10%" colspan="1">Your Response</th>
                <th class="auto-style1" width="10%" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:Label ID="Label1" runat="server" />K1.  Existing Ombudsman Case</td>
                <td>Case worker checks to see if there is an existing Ombudsman Case. (Ex: Did the case worker verify there is an existing Ombudsman case and if there is, did the case worker verify the case has already been routed to 
                    Ombudsman upon receiving the case? If the Existing Ombudsman Case Checkbox is marked, does the Research Task contain the OCTS Case Number and Status?  
                    Did the case worker verify if the ECS case is relevant to the OCTS case?)   (1 point total)  (If there is no existing Ombudsman case then the 1 point is 
                    automatically awarded). </td>
                <td align="center"><asp:DropDownList ID="ddlScoreK1" runat="server" TabIndex="1">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreK1" />
                </td>
                <td><asp:Label ID="lblScoreK1" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label2" runat="server" />K2.  Description</td>
                <td>If applicable, was the description used to route the case to the appropriate entity. 
                    If the correct categories are selected based on the customers description, the appropriate entity will be automatically selected.  
                    If the incorrect categories selected route the case to the appropriate entity, full credit will be given to the representative.  
                    If incorrect categories route the case to the wrong entity, full deduction of points possible will be applied to this category. (2 points total)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreK2" runat="server" TabIndex="2">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreK2" />
                </td>
                <td><asp:Label ID="lblScoreK2" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label3" runat="server" />K3. Desired Outcome</td>
                <td>Did the case worker review the desired outcome to determine the customer’s expectations (when applicable)?  
                    (Ex. In the description the customer will describe their issue, in the desired outcome they will see how the customer would like for their issue 
                    to be resolved.) (2 points total)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreK3" runat="server" TabIndex="3">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreK3" />
                </td>
                <td><asp:Label ID="lblScoreK3" runat="server" /></td>
            </tr>
            <tr>
                <th class="auto-style1" width="20%">Categorization</th>
                <th class="auto-style1" colspan="1">Criteria (5 points total)</th>
                <th class="auto-style1" width="10%" colspan="1">Your Response</th>
                <th class="auto-style1" width="10%" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:Label ID="Label4" runat="server" />C1. Issue Type</td>
                <td>Selected the appropriate issue type. (1 point total)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreC1" runat="server" TabIndex="4">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreC1" />
                </td>
                <td><asp:Label ID="lblScoreC1" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label5" runat="server" />C2. Issue Sub-Type</td>
                <td>Selected the appropriate issue subtype. (1 point total)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreC2" runat="server" TabIndex="5">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreC2" />
                </td>
                <td><asp:Label ID="lblScoreC2" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label6" runat="server" />C3. Lifecycle Phase</td>
                <td>Understands the situation and selects the appropriate lifecycle phase. (1 point total)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreC3" runat="server" TabIndex="6">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreC3" />
                </td>
                <td><asp:Label ID="lblScoreC3" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label7" runat="server" />C4. Complaint Category</td>
                <td>Selected the appropriate complaint category. (1 point total)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreC4" runat="server" TabIndex="7">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreC4" />
                </td>
                <td><asp:Label ID="lblScoreC4" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label8" runat="server" />C5. Complaint Sub-Category</td>
                <td>Selected the appropriate complaint subcategory. (1 point total)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreC5" runat="server" TabIndex="8">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreC5" />
                </td>
                <td><asp:Label ID="lblScoreC5" runat="server" /></td>
            </tr>
            <tr>
                <th class="auto-style1" width="20%">Documentation/Case Work</th>
                <th class="auto-style1" colspan="1">Criteria (28 points total)</th>
                <th class="auto-style1" width="10%" colspan="1">Your Response</th>
                <th class="auto-style1" width="10%" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:Label ID="Label9" runat="server" />D1. Appropriate Attachments</td>
                <td> </td>
                <td> </td>
                <td> </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label10" runat="server" />D1a.</td>
                <td>Did the case worker provide the appropriate documents and attach them to the case? Correct privacy release template sent to the customer (3 points)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD1a" runat="server" TabIndex="9">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD1a" />
                </td>
                <td><asp:Label ID="lblScoreD1a" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label11" runat="server" />D1b.</td>
                <td>Include any documents/correspondence sent to the customer (3 points)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD1b" runat="server" TabIndex="10">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD1b" />
                </td>
                <td><asp:Label ID="lblScoreD1b" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label12" runat="server" />D2.</td>
                 <td>Did the case worker log all activities completely and accurately? This includes completing all summary fields with appropriate and 
                    detailed information. (Ex: Did the case worker add appropriate related tasks to the case?)  Did not create necessary tasks, if applicable.  
                    Tasks include (10 points total)</td>
                <td> </td>
                <td> </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label13" runat="server" />D2a.</td>
                <td>Internal Tasks (5 points)<br /> 
                    Internal tasks are appropriately detailed. These tasks include:<br />
                    a) recommended activities,<br /> 
                    b) research tasks </td>
                <td align="center"><asp:DropDownList ID="ddlScoreD2a" runat="server" TabIndex="11">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD2a" />
                </td>
                <td><asp:Label ID="lblScoreD2a" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label14" runat="server" />D2b.</td>
                <td>External Tasks (5 points)<br />
                    External tasks are appropriately detailed. These tasks include:<br />
                    c) case reassignment tasks (servicers,  PCAs, DMCS)<br />
                    d) any outreach to customer related tasks (ex. Call log, emails/letters sent to customer)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD2b" runat="server" TabIndex="12">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD2b" />
                </td>
                <td><asp:Label ID="lblScoreD2b" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label15" runat="server" />D3. Checkboxes</td>
                <td>Did not mark or unmark one of the associated checkboxes/ drop down items within the case, if applicable.  
                    (Ex. If the case is private then make sure the private box is checked. If the case is not private then the box should not be checked) 
                    (Ex. If a customer no longer wishes to be anonymous after outreach then the anonymous box should be unchecked) (4 points total) </td>
                <td> </td>
                <td> </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label16" runat="server" />D3a.</td>
                <td>Outreach To Customer (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD3a" runat="server" TabIndex="13">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD3a" />
                </td>
                <td><asp:Label ID="lblScoreD3a" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label17" runat="server" />D3b.</td>
                <td>Private (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD3b" runat="server" TabIndex="14">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD3b" />
                </td>
                <td><asp:Label ID="lblScoreD3b" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label19" runat="server" />D3c.</td>
                <td>Anonymous (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD3c" runat="server" TabIndex="15">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD3c" />
                </td>
                <td><asp:Label ID="lblScoreD3c" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label21" runat="server" />D3d.</td>
                <td>Control Mail (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD3d" runat="server" TabIndex="16">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD3d" />
                </td>
                <td><asp:Label ID="lblScoreD3d" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label18" runat="server" />D4.  Capture/verify contact identification</td>
                <td>Did the case worker capture and/or update, when necessary, the proper contact information as required including (8 points total)?</td>
                <td> </td>
                <td> </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label20" runat="server" />D4a.</td>
                <td>Name (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD4a" runat="server" TabIndex="17">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />                        
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD4a" />
                </td>
                <td><asp:Label ID="lblScoreD4a" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label22" runat="server" />D4b.</td>
                <td>SSN (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD4b" runat="server" TabIndex="18">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />                        
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD4b" />
                </td>
                <td><asp:Label ID="lblScoreD4b" runat="server" /></td>
            </tr>
             <tr>
                <td><asp:Label ID="Label23" runat="server" />D4c.</td>
                <td>Date of Birth (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD4c" runat="server" TabIndex="19">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />                        
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD4c" />
                </td>
                <td><asp:Label ID="lblScoreD4c" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label24" runat="server" />D4d.</td>
                <td>Physical Address (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD4d" runat="server" TabIndex="20">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />                        
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD4d" />
                </td>
                <td><asp:Label ID="lblScoreD4d" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label25" runat="server" />D4e.</td>
                <td>Email Address (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD4e" runat="server" TabIndex="21">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />                        
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD4e" />
                </td>
                <td><asp:Label ID="lblScoreD4e" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label26" runat="server" />D4f.</td>
                <td>Military Information (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD4f" runat="server" TabIndex="22">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />                        
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD4f" />
                </td>
                <td><asp:Label ID="lblScoreD4f" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label27" runat="server" />D4g.</td>
                <td>Phone Number (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD4g" runat="server" TabIndex="23">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />                        
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD4g" />
                </td>
                <td><asp:Label ID="lblScoreD4g" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label28" runat="server" />D4h.</td>
                <td>This includes adding a contact/account/3rd party contact to the case (If applicable) (1 point)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreD4h" runat="server" TabIndex="24">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />                        
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreD4h" />
                </td>
                <td><asp:Label ID="lblScoreD4h" runat="server" /></td>
            </tr>
             <tr>
                <th class="auto-style1" width="20%">Communication</th>
                <th class="auto-style1" colspan="1">Criteria (32 points total)</th>
                <th class="auto-style1" width="10%" colspan="1">Your Response</th>
                <th class="auto-style1" width="10%" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:Label ID="Label29" runat="server" />Co1. Self-Service</td>
                <td>Did the case worker provide self-service features for the customer, if applicable? (Ex. Websites or phone numbers that would help answer any questions.) Not accurately capturing any part of the contact information will result in a full deduction in this category.  
                    This is a high priority category that can result in a negative experience for the customer. (5 points total)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreCo1" runat="server" TabIndex="25">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                        <asp:ListItem Text="N/A" Value="N/A" />                        
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreCo1" />
                </td>
                <td><asp:Label ID="lblScoreCo1" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label30" runat="server" />Co2. Etiquette/Use of terminology</td>
                <td>Does the communication with the customer display proper use of language (grammar/professionalism)? (17 points total)</td>
                <td> </td>
                <td> </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label31" runat="server" />Co2a.</td>
                <td>Did the case worker use appropriate system & process terminology, avoiding internal jargon and processes? (Avoid using jargon/slang.) (4 points)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreCo2a" runat="server" TabIndex="26">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreCo2a" />
                </td>
                <td><asp:Label ID="lblScoreCo2a" runat="server" /></td>
            </tr>
             <tr>
                <td><asp:Label ID="Label32" runat="server" />Co2b.</td>
                <td>Does the communication display courtesy, politeness, and empathy. (Tone of voice when responding to customer) (4 points).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreCo2b" runat="server" TabIndex="27">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreCo2b" />
                </td>
                <td><asp:Label ID="lblScoreCo2b" runat="server" /></td>
            </tr>
             <tr>
                <td><asp:Label ID="Label33" runat="server" />Co2c.</td>
                <td>Refrain from corresponding in short hand style. (Ex. Do not use shortened abbreviations because the customer may not understand them) (2 points).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreCo2c" runat="server" TabIndex="28">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreCo2c" />
                </td>
                <td><asp:Label ID="lblScoreCo2c" runat="server" /></td>
            </tr>
             <tr>
                <td><asp:Label ID="Label34" runat="server" />Co2d.</td>
                <td>Avoid referring to other internal entities such as Ombudsman, Program Compliance, or Servicer Liaison. (Ex. Customer may not understand organizational structure) (2 points).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreCo2d" runat="server" TabIndex="29">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreCo2d" />
                </td>
                <td><asp:Label ID="lblScoreCo2d" runat="server" /></td>
            </tr>
             <tr>
                <td><asp:Label ID="Label35" runat="server" />Co2e.</td>
                <td>Proofread correspondence for spelling, punctuation and grammatical errors (Ex. Was appropriate grammar used?). (5 points) </td>
                <td align="center"><asp:DropDownList ID="ddlScoreCo2e" runat="server" TabIndex="30">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator30" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreCo2e" />
                </td>
                <td><asp:Label ID="lblScoreCo2e" runat="server" /></td>
            </tr>

            <tr>
                <td><asp:Label ID="Label36" runat="server" />Co3. Responsiveness</td>
                <td>(10 points total)</td>
                <td> </td>
                <td> </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label37" runat="server" />Co3a.</td>
                <td>Reached out to the customer within the designated 15 day timeframe.  (Allowances should be made for cases where they were assigned after the first 15 days) (5 points).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreCo3a" runat="server" TabIndex="31">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreCo3a" />
                </td>
                <td><asp:Label ID="lblScoreCo3a" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label38" runat="server" />Co3b.</td>
                <td>Provided frequent updates to the customer in regards to the status and progress of their case every 15 days. (Note: For cases under 60 days old the 15 day status update should not apply because these cases are still being worked in a normal progression) (5 points).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreCo3b" runat="server" TabIndex="32">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator32" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreCo3b" />
                </td>
                <td><asp:Label ID="lblScoreCo3b" runat="server" /></td>
            </tr>
            <tr>
                <th class="auto-style1" width="20%">Resolution</th>
                <th class="auto-style1" colspan="1">Criteria (30 points total)</th>
                <th class="auto-style1" width="10%" colspan="1">Your Response</th>
                <th class="auto-style1" width="10%" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:Label ID="Label39" runat="server" />R1. Closing Details</td>
                <td>(16 points total)</td>
                <td> </td>
                <td> </td>
            </tr> 
            <tr>
                <td><asp:Label ID="Label40" runat="server" />R1a.</td>
                <td>Provided specific information in the closing summary as to why the case was closed and a summary of the customer's complaint. 
                    (Ex: Are the actions which led to the closure of a case detailed in the closing summary?)  (8 points).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreR1a" runat="server" TabIndex="33">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator33" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreR1a" />
                </td>
                <td><asp:Label ID="lblScoreR1a" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label41" runat="server" />R1b.</td>
                <td>Was Closing Summary template used correctly? (Ex. Including issue, research, findings, next steps/options) (6 points). </td>
                <td align="center"><asp:DropDownList ID="ddlScoreR1b" runat="server" TabIndex="34">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreR1b" />
                </td>
                <td><asp:Label ID="lblScoreR1b" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label42" runat="server" />R1c.</td>
                <td>Appropriate Resolution Action selected. Mark Appropriately depending on case details ( Ex. Clarified Communication/Process for customer, Action Taken, Submission Logged) (1 point).  </td>
                <td align="center"><asp:DropDownList ID="ddlScoreR1c" runat="server" TabIndex="35">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator35" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreR1c" />
                </td>
                <td><asp:Label ID="lblScoreR1c" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label43" runat="server" />R1d.</td>
                <td>If the case needs to be referred make sure to select the correct Resolution Entity, if applicable. 
                    (Ex. If case was a third party debt relief did we mark Federal Trade Commission as the Resolution Entity?) (1 point).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreR1d" runat="server" TabIndex="36">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator36" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreR1d" />
                </td>
                <td><asp:Label ID="lblScoreR1d" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label44" runat="server" />R2. Appropriate Response</td>
                <td>(12 points total)</td>
                <td> </td>
                <td> </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label45" runat="server" />R2a.</td>
                <td>Did the case worker provide the customer with the accurate information/response to address the customer's complaint? (Ex. Did the case worker provide the customer with an appropriate procedure to resolve the customer’s issue?) 
                    (Ex. Did the case worker provide accurate information regarding the customer’s account status?) (4 points).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreR2a" runat="server" TabIndex="37">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator37" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreR2a" />
                </td>
                <td><asp:Label ID="lblScoreR2a" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label46" runat="server" />R2b.</td>
                <td>Provided a sufficient enough response to answer/address all of the issues that the customer raised in the complaint. 
                    (Ex. Were call logs/dates included?) (Was all of the customer’s pertinent account history included?) (4 points).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreR2b" runat="server" TabIndex="38">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator38" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreR2b" />
                </td>
                <td><asp:Label ID="lblScoreR2b" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label47" runat="server" />R2c.</td>
                <td>Did case worker provide applicable guidance to the customer in regards to their next steps in the process? (Ex. Did you provide the customer with appropriate options moving forward given the details of their case?) 
                    (Ex. Rehabbing a loan, check with credit bureaus, considering consolidations, consider income-based repayment plans.) (4 points).</td>
                <td align="center"><asp:DropDownList ID="ddlScoreR2c" runat="server" TabIndex="39">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator39" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreR2c" />
                </td>
                <td><asp:Label ID="lblScoreR2c" runat="server" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label48" runat="server" />R3. Referred/escalated to appropriate business unit</td>
                <td>Did the case worker determine an applicable entity to resolve the issue? (Ex: Was the customer referred, or the case escalated, to an appropriate entity to resolve their case?) (Ex. If case owner was not able to resolve the issue, 
                    was the case referred or escalated to the appropriate entity that can potentially resolve it?) (2 points total)</td>
                <td align="center"><asp:DropDownList ID="ddlScoreR3" runat="server" TabIndex="40">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                     </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator40" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="ddlScoreR3" />
                </td>
                <td><asp:Label ID="lblScoreR3" runat="server" /></td>
            </tr>



            <tr>
                <td colspan="4">
                    <asp:Button ID="btnInsertNewReview" runat="server" Text="Add New Review" CssClass="btn btn-primary" /><br />
                    <asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" />
                </td>
            </tr>
        </table>     

                                          
    </div>
  </div>
</div>

    
</asp:Content>

