using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Globalization;
using System.Threading;

public partial class DailySummaryReport : BasePage
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
            btnResultSearch.Enabled = false;
            btnResultPrint.Enabled = false;
            if (user.admin == 1)
            {
                // bind Current UserName
                //lblUserName.Text = user.user_name;
            }
            else
            {
                using (DataTable dt = Users_ud_Permissions.GetUserPagePerm(user.user_id, "FinancialsReports.aspx"))
                {
                    if (dt.Rows.Count > 0)
                    {
                        if (Convert.ToBoolean(dt.Rows[0]["can_view"]))
                        {
                            FindButtons(Page.Controls);
                            Users_ud_Permissions.ApplyPagePerm(btns_lst, dt);
                            // bind Current UserName
                            //lblUserName.Text = user.user_name;
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

    #region

    protected void BindResultsGridView()
    {
        try
        {
            WorkParams_ud.BindGridView(gvResults, Transactions_ud.rptDailySummaryWithinPeriod(txtDateFrom.Value, txtDateTo.Value));

        }
        catch (Exception ex)
        {
            // show the error message in the div with id: t1
            string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnResultSearch_Click(object sender, EventArgs e)
    {
        BindResultsGridView();
    }
    protected void btnDateValidation_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime date_from = DateTime.ParseExact(txtDateFrom.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime date_to = DateTime.ParseExact(txtDateTo.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            int x = DateTime.Compare(date_from, date_to);
            if (x != 1)
            {
                btnResultSearch.Enabled = true;
                btnResultPrint.Enabled = true;
            }
            else
            {
                btnResultSearch.Enabled = false;
                btnResultPrint.Enabled = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' Please enter a valid period')", true);
            }
        }
        catch (Exception ex)
        {
            // show the error message in the div with id: t1
            string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    protected void gvResults_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvResults.PageIndex = e.NewPageIndex;
        BindResultsGridView();
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
                    Response.Redirect("~/Default.aspx", false);
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