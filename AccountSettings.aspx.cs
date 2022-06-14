using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AccountSettings : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check Session["user"] that contains Current User's Information
        if (user == null)
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }
        if (!IsPostBack)
        {
            // bind Current UserName
            lblUserName.Text = user.user_name;
            txtUserName.Value = user.user_name;
            txtEmail.Value = user.user_email;
        }
    }

    #region Account Seetings Tab

    protected void BindUserInfo()
    {
        try
        {
            Users_ud user = Users_ud.SelectByUserName(txtUserName.Value.Trim());
            Session["user"] = user;
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnUpdateEmail_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                // make sure that email are not used by another user
                if (Users_ud.CheckMailFoundUpdate(user.user_id, txtEmail.Value.Trim()))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(3,' Email already exists');", true);
                }
                else
                {
                    // get data from user and update Users_ud table
                    // if the returned value is equal to '4' that means successful operation
                    if (Users_ud.UpdateInfo(user.user_id,txtEmail.Value.Trim())==4)
                    {
                        BindUserInfo();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(1,' Email has been updated successfully');", true);
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' An error has occurred');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }

    }

    protected void btnUpdatePass_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                int state=Users_ud.UpdatePassword(user.user_id,txtOldPass.Value,txtNewPass.Value);
                if (state==4)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(1,' Password has been updated successfully');", true);
                }
                else if (state == 99)
                {
                    //returned value is equal to '99' means old password is incorrect
                    // show the error message
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' Old password is incorrect');", true);
                }
                else
                {
                    //returned value is equal to '9' (!= 4) means that failed operation
                    // show the error message
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' An error has occurred');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
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