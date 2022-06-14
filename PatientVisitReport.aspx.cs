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
public partial class PatientDetailReport : BasePage
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
        string date = txtDateRange.Text;
        if (date !="")
        {
            string[] arr = date.Split(' ');
            string dateFrom = arr[0];
            string dateTo = arr[2];
            HiddenDateFrom.Value = dateFrom;
            HiddenDateTo.Value = dateTo;
        }
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
                BindPatients_udGridViewFistTime();

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
        //upPatientResult.Update();
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
    #endregion
    #region

    //protected void BindResultsGridView()
    //{
    //    try
    //    {
    //        WorkParams_ud.BindGridView(gvResults, Transactions_ud.rptDailySummaryDetailsWithinPeriod(txtDateFrom.Value, txtDateTo.Value));

    //    }
    //    catch (Exception ex)
    //    {
    //        // show the error message in the div with id: t1
    //        string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
    //    }
    //}
    //protected void BindPatientGridView()
    //{
    //    try
    //    {
    //        // Bind Patients_ud GridView according to attributes of search
    //        WorkParams_ud.BindGridView(gvVisits, Patients_ud.Patients_udearch(txtPatId.Value));
    //    }
    //    catch (Exception ex)
    //    {
    //        // view the error messgae in the div with id : t1
    //        string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
    //    }
    //}
    protected void BindVisitsGridView()
    {
        try
        {
            if (txtPatId.Value.Trim() != "")
            {
                string date = txtDateRange.Text;
                 string dateFrom="";
                 string dateTo = "";
                if (date != "")
                {
                    string[] arr = date.Split(' ');
                    dateFrom = arr[0];
                    dateTo = arr[2];
                    Session["dateFrom"] = dateFrom;
                    Session["dateTo"] = dateTo;
                    HiddenDateFrom.Value = dateFrom;
                    HiddenDateTo.Value = dateTo;
                }
                WorkParams_ud.BindGridView(gvVisits, Pat_Visits_ud.GetPatientVisits(Convert.ToInt32(txtPatId.Value), dateFrom, dateTo));
            }
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divVisits
            string str = string.Format("{0}{1}{2}", "$('#divVisits').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    protected void btnResultSearch_Click(object sender, EventArgs e)
    {
        string date = txtDateRange.Text;
        if (date != "")
        {
            string[] arr = date.Split(' ');
            string dateFrom = arr[0];
            string dateTo = arr[2];
            HiddenDateFrom.Value = dateFrom;
            HiddenDateTo.Value = dateTo;
        }
        BindVisitsGridView();
    }
    protected void btnDateValidation_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    DateTime date_from = DateTime.ParseExact(txtDateFrom.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        //    DateTime date_to = DateTime.ParseExact(txtDateTo.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        //    int x = DateTime.Compare(date_from, date_to);
        //    if (x != 1)
        //    {
        btnResultSearch.Enabled = true;
        btnResultPrint.Enabled = true;
        //    }
        //    else
        //    {
        //        btnResultSearch.Enabled = false;
        //        btnResultPrint.Enabled = false;
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#t1').mShowStatus(2,' Please enter a valid period')", true);
        //    }
        //}
        //catch (Exception ex)
        //{
        //    // show the error message in the div with id: t1
        //    string str = string.Format("{0}{1}{2}", "$('#t1').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        //}
    }
    protected void gvVisits_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvVisits.PageIndex = e.NewPageIndex;
        BindVisitsGridView();
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
    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {

    }
    protected void txtDateRange_TextChanged(object sender, EventArgs e)
    {
        //string date = txtDateRange.Text;
        //if (date != "")
        //{
        //    string[] arr = date.Split(' ');
        //    string dateFrom = arr[0];
        //    string dateTo = arr[2];
        //    HiddenDateFrom.Value = dateFrom;
        //    HiddenDateTo.Value = dateTo;
        //    txtDateFrom.Value = dateFrom;
        //    txtDateTo.Value = dateTo;
        //}
    }
    protected void btnDateSplit_Click(object sender, EventArgs e)
    {
        string date = txtDateRange.Text;
        if (date != "")
        {
            string[] arr = date.Split(' ');
            string dateFrom = arr[0];
            string dateTo = arr[2];
            HiddenDateFrom.Value = dateFrom;
            HiddenDateTo.Value = dateTo;
            txtDateFrom.Value = dateFrom;
            txtDateTo.Value = dateTo;
        }
    }
}