$(document).ready(function () {
    //Attachment 1
    $("#MainContent_btnAttachment1").click(function (evt) {
        var xhr = new XMLHttpRequest();
        var data = new FormData();
        var files = $("#MainContent_ImageUpload1").get(0).files;
        var RandomNumber = Math.floor((Math.random() * 90) + 10);

        for (var i = 0; i < files.length; i++) {
            data.append(files[i].name, files[i]);
        }
        xhr.upload.addEventListener("progress", function (evt) {
            if (evt.lengthComputable) {
                var progress = Math.round(evt.loaded * 100 / evt.total);
                $("#progressbar1").progressbar("value", progress);
            }
        }, false);
        xhr.open("POST", "UploadHandler.ashx?RandomNumber=" + RandomNumber);
        xhr.send(data);

        $("#progressbar1").progressbar({
            max: 100,
            change: function (evt, ui) {
                $("#progresslabel1").text($("#progressbar1").progressbar("value") + "%");
            },
            complete: function (evt, ui) {
                $("#progresslabel1").text("File " + RandomNumber + " upload successful!");
                $("#MainContent_lblAttachment1Number").val(RandomNumber);
            }
        });
        evt.preventDefault();
    });


    //Attachment 2
    $("#MainContent_btnAttachment2").click(function (evt) {
        var xhr = new XMLHttpRequest();
        var data = new FormData();
        var files = $("#MainContent_ImageUpload2").get(0).files;
        var RandomNumber = Math.floor((Math.random() * 90) + 10);

        for (var i = 0; i < files.length; i++) {
            data.append(files[i].name, files[i]);
        }
        xhr.upload.addEventListener("progress", function (evt) {
            if (evt.lengthComputable) {
                var progress = Math.round(evt.loaded * 100 / evt.total);
                $("#progressbar2").progressbar("value", progress);
            }
        }, false);
        xhr.open("POST", "UploadHandler.ashx?RandomNumber=" + RandomNumber);
        xhr.send(data);

        $("#progressbar2").progressbar({
            max: 100,
            change: function (evt, ui) {
                $("#progresslabel2").text($("#progressbar2").progressbar("value") + "%");
            },
            complete: function (evt, ui) {
                $("#progresslabel2").text("File " + RandomNumber + " upload successful!");
                $("#MainContent_lblAttachment2Number").val(RandomNumber);
            }
        });
        evt.preventDefault();
    });

    //Attachment 3
    $("#MainContent_btnAttachment3").click(function (evt) {
        var xhr = new XMLHttpRequest();
        var data = new FormData();
        var files = $("#MainContent_ImageUpload3").get(0).files;
        var RandomNumber = Math.floor((Math.random() * 90) + 10);

        for (var i = 0; i < files.length; i++) {
            data.append(files[i].name, files[i]);
        }
        xhr.upload.addEventListener("progress", function (evt) {
            if (evt.lengthComputable) {
                var progress = Math.round(evt.loaded * 100 / evt.total);
                $("#progressbar3").progressbar("value", progress);
            }
        }, false);
        xhr.open("POST", "UploadHandler.ashx?RandomNumber=" + RandomNumber);
        xhr.send(data);

        $("#progressbar3").progressbar({
            max: 100,
            change: function (evt, ui) {
                $("#progresslabel3").text($("#progressbar3").progressbar("value") + "%");
            },
            complete: function (evt, ui) {
                $("#progresslabel3").text("File " + RandomNumber + " upload successful!");
                $("#MainContent_lblAttachment3Number").val(RandomNumber);
            }
        });
        evt.preventDefault();
    });

});