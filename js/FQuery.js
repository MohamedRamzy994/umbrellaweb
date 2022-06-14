///////////////////////
//////////////////////
/// <reference path="FQuery.js" />
// Library	: FQuery
// Done By 	: Mohamed El fiky & Moustafa Ebrahem
//////////////////////
//////////////////////


(function ($) {


    $.fn.fData = function (serviceName, sender, successFn) {
        /// <summary>
        ///    Date : [16-4-2013]
        ///    Function :  sava input data to DataBase using webservice 
        ///     of search for some thing from DataBase
        ///    in the form of [webpage.aspx/webMethod] .. [webpage.asmx/webMethod] .. etc.
        ///    Author : Elfiky
        /// </summary>
        /// <param name="serviceName" type="String">
        ///     web service Name
        /// </param>
        /// <param name="sender" type="String">
        ///    sender Name
        /// </param>
        /// <param name="successFn" type="function">
        ///     what happen if ajax call success
        /// </param>
        // debugger;
        var sendData = new Object(); // data send to webservice in form of object of objects
        var txtData = $(this).find("input");
        var drbData = $(this).find("select");
        var areaData = $(this).find("textarea");
        if (sender != undefined) {
            sendData.sender = new Array();
            sendData.sender = sender;
        }
        //----------------------
        if (txtData != undefined) {
            sendData.inputValues = new Array();


            txtData.each(function (index) {

                typeInp = $(this).attr("type");
                checkInp = $(this).attr("checked");
                // if it is radio or check and checked  ... capture it :)
                var x = ((typeInp == "radio" || typeInp == "checkbox") && checkInp == "checked");
                // if it is niether radio nor check ::::: type text ... capture it :)
                var y = (typeInp != "radio" && typeInp != "checkbox");

                if (x || y) {
                    sendData.inputValues[index] = $(this).val();
                }
                else {
                    sendData.inputValues[index] = null;
                }
            });

        }

        if (areaData != undefined) {
            sendData.areaValues = new Array();
            areaData.each(function (index) {
                sendData.areaValues[index] = $(this).val();
            });
        }

        sendData.selectValues = new Array();
        //----------------------
        if (drbData != undefined) {

            drbData.each(function (index) {

                //   debugger;
                sendData.selectValues[index] = $(this).val();

            });

        }
        //----------------------
        var myData = JSON.stringify({ "Data": sendData });
        //debugger;
        $.ajax({
            type: "POST",
            url: serviceName, //webMethod
            data: myData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function OnSuccess(response) {
                //debugger;
                if (successFn != undefined) successFn(response);
            },
            failure: function (response) {
                alert(response.d);
            }
        });

    };
    //----------------------------------------fData End----------------------------------

    $.fn.fClear = function () {

        $(this).find("input[type='text']").val("");
        $(this).find("input[type='hidden']").val("");
        $(this).find("input:checkbox").removeAttr("checked");
        $(this).find("input:radio").removeAttr("checked");
        $(this).find("textarea").val("");
        $(this).find("select").each(function () {
            $(this).get(0).selectedIndex = 0;
        });
    };



    //-------------------------------------------------------------------
    $.fn.mLoad = function (serviceName, sender, successFn) {
        /// <summary>
        ///    Date : [4-25-2013]
        ///    Function :  load Data according to specific send object individualy
        ///    in the form of [webpage.aspx/webMethod] .. [webpage.asmx/webMethod] .. etc.
        ///    Author : Maradona
        /// </summary>
        /// <param name="serviceName" type="String">
        ///     web service Name
        /// </param>
        /// <param name="successFn" type="function">
        ///     what happen if ajax call success
        /// </param>
        //  debugger;
        //debugger;
        if (sender != undefined) {
            sendData = sender;
        }
        //----------------------
        var myData = JSON.stringify({ "Data": sendData });
        $.ajax({
            type: "POST",
            url: serviceName, //webMethod
            data: myData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function OnSuccess(response) {
                if (successFn != undefined) successFn(response);
            },
            failure: function (response) {
                alert(response.d);
            }
        });

    };
    //////////////////////////////////////////
    ///////////////////////////////////


    $.fn.fLoad = function (serviceName, sender, successFn) {
        /// <summary>
        ///    Date : [16-4-2013]
        ///    Function :  load Data according to specific send object Array
        ///    in the form of [webpage.aspx/webMethod] .. [webpage.asmx/webMethod] .. etc.
        ///    Author : Elfiky
        /// </summary>
        /// <param name="serviceName" type="String">
        ///     web service Name
        /// </param>
        /// <param name="successFn" type="function">
        ///     what happen if ajax call success
        /// </param>
       // debugger;

        var sendData = new Object(); // data send to webservice in form of object of objects

        if (sender != undefined) {
            sendData.sender = new Array();
            sendData.sender = sender;
        }
        //----------------------
        var myData = JSON.stringify({ "Data": sendData });
        $.ajax({
            type: "POST",
            url: serviceName, //webMethod
            data: myData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function OnSuccess(response) {
                if (successFn != undefined) successFn(response);
            },
            failure: function (response) {
                alert(response.d);
            }
        });

    };
    //-------------------------------------------------------------------


    $.fn.mShowStatus = function (type, message) {
        /// <summary>
        ///    Date : [05-1-2014]
        ///    Function :  show message success in the selected elenet
        ///    Author : Moustafa Ebrahem 
        /// </summary>
        /// <param name="type" type="Int">
        ///     1 >> Done   2 >> Error   3 >> Info  4 >> Notification
        /// </param>
        /// <param name="message" type="String">
        ///     message to be posted
        /// </param>
        //  debugger;
        var delaySec = 5000;
        switch (type) {
            case 1:
                $(this).prepend($("<div class='alert alert-success' style='width:45%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> Done ! </strong>" + message + "</div>").delay(delaySec).fadeOut());
                break;
            case 2:
                $(this).prepend($("<div class='alert alert-error' style='width:45%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> Error ! </strong>" + message + "</div>").delay(delaySec).fadeOut());
                break;
            case 3:
                $(this).prepend($("<div class='alert alert-info' style='width:45%;'><button type='button' onclick='$(this).parent().hide();' class='close' data-dismiss='alert'>×</button><strong> Information ! </strong>" + message + "</div>").delay(delaySec).fadeOut());
                break;
            case 4:
                $(this).prepend($("<div class='alert' style='width:45%;'><button type='button' class='close' onclick='$(this).parent().hide();' data-dismiss='alert'>×</button><strong> Notification ! </strong>" + message + "</div>").delay(delaySec).fadeOut());
                break;
        }
    };



    $.fn.fAjaxUpload = function (url, multi, auto, alwdExt, maxSize) {
        /// <summary>
        ///    Date : [24-4-2013]
        ///    Function :  upload content to server by setting end point
        ///    Author : Elfiky
        /// </summary>
        /// <param name="url" type="String">
        ///     url to uplaod attatchment page 
        /// </param>
        /// <param name="multi" type="Boolen">
        ///     enable or disaple multiple file uploads
        /// </param>
        /// <param name="auto" type="Boolen">
        ///      enable or disaple multiple file auto upload
        /// </param>
        /// <param name="alwdExt" type="Array">
        ///    like ['jpeg', 'jpg', 'gif', 'png'] 
        /// </param>
        /// <param name="maxSize" type="number">
        ///    number of allawed bytes like 50 kB = 50 * 1024 bytes
        /// </param>
        //  debugger;

        var AddUploader = $(this).fineUploader({
            request: {
                endpoint: url
            },
            autoUpload: auto,
            multiple: multi,
            validation: {
                allowedExtensions: alwdExt,
                sizeLimit: maxSize
            },
            text: {
                uploadButton: '<span class="btn btn-success fileinput-button"><span><i class="icon-plus icon-white"></i> Add files...</span><input type="file" name="files[]" multiple=""></span>'
            }
        });
        return AddUploader;
    };

})(jQuery);

