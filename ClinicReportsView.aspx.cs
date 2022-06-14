using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.IO;

public partial class ClinicReportsView : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    ReportDocument rptDocument = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check Session["user"] that contains Current User's Information
        string[] str = Request["data"].Split(',');
        if (str.Length==4)
        {
            Session["datefrom"] = str[2];
            Session["dateto"] = str[3];
        }
       
        if (user == null)
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }
        crv.Unload += new EventHandler(crystalReportViewer_Unload);
        if (!IsPostBack)
        {
            // bind Current UserName
            //lblUserName.Text = user.user_name;
        }
        try
        {
            string[] data = null;
            if (Request["data"] != null)
            {
                data = Request["data"].ToString().Split(',');
            }
            if (data != null)
            {
                if (hfLoad.Value == "")
                {
                    HtmlGenericControl divDailyDet = (HtmlGenericControl)ucGeneralClinicsReports.FindControl("divDailyDet");
                    HtmlGenericControl divDailyPeriod = (HtmlGenericControl)ucGeneralClinicsReports.FindControl("divDailyPeriod");
                    switch (data[0])
                    {
                        case "detvisits":
                            CheckUserPremission("DailySummary.aspx");
                            //divDailyDet.Visible = true;
                            DailyDetVisits(Convert.ToInt32(data[1]), data[2], data[3]);
                            break;
                        case "patDet":
                            CheckUserPremission("DailySummary.aspx");
                            //divDailyDet.Visible = true;
                            PatientDetails(Convert.ToInt32(data[1]));
                            break;
                        default:
                            Response.Redirect("~/Home.aspx", false);
                            break;
                    }
                }
            }
            else
            {
                Response.Redirect("~/Home.aspx", false);
                return;
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + "</br</br>");
            Response.Write(ex.StackTrace);
        }
    }

    protected void crystalReportViewer_Unload(object sender, EventArgs e)
    {
        if (rptDocument != null)
        {
            rptDocument.Dispose();
            rptDocument.Close();
            GC.Collect();
        }
    }

    protected void Page_UnLoad(object sender, EventArgs e)
    {
        this.crv.Dispose();
        this.crv = null;
        rptDocument.Close();
        rptDocument.Dispose();
        GC.Collect();
    }

    protected void CheckUserPremission(string page_name)
    {
        if (user.admin == 0)
        {
            using (DataTable dt = Users_ud_Permissions.GetUserPagePerm(user.user_id, page_name))
            {
                if (dt.Rows.Count > 0)
                {
                    if (!Convert.ToBoolean(dt.Rows[0]["can_print"]))
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

    private void DailyDetVisits(int pat_id, string dateFrom, string dateTo)
    {
        string Gender="";
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_Patient_visits_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_Patient_visits_en.rpt"));

        //Transactions_ud.rptPatientVisits(pat_id)
        using (DataTable dt = Pat_Visits_ud.GetPatientVisits(Convert.ToInt32(pat_id), dateFrom, dateTo))
        {
            using (DataTable dt1 = Transactions_ud.rptPatients_udearch(pat_id))
            {
                TextObject txtPatId = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatId"];
                txtPatId.Text = dt1.Rows[0]["pat_id"].ToString();
                TextObject txtPatBirth = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatBirth"];
                txtPatBirth.Text = dt1.Rows[0]["pat_birthdate"].ToString();
                TextObject txtPatGender = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatGender"];
                if (dt1.Rows[0]["pat_gender"].ToString() == "f")
                {
                    Gender = "Female";
                }
                else
                    Gender = "male";
                txtPatGender.Text = Gender;
                TextObject txtPatAddr = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatAddress"];
                txtPatAddr.Text = dt1.Rows[0]["pat_address"].ToString();
                TextObject txtPatJob = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatJob"];
                txtPatJob.Text = dt1.Rows[0]["pat_job"].ToString();
                //
                TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
                txtUser.Text = user.user_name;
                TextObject txtPatName = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatName"];
                txtPatName.Text = dt1.Rows[0]["pat_name"].ToString();
            }

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Visits";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicsReports_lbPatientVisits');", true);
        }
    }
    public void GetReportBasicInfo()
    {
        TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
        txtUser.Text = user.user_name;
        using (DataTable dt = ReportsClass.GetBasicInfo())
        {
            if (dt.Rows.Count > 0)
            {
                TextObject txtHeader1 = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtHeader1"];
                txtHeader1.Text = dt.Rows[0]["header_line1"].ToString();
                TextObject txtHeader2 = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtHeader2"];
                txtHeader2.Text = dt.Rows[0]["header_line2"].ToString();
                TextObject txtHeader3 = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtHeader3"];
                txtHeader3.Text = dt.Rows[0]["header_line3"].ToString();
                TextObject txtHeader4 = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtHeader4"];
                txtHeader4.Text = dt.Rows[0]["header_line4"].ToString();
                TextObject txtFooter1 = (TextObject)rptDocument.ReportDefinition.Sections["Section5"].ReportObjects["txtFooter1"];
                txtFooter1.Text = dt.Rows[0]["footer_line1"].ToString();
                TextObject txtFooter2 = (TextObject)rptDocument.ReportDefinition.Sections["Section5"].ReportObjects["txtFooter2"];
                txtFooter2.Text = dt.Rows[0]["footer_line2"].ToString();
                TextObject txtFooter3 = (TextObject)rptDocument.ReportDefinition.Sections["Section5"].ReportObjects["txtFooter3"];
                txtFooter3.Text = dt.Rows[0]["footer_line3"].ToString();
            }
        }
    }
    private void PatientDetails(int pat_id)
    {
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/2_pat_Det_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/2_pat_Det_en.rpt"));
        using (DataTable dt = Transactions_ud.rptPatients_udearch(pat_id))
        {
            string gender = "";
            GetReportBasicInfo();
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            //TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            //txtDay.Text = pat_id.ToString();
            if (dt.Rows.Count > 0)
            {
                TextObject txtPatId = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatId"];
                txtPatId.Text = dt.Rows[0]["pat_id"].ToString();
                TextObject txtPatName = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatName"];
                txtPatName.Text = dt.Rows[0]["pat_name"].ToString();
                TextObject txtPatBirth = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatBirth"];
                txtPatBirth.Text = dt.Rows[0]["pat_birthdate"].ToString();
                TextObject txtPatGender = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatGender"];
                if (dt.Rows[0]["pat_gender"].ToString() == "m")
                {
                    if (language == "ar")
                    {
                        gender = "ذكر";
                    }
                    else
                        gender = "Male";
                }
                else
                {
                    if (language == "ar")
                        gender = "أنثي";
                    else
                        gender = "Female";
                }
                txtPatGender.Text = gender;
                TextObject txtPatAddr = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatAddr"];
                txtPatAddr.Text = dt.Rows[0]["pat_address"].ToString();
                TextObject txtPatMobile = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatMobile"];
                txtPatMobile.Text = dt.Rows[0]["pat_mobile"].ToString();
                TextObject txtPatTele = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatTele"];
                txtPatTele.Text = dt.Rows[0]["pat_phone"].ToString();
                TextObject txtPatJob = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatJob"];
                txtPatJob.Text = dt.Rows[0]["pat_job"].ToString();
                TextObject txtPatCreatedOn = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatCreatedOn"];
                txtPatCreatedOn.Text = dt.Rows[0]["created_date"].ToString();
            }

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Patient";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicsReports_lbPatientDetails');", true);
        }
    }


    #region Link Buttons

    protected void lbSummary_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=summary," + str[1], false);
    }

    protected void lbVisits_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=detvisits," + str[1], false);
    }
    protected void lbReturnedVisits_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=detretvisits," + str[1], false);
    }
    protected void lbFromCompanies_ud_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=detencashcomp," + str[1], false);
    }
    protected void lbFromPatients_ud_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=detencashpat," + str[1], false);
    }
    protected void lbForCompanies_ud_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=detpaycomp," + str[1], false);
    }
    protected void lbForPatients_ud_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=detpaypat," + str[1], false);
    }
    protected void lbForExaminations_ud_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=detpayexp," + str[1], false);
    }
    protected void lbWithdrawals_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=detwith," + str[1], false);
    }

    protected void lbDailySummary_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=period," + str[1] + "," + str[2], false);
    }
    protected void lbDailyDetail_Click(object sender, EventArgs e)
    {
        string[] str = Request["data"].Split(',');
        Response.Redirect("~/FinancialsReportsView.aspx?data=perdet," + str[1] + "," + str[2], false);
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