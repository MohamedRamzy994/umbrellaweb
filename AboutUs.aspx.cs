using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AboutUs : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check Session["user"] that contains Current User's Information
        if (user == null)
        {
            // abc
            Response.Redirect("~/Default.aspx", false);
            return;
        }
        if (!IsPostBack)
        {
            // bind Current UserName
            lblUserName.Text = user.user_name;
        }
    }

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
                    Response.Redirect("~/Default.aspx",false);
                    return null;
                }
            }
        }
    }
    #endregion

    protected void lbSignOut_Click(object sender, EventArgs e)
    {
        HttpCookie infoCookie = HttpContext.Current.Request.Cookies["info"];
        if (infoCookie != null)
        {
            infoCookie.Expires = DateTime.Now.AddDays(-1d);
            Response.Cookies.Add(infoCookie);
        }
        Session.Clear();
        Session.Abandon();
        Response.Redirect("~/Default.aspx", false);
    }

    #region Link Buttons
    protected void btnSaveTheme_Click(object sender, EventArgs e)
    {
        try
        {
            Users_ud.UpdateTheme(user.user_name, "theme-" + hfTheme.Value);
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    #endregion
}