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

public partial class EncashmentVoucher : BasePage
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
                // Bind Companies_ud GridView
                BindCompanies_udGridView();
                // Bind Companies_ud Transactions_ud GridView
                BindCompanies_udTransactions_udGridView();
                // Bind Patients_ud GridView
                BindPatients_udGridView();
                // Bind Patients_ud Transactions_ud GridView
                BindPatients_udTransactions_udGridView();
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
                            // Bind Companies_ud GridView
                            BindCompanies_udGridView();
                            // Bind Companies_ud Transactions_ud GridView
                            BindCompanies_udTransactions_udGridView();
                            // Bind Patients_ud GridView
                            BindPatients_udGridView();
                            // Bind Patients_ud Transactions_ud GridView
                            BindPatients_udTransactions_udGridView();

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

    #region Companies_ud Tab1
    protected void BindCompanies_udGridView()
    {
        try
        {
            // Bind Companies_ud GridView
            WorkParams_ud.BindGridView(gvCompanies_ud, Companies_ud.SelectAllData(2));
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    protected void BindCompanies_udTransactions_udGridView()
    {
        try
        {
            // Bind Companies_ud Transactions_ud GridView
            WorkParams_ud.BindGridView(gvCompTransaction, Transactions_ud.SelectEncashmentVouchers("c"));
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    protected void btnCompSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                decimal transact_amount = Convert.ToDecimal(txtCompAmount.Value);
                if (transact_amount <= 0)
                {
                    mNotifications.Notify(this, mNotifications.mNotifyType.warning_amount, "", true, "ClearComptbl();", "ClearCompSrch();", "Msignalr();");
                    return;
                }
                int status = Transactions_ud.SaveEncashmentVoucher("c", Convert.ToInt32(txtCompId.Value), txtCompCode.Value, txtCompNote.Value.Trim(), transact_amount, user.user_id);
                if (status == 4)
                {
                    BindCompanies_udGridView();
                    BindCompanies_udTransactions_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearComptbl();", "ClearCompSrch();", "Msignalr();");
                }
                else if (status == 7)
                {
                    BindCompanies_udGridView();
                    BindCompanies_udTransactions_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This code is not exists in the system", true, "ClearComptbl();", "ClearCompSrch();");
                }
                else if (status == 9)
                {
                    BindCompanies_udGridView();
                    BindCompanies_udTransactions_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearComptbl();", "ClearCompSrch();");
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }
    #endregion

    #region Patients_ud Tab2
    protected void BindPatients_udTransactions_udGridView()
    {
        try
        {
            // Bind Patients_ud Transactions_ud GridView
            WorkParams_ud.BindGridView(gvPatTransaction, Transactions_ud.SelectEncashmentVouchers("p"));
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    protected void BindPatients_udGridView()
    {
        try
        {
            // Bind Patients_ud GridView according to attributes of search
            WorkParams_ud.BindGridView(gvPatients_ud, Patients_ud.Patients_udSearch(drpSearchgvPatients_udCol.SelectedValue, txtSearchgvPatients_ud.Value.Trim(), drpSearchgvPatients_udGender.SelectedValue, drpSearchgvPatients_udStatus.SelectedValue));
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    protected void gvPatients_ud_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        // Bind Patients_ud GridView according to attributes of search and selected page index
        gvPatients_ud.PageIndex = e.NewPageIndex;
        BindPatients_udGridView();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ClearPatients_udtbl();", true);
    }

    protected void btnPatients_udSearch_Click(object sender, EventArgs e)
    {
        try
        {
            // Bind Patients_ud GridView according to attributes of search
            BindPatients_udGridView();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ClearPatients_udtbl();", true);
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    protected void btnPatSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                decimal transact_amount = Convert.ToDecimal(txtPatAmount.Value);
                if (transact_amount <= 0)
                {

                    mNotifications.Notify(this, mNotifications.mNotifyType.warning_amount, "", true, "ClearPatients_udtbl();", "ClearPatSrch();", "Msignalr();");
                    return;
                }
                int status = Transactions_ud.SaveEncashmentVoucher("p", Convert.ToInt32(txtPatId.Value), txtPatCode.Value, txtPatNote.Value.Trim(), transact_amount, user.user_id);
                if (status == 4)
                {
                    BindPatients_udGridView();
                    BindPatients_udTransactions_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearPatients_udtbl();", "ClearPatSrch();", "Msignalr();");
                }
                else if (status == 7)
                {
                    BindPatients_udGridView();
                    BindPatients_udTransactions_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This code is not exists in the system", true, "ClearPatients_udtbl();", "ClearPatSrch();");
                }
                else if (status == 9)
                {
                    BindPatients_udGridView();
                    BindPatients_udTransactions_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearPatients_udtbl();", "ClearPatSrch();");
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