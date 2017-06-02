<%@ Page Title="" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="true" CodeFile="RecoverPassword.aspx.vb" Inherits="Account_RecoverPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
     <asp:PasswordRecovery id="PasswordRecovery1" runat="server" BorderStyle="Solid" BorderWidth="1px" BackColor="#F7F7DE"
                Font-Size="10pt" Font-Names="Verdana" BorderColor="#CCCC99" 
                HelpPageText="Need help?" HelpPageUrl="recoveryHelp.aspx" 
                onuserlookuperror="PasswordRecovery1_UserLookupError" 
                onload="PasswordRecovery1_Load"
                maildefinition-from="userAdmin@your.site.name.here"
                onsendingmail="PasswordRecovery1_SendingMail">
                <successtemplate>
                    <table border="0" style="font-size:10pt;">
                        <tr>
                            <td>Your password has been sent to you.</td>
                        </tr>
                    </table>
                </successtemplate>
                <titletextstyle font-bold="True" forecolor="White" backcolor="#6B696B">
                </titletextstyle>
            </asp:PasswordRecovery>
</asp:Content>

