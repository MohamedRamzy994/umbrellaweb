using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;

/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
	public BasePage()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //here will be language property
    #region Language Proprety
    ///// <summary>
    ///// Language Property
    ///// used to get and set current lang of user
    ///// </summary>
    string lang = "ar";
    public string language {
        
        get {
            if (Session["lang"]!=null)
            {
                lang=Session["lang"].ToString();
            }
            else
            {
                lang = "ar";
                HttpContext.Current.Session["lang"] = "ar";
            }
            return lang;
        }
        set
        {
            language = value;
        }
         
    
    
    }
    #endregion
    //end 
    protected override void InitializeCulture()
    {
        if (Session["lang"] != null)
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["lang"].ToString());
        else
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("ar");
    }
    //check language for rpt files
    public string GetRptLangPath(string rpt)
    {
        
        if (rpt == "")
        {
            return "";
        }
        string rptPath = "";
        if (Session["lang"] != null)
        {
            rptPath = string.Format("{0}{1}{2}", rpt, Session["lang"].ToString(), ".rpt");
            return rptPath;
        }
        else
        {
            rptPath = string.Format("{0}{1}", rpt, "ar.rpt");
            return rptPath;
        }

    }
    //end of rpt

    #region User Session
    /// <summary>
    /// Property for current User's Information
    /// </summary>
    public Users_ud user
    {
        get
        {
            if (Session["user"] != null)
            {
                return (Users_ud)Session["user"];
            }
            else
            {
                // that means the session is timeout so should check cookie
                HttpCookie infoCookie = HttpContext.Current.Request.Cookies["info"];
                if (infoCookie != null)
                {
                    Users_ud user = Users_ud.SelectByUserName(mEncryption_ud.Decrypt(infoCookie.Value));
                    Session["user"] = user;
                    return user;
                }
                else
                {
                    // that means the session is timeout so user must be directed to Default Page
                    Response.Redirect("~/Default.aspx", false);
                    return null;
                }
            }
        }
    }
    #endregion

    #region User Theme
    /// <summary>
    /// Property for Current User's Theme
    /// </summary>
    private string userTheme;
    public string UserTheme
    {
        get
        {
            if (Session["theme"] == null)
            {
                userTheme = "theme-darkblue";
            }
            else
            {
                userTheme = Session["theme"].ToString();
            }
            return userTheme;
        }
        set { userTheme = value; }
    }

    #endregion

   
    //private static string language;
    //public static string Language
    //{
    //    get
    //    {
    //        if (HttpContext.Current.Session["language"] != null)
    //        {
    //            language = HttpContext.Current.Session["language"].ToString();
    //        }
    //        else
    //        {
    //            language = "ar";
    //            HttpContext.Current.Session["language"] = "ar";
    //        }
    //        return language;
    //    }
    //    set
    //    {
    //        language = value;
    //    }
    //}
    //#endregion
}