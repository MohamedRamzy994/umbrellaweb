using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.IO;
using System.Data;
using System.Threading;
using System.Globalization;
using System.Text.RegularExpressions;

public partial class UsersSettings : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    List<System.Web.UI.WebControls.Button> btns_lst = new List<System.Web.UI.WebControls.Button>();
    private void FindButtons(ControlCollection cc)
    {
        foreach (Control c in cc)
        {
            if (c is System.Web.UI.WebControls.Button)
                btns_lst.Add(c as System.Web.UI.WebControls.Button);
            else if (c.Controls.Count > 0)
                FindButtons(c.Controls);
        }
    }
    protected override void InitializeCulture()
    {
        if (Session["lang"] != null)
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["lang"].ToString());
        else
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("ar");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check Session["user"] that contains Current User's Information
        if (user == null)
        {
            Response.Redirect("~/Default.aspx", false);
        }
        if (!IsPostBack)
        {
            if (user.admin == 1)
            {
                // bind Current UserName
                //lblUserName.Text = user.user_name;
                BindUsers_udGridView();
            }
            else
            {
                using (DataTable dt = Users_ud_Permissions.GetUserPagePerm(user.user_id, Path.GetFileName(Request.Url.AbsolutePath)))
                {
                    if (dt.Rows.Count > 0)
                    {
                        if (Convert.ToBoolean(dt.Rows[0]["can_view"]))
                        {
                            FindButtons(Page.Controls);
                            Users_ud_Permissions.ApplyPagePerm(btns_lst, dt);
                            // bind Current UserName
                            //lblUserName.Text = user.user_name;
                            BindUsers_udGridView();
                        }
                        else
                        {
                            Response.Redirect("~/NoPerm.aspx", false);
                            return;
                        }
                    }
                    else
                    {
                        Response.Redirect("~/NoPerm.aspx", false);
                        return;
                    }
                }
            }
        }
    }

    #region Users_ud Tab
    protected void BindUsers_udGridView()
    {
        try
        {
            // Bind User GridView
            WorkParams_ud.BindGridView(gvUsers_ud, Users_ud.SelectAll(2));
            //upUser.Update();
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    protected void btnUsers_udave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                //if (new Regex("[a-zA-Z0-9_.]").IsMatch(txtUserName.Value) == false)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(3,'<br/>User Name length must be between 5 to 50 characters<br/>Spaces & Special Characters are not allowed');", true);
                //    return;
                //}
                // make sure that username are not used by another user
                if (Users_ud.CheckUserNameFound(txtUserName.Value.Trim()))
                {
                    LinkButton lnk = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
                    if (lnk != null && lnk.Text == "EN")
                    {
                        mNotifications.Notify(this, mNotifications.mNotifyType.info, "إســم المسـتخـدم مـوجـود بالـفعـل", true, "ClearSrch();");
                        return;
                    }
                    else
                    {
                        mNotifications.Notify(this, mNotifications.mNotifyType.info, "User Name already exists", true, "ClearSrch();");
                        return;
                    }
                }
                else
                {

                    // make sure that email are not used by another user
                    if (Users_ud.CheckMailFound(txtEmail.Value.Trim()))
                    {
                        LinkButton lnk = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
                        if (lnk != null && lnk.Text == "EN")
                        {
                            mNotifications.Notify(this, mNotifications.mNotifyType.info, "البـريـد الإلكتـرونـي مـوجـود بالـفعـل", true, "ClearSrch();");
                            return;
                        }
                        else
                        {
                            mNotifications.Notify(this, mNotifications.mNotifyType.info, "Email already exists", true, "ClearSrch();");
                            return;
                        }
                    }
                    else
                    {
                        // get the data from user and insert into Users_ud table
                        // if the returned value is equal to '4' that means successful operation
                        if (Users_ud.Insert(new Users_ud
                        {
                            user_name = txtUserName.Value.Trim(),
                            user_password = txtPassword.Value,
                            user_email = txtEmail.Value.Trim(),
                            admin = Convert.ToInt16(drpAdmin.SelectedValue),
                            active = Convert.ToInt16(drpUsers_udtatus.SelectedValue)
                        }) == 4)
                        {
                            BindUsers_udGridView();
                            // Show the success message in the div with id: t1 and call methods ClearUsertbl(); & ClearSrch();
                            mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearUsertbl();", "ClearSrch();");
                            return;
                        }
                        else
                        {
                            //returned value is equal to '9' (!= 4) means that failed operation
                            // show the error message
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearUsertbl();", "ClearSrch();");
                            return;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }
    protected void btnUserUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                //if (new Regex("[a-zA-Z0-9_]").IsMatch(txtUserName.Value) == false)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(3,'<br/>User Name length must be between 5 to 50 characters<br/>Spaces & Special Characters are not allowed');$('#tblUser').fClear();", true);
                //    return;
                //}
                if (txtUserID.Value.Trim() != "")
                {
                    // make sure that username are not used by another user
                    if (Users_ud.CheckUserNameFoundUpdate(Convert.ToInt32(txtUserID.Value), txtUserName.Value.Trim()))
                    {
                        LinkButton lnk = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
                        if (lnk !=null && lnk.Text == "EN")
                        {
                            mNotifications.Notify(this, mNotifications.mNotifyType.info, "إســم المسـتخـدم مـوجـود بالـفعـل", true, "ClearSrch();");
                            return;
                        }
                        else
                        {
                            mNotifications.Notify(this, mNotifications.mNotifyType.info, "User Name already exists", true, "ClearSrch();");
                            return;
                        }
                    }
                    else
                    {
                        // make sure that email are not used by another user
                        if (Users_ud.CheckMailFoundUpdate(Convert.ToInt32(txtUserID.Value), txtEmail.Value.Trim()))
                        {
                            LinkButton lnk = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
                            if (lnk != null && lnk.Text == "EN")
                            {
                                mNotifications.Notify(this, mNotifications.mNotifyType.info, "البـريـد الإلكتـرونـي مـوجـود بالـفعـل", true, "ClearSrch();");
                                return;
                            }
                            else
                            {
                                mNotifications.Notify(this, mNotifications.mNotifyType.info, "Email already exists", true, "ClearSrch();");
                                return;
                            }
                        }
                        else
                        {
                            // if the returned value is equal to '4' that means successful operation
                            if (Users_ud.Update(new Users_ud
                            {
                                user_id = Convert.ToInt32(txtUserID.Value),
                                user_name = txtUserName.Value.Trim(),
                                user_password = txtPassword.Value,
                                user_email = txtEmail.Value.Trim(),
                                admin = Convert.ToInt16(drpAdmin.SelectedValue),
                                active = Convert.ToInt16(drpUsers_udtatus.SelectedValue)
                            }) == 4)
                            {
                                BindUsers_udGridView();
                                mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "", true, "ClearUsertbl();", "ClearSrch();");
                                return;
                            }
                            else
                            {
                                //returned value is equal to '9' (!= 4) means that failed operation
                                // show the error message
                                BindUsers_udGridView();
                                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearUsertbl();", "ClearSrch();");
                                return;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }

        }
    }

    protected void btnUserDelete_Click(object sender, EventArgs e)
    {

        try
        {
            if (txtUserID.Value.Trim() != "")
            {
                //if the returned value is equal to '4' that means successful operation
                if (Users_ud.Delete(Convert.ToInt32(txtUserID.Value)) == 4)
                {
                    BindUsers_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true, "ClearUsertbl();", "ClearSrch();");
                }
                else
                {
                    // returned value is equal to '9' (!= 4) means that failed operation
                    // that means that this record are used in other place
                    BindUsers_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_delete, "", true, "ClearUsertbl();", "ClearSrch();");
                }
            }
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
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

    #region Link Buttons
    protected void btnSaveTheme_Click(object sender, EventArgs e)
    {
        try
        {
            Users_ud.UpdateTheme(user.user_name, "theme-" + hfTheme.Value);
            Session["user"] = Users_ud.SelectByUserName(user.user_name);
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    #endregion
}