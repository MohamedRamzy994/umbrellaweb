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

public partial class Withdrawals : BasePage
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
                // Bind Clinic_ud GridView()
                BindClinic_udGridView();
                // Bind Clinic_ud Transactions_ud GridView
                BindClinic_udTransactions_udGridView();
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
                            // Bind Clinic_ud GridView()
                            BindClinic_udGridView();
                            // Bind Clinic_ud Transactions_ud GridView
                            BindClinic_udTransactions_udGridView();
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

    #region Clinic_ud Tab1
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        BindClinic_udGridView();
        BindClinic_udTransactions_udGridView();
    }
    protected void BindClinic_udGridView()
    {
        try
        {
            // Bind Clinic_ud GridView
            LinkButton lnk = ucFinancials.FindControl("lnklang") as LinkButton;
            if (lnk != null && lnk.Text == "EN")
            {
                WorkParams_ud.BindGridView(gvClinic_ud, Clinic_ud.SelectFinancials("ar"));
            }
            else
            {
                WorkParams_ud.BindGridView(gvClinic_ud, Clinic_ud.SelectFinancials("en"));
            }
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    protected void BindClinic_udTransactions_udGridView()
    {
        try
        {
            // Bind Clinic_ud Transactions_ud GridView
            WorkParams_ud.BindGridView(gvClinic_udTransaction, Transactions_ud.SelectWithdrawals());
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    protected void btnClinic_udSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                decimal transact_amount = Convert.ToDecimal(txtClinic_udAmount.Value);
                if (transact_amount <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' Paid amount cannot be equal or less than zero');ClearClinic_udtbl();ClearClinic_udSrch();", true);
                    return;
                }
                int status = Transactions_ud.SaveWithdrawals(Convert.ToInt32(txtClinic_udId.Value), txtClinic_udCode.Value, txtClinic_udNote.Value.Trim(), transact_amount, user.user_id);
                if (status == 4)
                {
                    BindClinic_udGridView();
                    BindClinic_udTransactions_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearClinic_udtbl();", "ClearClinic_udSrch();", "Msignalr();");
                }
                else if (status == 5)
                {
                    BindClinic_udGridView();
                    BindClinic_udTransactions_udGridView();
                    LinkButton lnk = ucFinancials.FindControl("lnklang") as LinkButton;
                    if (lnk != null && lnk.Text == "EN")
                    {
                        mNotifications.Notify(this, mNotifications.mNotifyType.warning, "لا يـوجـد مبلـغ كـافـي فـي الخـزنـة لتنفيـذ هـذه العمليـة", true, "ClearClinic_udtbl();", "ClearClinic_udSrch();", "Msignalr();");
                    }
                    else
                    {
                        mNotifications.Notify(this, mNotifications.mNotifyType.warning, "There is no enough money in the safe to perform this operation", true, "ClearClinic_udtbl();", "ClearClinic_udSrch();", "Msignalr();");
                    }
                }
                else if (status == 7)
                {
                    BindClinic_udGridView();
                    BindClinic_udTransactions_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This code is not exists in the system", true, "ClearClinic_udtbl();", "ClearClinic_udSrch();");
                }
                else if (status == 9)
                {
                    BindClinic_udGridView();
                    BindClinic_udTransactions_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearClinic_udtbl();", "ClearClinic_udSrch();");
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
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
                        Response.Redirect("~/Default.aspx", false);
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