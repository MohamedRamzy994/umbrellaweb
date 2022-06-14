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

public partial class PatientsofCompanies_ud : BasePage
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
                // Bind Companies_ud DropDownList Tab1
                BindDrpCompanies_ud();
                //Bind CompanyPatients_ud Gridviews
                BindCompanyPatients_udGridviews();
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
                            // Bind Companies_ud DropDownList Tab1
                            BindDrpCompanies_ud();
                            //Bind CompanyPatients_ud Gridviews
                            BindCompanyPatients_udGridviews();
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
    #region Patients_ud of Companies_ud Tab2
    protected void BindDrpCompanies_ud()
    {
        LinkButton lnklang = (LinkButton)ucReception.FindControl("lnklang");
        try
        {
            // Bind Companies_ud DropDownList
            if (lnklang.Text == "AR")
            {
                WorkParams_ud.BindDropDownList(drpCompanies_ud, Company_Pat_Det_ud.SelectCompanies_ud(1), "company_name", "company_id", new string[] { "select a company", "0" });
                upPatCompanies_ud.Update();
            }
            else
            {
                WorkParams_ud.BindDropDownList(drpCompanies_ud, Company_Pat_Det_ud.SelectCompanies_ud(1), "company_name", "company_id", new string[] { "اختر شركة", "0" });
                upPatCompanies_ud.Update();
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divComp
            //string str = string.Format("{0}{1}{2}", "$('#divComp').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true);
        }
    }
    protected void BindCompanyPatients_udGridviews()
    {
        try
        {
            // Make sure that there is a selected company
            if (drpCompanies_ud.SelectedIndex != 0)
            {
                // Bind gvPatCompanies_ud (GridView) -- get the Patients_ud in the selected company
                WorkParams_ud.BindGridView(gvPatCompanies_ud, Company_Pat_Det_ud.SelectPatients_udOfCompany(Convert.ToInt32(drpCompanies_ud.SelectedValue)));
                // Bind gvPat (GridView) -- get all Patients_ud that not obtained in a company
                WorkParams_ud.BindGridView(gvPat, Company_Pat_Det_ud.SelectAllPatients_ud());
            }
            else
            {
                // that means no company was selected
                gvPatCompanies_ud.DataSource = null;
                gvPatCompanies_ud.DataBind();
                gvPat.DataSource = null;
                gvPat.DataBind();
            }

        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divComp
            //string str = string.Format("{0}{1}{2}", "$('#divComp').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true);
        }
    }
    protected void drpCompanies_ud_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindCompanyPatients_udGridviews();
    }
    protected void btnPatComAdd_Click(object sender, EventArgs e)
    {
        try
        {
            // make sure that textbox has id 'txtCompanyPatID' contains a value (pat_id)
            if (txtCompanyPatID.Value.Trim() != "")
            {
                // get the pat_id & company id and insert this data in Company_Pat_Det_ud table
                // returned value equal to 4 means successful operation
                if (Company_Pat_Det_ud.Insert(new Company_Pat_Det_ud
                {
                    company_id = Convert.ToInt32(drpCompanies_ud.SelectedValue),
                    pat_id = Convert.ToInt32(txtCompanyPatID.Value)
                }) == 4)
                {
                    BindCompanyPatients_udGridviews();
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divComp').mShowStatus(1,' Record has been saved successfully');", true);
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true);
                }
                else
                {
                    // returned value equal to 9 means failed operation
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divComp').mShowStatus(2,' An error has occurred');", true);
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true);
                }
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divComp
            //string str = string.Format("{0}{1}{2}", "$('#divComp').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true);
        }
    }
    protected void btnPatComRemove_Click(object sender, EventArgs e)
    {
        try
        {
            // make sure that textbox has id 'txtCompanyPatDetId' contains a value (Company_Pat_Det_ud_id)
            if (txtCompanyPatDetId.Value.Trim() != "")
            {
                // get the Company_Pat_Det_ud_id and delete it from Company_Pat_Det_ud table
                // returned value equal to 4 means successful operation
                if (Company_Pat_Det_ud.Delete(Convert.ToInt32(txtCompanyPatDetId.Value)) == 4)
                {
                    BindCompanyPatients_udGridviews();
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divComp').mShowStatus(1,' Record has been deleted successfully');", true);
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true);
                }
                else
                {
                    // returned value equal to 9 means failed operation
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divComp').mShowStatus(2,' An error has occurred');", true);
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true);
                }
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divComp
            //string str = string.Format("{0}{1}{2}", "$('#divComp').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true);
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