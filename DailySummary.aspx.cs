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

public partial class DailySummary : BasePage
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
                // BindSummaryGridViews
                txtDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
                BindSummaryGridViews();
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
                            // BindSummaryGridViews
                            txtDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
                            BindSummaryGridViews();

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

    #region Summary Tab 1
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        BindSummaryGridViews();
    }
    protected void BindSummaryGridViews()
    {
        try
        {
            using (DataSet ds = Transactions_ud.GetDailySummary(txtDate.Value))
            {
                if (ds.Tables.Count > 0)
                {
                    gvSummary.DataSource = ds.Tables[0];
                    gvSummary.DataBind();
                    gvSummaryVisits.DataSource = ds.Tables[1];
                    gvSummaryVisits.DataBind();
                    gvSummaryEncash.DataSource = ds.Tables[3];
                    gvSummaryEncash.DataBind();
                    gvSummaryRetVisits.DataSource = ds.Tables[2];
                    gvSummaryRetVisits.DataBind();
                    gvSummaryPay.DataSource = ds.Tables[4];
                    gvSummaryPay.DataBind();
                    gvSummaryWith.DataSource = ds.Tables[5];
                    gvSummaryWith.DataBind();
                }
                else
                {
                    gvSummary.DataSource = null;
                    gvSummary.DataBind();
                    gvSummaryVisits.DataSource = null;
                    gvSummaryVisits.DataBind();
                    gvSummaryEncash.DataSource = null;
                    gvSummaryEncash.DataBind();
                    gvSummaryRetVisits.DataSource = null;
                    gvSummaryRetVisits.DataBind();
                    gvSummaryPay.DataSource = null;
                    gvSummaryPay.DataBind();
                    gvSummaryWith.DataSource = null;
                    gvSummaryWith.DataBind();
                }
            }

            using (DataSet dsd = Transactions_ud.GetDailySummarDetails(txtDate.Value))
            {
                if (dsd.Tables.Count > 0)
                {
                    gvDetVisits.DataSource = dsd.Tables[0];
                    gvDetVisits.DataBind();
                    gvDetVisitsTotal.DataSource = dsd.Tables[1];
                    gvDetVisitsTotal.DataBind();
                    gvDetEncashComp.DataSource = dsd.Tables[2];
                    gvDetEncashComp.DataBind();
                    gvDetEncashCompTotal.DataSource = dsd.Tables[3];
                    gvDetEncashCompTotal.DataBind();
                    gvDetEncashPat.DataSource = dsd.Tables[4];
                    gvDetEncashPat.DataBind();
                    gvDetEncashPatTotal.DataSource = dsd.Tables[5];
                    gvDetEncashPatTotal.DataBind();
                    gvDetRetVisits.DataSource = dsd.Tables[6];
                    gvDetRetVisits.DataBind();
                    gvDetRetVisitsTotal.DataSource = dsd.Tables[7];
                    gvDetRetVisitsTotal.DataBind();
                    gvDetPayComp.DataSource = dsd.Tables[8];
                    gvDetPayComp.DataBind();
                    gvDetPayCompTotal.DataSource = dsd.Tables[9];
                    gvDetPayCompTotal.DataBind();
                    gvDetPayPat.DataSource = dsd.Tables[10];
                    gvDetPayPat.DataBind();
                    gvDetPayPatTotal.DataSource = dsd.Tables[11];
                    gvDetPayPatTotal.DataBind();
                    gvDetPayExp.DataSource = dsd.Tables[12];
                    gvDetPayExp.DataBind();
                    gvDetPayExpTotal.DataSource = dsd.Tables[13];
                    gvDetPayExpTotal.DataBind();
                    gvDetWith.DataSource = dsd.Tables[14];
                    gvDetWith.DataBind();
                    gvDetWithTotal.DataSource = dsd.Tables[15];
                    gvDetWithTotal.DataBind();
                }
                else
                {
                    gvDetVisits.DataSource = null;
                    gvDetVisits.DataBind();
                    gvDetVisitsTotal.DataSource = null;
                    gvDetVisitsTotal.DataBind();
                    gvDetEncashComp.DataSource = null;
                    gvDetEncashComp.DataBind();
                    gvDetEncashCompTotal.DataSource = null;
                    gvDetEncashCompTotal.DataBind();
                    gvDetEncashPat.DataSource = null;
                    gvDetEncashPat.DataBind();
                    gvDetEncashPatTotal.DataSource = null;
                    gvDetEncashPatTotal.DataBind();
                    gvDetRetVisits.DataSource = null;
                    gvDetRetVisits.DataBind();
                    gvDetRetVisitsTotal.DataSource = null;
                    gvDetRetVisitsTotal.DataBind();
                    gvDetPayComp.DataSource = null;
                    gvDetPayComp.DataBind();
                    gvDetPayCompTotal.DataSource = null;
                    gvDetPayCompTotal.DataBind();
                    gvDetPayPat.DataSource = null;
                    gvDetPayPat.DataBind();
                    gvDetPayPatTotal.DataSource = null;
                    gvDetPayPatTotal.DataBind();
                    gvDetPayExp.DataSource = null;
                    gvDetPayExp.DataBind();
                    gvDetPayExpTotal.DataSource = null;
                    gvDetPayExpTotal.DataBind();
                    gvDetWith.DataSource = null;
                    gvDetWith.DataBind();
                    gvDetWithTotal.DataSource = null;
                    gvDetWithTotal.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : t1
            string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
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