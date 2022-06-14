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

public partial class PatientsSettings : BasePage
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
                // Bind Patients_ud GridView   Tab1
                BindPatients_udGridViewFistTime();
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
                            // Bind Patients_ud GridView   Tab1
                            BindPatients_udGridViewFistTime();
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

    #region Patients_ud Information Tab1
    protected void BindPatients_udGridViewFistTime()
    {
        try
        {
            // Bind Patients_ud GridView -- all Patients_ud without search
            WorkParams_ud.BindGridView(gvPatients_ud, Patients_ud.SelectAll(2));
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : t1
            //string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearPatients_udtbl();");
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
            // view the error messgae in the div with id : t1
            //string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearPatients_udtbl();");
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
            // view the error messgae in the div with id : divSearch
            //string str = string.Format("{0}{1}{2}", "$('#divSearch').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearPatients_udtbl();");
        }
    }
    protected void btnPatients_udSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                // get the data from user and insert into Patients_ud Table 
                // if the returned value is equal to '4' that means successful operation
                if (Patients_ud.Insert(new Patients_ud
                {
                    pat_name = txtPatName.Value.Trim(),
                    pat_birthdate = txtPatBirthdate.Value,
                    pat_address = txtPatAddress.Value.Trim(),
                    pat_gender = drpPatGender.SelectedValue,
                    pat_mobile = txtPatMobile.Value.Trim(),
                    pat_phone = txtPatPhone.Value.Trim(),
                    pat_job = txtPatJob.Value.Trim(),
                    marital_id = Convert.ToInt16(drpPatMarital.SelectedValue),
                    blood_id = Convert.ToInt16(drpPatBlood.SelectedValue),
                    pat_smoker = Convert.ToInt16(drpPatSmoker.SelectedValue),
                    pat_dm = Convert.ToInt16(drpPatDM.SelectedValue),
                    pat_htn = Convert.ToInt16(drpPatHTN.SelectedValue),
                    created_date = DateTime.Now.ToString("dd/MM/yyyy"),
                    created_by = user.user_id,
                    modified_date = DateTime.Now.ToString("dd/MM/yyyy"),
                    modified_by = user.user_id
                }) == 4)
                {
                    // Bind Patients_udGridView in Tab1
                    BindPatients_udGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearPatients_udtbl();");
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' An error has occurred');", true);
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearPatients_udtbl();");
                }
            }
            catch (Exception ex)
            {
                // view the error messgae in the div with id : t1
                //string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearPatients_udtbl();");
            }
        }
    }
    protected void btnPatients_udUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtPatID.Value.Trim() != "")
                {
                    // if the returned value equal to '4' that means successful operation
                    if (Patients_ud.Update(new Patients_ud
                    {
                        pat_id = Convert.ToInt32(txtPatID.Value),
                        pat_name = txtPatName.Value.Trim(),
                        pat_birthdate = txtPatBirthdate.Value,
                        pat_address = txtPatAddress.Value.Trim(),
                        pat_gender = drpPatGender.SelectedValue,
                        pat_mobile = txtPatMobile.Value.Trim(),
                        pat_phone = txtPatPhone.Value.Trim(),
                        pat_job = txtPatJob.Value.Trim(),
                        marital_id = Convert.ToInt16(drpPatMarital.SelectedValue),
                        blood_id = Convert.ToInt16(drpPatBlood.SelectedValue),
                        pat_smoker = Convert.ToInt16(drpPatSmoker.SelectedValue),
                        pat_dm = Convert.ToInt16(drpPatDM.SelectedValue),
                        pat_htn = Convert.ToInt16(drpPatHTN.SelectedValue),
                        modified_date = DateTime.Now.ToString("dd/MM/yyyy"),
                        modified_by = user.user_id,
                        active = Convert.ToInt16(drpPatStatus.SelectedValue)
                    }) == 4)
                    {
                        // Bind Patients_udGridView in Tab1
                        BindPatients_udGridView();
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(1,' Record has been updated successfully');ClearPatients_udtbl();", true);
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "", true, "ClearPatients_udtbl();");
                    }
                    else
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' An error has occurred');", true);
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearPatients_udtbl();");
                    }
                }
            }
            catch (Exception ex)
            {
                // view the error messgae in the div with id : t1
                //string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearPatients_udtbl();");
            }

        }
    }
    protected void btnPatients_udDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtPatID.Value.Trim() != "")
            {
                // returned value is equal to '4' means that successful operation
                if (Patients_ud.Delete(Convert.ToInt32(txtPatID.Value)) == 4)
                {
                    // Bind Patients_udGridView in Tab1
                    BindPatients_udGridView();
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(1,' Record has been deleted successfully');ClearPatients_udtbl();", true);
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true, "ClearPatients_udtbl();");
                }
                else
                {
                    // returned value is equal to '9' (!= 4) means that failed operation
                    // that means that this record are used in other place
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' This record cannot be deleted because it is used in another place');ClearPatients_udtbl();", true);
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This record cannot be deleted because it is used in another place", true, "ClearPatients_udtbl();");
                }
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : t1
            //string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearPatients_udtbl();");
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