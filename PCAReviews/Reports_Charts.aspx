<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Reports_Charts.aspx.vb" Inherits="PCAReviews_Reports_Charts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../Scripts/highcharts.js" type="text/javascript"></script>
    <script src="../Scripts/highcharts-data.js" type="text/javascript"></script>
    <script src="../Scripts/highcharts-exporting.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        $(document).ready(function() {           

            $(function () {
                $('#chartIncorrectActions').highcharts({
                    data: {
                        table: 'MainContent_grdIncorrectActions'
                    },
                    chart: {
                        type: 'column'
                    },
                    title: {
                        text: '% Incorrect Actions for the Selected Review Period'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: true,
                                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                                style: {
                                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                }
                            }
                        }
                    },
                    yAxis: {
                        allowDecimals: false,
                        title: {
                            text: '% Incorrect of Actions'
                        }
                    },
                    tooltip: {
                        formatter: function () {
                            return '<b>' + this.series.name + '</b><br/>' +
                                this.point.y + ' ' + this.point.name.toLowerCase();
                        }
                    }
                });
            });

        });
</script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 <!--Navigation Menu-->
<div class="hidden-print">
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">Save New PCA Review Old</a></li>
        <li><a href="Reports2.aspx">Save New PCA Review</a></li>
        <li><a href="Reports_SavedReports.aspx">Search PCA Reviews</a></li>       
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="MakeAssignments.aspx">Make New LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="Reports_Incorrect_Actions_ByGroup.aspx">PCA Incorrect Actions Summary</a></li>
        <li><a href="Reports_Incorrect_Actions.aspx">PCA Incorrect Actions Detail</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p><br /></p>
 <label class="form-label">Review Period Month:</label>
            <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" AutoPostBack="true" CssClass="inputBox">
                <asp:ListItem Text="01" Value="01" />
                <asp:ListItem Text="02" Value="02" />
                <asp:ListItem Text="03" Value="03" />
                <asp:ListItem Text="04" Value="04" />
                <asp:ListItem Text="05" Value="05" />
                <asp:ListItem Text="06" Value="06" />
                <asp:ListItem Text="07" Value="07" />
                <asp:ListItem Text="08" Value="08" />
                <asp:ListItem Text="09" Value="09" />
                <asp:ListItem Text="10" Value="10" />
                <asp:ListItem Text="11" Value="11" />
                <asp:ListItem Text="12" Value="12" />
            </asp:DropDownList>
             <label class="form-label">Review Period Year:</label>
            <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" AutoPostBack="true" CssClass="inputBox">
                 <asp:ListItem Text="2015" Value="2015" />
                 <asp:ListItem Text="2016" Value="2016" />
           </asp:DropDownList>
          
        <div id="chartIncorrectActions" />

         <asp:SqlDataSource ID="dsCalls" runat="server" SelectCommand="p_ReportPercentIncorrectAllPCAs_Chart" SelectCommandType="StoredProcedure"
        ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" FilterExpression="ReviewPeriodMonth LIKE '{0}%' AND ReviewPeriodYear LIKE '{1}%'">    
        <FilterParameters>
            <asp:ControlParameter Name="ReviewPeriodMonth" ControlID="ddlReviewPeriodMonth" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="ReviewPeriodYear" ControlID="ddlReviewPeriodYear" PropertyName="SelectedValue" />
        </FilterParameters>
         </asp:SqlDataSource>

        <asp:GridView ID="grdIncorrectActions" runat="server" DataSourceID="dsCalls" AllowSorting="false" AutoGenerateColumns="false" CssClass="hide">
         <Columns>
                <asp:BoundField DataField="PCA" HeaderText="PCA" />
                <asp:BoundField DataField="% Incorrect" HeaderText="% Incorrect" />
         </Columns>   
        </asp:GridView>

</asp:Content>

