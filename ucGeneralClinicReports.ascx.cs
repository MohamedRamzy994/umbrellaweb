using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class ucReception : System.Web.UI.UserControl
{
    protected override void OnLoad(EventArgs e)
    {
        if (user != null && user.sounds == 1)
        {
            Page.Header.Controls.Add(mNotifications.CreateJavaScriptLink("~/js/mSounds.js"));
        }
        base.OnLoad(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (user == null)
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }
        if (!IsPostBack)
        {
            lblUserName.Text = user.user_name;
        }
    }

    public PlaceHolder BottomScriptsPlaceHolder
    {
        get
        {
            return phBottomScripts;
        }
    }

    //#region link Buttons

    //protected void lbSignOut_Click(object sender, EventArgs e)
    //{
    //    HttpCookie infoCookie = HttpContext.Current.Request.Cookies["info"];
    //    if (infoCookie != null)
    //    {
    //        infoCookie.Expires = DateTime.Now.AddDays(-1d);
    //        Response.Cookies.Add(infoCookie);
    //    }
    //    Session.Clear();
    //    Session.Abandon();
    //    Response.Redirect("~/Default.aspx", false);
    //    return;
    //}

    protected void lnklang_Click(object sender, EventArgs e)
    {
        if (lnklang.Text == "EN")
        {
            Session["lang"] = "en";
        }
        else
        {
            Session["lang"] = "ar";
        }
        string path = Path.GetFileName(Request.Url.AbsoluteUri);
        Response.Redirect(path, false);
        return;
    }
    protected void lnkSounds_Click(object sender, EventArgs e)
    {
        try
        {
            string user_name = user.user_name;
            if (Users_ud.UpdateSounds(user_name) == 4)
            {
                Session["user"] = Users_ud.SelectByUserName(user_name);
                Response.Redirect(Path.GetFileName(Request.Url.AbsolutePath), false);
                return;
            }
            else
            {
                mNotifications.Notify(this.Page, mNotifications.mNotifyType.error_general, "", true, null);
            }
        }
        catch (Exception ex)
        {

            mNotifications.Notify(this.Page, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    //protected void lbSummary_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=summary," + str[1], false);
    //}

    //protected void lbVisits_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=detvisits," + str[1], false);
    //}
    //protected void lbReturnedVisits_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=detretvisits," + str[1], false);
    //}
    //protected void lbFromCompanies_ud_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=detencashcomp," + str[1], false);
    //}
    //protected void lbFromPatients_ud_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=detencashpat," + str[1], false);
    //}
    //protected void lbForCompanies_ud_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=detpaycomp," + str[1], false);
    //}
    //protected void lbForPatients_ud_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=detpaypat," + str[1], false);
    //}
    //protected void lbForExaminations_ud_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=detpayexp," + str[1], false);
    //}
    //protected void lbWithdrawals_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=detwith," + str[1], false);
    //}

    //protected void lbDailySummary_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=period," + str[1] + "," + str[2], false);
    //}
    //protected void lbDailyDetail_Click(object sender, EventArgs e)
    //{
    //    string[] str = Request["data"].Split(',');
    //    Response.Redirect("~/FinancialsReportsView.aspx?data=perdet," + str[1] + "," + str[2], false);
    //}
    ////protected void lbSignOut_Click(object sender, EventArgs e)
    ////{
    ////    HttpCookie infoCookie = HttpContext.Current.Request.Cookies["info"];
    ////    if (infoCookie != null)
    ////    {
    ////        infoCookie.Expires = DateTime.Now.AddDays(-1d);
    ////        Response.Cookies.Add(infoCookie);
    ////    }
    ////    Session.Clear();
    ////    Session.Abandon();
    ////    Response.Redirect("~/Default.aspx", false);
    ////}
   

    //#endregion

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
    protected void lbVisit_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=visit," + str[1], false);
    }
    protected void lbVitalSigns_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=vital," + str[1], false);
    }
    protected void lbComplaintDiagnosis_ud_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=Diagnosis_ud," + str[1], false);
    }
    protected void lbPrescription_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=prescription," + str[1], false);
    }
    protected void lbRequest_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=request," + str[1], false);
    }
    protected void lbFamily_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=family," + str[1], false);
    }
    protected void lbChronic_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=chronic," + str[1], false);
    }
    protected void lbDrugs_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=drugs," + str[1], false);
    }
    protected void lbSurgeries_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=surgeries," + str[1], false);
    }
    protected void lbTransfusion_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=transfusion," + str[1], false);
    }
    protected void lbHospital_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=hospital," + str[1], false);
    }
    protected void lbImages_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/ReportView.aspx?data=images," + str[1], false);
    }
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
    #endregion
}