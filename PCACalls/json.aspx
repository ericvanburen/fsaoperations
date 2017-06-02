<%@ Page Language="VB" AutoEventWireup="true" CodeFile="json.aspx.vb" Inherits="PCACalls_json" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-1.12.0.js" type="text/javascript"></script>
    <script src="http://code.highcharts.com/highcharts.js" type="text/javascript"></script>
    <script src="http://code.highcharts.com/modules/exporting.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://code.highcharts.com/modules/data.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {

            //var options = {
            //    chart: {
            //        renderTo: 'container',
            //        type: 'bar'
            //    },
            //    series: [{}]
            //};
        
        
            //$.getJSON("jsonResults.aspx", function (data) {
            //    options.series[0].data = data;
            //    var chart = new Highcharts.Chart(options);        
            //})  

            //$.get('data.csv', function (csv) {
            //    $('#container').highcharts({
            //        chart: {
            //            type: 'column'
            //        },
            //        data: {
            //            csv: csv
            //        },
            //        title: {
            //            text: 'PCA Assignnments'
            //        },
            //        yAxis: {
            //            title: {
            //                text: 'PCAs'
            //            }
            //        }
            //    });
            //});

            $(function () {
                $('#container').highcharts({
                    data: {
                        table: 'GridView1'
                    },
                    chart: {
                        type: 'pie'
                    },
                    title: {
                        text: 'Incorrect Actions for This Review Period'
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
                            text: 'Units'
                        }
                    },
                    tooltip: {
                        formatter: function () {
                            return '<b>' + this.series.name + '</b><br/>' +
                                this.point.name.toLowerCase();
                        }
                    }
                });
            });

        });
</script>  

</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Label ID="lblJsonOutput" runat="server" />
    </div>

    <div id="container" />

         <asp:SqlDataSource ID="dsCalls" runat="server" SelectCommand="p_ReportPercentIncorrectAllPCAs_Chart" SelectCommandType="StoredProcedure"
        ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">    
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" runat="server" DataSourceID="dsCalls" AllowSorting="false" AutoGenerateColumns="true" CssClass="hide" />

    </form>
</body>
</html>
