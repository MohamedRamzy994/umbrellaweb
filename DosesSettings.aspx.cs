using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Threading;
using System.Globalization;

public partial class DosesSettings : BasePage
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
            return;
        }
        if (!IsPostBack)
        {
            if (user.admin == 1)
            {
                // bind Current UserName
                //lblUserName.Text = user.user_name;
                BindDoses_udGridView();
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
                            BindDoses_udGridView();
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

    #region Doses_ud Tab
    protected void BindDoses_udGridView()
    {
        try
        {
            // Bind Dose GridView
            WorkParams_ud.BindGridView(gvDoses_ud, Doses_ud.SelectAll(2));

        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    protected void btnDoses_udave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtDoseID.Value.Trim() == "")
                {
                    // get the data from user and insert into Doses_ud table
                    // if the returned value is equal to '4' that means successful operation
                    if (Doses_ud.Insert(new Doses_ud
                    {
                        dose_name = txtDoseName.Value.Trim(),
                        active = Convert.ToInt16(drpDoses_udtatus.SelectedValue)
                    }) == 4)
                    {
                        BindDoses_udGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearDosetbl();", "ClearSearchAttr();");
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearDosetbl();", "ClearSearchAttr();");
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }
    protected void btnDoseUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtDoseID.Value.Trim() != "")
                {
                    // if the returned value is equal to '4' that means successful operation
                    if (Doses_ud.Update(new Doses_ud
                    {
                        dose_id = Convert.ToInt32(txtDoseID.Value),
                        dose_name = txtDoseName.Value.Trim(),
                        active = Convert.ToInt16(drpDoses_udtatus.SelectedValue)
                    }) == 4)
                    {
                        BindDoses_udGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "", true, "ClearDosetbl();", "ClearSearchAttr();");
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearDosetbl();", "ClearSearchAttr();");
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }

        }
    }

    protected void btnDoseDelete_Click(object sender, EventArgs e)
    {

        try
        {
            if (txtDoseID.Value.Trim() != "")
            {
                //if the returned value is equal to '4' that means successful operation
                if (Doses_ud.Delete(Convert.ToInt32(txtDoseID.Value)) == 4)
                {
                    BindDoses_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true, "ClearDosetbl();", "ClearSearchAttr();");
                }
                else
                {
                    // returned value is equal to '9' (!= 4) means that failed operation
                    // that means that this record are used in other place so it will be set to Inactive
                    BindDoses_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_delete, "", true, "ClearDosetbl();", "ClearSearchAttr();");
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