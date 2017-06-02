<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Charts_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>     
    <script src="//cdn.jsdelivr.net/excanvas/r3/excanvas.js" type="text/javascript"></script>     
    <script src="//cdn.jsdelivr.net/chart.js/0.2/Chart.js" type="text/javascript"></script> 
    <script type="text/javascript">
        var crct = $('#<%= lbl_crct.ClientID %>').text();
        var incrct = $('#<%= lbl_incrct.ClientID %>').text();
        var doughnutData = [
        {
            value: incrct,
            color: "#F7464A"
        },
        {
            value: crct,
            color: "#8cc63f"
        }
        ];
        var myDoughnut = new Chart(document.getElementById("canvas").getContext("2d")).Doughnut(doughnutData);           
    </script> 
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="lbl_crct" runat="server" Text=""></asp:Label>     
        <asp:Label ID="lbl_incrct" runat="server" Text=""></asp:Label>   
    </div>
    </form>
</body>
</html>

        
    
    
