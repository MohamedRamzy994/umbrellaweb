using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.IO;
using System.Web.UI.HtmlControls;

public partial class ReportView : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    ReportDocument rptDocument = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check Session["user"] that contains Current User's Information
        if (user == null)
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }
        crv.Unload += new EventHandler(crystalReportViewer_Unload);
        if (!IsPostBack)
        {
            if (user.admin == 1)
            {
                // bind Current UserName
                //lblUserName.Text = user.user_name;
            }
            else
            {
                using (DataTable dt = Users_ud_Permissions.GetUserPagePerm(user.user_id, "GeneralClinic.aspx"))
                {
                    if (dt.Rows.Count > 0)
                    {
                        if (Convert.ToBoolean(dt.Rows[0]["can_print"]))
                        {
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
                    HtmlGenericControl divVisit = (HtmlGenericControl)ucGeneralClinicReports.FindControl("divVisit");
                    HtmlGenericControl divPast_history = (HtmlGenericControl)ucGeneralClinicReports.FindControl("divPast_history");
                    switch (data[0])
                    {
                        case "visit":
                            CheckUserPremission("GeneralClinic.aspx");
                            divVisit.Visible = true;
                            PatVisit(data[1]);
                            break;
                        case "prescription":
                            CheckUserPremission("GeneralClinic.aspx");
                            divVisit.Visible = true;
                            VisitPrescription(data[1]);
                            break;
                        case "request":
                            CheckUserPremission("GeneralClinic.aspx");
                            divVisit.Visible = true;
                            VisitRequest(data[1]);
                            break;
                        case "Diagnosis_ud":
                            CheckUserPremission("GeneralClinic.aspx");
                            divVisit.Visible = true;
                            VisitDiagnosis_ud(data[1]);
                            break;
                        case "vital":
                            CheckUserPremission("GeneralClinic.aspx");
                            divVisit.Visible = true;
                            VisitVitalSigns(data[1]);
                            break;
                        case "family":
                            CheckUserPremission("GeneralClinic.aspx");
                            divPast_history.Visible = true;
                            PatFamilyHistroy(data[1]);
                            break;
                        case "chronic":
                            CheckUserPremission("GeneralClinic.aspx");
                            divPast_history.Visible = true;
                            PatChronic(data[1]);
                            break;
                        case "drugs":
                            CheckUserPremission("GeneralClinic.aspx");
                            divPast_history.Visible = true;
                            PatDrugs(data[1]);
                            break;
                        case "surgeries":
                            CheckUserPremission("GeneralClinic.aspx");
                            divPast_history.Visible = true;
                            PatSurgeries(data[1]);
                            break;
                        case "transfusion":
                            CheckUserPremission("GeneralClinic.aspx");
                            divPast_history.Visible = true;
                            PatTransfusion(data[1]);
                            break;
                        case "hospital":
                            CheckUserPremission("GeneralClinic.aspx");
                            divPast_history.Visible = true;
                            PatHospital(data[1]);
                            break;
                        case "images":
                            CheckUserPremission("GeneralClinic.aspx");
                            divPast_history.Visible = true;
                            PatImages(data[1]);
                            break;
                        case "demo":
                            CheckUserPremission("Clinic_udSettings.aspx");
                            Demo();
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

    public void GetPatientInfo(int pat_id)
    {
        using (DataTable dt = ReportsClass.GetPatientInfo(pat_id))
        {
            if (dt.Rows.Count > 0)
            {
                TextObject txtPatId = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatId"];
                txtPatId.Text = dt.Rows[0]["pat_id"].ToString();
                TextObject txtPatName = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatName"];
                txtPatName.Text = dt.Rows[0]["pat_name"].ToString();
                TextObject txtPatAge = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatAge"];
                txtPatAge.Text = dt.Rows[0]["pat_age"].ToString();
                TextObject txtPat_gender = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPat_gender"];
                txtPat_gender.Text = dt.Rows[0]["pat_gender"].ToString();
                TextObject txtMarital_id = (TextObject)rptDocument.ReportDefinition.Sections["Section5"].ReportObjects["txtMarital_id"];
                txtMarital_id.Text = dt.Rows[0]["marital_id"].ToString();
                TextObject txtBlood_id = (TextObject)rptDocument.ReportDefinition.Sections["Section5"].ReportObjects["txtBlood_id"];
                txtBlood_id.Text = dt.Rows[0]["blood_id"].ToString();
                TextObject txtPat_smoker = (TextObject)rptDocument.ReportDefinition.Sections["Section5"].ReportObjects["txtPat_smoker"];
                txtPat_smoker.Text = dt.Rows[0]["pat_smoker"].ToString();
                TextObject txtPat_dm = (TextObject)rptDocument.ReportDefinition.Sections["Section5"].ReportObjects["txtPat_dm"];
                txtPat_dm.Text = dt.Rows[0]["pat_dm"].ToString();
                TextObject txtPat_htn = (TextObject)rptDocument.ReportDefinition.Sections["Section5"].ReportObjects["txtPat_htn"];
                txtPat_htn.Text = dt.Rows[0]["pat_htn"].ToString();
            }
        }
    }

   
    private void Demo()
    {

        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_Clinic_ud_demo_ar.rpt")));

        GetReportBasicInfo();
        rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
        rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
        //rptDocument.SetDataSource(dt);
        this.Title = "Demo Report";
        crv.ReportSource = rptDocument;
    }
    private void PatVisit(string visit_id)
    {
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_pat_visit_")));

        using (DataTable dt = ReportsClass.PatVisit(Convert.ToInt32(visit_id)))
        {
            GetReportBasicInfo();
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Visit Summary";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbVisit');", true);
    }

    private void VisitPrescription(string visit_id)
    {
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_visit_prescription_")));

        using (DataTable dt = ReportsClass.VisitPrescription(Convert.ToInt32(visit_id)))
        {
            GetReportBasicInfo();
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA5;
            rptDocument.SetDataSource(dt);
            this.Title = "Precription";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbPrescription');", true);
    }

    private void VisitRequest(string visit_id)
    {
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_visit_request_")));

        using (DataTable dt = ReportsClass.VisitRequest(Convert.ToInt32(visit_id)))
        {
            GetReportBasicInfo();
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA5;
            rptDocument.SetDataSource(dt);
            this.Title = "Request";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbRequest');", true);
    }
    private void VisitDiagnosis_ud(string visit_id)
    {
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_visit_complaint_Diagnosis_ud_")));

        using (DataSet ds = ReportsClass.VisitDiagnosis_ud(Convert.ToInt32(visit_id)))
        {
            GetReportBasicInfo();
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA5;
            rptDocument.SetDataSource(ds.Tables[0]);
            if (ds.Tables[1].Rows.Count > 0)
            {
                TextObject txtPatComplaint = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtPatComplaint"];
                txtPatComplaint.Text = ds.Tables[1].Rows[0]["pat_complaint_name"].ToString();
                TextObject txtDoctorNotes = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDoctorNotes"];
                txtDoctorNotes.Text = ds.Tables[1].Rows[0]["pat_complaint_note"].ToString();
            }
            this.Title = "Complaints & Diagnosis_ud";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbComplaintDiagnosis_ud');", true);
    }

    private void VisitVitalSigns(string visit_id)
    {
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_visit_vital_")));

        using (DataTable dt = ReportsClass.VisitVitalSigns(Convert.ToInt32(visit_id)))
        {
            GetReportBasicInfo();
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA5;
            rptDocument.SetDataSource(dt);
            this.Title = "Vital Signs";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbVitalSigns');", true);
    }

    private void PatFamilyHistroy(string pat_id)
    {
        int id = Convert.ToInt32(pat_id);
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_pat_family_")));

        using (DataTable dt = Pat_Family_History_ud.SlcWithNames(id))
        {
            GetReportBasicInfo();
            GetPatientInfo(id);
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Family History";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbFamily');", true);
    }
    private void PatChronic(string pat_id)
    {
        int id = Convert.ToInt32(pat_id);
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_pat_chronic_")));

        using (DataTable dt = Pat_Chronic_Diseases_ud.SelectAll(id))
        {
            GetReportBasicInfo();
            GetPatientInfo(id);
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Chronic Diseases";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbChronic');", true);
    }
    private void PatDrugs(string pat_id)
    {
        int id = Convert.ToInt32(pat_id);
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_Pat_Drugs_ud_")));

        using (DataTable dt = Pat_Drugs_ud.SelectAll(id))
        {
            GetReportBasicInfo();
            GetPatientInfo(id);
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Drugs";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbDrugs');", true);
    }
    private void PatSurgeries(string pat_id)
    {
        int id = Convert.ToInt32(pat_id);
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_Pat_Surgeries_ud_")));

        using (DataTable dt = Pat_Surgeries_ud.SelectAll(id))
        {
            GetReportBasicInfo();
            GetPatientInfo(id);
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Surgeries";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbSurgeries');", true);
    }
    private void PatTransfusion(string pat_id)
    {
        int id = Convert.ToInt32(pat_id);
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_Pat_Transfusion_ud_")));

        using (DataTable dt = Pat_Transfusion_ud.SelectAll(id))
        {
            GetReportBasicInfo();
            GetPatientInfo(id);
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Transfusion";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbTransfusion');", true);
    }
    private void PatHospital(string pat_id)
    {
        int id = Convert.ToInt32(pat_id);
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_pat_hospital_")));

        using (DataTable dt = Pat_Hospital_Admission_ud.SelectAll(id))
        {
            GetReportBasicInfo();
            GetPatientInfo(id);
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Hospital Admission";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbHospital');", true);
    }
    private void PatImages(string pat_id)
    {
        int id = Convert.ToInt32(pat_id);
        rptDocument.Load(Server.MapPath(GetRptLangPath("~/rpt/2_Pat_Images_ud_")));

        using (DataTable dt = Pat_Images_ud.PatImages(id, Server.MapPath("~/Images/")))
        {
            GetReportBasicInfo();
            GetPatientInfo(id);
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;

            rptDocument.SetDataSource(dt);
            this.Title = "Images";
            crv.ReportSource = rptDocument;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucGeneralClinicReports_lbImages');", true);
    }

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
                    Response.Redirect("~/Default.aspx",false);
                    return null;
                }
            }
        }
    }
    #endregion


    
}