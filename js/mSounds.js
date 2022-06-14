$(document).ready(function () {
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    $.ionSound({ sounds: ['confirm3'] });
    $.ionSound.play('confirm3');
    DoSomeWork();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequestHandler);
});
function endRequestHandler(sender, args) {
    // this code is excected after the first postback
    DoSomeWork();

};
function DoSomeWork() {
    $.ionSound({ sounds: ['switch'] });
    $.ionSound({ sounds: ['confirm'] });
    $.ionSound({ sounds: ['buttonhover'] });
    $.ionSound({ sounds: ['mousehover'] });
    $.ionSound({ sounds: ['selected'] });
    $.ionSound({ sounds: ['misc_menu'] });
    $.ionSound({ sounds: ['misc_menu_2'] });
    $.ionSound({ sounds: ['misc_menu_4'] });

    $('input[type="checkbox"]').change(function () {
        $.ionSound.play('switch');
    });
    $('input[type="button"],input[type="submit"]').hover(function () {
        $.ionSound.play('buttonhover');
    }, function () {

    });
    $('.gvpagination a').hover(function () {
        $.ionSound.play('buttonhover');
    }, function () {

    });
    $('.gvrow,.gvrow2').hover(function () {
        $.ionSound.play('mousehover');

    }, function () {

    });
    $('.gvrow,.gvrow2').click(function () {
        $.ionSound.play('selected');

        // not working well
        //if ($(this).hasClass('blue3')) {

        //}
        //else {
        //    $.ionSound.play('selected');
        //}

    });
    $('select').click(function () {
        $.ionSound.play('switch');

    });
    $('.main-nav li,.mobile-nav li').hover(function () {
        $.ionSound.play('misc_menu');

    }, function () {

    });
    $('.icon-reorder').hover(function () {
        $.ionSound.play('misc_menu');

    }, function () {

    });

    $('.user li:not(".colors")').hover(function () {
        $.ionSound.play('misc_menu_2');

    }, function () {

    });

    // this code is executed when the modal still loading
    $('.modal').on('show.bs.modal', function () {
        $.ionSound.play('confirm');
    });
    $('.tiles li').hover(function () {
        $.ionSound.play('misc_menu_4');
    }, function () {

    });
    // this code is executed when the modal is already loaded
    //$('.modal').on('shown.bs.modal', function () {
    //    $.ionSound.play('confirm');
    //});

    $('.lblUserName').hover(function () {
        $.ionSound.play('misc_menu_2');

    }, function () {

    });


    //$('[data-toggle="tab"]').hover(function () {
    //    $.ionSound.play('buttonhover');
    //});
    /// alternative solution as some tabs has no [data-toggle="tab"] as it is anchor tag
    $('.tabs li').hover(function () {
        $.ionSound.play('buttonhover');
    });
    $('[data-toggle="tab"]').click(function () {
        if ($(this).parent().hasClass('active')) {

        }
        else {
            $.ionSound.play('switch');
        }
    });

}