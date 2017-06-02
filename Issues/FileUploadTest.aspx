<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FileUploadTest.aspx.vb" Inherits="Issues_FileUploadTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.0/themes/base/minified/jquery-ui.min.css" rel="stylesheet" />
   
    <style type="text/css">
        .progressbar {
            width: 300px;
            height: 21px;
        }

        .progressbarlabel {
            width: 300px;
            height: 21px;
            position: absolute;
            text-align: center;
            font-size: small;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#Button1").click(function (evt) {
                var xhr = new XMLHttpRequest();
                var data = new FormData();
                var files = $("#FileUpload1").get(0).files;
                for (var i = 0; i < files.length; i++) {
                    data.append(files[i].name, files[i]);
                }
                xhr.upload.addEventListener("progress", function (evt) {
                    if (evt.lengthComputable) {
                        var progress = Math.round(evt.loaded * 100 / evt.total);
                        $("#progressbar").progressbar("value", progress);
                    }
                }, false);
                xhr.open("POST", "UploadHandler.ashx");
                xhr.send(data);

                $("#progressbar").progressbar({
                    max: 100,
                    change: function (evt, ui) {
                        $("#progresslabel").text($("#progressbar").progressbar("value") + "%");
                    },
                    complete: function (evt, ui) {
                        $("#progresslabel").text("File upload successful!");
                    }
                });
                evt.preventDefault();
            });
        });

    </script>
</head>
<body>
  <form id="form1" runat="server">
    <div>

  <div class="panel-body" id="pnlAttachmentsBody">
  <asp:Label ID="Label1" runat="server" Text="Select File to Upload" />
   <asp:FileUpload ID="FileUpload1" runat="server" />
   <asp:Button ID="Button1" runat="server" Text="Upload" />    
  </div>
 </div>
      <div id="progressbar" class="progressbar">
          <div id="progresslabel" class="progressbarlabel"></div>
      </div>
 </form>
</body>
</html>
