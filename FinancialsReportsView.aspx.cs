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

public partial class FinancialsReportsView : BasePage
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
                    HtmlGenericControl divDailyDet = (HtmlGenericControl)ucfinancialReports.FindControl("divDailyDet");
                    HtmlGenericControl divDailyPeriod = (HtmlGenericControl)ucfinancialReports.FindControl("divDailyPeriod");
                    switch (data[0])
                    {
                        case "summary":
                            CheckUserPremission("DailySummary.aspx");
                           
                            divDailyDet.Visible = true;
                            DailySummary(data[1]);
                            break;
                        case "detvisits":
                            CheckUserPremission("DailySummary.aspx");
                            divDailyDet.Visible = true;
                            DailyDetVisits(data[1]);
                            break;
                        case "detretvisits":
                            CheckUserPremission("DailySummary.aspx");
                            divDailyDet.Visible = true;
                            DailyDetRetVisits(data[1]);
                            break;
                        case "detencashcomp":
                            CheckUserPremission("DailySummary.aspx");
                            divDailyDet.Visible = true;
                            DailyDetEncashCompnaies(data[1]);
                            break;
                        case "detencashpat":
                            CheckUserPremission("DailySummary.aspx");
                            divDailyDet.Visible = true;
                            DailyDetEncashPatients_ud(data[1]);
                            break;
                        case "detpaycomp":
                            CheckUserPremission("DailySummary.aspx");
                            divDailyDet.Visible = true;
                            DailyDetPayCompanies_ud(data[1]);
                            break;
                        case "detpaypat":
                            CheckUserPremission("DailySummary.aspx");
                            divDailyDet.Visible = true;
                            DailyDetPayPatients_ud(data[1]);
                            break;
                        case "detpayexp":
                            CheckUserPremission("DailySummary.aspx");
                            divDailyDet.Visible = true;
                            DailyDetPayExaminations_ud(data[1]);
                            break;
                        case "detwith":
                            CheckUserPremission("DailySummary.aspx");
                            divDailyDet.Visible = true;
                            DailyDetWithdrawals(data[1]);
                            break;
                        case "period":
                            CheckUserPremission("FinancialsReports.aspx");
                            divDailyPeriod.Visible = true;
                            DailySummaryPeriod(data[1], data[2]);
                            break;
                        case "perdet":
                            CheckUserPremission("FinancialsReports.aspx");
                            divDailyPeriod.Visible = true;
                            DailySummaryDetailsPeriod(data[1], data[2]);
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
   
    private void DailySummary(string day)
    {
        if (language=="ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_summary_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_summary_en.rpt"));
       

        using (DataSet ds = Transactions_ud.GetDailySummary(day))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            txtDay.Text = day;
            TextObject txtCountVisits = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtCountVisits"];
            txtCountVisits.Text = ds.Tables[1].Rows[0]["visits_count"].ToString();
            TextObject txtTotalVisits = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtTotalVisits"];
            txtTotalVisits.Text = ds.Tables[1].Rows[0]["visits_total"].ToString();
            TextObject txtCountEncash = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtCountEncash"];
            txtCountEncash.Text = ds.Tables[3].Rows[0]["encash_count"].ToString();
            TextObject txtTotalEncash = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtTotalEncash"];
            txtTotalEncash.Text = ds.Tables[3].Rows[0]["encash_total"].ToString();
            TextObject txtCountRevisits = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtCountRevisits"];
            txtCountRevisits.Text = ds.Tables[2].Rows[0]["ret_visits_count"].ToString();
            TextObject txtTotalRevisits = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtTotalRevisits"];
            txtTotalRevisits.Text = ds.Tables[2].Rows[0]["ret_visits_total"].ToString();
            TextObject txtCountPay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtCountPay"];
            txtCountPay.Text = ds.Tables[4].Rows[0]["pay_count"].ToString();
            TextObject txtTotalPay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtTotalPay"];
            txtTotalPay.Text = ds.Tables[4].Rows[0]["pay_total"].ToString();
            TextObject txtCountWith = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtCountWith"];
            txtCountWith.Text = ds.Tables[5].Rows[0]["with_count"].ToString();
            TextObject txtTotalWith = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtTotalWith"];
            txtTotalWith.Text = ds.Tables[5].Rows[0]["with_total"].ToString();
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(ds.Tables[0]);
            this.Title = "Daily Summary";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbSummary');", true);
        }
    }

    private void DailyDetVisits(string day)
    {
        if (language=="ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_visits_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_visits_en.rpt"));
       

        using (DataTable dt = Transactions_ud.rptDailyDetVisits(day))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            txtDay.Text = day;

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Visits";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbVisits');", true);
        }
    }

    private void DailyDetRetVisits(string day)
    {
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_ret_visits_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_ret_visits_en.rpt"));
        

        using (DataTable dt = Transactions_ud.rptDailyDetReturnedVisits(day))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            txtDay.Text = day;

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Returned Visits";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbReturnedVisits');", true);
        }
    }

    private void DailyDetEncashCompnaies(string day)
    {
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_encash_comp_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_encash_comp_en.rpt"));
        

        using (DataTable dt = Transactions_ud.rptDailyDetEncashCompanies_ud(day))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            txtDay.Text = day;

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "EV's Companies_ud";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbFromCompanies_ud');MakeActive2('ucfinancialReports_lbFromCompanies_ud');", true);
        }
    }

    private void DailyDetEncashPatients_ud(string day)
    {
        if (language== "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_encash_pat_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_encash_pat_en.rpt"));
        

        using (DataTable dt = Transactions_ud.rptDailyDetEncashPatients_ud(day))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            txtDay.Text = day;

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "EV's Patients_ud";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbFromPatients_ud');MakeActive2('ucfinancialReports_lbFromPatients_ud');", true);
        }
    }

    private void DailyDetPayCompanies_ud(string day)
    {
          
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_pay_comp_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_pay_comp_en.rpt"));
        

        using (DataTable dt = Transactions_ud.rptDailyDetPayCompanies_ud(day))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            txtDay.Text = day;

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "PV's Companies_ud";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbForCompanies_ud');MakeActive2('ucfinancialReports_lbForCompanies_ud');", true);
        }
    }
    private void DailyDetPayPatients_ud(string day)
    {
          
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_pay_pat_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_pay_pat_en.rpt"));
        

        using (DataTable dt = Transactions_ud.rptDailyDetPayPatients_ud(day))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            txtDay.Text = day;

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "PV's Patients_ud";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbForPatients_ud');MakeActive2('ucfinancialReports_lbForPatients_ud');", true);
        }
    }

    private void DailyDetPayExaminations_ud(string day)
    {
          
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_pay_exp_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_pay_exp_en.rpt"));
        
        

        using (DataTable dt = Transactions_ud.rptDailyDetPayExaminations_ud(day))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            txtDay.Text = day;

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "PV's Examinations_ud";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbForExaminations_ud');MakeActive2('ucfinancialReports_lbForExaminations_ud');", true);
        }
    }

    private void DailyDetWithdrawals(string day)
    {
          
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_with_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_det_with_en.rpt"));
        
        

        using (DataTable dt = Transactions_ud.rptDailyDetWithdrawals(day))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDay = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDay"];
            txtDay.Text = day;

            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Withdrawals";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbWithdrawals');", true);
        }
    }
    private void DailySummaryPeriod(string date_from, string date_to)
    {
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_summary_period_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_summary_period_en.rpt"));
        
        
        using (DataTable dt = Transactions_ud.rptDailySummaryWithinPeriod(date_from, date_to))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDateFrom = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDateFrom"];
            txtDateFrom.Text = date_from;
            TextObject txtDateTo = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDateTo"];
            txtDateTo.Text = date_to;
            TextObject txtRecordsCount = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtRecordsCount"];
            txtRecordsCount.Text = dt.Rows.Count.ToString();
            if (dt.Rows.Count > 0)
            {
                // minimum value <> 0
                decimal start_balance = Convert.ToDecimal(dt.Rows[0]["start_balance"]);
                decimal income = Convert.ToDecimal(dt.Rows[0]["income"]);
                decimal outcome = Convert.ToDecimal(dt.Rows[0]["outcome"]);
                decimal withdrawals = Convert.ToDecimal(dt.Rows[0]["withdrawals"]);
                decimal balance = Convert.ToDecimal(dt.Rows[0]["balance"]);
                decimal visits_count = Convert.ToDecimal(dt.Rows[0]["visits_count"]);
                decimal visits_total = Convert.ToDecimal(dt.Rows[0]["visits_total"]);
                decimal encash_count = Convert.ToDecimal(dt.Rows[0]["encash_count"]);
                decimal encash_total = Convert.ToDecimal(dt.Rows[0]["encash_total"]);
                decimal ret_visits_count = Convert.ToDecimal(dt.Rows[0]["ret_visits_count"]);
                decimal ret_visits_total = Convert.ToDecimal(dt.Rows[0]["ret_visits_total"]);
                decimal pay_count = Convert.ToDecimal(dt.Rows[0]["pay_count"]);
                decimal pay_total = Convert.ToDecimal(dt.Rows[0]["pay_total"]);
                decimal with_count = Convert.ToDecimal(dt.Rows[0]["with_count"]);
                decimal with_total = Convert.ToDecimal(dt.Rows[0]["with_total"]);
                for (int i = 1; i < dt.Rows.Count; i++)
                {
                    if ((start_balance == 0) || (start_balance > Convert.ToDecimal(dt.Rows[i]["start_balance"]) && Convert.ToDecimal(dt.Rows[i]["start_balance"]) != 0))
                    {
                        start_balance = Convert.ToDecimal(dt.Rows[i]["start_balance"]);
                    }
                    if ((income == 0) || (income > Convert.ToDecimal(dt.Rows[i]["income"]) && Convert.ToDecimal(dt.Rows[i]["income"]) != 0))
                    {
                        income = Convert.ToDecimal(dt.Rows[i]["income"]);
                    }
                    if ((outcome == 0) || (outcome > Convert.ToDecimal(dt.Rows[i]["outcome"]) && Convert.ToDecimal(dt.Rows[i]["outcome"]) != 0))
                    {
                        outcome = Convert.ToDecimal(dt.Rows[i]["outcome"]);
                    }
                    if ((withdrawals == 0) || (withdrawals > Convert.ToDecimal(dt.Rows[i]["withdrawals"]) && Convert.ToDecimal(dt.Rows[i]["withdrawals"]) != 0))
                    {
                        withdrawals = Convert.ToDecimal(dt.Rows[i]["withdrawals"]);
                    }
                    if ((balance == 0) || (balance > Convert.ToDecimal(dt.Rows[i]["balance"]) && Convert.ToDecimal(dt.Rows[i]["balance"]) != 0))
                    {
                        balance = Convert.ToDecimal(dt.Rows[i]["balance"]);
                    }
                    if ((visits_count == 0) || (visits_count > Convert.ToDecimal(dt.Rows[i]["visits_count"]) && Convert.ToDecimal(dt.Rows[i]["visits_count"]) != 0))
                    {
                        visits_count = Convert.ToDecimal(dt.Rows[i]["visits_count"]);
                    }
                    if ((visits_total == 0) || (visits_total > Convert.ToDecimal(dt.Rows[i]["visits_total"]) && Convert.ToDecimal(dt.Rows[i]["visits_total"]) != 0))
                    {
                        visits_total = Convert.ToDecimal(dt.Rows[i]["visits_total"]);
                    }
                    if ((encash_count == 0) || (encash_count > Convert.ToDecimal(dt.Rows[i]["encash_count"]) && Convert.ToDecimal(dt.Rows[i]["encash_count"]) != 0))
                    {
                        encash_count = Convert.ToDecimal(dt.Rows[i]["encash_count"]);
                    }
                    if ((encash_total == 0) || (encash_total > Convert.ToDecimal(dt.Rows[i]["encash_total"]) && Convert.ToDecimal(dt.Rows[i]["encash_total"]) != 0))
                    {
                        encash_total = Convert.ToDecimal(dt.Rows[i]["encash_total"]);
                    }
                    if ((ret_visits_count == 0) || (ret_visits_count > Convert.ToDecimal(dt.Rows[i]["ret_visits_count"]) && Convert.ToDecimal(dt.Rows[i]["ret_visits_count"]) != 0))
                    {
                        ret_visits_count = Convert.ToDecimal(dt.Rows[i]["ret_visits_count"]);
                    }
                    if ((ret_visits_total == 0) || (ret_visits_total > Convert.ToDecimal(dt.Rows[i]["ret_visits_total"]) && Convert.ToDecimal(dt.Rows[i]["ret_visits_total"]) != 0))
                    {
                        ret_visits_total = Convert.ToDecimal(dt.Rows[i]["ret_visits_total"]);
                    }
                    if ((pay_count == 0) || (pay_count > Convert.ToDecimal(dt.Rows[i]["pay_count"]) && Convert.ToDecimal(dt.Rows[i]["pay_count"]) != 0))
                    {
                        pay_count = Convert.ToDecimal(dt.Rows[i]["pay_count"]);
                    }
                    if ((pay_total == 0) || (pay_total > Convert.ToDecimal(dt.Rows[i]["pay_total"]) && Convert.ToDecimal(dt.Rows[i]["pay_total"]) != 0))
                    {
                        pay_total = Convert.ToDecimal(dt.Rows[i]["pay_total"]);
                    }
                    if ((with_count == 0) || (with_count > Convert.ToDecimal(dt.Rows[i]["with_count"]) && Convert.ToDecimal(dt.Rows[i]["with_count"]) != 0))
                    {
                        with_count = Convert.ToDecimal(dt.Rows[i]["with_count"]);
                    }
                    if ((with_total == 0) || (with_total > Convert.ToDecimal(dt.Rows[i]["with_total"]) && Convert.ToDecimal(dt.Rows[i]["with_total"]) != 0))
                    {
                        with_total = Convert.ToDecimal(dt.Rows[i]["with_total"]);
                    }
                }
                TextObject txtMinStartBal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinStartBal"];
                TextObject txtMinIncome = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinIncome"];
                TextObject txtMinOutcome = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinOutcome"];
                TextObject txtMinWith = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinWith"];
                TextObject txtMinBal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinBal"];
                TextObject txtMinVisitsCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinVisitsCount"];
                TextObject txtMinVisitsTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinVisitsTotal"];
                TextObject txtMinEncashCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinEncashCount"];
                TextObject txtMinEncashTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinEncashTotal"];
                TextObject txtMinRetVisitsCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinRetVisitsCount"];
                TextObject txtMinRetVisitsTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinRetVisitsTotal"];
                TextObject txtMinPayCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinPayCount"];
                TextObject txtMinPayTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinPayTotal"];
                TextObject txtMinWithCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinWithCount"];
                TextObject txtMinWithTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinWithTotal"];
                txtMinStartBal.Text = start_balance.ToString();
                txtMinIncome.Text = income.ToString();
                txtMinOutcome.Text = outcome.ToString();
                txtMinWith.Text = withdrawals.ToString();
                txtMinBal.Text = balance.ToString();
                txtMinVisitsCount.Text = visits_count.ToString();
                txtMinVisitsTotal.Text = visits_total.ToString();
                txtMinEncashCount.Text = encash_count.ToString();
                txtMinEncashTotal.Text = encash_total.ToString();
                txtMinRetVisitsCount.Text = ret_visits_count.ToString();
                txtMinRetVisitsTotal.Text = ret_visits_total.ToString();
                txtMinPayCount.Text = pay_count.ToString();
                txtMinPayTotal.Text = pay_total.ToString();
                txtMinWithCount.Text = with_count.ToString();
                txtMinWithTotal.Text = with_total.ToString();
            }
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Daily Summary Within Period";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbDailySummary');", true);
        }
    }

    private void DailySummaryDetailsPeriod(string date_from, string date_to)
    {
          
        if (language == "ar")
        {
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_summary_det_period_ar.rpt"));
        }
        else
            rptDocument.Load(Server.MapPath("~/rpt/4_daily_summary_det_period_en.rpt"));
        
        
        using (DataTable dt = Transactions_ud.rptDailySummaryDetailsWithinPeriod(date_from, date_to))
        {
            TextObject txtUser = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtUser"];
            txtUser.Text = user.user_name;
            TextObject txtDateFrom = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDateFrom"];
            txtDateFrom.Text = date_from;
            TextObject txtDateTo = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtDateTo"];
            txtDateTo.Text = date_to;
            TextObject txtRecordsCount = (TextObject)rptDocument.ReportDefinition.Sections["Section2"].ReportObjects["txtRecordsCount"];
            txtRecordsCount.Text = dt.Rows.Count.ToString();
            if (dt.Rows.Count > 0)
            {
                // minimum value <> 0
                decimal visits_count = Convert.ToDecimal(dt.Rows[0]["visits_count"]);
                decimal visits_total = Convert.ToDecimal(dt.Rows[0]["visits_total"]);
                decimal encash_comp_count = Convert.ToDecimal(dt.Rows[0]["encash_comp_count"]);
                decimal encash_comp_total = Convert.ToDecimal(dt.Rows[0]["encash_comp_total"]);
                decimal encash_pat_count = Convert.ToDecimal(dt.Rows[0]["encash_pat_count"]);
                decimal encash_pat_total = Convert.ToDecimal(dt.Rows[0]["encash_pat_total"]);
                decimal ret_visits_count = Convert.ToDecimal(dt.Rows[0]["ret_visits_count"]);
                decimal ret_visits_total = Convert.ToDecimal(dt.Rows[0]["ret_visits_total"]);
                decimal pay_comp_count = Convert.ToDecimal(dt.Rows[0]["pay_comp_count"]);
                decimal pay_comp_total = Convert.ToDecimal(dt.Rows[0]["pay_comp_total"]);
                decimal pay_pat_count = Convert.ToDecimal(dt.Rows[0]["pay_pat_count"]);
                decimal pay_pat_total = Convert.ToDecimal(dt.Rows[0]["pay_pat_total"]);
                decimal pay_exp_count = Convert.ToDecimal(dt.Rows[0]["pay_exp_count"]);
                decimal pay_exp_total = Convert.ToDecimal(dt.Rows[0]["pay_exp_total"]);
                decimal with_count = Convert.ToDecimal(dt.Rows[0]["with_count"]);
                decimal with_total = Convert.ToDecimal(dt.Rows[0]["with_total"]);

                for (int i = 1; i < dt.Rows.Count; i++)
                {
                    if ((visits_count == 0) || (visits_count > Convert.ToDecimal(dt.Rows[i]["visits_count"]) && Convert.ToDecimal(dt.Rows[i]["visits_count"]) != 0))
                    {
                        visits_count = Convert.ToDecimal(dt.Rows[i]["visits_count"]);
                    }
                    if ((visits_total == 0) || (visits_total > Convert.ToDecimal(dt.Rows[i]["visits_total"]) && Convert.ToDecimal(dt.Rows[i]["visits_total"]) != 0))
                    {
                        visits_total = Convert.ToDecimal(dt.Rows[i]["visits_total"]);
                    }
                    if ((encash_comp_count == 0) || (encash_comp_count > Convert.ToDecimal(dt.Rows[i]["encash_comp_count"]) && Convert.ToDecimal(dt.Rows[i]["encash_comp_count"]) != 0))
                    {
                        encash_comp_count = Convert.ToDecimal(dt.Rows[i]["encash_comp_count"]);
                    }
                    if ((encash_comp_total == 0) || (encash_comp_total > Convert.ToDecimal(dt.Rows[i]["encash_comp_total"]) && Convert.ToDecimal(dt.Rows[i]["encash_comp_total"]) != 0))
                    {
                        encash_comp_total = Convert.ToDecimal(dt.Rows[i]["encash_comp_total"]);
                    }
                    if ((encash_pat_count == 0) || (encash_pat_count > Convert.ToDecimal(dt.Rows[i]["encash_pat_count"]) && Convert.ToDecimal(dt.Rows[i]["encash_pat_count"]) != 0))
                    {
                        encash_pat_count = Convert.ToDecimal(dt.Rows[i]["encash_pat_count"]);
                    }
                    if ((encash_pat_total == 0) || (encash_pat_total > Convert.ToDecimal(dt.Rows[i]["encash_pat_total"]) && Convert.ToDecimal(dt.Rows[i]["encash_pat_total"]) != 0))
                    {
                        encash_pat_total = Convert.ToDecimal(dt.Rows[i]["encash_pat_total"]);
                    }
                    if ((ret_visits_count == 0) || (ret_visits_count > Convert.ToDecimal(dt.Rows[i]["ret_visits_count"]) && Convert.ToDecimal(dt.Rows[i]["ret_visits_count"]) != 0))
                    {
                        ret_visits_count = Convert.ToDecimal(dt.Rows[i]["ret_visits_count"]);
                    }
                    if ((ret_visits_total == 0) || (ret_visits_total > Convert.ToDecimal(dt.Rows[i]["ret_visits_total"]) && Convert.ToDecimal(dt.Rows[i]["ret_visits_total"]) != 0))
                    {
                        ret_visits_total = Convert.ToDecimal(dt.Rows[i]["ret_visits_total"]);
                    }
                    if ((pay_comp_count == 0) || (pay_comp_count > Convert.ToDecimal(dt.Rows[i]["pay_comp_count"]) && Convert.ToDecimal(dt.Rows[i]["pay_comp_count"]) != 0))
                    {
                        pay_comp_count = Convert.ToDecimal(dt.Rows[i]["pay_comp_count"]);
                    }
                    if ((pay_comp_total == 0) || (with_count > Convert.ToDecimal(dt.Rows[i]["pay_comp_total"]) && Convert.ToDecimal(dt.Rows[i]["pay_comp_total"]) != 0))
                    {
                        pay_comp_total = Convert.ToDecimal(dt.Rows[i]["pay_comp_total"]);
                    }
                    if ((pay_pat_count == 0) || (with_total > Convert.ToDecimal(dt.Rows[i]["pay_pat_count"]) && Convert.ToDecimal(dt.Rows[i]["pay_pat_count"]) != 0))
                    {
                        pay_pat_count = Convert.ToDecimal(dt.Rows[i]["pay_pat_count"]);
                    }
                    if ((pay_pat_total == 0) || (with_count > Convert.ToDecimal(dt.Rows[i]["pay_pat_total"]) && Convert.ToDecimal(dt.Rows[i]["pay_pat_total"]) != 0))
                    {
                        pay_pat_total = Convert.ToDecimal(dt.Rows[i]["pay_pat_total"]);
                    }
                    if ((pay_exp_count == 0) || (with_total > Convert.ToDecimal(dt.Rows[i]["pay_exp_count"]) && Convert.ToDecimal(dt.Rows[i]["pay_exp_count"]) != 0))
                    {
                        pay_exp_count = Convert.ToDecimal(dt.Rows[i]["pay_exp_count"]);
                    }
                    if ((pay_exp_total == 0) || (with_count > Convert.ToDecimal(dt.Rows[i]["pay_exp_total"]) && Convert.ToDecimal(dt.Rows[i]["pay_exp_total"]) != 0))
                    {
                        pay_exp_total = Convert.ToDecimal(dt.Rows[i]["pay_exp_total"]);
                    }
                    if ((with_count == 0) || (with_count > Convert.ToDecimal(dt.Rows[i]["with_count"]) && Convert.ToDecimal(dt.Rows[i]["with_count"]) != 0))
                    {
                        with_count = Convert.ToDecimal(dt.Rows[i]["with_count"]);
                    }
                    if ((with_total == 0) || (with_total > Convert.ToDecimal(dt.Rows[i]["with_total"]) && Convert.ToDecimal(dt.Rows[i]["with_total"]) != 0))
                    {
                        with_total = Convert.ToDecimal(dt.Rows[i]["with_total"]);
                    }
                }

                TextObject txtMinVisitsCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinVisitsCount"];
                TextObject txtMinVisitsTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinVisitsTotal"];
                TextObject txtMinEncashCompCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinEncashCompCount"];
                TextObject txtMinEncashCompTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinEncashCompTotal"];
                TextObject txtMinEncashPatCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinEncashPatCount"];
                TextObject txtMinEncashPatTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinEncashPatTotal"];
                TextObject txtMinRetVisitsCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinRetVisitsCount"];
                TextObject txtMinRetVisitsTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinRetVisitsTotal"];
                TextObject txtMinPayCompCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinPayCompCount"];
                TextObject txtMinPayCompTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinPayCompTotal"];
                TextObject txtMinPayPatCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinPayPatCount"];
                TextObject txtMinPayPatTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinPayPatTotal"];
                TextObject txtMinPayExpCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinPayExpCount"];
                TextObject txtMinPayExpTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinPayExpTotal"];
                TextObject txtMinWithCount = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinWithCount"];
                TextObject txtMinWithTotal = (TextObject)rptDocument.ReportDefinition.Sections["Section4"].ReportObjects["txtMinWithTotal"];

                txtMinVisitsCount.Text = visits_count.ToString();
                txtMinVisitsTotal.Text = visits_total.ToString();
                txtMinEncashCompCount.Text = encash_comp_count.ToString();
                txtMinEncashCompTotal.Text = encash_comp_total.ToString();
                txtMinEncashPatCount.Text = encash_pat_count.ToString();
                txtMinEncashPatTotal.Text = encash_pat_total.ToString();
                txtMinRetVisitsCount.Text = ret_visits_count.ToString();
                txtMinRetVisitsTotal.Text = ret_visits_total.ToString();
                txtMinPayCompCount.Text = pay_comp_count.ToString();
                txtMinPayCompTotal.Text = pay_comp_total.ToString();
                txtMinPayPatCount.Text = pay_pat_count.ToString();
                txtMinPayPatTotal.Text = pay_pat_total.ToString();
                txtMinPayExpCount.Text = pay_exp_count.ToString();
                txtMinPayExpTotal.Text = pay_exp_total.ToString();
                txtMinWithCount.Text = with_count.ToString();
                txtMinWithTotal.Text = with_total.ToString();
            }
            rptDocument.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
            rptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4;
            rptDocument.SetDataSource(dt);
            this.Title = "Daily Detail Within Period";
            crv.ReportSource = rptDocument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "MakeActive('ucfinancialReports_lbDailyDetail');", true);
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