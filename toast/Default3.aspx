<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript">
    $(function () {
        alert("yes");
        $('#dp2').datepicker();
    });
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>    
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
   
            <input type="text" class="span2" value="02-16-2012" id="dp2" >
         
    </form>
</body>
</html>
