using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading;
using System.Globalization;

public class LanguageHelper_ud
{
    public static void ChangeLanguage(string lang)
    {
        HttpCookie cookie = new HttpCookie("lang");
        cookie.Value = lang;
        cookie.Expires = DateTime.Now.AddMonths(1);
        HttpContext.Current.Response.Cookies.Add(cookie);
        HttpContext.Current.Response.Redirect(HttpContext.Current.Request.FilePath);
    }

    public static void SetUiCulture()
    {
        HttpRequest request = HttpContext.Current.Request;
        if (request.Cookies["lang"] != null)
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(request.Cookies["lang"].Value);
        else
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("ar");
    }

    public static string GetCurrentLanguage()
    {
        HttpRequest request = HttpContext.Current.Request;
        if (request.Cookies["lang"] != null)
            return request.Cookies["lang"].Value;
        else
            return "ar";
    }

    public static string GetColumnName(string columnName)
    {
        return columnName + "_" + GetCurrentLanguage();
    }
}
