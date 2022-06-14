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

public partial class Days_udSettings : BasePage
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
                // lblUserName.Text = user.user_name;
                //Bind Patients_ud GridView for FistTime
                BindDays_udGridView();
                //BindDrpDays_ud
                BindDrpDays_ud();
                //BindDayDetGridView
                BindDayDetGridView();
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
                            //Bind Patients_ud GridView for FistTime
                            BindDays_udGridView();
                            //BindDrpDays_ud
                            BindDrpDays_ud();
                            //BindDayDetGridView
                            BindDayDetGridView();
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

    #region Days_ud
    protected void BindDays_udGridView()
    {
        try
        {
            // Bind Days_ud GridView -- all Patients_ud without search
            WorkParams_ud.BindGridView(gvDays_ud, Days_ud.SelectDays_ud(2));
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    protected void btnDays_udSave_Click(object sender, EventArgs e)
    {
        try
        {
            Int16 active = 0;
            if (chkDayAvailable.Checked)
            {
                active = 1;
            }
            if (Days_ud.Days_udSave(Convert.ToInt32(txtDayID.Value), active) == 4)
            {
                BindDays_udGridView();
                BindDrpDays_ud();
                BindDayDetGridView();
                mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearDays_udTbl();");
            }
            else
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearDays_udTbl();");
            }
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    #endregion

    #region Day Details Tab
    protected void BindDrpDays_ud()
    {
        try
        {
            // Bind Days_ud DropDownList
            WorkParams_ud.BindDropDownList(drpDays_ud, Days_ud.SelectDays_ud(1), "day_name_ar", "day_id", null);
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    protected void BindDayDetGridView()
    {
        try
        {
            // Bind DayDetails GridView
            WorkParams_ud.BindGridView(gvDayDet, Days_ud.SelectDayDetails(drpDays_ud.SelectedValue));
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    protected void drpDays_ud_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDayDetGridView();
    }
    protected void btnDayDetSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtDayDetID.Value == "")
                {
                    DateTime time_from, time_to;
                    time_from = Convert.ToDateTime(txtTimeFrom.Value);
                    time_to = Convert.ToDateTime(txtTimeTo.Value);
                    int time_status = DateTime.Compare(time_from, time_to);
                    if (time_status == -1)
                    {
                        int status = Days_ud.InsertDayDetails(new Days_ud
                        {
                            day_id = Convert.ToInt32(drpDays_ud.SelectedValue),
                            time_from = time_from.ToString("HH:mm"),
                            time_to = time_to.ToString("HH:mm")
                        });
                        if (status == 4)
                        {
                            BindDayDetGridView();
                            mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, null);
                        }
                        else if (status == 7)
                        {
                            mNotifications.Notify(this, mNotifications.mNotifyType.period_exist, "", true, null);
                        }
                        else
                        {
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, null);
                        }
                    }
                    else
                    {
                        mNotifications.Notify(this, mNotifications.mNotifyType.period_select, "", true, null);
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }
    protected void btnDayDetUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtDayDetID.Value != "")
                {
                    DateTime time_from, time_to;
                    time_from = Convert.ToDateTime(txtTimeFrom.Value);
                    time_to = Convert.ToDateTime(txtTimeTo.Value);
                    int time_status = DateTime.Compare(time_from, time_to);
                    if (time_status == -1)
                    {
                        int status = Days_ud.UpdateDayDetails(new Days_ud
                        {
                            day_det_id = Convert.ToInt32(txtDayDetID.Value),
                            day_id = Convert.ToInt32(drpDays_ud.SelectedValue),
                            time_from = time_from.ToString("HH:mm"),
                            time_to = time_to.ToString("HH:mm")
                        });
                        if (status == 4)
                        {
                            BindDayDetGridView();
                            mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "", true, null);
                        }
                        else if (status == 7)
                        {
                            mNotifications.Notify(this, mNotifications.mNotifyType.period_exist, "", true, null);
                        }
                        else
                        {
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, null);
                        }
                    }
                    else
                    {
                        mNotifications.Notify(this, mNotifications.mNotifyType.period_select, "", true, null);
                    }

                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }
    protected void btnDayDetDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtDayDetID.Value != "")
            {
                int status = Days_ud.DeleteDayDetails(txtDayDetID.Value);
                if (status == 4)
                {
                    BindDayDetGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true, null);
                }
                else
                {
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, null);
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