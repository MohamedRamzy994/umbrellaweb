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

public partial class PatientsCurrentVisits : BasePage
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
                //Bind Current visits GridView for FistTime
                BindCurrentVisitsFirstTime();
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
                            //Bind Current visits GridView for FistTime
                            BindCurrentVisitsFirstTime();
                        }
                        else
                        {
                            Response.Redirect("~/NoPerm.aspx");
                            return;
                        }
                    }
                    else
                    {
                        Response.Redirect("~/NoPerm.aspx");
                        return;
                    }
                }
            }
        }
    }

    #region Current Visits Tab

    protected void BindCurrentVisitsFirstTime()
    {
        try
        {
            txtCurrentDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
            WorkParams_ud.BindGridView(gvCurrentVisits, Pat_Visits_ud.SelectCurrentVisits(txtCurrentDate.Value));
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : t1
            string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    protected void BindCurrentVisits()
    {
        try
        {
            WorkParams_ud.BindGridView(gvCurrentVisits, Pat_Visits_ud.SelectCurrentVisits(txtCurrentDate.Value));
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : t1
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");
        }
    }
    protected void btnCurrentRefresh_Click(object sender, EventArgs e)
    {
        BindCurrentVisits();
    }
    protected void btnVisitUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                decimal paid_amount = Convert.ToDecimal(txtCost.Value);
                if (paid_amount < 0)
                {
                    return;
                }
                if (txtVisitID.Value.Trim() != "")
                {
                    // get the data from user and update Pat_Visits_ud Table 
                    // if the returned value is equal to '4' that means successful operation
                    Int16 paid_status = 0;
                    if (chkVisitPaid.Checked)
                    {
                        paid_status = 1;
                        int status = Pat_Visits_ud.UpdatePaidDetails(new Pat_Visits_ud
                        {
                            pat_visit_id = Convert.ToInt32(txtVisitID.Value),
                            paid_status = paid_status,
                            paid_amount = paid_amount,
                            user_id = user.user_id
                        });
                        if (status == 4)
                        {
                            BindCurrentVisits();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(1,' Visit has been updated successfully');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.success_update,"", true, "ClearVisitsTbl();");
                        }
                        else if (status == 5)
                        {
                            BindCurrentVisits();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(3,' This visit is already paid');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "This visit is already paid", true, "ClearVisitsTbl();");
                        }
                        else if (status == 7)
                        {
                            BindCurrentVisits();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(3,' Nothing has changed');", true);
                             mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "Nothing has changed", true, "ClearVisitsTbl();");
                        }
                        else if (status == 9)
                        {
                            BindCurrentVisits();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' An error has occurred');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "", true, "ClearVisitsTbl();");
                        }
                    }
                    else
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(3,' Nothing has changed');", true);
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "Nothing has changed", true, "ClearVisitsTbl();");
                    }
                }
            }
            catch (Exception ex)
            {
                // view the error messgae in the div with id : divVisits
               mNotifications.Notify(this, mNotifications.mNotifyType.success_update, ex.Message, true, "ClearVisitsTbl();");
            }
        }
    }
    protected void btnVisitDelete_Click(object sender, EventArgs e)
    {
        try
        {
            // get the data from user and update Pat_Visits_ud Table 
            // if the returned value is equal to '4' that means successful operation
            if (txtVisitID.Value.Trim() != "")
            {
                string status = Pat_Visits_ud.DeleteVisit(Convert.ToInt32(txtVisitID.Value), user.user_id);
                if (status != "")
                {
                    string[] arr = status.Split(',');
                    if (arr[0] == "4")
                    {
                        BindCurrentVisits();
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(1,' Visit has been deleted successfully');", true);
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true, "ClearVisitsTbl();");
                    }
                    else if (arr[0] == "5")
                    {
                        BindCurrentVisits();
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' This visit cannot be deleted');", true);
                         mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This visit cannot be deleted", true, "ClearVisitsTbl();");
                    }
                    else if (arr[0] == "9")
                    {
                        BindCurrentVisits();
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' An error has occurred');", true);
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearVisitsTbl();");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divVisits
           mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");
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