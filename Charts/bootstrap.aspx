<%@ Page Language="VB" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="../bootstrap/dist/js/bootstrap.min.js"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style>
        body {
            margin: 30px;
        }    
        
        #leftSide {
            background-color: #dbe3ff;
            height: 600px;
        }    
        
        #mainContent 
        {
            background-color: #fff5d4;
            height: 600px;
            padding-top: 20px;
        }
            
    </style>
</head>
<body>

<form id="form1" runat="server" class="form-horizontal">
    <fieldset class="col-sm-6">
    <legend>Complete My Form</legend>


    <div class="form-group">
        <label for="fullname" class="col-sm-2 control-label">Name</label>
        <div class="col-sm-10">
            <input type="text" id="fullname" name="fullname" class="form-control" />
            <span class="help-block">Here is some help text for this field</span>
        </div>    
    </div>

    <div class="form-group">
        <label for="comments" class="col-sm-2 control-label">Comments</label>
        <div class="col-sm-10">
            <textarea name="comments" id="comments" class="form-control" rows="5" cols="40"></textarea> 
        </div>   
    </div>

    <div class="form-group">
        <label for="luckynumber" class="col-sm-2 control-label">Lucky Number</label>
        <div class="col-sm-10">
        <select name="luckynumber" id="luckynumber" class="form-control">
            <option>double zero</option>
            <option>nine</option>
            <option>thirteen</option>
        </select>
        </div>
     </div>
   </fieldset>  
        
     
   <fieldset class="col-sm-6">
    <legend>Survey</legend>  
     <div class="form-group">
        <label for="luckynumber" class="col-sm-2 control-label">Favorite Animal</label>
        <div class="col-sm-10">
        <select name="luckynumber" id="Select1" class="form-control">
            <option>double zero</option>
            <option>nine</option>
            <option>thirteen</option>
        </select>
        </div>   
     </div>

     <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <div class="checkbox">            
                <label><input type="checkbox" value="dog" />Dog</label>
            </div>
            <div class="checkbox">            
                <label><input type="checkbox" value="bird" />Bird</label>
            </div>
            <div class="checkbox">            
                <label><input type="checkbox" value="monkey" />Monkey</label>
            </div>        
        </div>     
     </div>

     <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <span>Your favorite state?</span>
            <div class="radio">
                <label><input type="radio" name="count" value="maine" />maine</label><br />
            </div>
            <div class="radio">
                <label><input type="radio" name="count" value="arizona" />arizona</label><br />
            </div>
            <div class="radio">
                <label><input type="radio" name="count" value="florida" />florida</label><br />
            </div>
        </div>     
     </div>

     <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <input type="submit" class="btn btn-primary" value="submit" />
        </div>
    </div>
 
 </fieldset>
 </form>

</body>
</html>
