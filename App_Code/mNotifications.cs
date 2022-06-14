using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.EnterpriseServices;
using System.Reflection;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for mNotifications
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// mNotifications v1.2
/// 06_13_2014
/// </summary>
public class mNotifications
{
    public mNotifications()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public enum mNotifyType
    {
        success_save,
        success_update,
        success_delete,
        info,
        error_general,
        error_delete,
        warning_amount,
        warning,
        period_exist,
        period_select
    };
    public static void Notify(System.Web.UI.Page page, mNotifyType type, String msg, bool ShowDefaultMsg, params string[] JsMethos)
    {
        string success_title = "";
        string success_save = "";
        string success_update = "";
        string success_delete = "";
        string error_title = "";
        string error_general = "";
        string error_delete = "";
        string info_title = "";
        string info_msg = "";
        string warning_title = "";
        string warning_msg = "";
        string warning_amount = "";
        string period_exist = "";
        string period_select = "";
        string options = "var ops= toastr.options = {'closeButton': true,'debug': false,'positionClass': 'toast-top-full-width','onclick': null,'showDuration': '800','hideDuration': '2000','timeOut': '4000','extendedTimeOut': '2000','showEasing': 'swing','hideEasing': 'linear','showMethod': 'fadeIn','hideMethod': 'fadeOut','closeHtml':'<button><i class=icon-off></i></button>'};";
        string str = "";
        Users_ud user = (Users_ud)HttpContext.Current.Session["user"];
        if (HttpContext.Current.Session["lang"] != null)
        {
            if (HttpContext.Current.Session["lang"].ToString() == "en")
            {
                success_title = "Done";
                success_save = "Record has been saved successfully";
                success_update = "Record has been updated successfully";
                success_delete = "Record has been deleted successfully";
                error_title = "Error";
                error_general = "An error has occured";
                error_delete = "This record cannot be deleted because it is used in another place";
                info_title = "Information";
                info_msg = "Attention please";
                warning_title = "Warning";
                warning_msg = "Attention please";
                warning_amount = "Amount cannot be less than or equal zero";
                period_exist = "Period range already exists";
                period_select = "Please select a valid period";
            }
            else
            {
                success_title = "حسنــا";
                success_save = "تـم حفــظ السجـل بنجــاح";
                success_update = "تـم تعـديــل السجـل بنجــاح";
                success_delete = "تـم مســح السجـل بنجــاح";
                error_title = "خطــأ";
                error_general = "حـدث خطــأ مـا";
                error_delete = "لا يمكـن مسـح السجـل لأنـه مستخـدم في مكـان آخـر";
                info_title = "معلـومــة";
                info_msg = "انتبــه من فضــلك";
                warning_title = "تحـذيــر";
                warning_msg = "انتبــه من فضــلك";
                warning_amount = "لا ينبغـي أن يكـون المبلـغ أقل من أو يسـاوي الصفــر";
                period_exist = "نطـاق الفتـرة مـوجـود بالفعـل";
                period_select = "مـن فضـلك اختـر فتـرة صـحيحـة";
            }
        }
        else
        {
            HttpContext.Current.Session["lang"] = "ar";
            success_title = "حسنــا";
            success_save = "تـم حفــظ السجـل بنجــاح";
            success_update = "تـم تعـديــل السجـل بنجــاح";
            success_delete = "تـم مســح السجـل بنجــاح";
            error_title = "خطــأ";
            error_general = "حـدث خطــأ مـا";
            error_delete = "لا يمكـن مسـح السجـل لأنـه مستخـدم في مكـان آخـر";
            info_title = "معلـومــة";
            info_msg = "انتبــه من فضــلك";
            warning_title = "تحـذيــر";
            warning_msg = "انتبــه من فضــلك";
            warning_amount = "لا ينبغـي أن يكـون المبلـغ أقل من أو يسـاوي الصفــر";
            period_exist = "نطـاق الفتـرة مـوجـود بالفعـل";
            period_select = "مـن فضـلك اختـر فتـرة صـحيحـة";
        }
        if (ShowDefaultMsg)
        {
            switch (type)
            {
                case mNotifyType.success_save:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.success('", success_save + "<br/>" + msg.Replace("'", "-"), "','" + success_title + "',ops);");
                    if (user != null && user.sounds == 1)
                    {
                        str = str + "$.ionSound({ sounds: ['success'] });$.ionSound.play('success');";
                    }
                    break;
                case mNotifyType.success_update:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.success('", success_update + "<br/>" + msg.Replace("'", "-"), "','" + success_title + "',ops);");
                    break;
                case mNotifyType.success_delete:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.success('", success_delete + "<br/>" + msg.Replace("'", "-"), "','" + success_title + "',ops);");
                    break;
                case mNotifyType.error_general:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.error('", error_general + "<br/>" + msg.Replace("'", "-"), "','" + error_title + "', ops);");
                    break;
                case mNotifyType.error_delete:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.error('", error_delete + "<br/>" + msg.Replace("'", "-"), "','" + error_title + "', ops);");
                    break;
                case mNotifyType.info:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.info('", info_msg + "<br/>" + msg.Replace("'", "-"), "','" + info_title + "', ops);");
                    break;
                case mNotifyType.warning_amount:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.warning('", warning_amount + "<br/>" + msg.Replace("'", "-"), "','" + warning_msg + "', ops);");
                    break;
                case mNotifyType.warning:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.warning('", warning_msg + "<br/>" + msg.Replace("'", "-"), "','" + warning_title + "', ops);");
                    break;
                case mNotifyType.period_select:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.error('", period_select + "<br/>" + msg.Replace("'", "-"), "','" + error_title + "', ops);");
                    break;
                case mNotifyType.period_exist:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.info('", period_exist + "<br/>" + msg.Replace("'", "-"), "','" + info_title + "', ops);");
                    break;
                default:
                    break;
            }
        }
        else
        {
            switch (type)
            {
                case mNotifyType.success_save:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.success('", msg.Replace("'", "-"), "','" + success_title + "',ops);");
                    break;
                case mNotifyType.success_update:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.success('", msg.Replace("'", "-"), "','" + success_title + "',ops);");
                    break;
                case mNotifyType.success_delete:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.success('", msg.Replace("'", "-"), "','" + success_title + "',ops);");
                    break;
                case mNotifyType.error_general:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.error('", msg.Replace("'", "-"), "','" + error_title + "', ops);");
                    break;
                case mNotifyType.error_delete:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.error('", msg.Replace("'", "-"), "','" + error_title + "', ops);");
                    break;
                case mNotifyType.info:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.info('", msg.Replace("'", "-"), "','" + info_title + "', ops);");
                    break;
                case mNotifyType.warning_amount:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.warning('", warning_amount + "<br/>" + msg.Replace("'", "-"), "','" + warning_msg + "', ops);");
                    break;
                case mNotifyType.warning:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.warning('", msg.Replace("'", "-"), "','" + warning_title + "', ops);");
                    break;
                case mNotifyType.period_select:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.error('", msg.Replace("'", "-"), "','" + error_title + "', ops);");
                    break;
                case mNotifyType.period_exist:
                    str = string.Format("{0}{1}{2}", options + "toastr.clear(); toastr.info('", msg.Replace("'", "-"), "','" + info_title + "', ops);");
                    break;
                default:
                    break;
            }
        }
        if (user != null && user.sounds == 1)
        {
            if (str.Contains("toastr.success"))
            {
                str = str + "$.ionSound({ sounds: ['success'] });$.ionSound.play('success');";
            }
            else if (str.Contains("toastr.error"))
            {
                str = str + "$.ionSound({ sounds: ['error'] });$.ionSound.play('error');";
            }
            else if (str.Contains("toastr.info"))
            {
                str = str + "$.ionSound({ sounds: ['info'] });$.ionSound.play('info');";
            }
            else if (str.Contains("toastr.warning"))
            {
                str = str + "$.ionSound({ sounds: ['warning'] });$.ionSound.play('warning');";
            }
        }
        if (JsMethos != null && JsMethos.Length > 0)
        {
            for (int i = 0; i < JsMethos.Length; i++)
            {
                str = str + JsMethos[i];
            }
        }
        ScriptManager.RegisterStartupScript(page, page.GetType(),"script", str, true);
    }

    // using System.Web.UI.HtmlControls;
    public static HtmlLink CreateCssLink(string cssFilePath, string media)
    {
        var link = new HtmlLink();
        link.Attributes.Add("type", "text/css");
        link.Attributes.Add("rel", "stylesheet");
        link.Href = link.ResolveUrl(cssFilePath);
        if (string.IsNullOrEmpty(media))
        {
            media = "all";
        }

        link.Attributes.Add("media", media);
        return link;
    }

    public static HtmlGenericControl CreateJavaScriptLink(string scriptFilePath)
    {
        var script = new HtmlGenericControl();
        script.TagName = "script";
        script.Attributes.Add("type", "text/javascript");
        script.Attributes.Add("src", script.ResolveUrl(scriptFilePath));

        return script;
    }
}