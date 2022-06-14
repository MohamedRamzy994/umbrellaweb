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

public partial class VisitsViaCompany : BasePage
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
                //Delete old visits from DB
                Pat_Visits_ud.DeleteOldVisits();
                // Bind Companies_ud DropDownList
                BindCompanies_udDrp();
                //Bind Patients_ud GridView
                BindPatients_udGridView();
                // Bind Doctor's Appointments GridView
                BingDoctorDatesGridView();
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
                            //Delete old visits from DB
                            Pat_Visits_ud.DeleteOldVisits();
                            // Bind Companies_ud DropDownList
                            BindCompanies_udDrp();
                            //Bind Patients_ud GridView
                            BindPatients_udGridView();
                            // Bind Doctor's Appointments GridView
                            BingDoctorDatesGridView();
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

    #region Patients_ud Information Tab

    protected void BindPatients_udGridView()
    {
        try
        {
            if (drpCompanies_ud.SelectedIndex != 0)
            {
                // Bind Patients_ud GridView according to attributes of search
                WorkParams_ud.BindGridView(gvPatients_ud, Patients_ud.Companies_udPatients_udSearch(Convert.ToInt32(drpCompanies_ud.SelectedValue), drpSearchgvPatients_udCol.SelectedValue, txtSearchgvPatients_ud.Value.Trim(), drpSearchgvPatients_udGender.SelectedValue, "1"));
            }
            else
            {
                gvPatients_ud.DataSource = null;
                gvPatients_ud.DataBind();
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : t1
            //string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");

        }

    }
    protected void gvPatients_ud_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        // Bind Patients_ud GridView according to attributes of search and selected page index
        gvPatients_ud.PageIndex = e.NewPageIndex;
        BindPatients_udGridView();

    }
    protected void btnPatients_udSearch_Click(object sender, EventArgs e)
    {
        BindPatients_udGridView();
    }

    protected void BindCompanies_udDrp()
    {
        LinkButton lnklang = (LinkButton)ucReception.FindControl("lnklang");
        try
        {
            if (lnklang.Text == "AR")
                WorkParams_ud.BindDropDownList(drpCompanies_ud, Companies_ud.SelectCompanies_ud(1), "company_name", "company_id", new string[] { "select a company", "0" });
            else
                WorkParams_ud.BindDropDownList(drpCompanies_ud, Companies_ud.SelectCompanies_ud(1), "company_name", "company_id", new string[] { "اختر شركة", "0" });
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divSearch
            //string str = string.Format("{0}{1}{2}", "$('#divSearch').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");
        }
    }

    protected void drpCompanies_ud_SelectedIndexChanged(object sender, EventArgs e)
    {

        BindPatients_udGridView();
    }
    #endregion

    #region Visits Tab


    protected void BindVisitsGridView()
    {
        try
        {
            if (txtPatID.Value.Trim() != "")
            {
                WorkParams_ud.BindGridView(gvVisits, Pat_Visits_ud.SelectNewVisits(txtPatID.Value, "1"));
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divVisits
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");
        }
    }

    protected void btnVisitsRefresh_Click(object sender, EventArgs e)
    {
        BindVisitsGridView();
        //Bind Examinations_ud Drp
        BindExaminations_udDrp();
        // Get Contract Details
        using (DataTable dt = Contracts_ud.SelectValidContracts_ud(drpCompanies_ud.SelectedValue))
        {
            if (dt.Rows.Count > 0)
            {
                lblContracts_udtatus.Text = "";
                // btnVisitSave.Visible = true;
                txtContractId.Value = dt.Rows[0]["contract_id"].ToString();
                txtDiscount.Value = dt.Rows[0]["contract_discount"].ToString();
            }
            else
            {
                lblContracts_udtatus.Text = "This company has no valid contract";
                //btnVisitSave.Visible = false;
                txtContractId.Value = "";
                txtDiscount.Value = "";
            }
        }
    }
    protected void BindExaminations_udDrp()
    {
        try
        {
            drpVisitExam.Items.Clear();
            drpExam.Items.Clear();
            using (DataTable dt = Examinations_ud.SelectAll(1))
            {
                if (dt.Rows.Count > 0)
                {
                    drpVisitExam.DataSource = dt;
                    drpVisitExam.DataTextField = "exam_full";
                    drpVisitExam.DataValueField = "exam_det_id";
                    drpVisitExam.DataBind();
                    drpExam.DataSource = dt;
                    drpExam.DataTextField = "exam_cost";
                    drpExam.DataValueField = "exam_det_id";
                    drpExam.DataBind();
                    if (drpVisitExam.Items.Count > 0)
                        drpVisitExam.Items.Insert(0, new ListItem("Select Exam", "0"));
                    else
                        drpVisitExam.Items.Add(new ListItem("Select Exam", "0"));
                    if (drpExam.Items.Count > 0)
                        drpExam.Items.Insert(0, new ListItem("Select Exam", "0"));
                    else
                        drpExam.Items.Add(new ListItem("Select Exam", "0"));

                }
                else
                {
                    drpVisitExam.DataSource = null;
                    drpVisitExam.DataBind();
                    drpExam.DataSource = null;
                    drpExam.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divVisits
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");
        }
    }

    protected void btnVisitSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                decimal paid_amount = Convert.ToDecimal(txtPaidAmount.Value);
                if (drpCompanies_ud.SelectedIndex == 0 || txtPatID.Value == "" || paid_amount < 0)
                {
                    return;
                }
                DateTime date_from = DateTime.ParseExact(txtVisitDate.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                DateTime now = DateTime.Now;
                if (date_from > now || date_from.ToString("dd/MM/yyyy") == now.ToString("dd/MM/yyyy"))
                {
                    // get the data from user and insert into Pat_Visits_ud Table 
                    // if the returned value is equal to '4' that means successful operation
                    Int16 paid_status = 0;
                    if (chkVisitPaid.Checked)
                    {
                        paid_status = 1;
                    }
                    string status = Pat_Visits_ud.InsertCompanyVisit(new Pat_Visits_ud
                    {
                        pat_id = Convert.ToInt32(txtPatID.Value),
                        pat_visit_date = txtVisitDate.Value,
                        pat_visit_time = Convert.ToDateTime(txtVisitTime.Value).ToString("HH:mm"),
                        exam_det_id = Convert.ToInt32(drpVisitExam.SelectedValue),
                        paid_status = paid_status,
                        paid_amount = paid_amount,
                        user_id = user.user_id
                    }, Convert.ToInt32(drpCompanies_ud.SelectedValue));
                    if (status != "")
                    {
                        string[] arr = status.Split(',');
                        if (arr[0] == "4")
                        {
                            BindVisitsGridView();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(1,' Visit has been saved successfully');ClearVisitsTbl();UpdateBalance('" + arr[1] + "')", true);

                            mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearVisitsTbl();");
                        }
                        else if (arr[0] == "2")
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' This Company has no valid contract');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This Company has no valid contract",true);
                        }
                        else if (arr[0] == "3")
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' Doctor is not available in this day');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "Doctor is not available in this day", true);
                        }
                        else if (arr[0] == "5")
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' This Time is already reserved for a patient');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This Time is already reserved for a patient", true);
                        }
                        else if (arr[0] == "8")
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' Doctor is not available in this time');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "Doctor is not available in this time", true);
                        }
                        else if (arr[0] == "7")
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' This patient has an unfinished visit');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This patient has an unfinished visit", true);
                        }
                        else if (arr[0] == "9")
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' An error has occurred');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general,"", true);
                        }
                    }
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' Please enter a valid date');", true);
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "Please enter a valid date", true);
                }
            }
            catch (Exception ex)
            {
                // view the error messgae in the div with id : divVisits
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");
            }
        }
    }
    protected void btnVisitUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                // get the data from user and update Pat_Visits_ud Table 
                // if the returned value is equal to '4' that means successful operation
                if (txtVisitID.Value.Trim() != "")
                {
                    DateTime date_from = DateTime.ParseExact(txtVisitDate.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    DateTime now = DateTime.Now;
                    if (date_from > now || date_from.ToString("dd/MM/yyyy") == now.ToString("dd/MM/yyyy"))
                    {
                        int status = Pat_Visits_ud.UpdateDateTime(new Pat_Visits_ud
                        {
                            pat_visit_id = Convert.ToInt32(txtVisitID.Value),
                            pat_id = Convert.ToInt32(txtPatID.Value),
                            pat_visit_date = txtVisitDate.Value,
                            pat_visit_time = Convert.ToDateTime(txtVisitTime.Value).ToString("HH:mm"),
                        });
                        if (status == 4)
                        {
                            BindVisitsGridView();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(1,' Visit has been updated successfully');ClearVisitsTbl();", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "", true, "ClearVisitsTbl();");
                        }
                        else if (status == 3)
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(3,' Doctor is not available in this day');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "Doctor is not available in this day", true);
                        }
                        else if (status == 5)
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(3,' This Time is already reserved for a patient');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This Time is already reserved for a patient", true);
                        }
                        else if (status == 8)
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(3,' Doctor is not available in this time');", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "Doctor is not available in this time", true);
                        }
                        else if (status == 7)
                        {
                            BindVisitsGridView();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' This visit cannot be updated');ClearVisitsTbl();", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This visit cannot be updated", true);
                        }
                        else if (status == 9)
                        {
                            BindVisitsGridView();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' An error has occurred');ClearVisitsTbl();", true);
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true);
                        }
                    }
                    else
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' Please enter a valid date');", true);
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "Please enter a valid date", true);
                    }
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' Please select a visit first');", true);
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "Please select a visit first", true);
                }

            }
            catch (Exception ex)
            {
                // view the error messgae in the div with id : divVisits
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");
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
                        BindVisitsGridView();
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(1,' Visit has been deleted successfully');ClearVisitsTbl();UpdateBalance('" + arr[1] + "')", true);
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true);
                    }
                    else if (arr[0] == "5")
                    {
                        BindVisitsGridView();
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' This visit cannot be deleted');ClearVisitsTbl();", true);
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "This visit cannot be deleted", true);
                    }
                    else if (arr[0] == "9")
                    {
                        BindVisitsGridView();
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' An error has occurred');ClearVisitsTbl();", true);
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true);
                    }
                }
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divVisits').mShowStatus(2,' Please select a visit first');", true);
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, " Please select a visit first", true);
            }

        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divVisits
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");
        }
    }
    #endregion

    #region Doctors' Appointments Tab

    protected void BingDoctorDatesGridView()
    {
        try
        {
            WorkParams_ud.BindDropDownList(drpSrchgvDoctorDates, Days_ud.SelectDays_ud(1), "day_name", "day_id", new string[] { "All", "" });
            WorkParams_ud.BindGridView(gvDoctorDates, Days_ud.SelectDoctorAppointments());
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : t2
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, "ClearVisitsTbl();");
        }
    }

    protected void btnDoctorRefresh_Click(object sender, EventArgs e)
    {
        BingDoctorDatesGridView();
        // ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('.has-switch div:nth-child(2)').parent().remove();", true);  
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
}