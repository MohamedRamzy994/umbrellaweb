$(document).ready(function () {
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com

    DoSomeThing();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequestHandlers);
});
function endRequestHandlers(sender, args) {
    // this code is excected after the first postback
    DoSomeThing();

};
function DoSomeThing() {
    $('.brand').attr('id', 'brand');
    $('.brand').on({
        mouseenter: function () {
            //stuff to do on mouse enter
            $(this).css('cursor', 'pointer');
        },
        mouseleave: function () {
            //stuff to do on mouse leave
            $(this).css('cursor', 'auto');
        }
    });

    //$(".gvpagination table").css("margin", "2px auto");
    $(".gvpagination").find("span").addClass("gvcurrentrow");
    $(".gvpagination").find("a").addClass("gvnumbtn");
    $(".gvpagination table").first().css("width", "auto");

    $(".colors span").hover(function () {
        $("#hfTheme").val($(this).attr("class"));
        $(this).click(function () {
            __doPostBack('btnSaveTheme', '');
        });
    });

    /////////////////////////////////
    //////// Arabic Numbers//////////
    ////////////////////////////////
    if ($('.lnklang').html() == "EN") {
        if ($.fn.persiaNumber) {
            $('#footer p').persiaNumber('ar');
            $('.gvpagination tr').persiaNumber('ar');
            //$("*:not(.NoAr)").persiaNumber('ar');
        }
    };
    /////////////////////////////////
    ////// End Arabic Numbers ///////
    ////////////////////////////////
    $(".badge").parent().each(function () {
        debugger;
        var cellText = $(this).html().trim();
        if ($('.lnklang').html() == "EN") {
            if (cellText == '<span class="badge badge-success">Active</span>' || cellText == '<span class="badge badge-success">مفعـل</span>') {
                $(this).html('<span class="badge badge-success">مفعـل</span>');
            }
            else {

                $(this).html('<span class="badge badge-important">غير مفعـل</span>');
            }
        }
    });
    $(".yesno").each(function () {
        var cellText = $(this).html().trim();
        if ($('.lnklang').html() == "EN") {
            if (cellText == 'Yes') {
                $(this).html('نعــم');
            }
            else {
                $(this).html('لا');
            }
        }
    });
    $('.gvrow').click(function () {
        var txtInput = $(this).closest('div[class^="box-content"]').find('.txtFocus');
        if ($(txtInput).is("input") || $(txtInput).is("select")) {
            $('html, body').animate({
                scrollTop: $(txtInput).offset().top - 160
            },
            'slow', function () {
                $(txtInput).focus();
            });
        }
        else
        {
            txtInput = $(this).parents('div[class^="box-content"]').find('.txtFocus');
            if ($(txtInput).is("input") || $(txtInput).is("select")) {
                $('html, body').animate({
                    scrollTop: $(txtInput).offset().top - 215
                },
                'slow', function () {
                    $(txtInput).focus();
                });
            }
        }
    });
}