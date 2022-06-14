/**
 * Default Button - A jQuery plugin to easily define a default button
 * Version 1.2 - 2011-12-18
 * Requires jQuery 1.7+
 *
 * ©2010-2011 Ronald M. Clifford (roncli@roncli.com)
 *
 * License_udd under the MIT License_ud:
 * http://www.opensource.org/License_uds/mit-License_ud.php
 *
 * Usage:
 * $(region).defaultButton(button);
 *
 * region: A selector that indicates the region where you want the enter key to
 *         click the default button.
 * button: A selector that indicates the default button to be clicked when the
 *         enter key is pressed inside the specified region.
 */

(function($)
{
    "use strict";
    $.fn.defaultButton = function(ui)
    {
        var _this = this;
        $(_this).off("keypress").on("keypress", function(e)
        {
            var which = e.which,
                keyCode = e.keyCode;
            if (e.target.nodeName === "INPUT" && ((which && which === 13) || (keyCode && keyCode === 13))) {
                $(ui).click();
                return true;
            }
        });
        return _this;
    };
}(jQuery));
