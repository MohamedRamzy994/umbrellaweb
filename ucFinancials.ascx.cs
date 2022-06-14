using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class ucFinancials : System.Web.UI.UserControl
{
    protected override void OnLoad(EventArgs e)
    {
        if (user != null && user.sounds == 1)
        {
            Page.Header.Controls.Add(mNotifications.CreateJavaScriptLink("~/js/mSounds.js"));
        }
        base.OnLoad(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (user == null)
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }
        if (!IsPostBack)
        {
            lblUserName.Text = user.user_name;
        }
    }

    public PlaceHolder BottomScriptsPlaceHolder
    {
        get
        {
            return phBottomScripts;
        }
    }

    #region link Buttons

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
        return;
    }

    protected void lnklang_Click(object sender, EventArgs e)
    {
        if (lnklang.Text == "EN")
        {
            Session["lang"] = "en";
        }
        else
        {
            Session["lang"] = "ar";
        }
        Response.Redirect(Path.GetFileName(Request.Url.AbsolutePath), false);
        return;
    }
    protected void lnkSounds_Click(object sender, EventArgs e)
    {
        try
        {
            string user_name = user.user_name;
            if (Users_ud.UpdateSounds(user_name) == 4)
            {
                Session["user"] = Users_ud.SelectByUserName(user_name);
                Response.Redirect(Path.GetFileName(Request.Url.AbsolutePath), false);
                return;
            }
            else
            {
                mNotifications.Notify(this.Page, mNotifications.mNotifyType.error_general, "", true, null);
            }
        }
        catch (Exception ex)
        {

            mNotifications.Notify(this.Page, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
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
                try
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
                catch (Exception ex)
                {

                    mNotifications.Notify(this.Page, mNotifications.mNotifyType.error_general, ex.Message, true, null);
                    return null;
                }

            }
        }
    }
    #endregion
}