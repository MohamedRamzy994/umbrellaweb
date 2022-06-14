using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using AjaxControlToolkit;
using System.Web.Script.Serialization;

public partial class GeneralClinic : BasePage
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
                lblUserName.Text = user.user_name;
                // Bind DropDownList Of waiting List
                // flag set to False means that its the first time i bind drpWaitingList 
                BindDrpWaitingList(false);
                // Bind Diagnosis_ud ListBox
                BindDiagnosis_udListBox();
                // Bind Requests ListBox
                BindRequestsListBox();
                // Bind Doses_ud DropDownList
                BindDoses_udDropDownList();
                // Bind Medicines_ud GridView
                BindMedicines_udGridView();
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
                            lblUserName.Text = user.user_name;
                            // Bind DropDownList Of waiting List
                            // flag set to False means that its the first time i bind drpWaitingList 
                            BindDrpWaitingList(false);
                            // Bind Diagnosis_ud ListBox
                            BindDiagnosis_udListBox();
                            // Bind Requests ListBox
                            BindRequestsListBox();
                            // Bind Doses_ud DropDownList
                            BindDoses_udDropDownList();
                            // Bind Medicines_ud GridView
                            BindMedicines_udGridView();
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

    #region Patients_ud Information Tab wl

    protected void BindDrpWaitingList(bool flag)
    {
        try
        {
            // count: used to store cuurent count of Patients_ud in the waiting list
            int count = Convert.ToInt32(hfPatCount.Value);
            using (DataTable dt = Pat_Visits_ud.SelectWaitingListClinic_ud(DateTime.Now.ToString("dd/MM/yyyy")))
            {
                // hfPatCount (Hidden field) : used to store new count of Patients_ud in the waiting list
                hfPatCount.Value = dt.Rows.Count.ToString();
                drpWaitingList.Items.Clear();
                WorkParams_ud.BindDropDownList(drpWaitingList, dt, "pat_name", "pat_id", new string[] { "Select a Patient", "0" });

                drpWaitingList.SelectedValue = hfWlSelected.Value;

                if (flag)
                {
                    // check if a new Patients_ud been added to the waiting list
                    if (dt.Rows.Count > count)
                    {
                        // c: used to khonw count of new Patients_ud that will be added to the waiting list
                        int c = dt.Rows.Count - count;
                        //WlPatNew() : this javascropt method that show the notification if a new Patients_ud added to the waiting list
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "WlPatNew('" + c + "')", true);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void BindPatients_udInfo()
    {
        try
        {
            int pat_id = Convert.ToInt32(hfPatId.Value);
            Patients_ud pat = Patients_ud.SelectByID(pat_id);
            txtPatId.Value = pat.pat_id.ToString();
            txtPatName.Text = pat.pat_name;
            txtPatAge.Value = pat.pat_age;
            drpPatGender.Value = pat.pat_gender;
            drpPatMarital.Value = pat.marital_id.ToString();
            drpPatBlood.Value = pat.blood_id.ToString();
            drpPatSmoker.Value = pat.pat_smoker.ToString();
            drpPatDm.Value = pat.pat_dm.ToString();
            drpPatHtn.Value = pat.pat_htn.ToString();

            // 
            if (drpWaitingList.Items.Contains(new ListItem(pat.pat_name, hfPatId.Value)))
            {
                drpWaitingList.SelectedValue = hfPatId.Value;
                hfWlSelected.Value = hfPatId.Value;
            }
            else
            {
                drpWaitingList.SelectedIndex = 0;
            }
            // Bind Patients_ud Visits GridView
            BindPatientsVisitsGridView(pat_id);
            // Bind Family History GridView
            BindFamilyHistoryGridView();
            // Bind Chronic Diseases GridView
            BindChronicDiseasesGridView();
            // Bind Drugs GridView
            BindDrugsGridView();
            // Bind Surgeries GridView
            BindSurgeriesGridView();
            // Bind Transfusion GridView
            BindTransfusionGridView();
            // Bind Hospital GridView()
            BindHospitalGridView();
            // Bind Images GridView
            BindImagesGridView();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void drpWaitingList_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Clear HiddenFileds of Patient Visits & Prescritpions
        hfVisitId.Value = "";
        hfVisitFinish.Value = "";
        hfVisitDelete.Value = "";
        hfPresciptionDetId.Value = "";
        hfPrescriptionMedId.Value = "";
        // make sure that the user select a patient
        if (drpWaitingList.SelectedIndex != 0)
        {
            try
            {

                // hfPatId (hidden field) : used to store the current selected pat_id either when user select a pateint from waiting list
                // or when the user select a patient from the search window
                hfPatId.Value = drpWaitingList.SelectedValue;
                // hfWlSelected (hidden Field) : used to store current selected value of drpWaitingList
                // that means the pat_id selected by the user
                // the problem is when bind drpWaitingList , the selected index will be set to 0
                // and i want to keep the selected value (pat_id) after bind drpWaitingList
                hfWlSelected.Value = drpWaitingList.SelectedValue;
                //Bind Patient Information
                BindPatients_udInfo();
                // Clear gvPrecription (GridView)
                gvPrescription.DataSource = null;
                gvPrescription.DataBind();
                upPrescription.Update();
                // Clear all data from tabs
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ClearFamilytbl();ClearChronictbl();ClearDrugtbl();ClearSurgerytbl();ClearTransfusiontbl(); ClearHospitaltbl();ClearImagetbl();ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
        else
        {
            hfWlSelected.Value = "0";
            //  ClearPatient Information
            ClearPatients_udInfo();
        }
    }

    protected void ClearPatients_udInfo()
    {
        try
        {
            hfPatId.Value = "";
            // Clear all gridviews
            WorkParams_ud.ClearGridView(new GridView[]
            {
                gvPatientsVisits,
                gvFamily,
                gvChronic,
                gvDrug,
                gvSurgery,
                gvTransfusion,
                gvHospital,
                gvImage,
                gvPrescription
            });
            // Update all update panels
            WorkParams_ud.UpdatePanels(new UpdatePanel[]
            {
                upPatientsVisits,
                upFamilyHistory,
                upChronicDiseases,
                upDrug,
                upSurgery,
                upTransfusion,
                upHospital,
                upImage,
                upPrescription
            });

            // Clear all data from tabs
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#Patients_udtbl').fClear();ClearFamilytbl();ClearChronictbl();ClearDrugtbl();ClearSurgerytbl();ClearTransfusiontbl(); ClearHospitaltbl();ClearImagetbl();ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnWlRefresh_Click(object sender, EventArgs e)
    {
        // flag set to True means that there is a possibility that new Patients_ud will be added to the waiting list
        BindDrpWaitingList(true);
    }

    protected void btnLoadPatInfo_Click(object sender, EventArgs e)
    {
        try
        {
            // this button is fired when the user select a patient from Search Patients_ud tab
            // Clear HiddenFileds of Patient Visits & Prescritpions
            hfWlSelected.Value = "0";
            hfVisitId.Value = "";
            hfVisitFinish.Value = "";
            hfVisitDelete.Value = "";
            hfPresciptionDetId.Value = "";
            hfPrescriptionMedId.Value = "";
            //Bind Patient Information
            BindPatients_udInfo();
            // Clear gvPrecription (GridView)
            gvPrescription.DataSource = null;
            gvPrescription.DataBind();
            upPrescription.Update();
            // Clear all data from tabs
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ClearFamilytbl();ClearChronictbl();ClearDrugtbl();ClearSurgerytbl();ClearTransfusiontbl(); ClearHospitaltbl();ClearImagetbl();ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    #endregion

    #region Patients_ud Visits Tab 1
    protected void BindPatientsVisitsGridView(int pat_id)
    {
        try
        {
            // bind Patients_ud Visits GridView
            WorkParams_ud.BindGridView(gvPatientsVisits, Pat_Visits_ud.GetPatientsVisits(pat_id));
            upPatientsVisits.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnVisitView_Click(object sender, EventArgs e)
    {
        try
        {
            // make sure that the user already select a patient
            if (hfPatId.Value != "")
            {
                // make sure that the user already select a visit to delete
                if (hfVisitId.Value != "")
                {
                    int visit_id = Convert.ToInt32(hfVisitId.Value);
                    // Bind Patient VitalSigns
                    BindPatientVitalSigns(visit_id);
                    // Bind Patient Complaints
                    BindPatientComplaints(visit_id);
                    // Bind Patient Diagnosis_ud
                    BindPatientDiagnosis_ud(visit_id);
                    // update upComplaintDiagnosis_ud (update Panel) 
                    // as there are in the same update panel i call the update method here
                    upComplaintDiagnosis_ud.Update();
                    // Bind Patient Requests (Blood Tests & Scans)
                    BindPatientRequests(visit_id);
                    // Bind Patient Prescription()
                    BindPatientPrescription(visit_id);
                }
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnVisitFinish_Click(object sender, EventArgs e)
    {
        try
        {
            // make sure that the user already select a patient
            if (hfPatId.Value != "")
            {
                int pat_id = Convert.ToInt32(hfPatId.Value);
                // make sure that the user already select a visit to delete
                if (hfVisitId.Value != "")
                {
                    // make sure that the selected visit can be finished
                    if (hfVisitFinish.Value != "")
                    {
                        int status = Pat_Visits_ud.FinishVisit(Convert.ToInt32(hfVisitId.Value), user.user_id);
                        if (status == 4)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Visit has been finished successfully');ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
                        }
                        else if (status == 5)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' This visit already finished');ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
                        }
                        else if (status == 9)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' This visit cannot be finished');ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
                    }
                    BindPatientsVisitsGridView(pat_id);
                    ClearCurrentVisitData();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    protected void btnVisitDelete_Click(object sender, EventArgs e)
    {
        try
        {
            // make sure that the user already select a patient
            if (hfPatId.Value != "")
            {
                int pat_id = Convert.ToInt32(hfPatId.Value);
                // make sure that the user already select a visit to delete
                if (hfVisitId.Value != "")
                {
                    // make sure that the selected visit can be deleted
                    if (hfVisitDelete.Value != "")
                    {
                        string status = Pat_Visits_ud.DeleteVisit(Convert.ToInt32(hfVisitId.Value), user.user_id);
                        if (status != "")
                        {
                            string[] arr = status.Split(',');
                            if (arr[0] == "4")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Visit has been deleted successfully');ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
                            }
                            else if (arr[0] == "5")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' This visit cannot be deleted');ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
                            }
                            else if (arr[0] == "9")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
                            }
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' This visit cannot be deleted');ClearVitaltbl();ClearComplaintDiagnosis_udtbl();ClearRequesttbl();ClearPrescriptiontbl();", true);
                    }
                    BindPatientsVisitsGridView(pat_id);
                    ClearCurrentVisitData();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void ClearCurrentVisitData()
    {
        try
        {
            hfWlSelected.Value = "0";
            hfVisitId.Value = "";
            hfVisitDelete.Value = "";
            hfVisitFinish.Value = "";
            hfPresciptionDetId.Value = "";
            hfPrescriptionMedId.Value = "";
            gvPrescription.DataSource = null;
            gvPrescription.DataBind();
            upPrescription.Update();
            BindDrpWaitingList(true);
            upPatients_udInfo.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    #endregion

    #region Search Patients_ud
    protected void BindPatients_udGridView()
    {
        try
        {
            // Bind Patients_ud GridView according to attributes of search
            WorkParams_ud.BindGridView(gvPatients_ud, Patients_ud.Patients_udSearch(drpSearchgvPatients_udCol.Value, txtSearchgvPatients_ud.Value.Trim(), drpSearchgvPatients_udGender.Value, drpSearchgvPatients_udStatus.Value));
        }
        catch (Exception ex)
        {
            // view the error messgae in the div with id : divGeneral
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
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
            string str = string.Format("{0}{1}{2}", "$('#divSearch').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    #endregion

    #region Vital Signs Tap 4

    protected void BindPatientVitalSigns(int visit_id)
    {
        try
        {
            using (DataTable dt = Pat_Vital_Signs_ud.SelectVitalSigns(visit_id))
            {
                if (dt.Rows.Count > 0)
                {
                    txtVitalWeight.Value = dt.Rows[0]["vital_weight"].ToString();
                    txtVitalHeight.Value = dt.Rows[0]["vital_height"].ToString();
                    txtVitalTemp.Value = dt.Rows[0]["vital_temp"].ToString();
                    txtVitalPulse.Value = dt.Rows[0]["vital_pulse"].ToString();
                    txtVitalRespiratory.Value = dt.Rows[0]["vital_respiratory"].ToString();
                    txtVitalBlood.Value = dt.Rows[0]["vital_blood"].ToString();
                    drpVitalPupil.Value = dt.Rows[0]["vital_pupil"].ToString();
                    drpVitalSkin.Value = dt.Rows[0]["vital_skin"].ToString();
                    txtVitalNotes.Value = dt.Rows[0]["vital_notes"].ToString();
                    upVitslSigns.Update();
                }
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }


    protected void btnVitalSave_Click(object sender, EventArgs e)
    {
        try
        {
            // make sure that the user select a patient
            if (hfPatId.Value != "")
            {
                // make sure that the user select a visit
                if (hfVisitId.Value != "")
                {
                    // get the data from the user and make changes in Pat_Vital_Signs_ud table
                    if (Pat_Vital_Signs_ud.SaveVitalSigns(new Pat_Vital_Signs_ud
                    {
                        pat_visit_id = Convert.ToInt32(hfVisitId.Value),
                        vital_weight = txtVitalWeight.Value.Trim(),
                        vital_height = txtVitalHeight.Value.Trim(),
                        vital_temp = txtVitalTemp.Value.Trim(),
                        vital_pulse = txtVitalPulse.Value.Trim(),
                        vital_respiratory = txtVitalRespiratory.Value.Trim(),
                        vital_blood = txtVitalBlood.Value.Trim(),
                        vital_pupil = drpVitalPupil.Value,
                        vital_skin = drpVitalSkin.Value,
                        vital_notes = txtVitalNotes.Value.Trim()
                    }) == 4)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');UpdateVisitStatus();", true);
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    #endregion

    #region Complaints & Diagnosis_ud Tap 5

    protected void BindDiagnosis_udListBox()
    {
        try
        {
            // bind Diagnosis_ud list box with active Diagnosis_ud only
            WorkParams_ud.BindListBoxs(lbDiagnosis_ud, Diagnosis_ud.SelectAll(1), "Diagnosis_ud_name", "Diagnosis_ud_id");
        }
        catch (Exception ex)
        {
            // show the error in divGeneral not divGeneral 
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    protected void BindPatientComplaints(int visit_id)
    {
        try
        {
            using (DataTable dt = Pat_Complaints_ud.SelectPatientComplaint(visit_id))
            {
                if (dt.Rows.Count > 0)
                {
                    txtComplaintName.Value = dt.Rows[0]["pat_complaint_name"].ToString();
                    txtComplaintNote.Value = dt.Rows[0]["pat_complaint_note"].ToString();
                }
            }
        }
        catch (Exception ex)
        {
            // show the error in divGeneral not divGeneral 
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void BindPatientDiagnosis_ud(int visit_id)
    {
        try
        {
            // get the Diagnosis_ud in the selected visit
            using (DataTable dt = Pat_Diagnosis_ud.SelectPatientDiagnosis_ud(visit_id))
            {
                // make sure that the dt has rows
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        string Diagnosis_ud_name = row["Diagnosis_ud_name"].ToString();
                        string Diagnosis_ud_id = row["Diagnosis_ud_id"].ToString();

                        // make sure that the Diagnosis_ud already exist in lbDiagnosis_ud (ListBox)
                        // because there is possibility that the admin set a Diagnosis_ud to inactive
                        // and i'm binding  lbDiagnosis_ud (ListBox) with active Diagnosis_ud only
                        if (lbDiagnosis_ud.Items.Contains(new ListItem(Diagnosis_ud_name, Diagnosis_ud_id)))
                        {
                            lbDiagnosis_ud.Items.FindByValue(Diagnosis_ud_id).Selected = true;
                        }
                        else
                        {
                            // that means that this Diagnosis_ud is already inactive
                            // so i have to add it to lbDiagnosis_ud
                            lbDiagnosis_ud.Items.Add(new ListItem(Diagnosis_ud_name, Diagnosis_ud_id));
                            lbDiagnosis_ud.Items.FindByValue(Diagnosis_ud_id).Selected = true;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    protected void btnComplaintDiagnosis_udSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                // make sure that the user select a patient
                if (hfPatId.Value != "")
                {
                    // make sure that the user select a visit
                    if (hfVisitId.Value != "")
                    {
                        // get data from user and make changes in Pat_Complaints_ud table and pat_Diagnosis_ud table
                        // get the selected Diagnosis_ud by the user
                        string Diagnosis_ud_id = "";
                        foreach (ListItem item in lbDiagnosis_ud.Items)
                        {
                            if (item.Selected)
                                Diagnosis_ud_id += item.Value + ",";
                        }
                        if (Pat_Diagnosis_ud.SaveComplaintsDiagnosis_ud
                            (
                            Convert.ToInt32(hfVisitId.Value),
                            txtComplaintName.Value.Trim(),
                            txtComplaintNote.Value.Trim(),
                            Diagnosis_ud_id
                            ) == 4)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');UpdateVisitStatus();", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    #endregion

    #region Prescription Tap 6

    protected void BindDoses_udDropDownList()
    {
        try
        {
            WorkParams_ud.BindDropDownList(drpPrescriptonDose, Doses_ud.SelectAll(1), "dose_name", "dose_id", null);
        }
        catch (Exception ex)
        {
            // show error message in divGeneral not divGeneral
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    protected void BindMedicines_udGridView()
    {
        try
        {
            WorkParams_ud.BindGridView(gvMedicines_ud, Medicines_ud.SearchMedicines_ud(txtSrchgvMedicines_ud.Value.Trim(), "1", drpSrchgvMedicines_udCommon.Value));
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void gvMedicines_ud_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        // Bind Medicines_ud GridView according to attributes of search and selected page index
        gvMedicines_ud.PageIndex = e.NewPageIndex;
        BindMedicines_udGridView();
    }
    protected void btnMedicines_udSrch_Click(object sender, EventArgs e)
    {
        BindMedicines_udGridView();
    }

    protected void BindPatientPrescription(int visit_id)
    {
        try
        {
            WorkParams_ud.BindGridView(gvPrescription, Pat_Prescriptions_ud.SelectVisitPrescription(visit_id));
            upPrescription.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnPrescriptionSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (hfVisitId.Value != "")
                {
                    int visit_id = Convert.ToInt32(hfVisitId.Value);
                    int status = Pat_Prescriptions_ud.InsertMedicines_ud(new Pat_Prescriptions_ud()
                    {
                        pat_visit_id = visit_id,
                        medicine_id = Convert.ToInt32(hfPrescriptionMedId.Value),
                        dose_id = Convert.ToInt32(drpPrescriptonDose.Value),
                        note = txtPrescriptionNote.Value.Trim()
                    });
                    if (status == 4)
                    {
                        BindPatientPrescription(visit_id);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');ClearPrescriptiontbl();UpdateVisitStatus();", true);
                    }
                    else if (status == 5)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' This medicine already exists in the current prescription');ClearPrescriptiontbl();", true);
                    }
                    else if (status == 9)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearPrescriptiontbl();", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');ClearPrescriptiontbl();", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');ClearPrescriptiontbl();", true);
            }

        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnPrescriptionUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (hfVisitId.Value != "")
                {
                    if (hfPresciptionDetId.Value != "" && hfPrescriptionMedId.Value != "")
                    {
                        int status = Pat_Prescriptions_ud.UpdateMedicines_ud(new Pat_Prescriptions_ud()
                        {
                            pat_prescription_det_id = Convert.ToInt32(hfPresciptionDetId.Value),
                            medicine_id = Convert.ToInt32(hfPrescriptionMedId.Value),
                            dose_id = Convert.ToInt32(drpPrescriptonDose.Value),
                            note = txtPrescriptionNote.Value.Trim()
                        });
                        if (status == 4)
                        {
                            BindPatientPrescription(Convert.ToInt32(hfVisitId.Value));
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been updated successfully');ClearPrescriptiontbl();", true);
                        }
                        else if (status == 5)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' This medicine already exists in the current prescription');ClearPrescriptiontbl();", true);
                        }
                        else if (status == 9)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearPrescriptiontbl();", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');ClearPrescriptiontbl();", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');ClearPrescriptiontbl();", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnPrescriptionDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (hfVisitId.Value != "")
                {
                    if (hfPresciptionDetId.Value != "")
                    {
                        if (Pat_Prescriptions_ud.DeleteMedicine(Convert.ToInt32(hfPresciptionDetId.Value)) == 4)
                        {
                            BindPatientPrescription(Convert.ToInt32(hfVisitId.Value));
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been deleted successfully');ClearPrescriptiontbl();", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearPrescriptiontbl();", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');ClearPrescriptiontbl();", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');ClearPrescriptiontbl();", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnPrescriptionPrint_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (hfVisitId.Value != "")
                {
                    Session["data"] = "prescription," + hfVisitId.Value;
                    WorkParams_ud.RedirectToNewTap(this, "~/ReportView.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');ClearPrescriptiontbl();", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');ClearPrescriptiontbl();", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    #endregion

    #region Requests Tab 7

    protected void BindRequestsListBox()
    {
        try
        {
            // Bind Blood Tests ListBox with active tests only
            WorkParams_ud.BindListBoxs(lbRequestBlood, Tests.SelectAll("b", 1), "test_name", "test_id");
            // Bind Scans ListBox with active tests only
            WorkParams_ud.BindListBoxs(lbRequestScan, Tests.SelectAll("s", 1), "test_name", "test_id");
        }
        catch (Exception ex)
        {
            // show error message in divGeneral not divGeneral
            string str = string.Format("{0}{1}{2}", "$('#tdivGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void BindPatientRequests(int visit_id)
    {
        try
        {
            // get the Diagnosis_ud in the selected visit
            using (DataSet ds = Pat_Requests_ud.SelectRequests(visit_id))
            {
                // make sure that the dt[0] has rows
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        string test_id = row["test_id"].ToString();
                        string test_name = row["test_name"].ToString();
                        // make sure that the test already exist in lbRequestBlood (ListBox)
                        // because there is possibility that the admin set a Diagnosis_ud to inactive
                        // and i'm binding  lbRequestBlood (ListBox) with active tests only
                        if (lbRequestBlood.Items.Contains(new ListItem(test_name, test_id)))
                        {
                            lbRequestBlood.Items.FindByValue(test_id).Selected = true;
                        }
                        else
                        {
                            // that means that this test is already inactive
                            // so i have to add it to lbRequestBlood
                            lbRequestBlood.Items.Add(new ListItem(test_name, test_id));
                            lbRequestBlood.Items.FindByValue(test_id).Selected = true;
                        }
                    }
                }
                // make sure that the dt[1] has rows
                if (ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[1].Rows)
                    {
                        string test_id = row["test_id"].ToString();
                        string test_name = row["test_name"].ToString();
                        // make sure that the test already exist in lbRequestScan (ListBox)
                        // because there is possibility that the admin set a Diagnosis_ud to inactive
                        // and i'm binding  lbRequestScan (ListBox) with active tests only
                        if (lbRequestScan.Items.Contains(new ListItem(test_name, test_id)))
                        {
                            lbRequestScan.Items.FindByValue(test_id).Selected = true;
                        }
                        else
                        {
                            // that means that this test is already inactive
                            // so i have to add it to lbRequestScan
                            lbRequestScan.Items.Add(new ListItem(test_name, test_id));
                            lbRequestScan.Items.FindByValue(test_id).Selected = true;
                        }
                    }
                }
                // update upRequests (Update Panel)
                upRequests.Update();
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#tdivGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }
    protected void btnRequestBloodSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                // make sure that the user select a patient
                if (hfPatId.Value != "")
                {
                    // make sure that the user select a visit
                    if (hfVisitId.Value != "")
                    {
                        // get data from user and make changes in Pat_Requests_ud table and Pat_Requests_ud_det table
                        // get the selected blood tests by the user
                        string test_id = "";
                        foreach (ListItem item in lbRequestBlood.Items)
                        {
                            if (item.Selected)
                                test_id += item.Value + ",";
                        }
                        if (Pat_Requests_ud.SaveRequests(Convert.ToInt32(hfVisitId.Value), test_id, "b") == 4)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');UpdateVisitStatus();", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    protected void btnRequestScanSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                // make sure that the user select a patient
                if (hfPatId.Value != "")
                {
                    // make sure that the user select a visit
                    if (hfVisitId.Value != "")
                    {
                        // get data from user and make changes in Pat_Requests_ud table and Pat_Requests_ud_det table
                        // get the selected scans by the user
                        string test_id = "";
                        foreach (ListItem item in lbRequestScan.Items)
                        {
                            if (item.Selected)
                                test_id += item.Value + ",";
                        }
                        if (Pat_Requests_ud.SaveRequests(Convert.ToInt32(hfVisitId.Value), test_id, "s") == 4)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');UpdateVisitStatus();", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a visit first');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    #endregion

    #region Fammily History Tab 8

    protected void BindFamilyHistoryGridView()
    {
        try
        {
            // Bind Family History GridView
            WorkParams_ud.BindGridView(gvFamily, Pat_Family_History_ud.SelectAll(Convert.ToInt32(hfPatId.Value)));
            upFamilyHistory.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnFamilySave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    // get the data from user and insert into Pat_Family_History_ud table
                    // if the returned value is equal to '4' that means successful operation
                    if (Pat_Family_History_ud.Insert(new Pat_Family_History_ud
                    {
                        pat_id = Convert.ToInt32(hfPatId.Value),
                        relationship = Convert.ToInt16(drpFamilyRelationship.Value),
                        pat_family_disease_name = txtFamilyDiseaseName.Value.Trim()
                    }) == 4)
                    {
                        BindFamilyHistoryGridView();
                        // Show the success message in the div with id: divGeneral and call method ClearFamilytbl();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');ClearFamilytbl();", true);
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    protected void btnFamilyUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    if (txtFamilyId.Value.Trim() != "")
                    {

                        // get data from user and update Pat_Family_History_ud table
                        // if the returned value is equal to '4' that means successful operation
                        if (Pat_Family_History_ud.Update(new Pat_Family_History_ud
                        {
                            pat_family_id = Convert.ToInt32(txtFamilyId.Value),
                            relationship = Convert.ToInt16(drpFamilyRelationship.Value),
                            pat_family_disease_name = txtFamilyDiseaseName.Value.Trim()
                        }) == 4)
                        {
                            BindFamilyHistoryGridView();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been updated successfully');ClearFamilytbl();", true);
                        }
                        else
                        {
                            //returned value is equal to '9' (!= 4) means that failed operation
                            // show the error message
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                // show the error message in the div with id: divGeneral
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }

        }
    }

    protected void btnFamilyDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (txtFamilyId.Value.Trim() != "")
                {
                    //if the returned value is equal to '4' that means successful operation
                    if (Pat_Family_History_ud.Delete(Convert.ToInt32(txtFamilyId.Value)) == 4)
                    {
                        BindFamilyHistoryGridView();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been deleted successfully');ClearFamilytbl();", true);
                    }
                    else
                    {
                        // returned value is equal to '9' (!= 4) means that failed operation
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearFamilytbl();", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    #endregion

    #region Chronic Diseases Tab 9

    protected void BindChronicDiseasesGridView()
    {
        try
        {
            // Bind Chronic Diseases GridView
            WorkParams_ud.BindGridView(gvChronic, Pat_Chronic_Diseases_ud.SelectAll(Convert.ToInt32(hfPatId.Value)));
            upChronicDiseases.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnChronicSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    // get the data from user and insert into Pat_Chronic_Diseases_ud table
                    // if the returned value is equal to '4' that means successful operation
                    if (Pat_Chronic_Diseases_ud.Insert(new Pat_Chronic_Diseases_ud
                    {
                        pat_id = Convert.ToInt32(hfPatId.Value),
                        pat_chronic_name = txtChronicName.Value.Trim()
                    }) == 4)
                    {
                        BindChronicDiseasesGridView();
                        // Show the success message in the div with id: divGeneral and call method ClearChronictbl();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');ClearChronictbl();", true);
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    protected void btnChronicUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    if (txtChronicId.Value.Trim() != "")
                    {
                        // get data from user and update Pat_Chronic_Diseases_ud table
                        // if the returned value is equal to '4' that means successful operation
                        if (Pat_Chronic_Diseases_ud.Update(new Pat_Chronic_Diseases_ud
                        {
                            pat_chronic_id = Convert.ToInt32(txtChronicId.Value),
                            pat_chronic_name = txtChronicName.Value.Trim()
                        }) == 4)
                        {
                            BindChronicDiseasesGridView();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been updated successfully');ClearChronictbl();", true);
                        }
                        else
                        {
                            //returned value is equal to '9' (!= 4) means that failed operation
                            // show the error message
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                // show the error message in the div with id: divGeneral
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }

    protected void btnChronicDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (txtChronicId.Value.Trim() != "")
                {
                    //if the returned value is equal to '4' that means successful operation
                    if (Pat_Chronic_Diseases_ud.Delete(Convert.ToInt32(txtChronicId.Value)) == 4)
                    {
                        BindChronicDiseasesGridView();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been deleted successfully');ClearChronictbl();", true);
                    }
                    else
                    {
                        // returned value is equal to '9' (!= 4) means that failed operation
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearChronictbl();", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    #endregion

    #region Drugs Tab 10

    protected void BindDrugsGridView()
    {
        try
        {
            // Bind Drugs GridView
            WorkParams_ud.BindGridView(gvDrug, Pat_Drugs_ud.SelectAll(Convert.ToInt32(hfPatId.Value)));
            upDrug.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnDrugSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    // get the data from user and insert into Pat_Drugs_ud table
                    // if the returned value is equal to '4' that means successful operation
                    if (Pat_Drugs_ud.Insert(new Pat_Drugs_ud
                    {
                        pat_id = Convert.ToInt32(hfPatId.Value),
                        pat_drug_name = txtDrugName.Value.Trim()
                    }) == 4)
                    {
                        BindDrugsGridView();
                        // Show the success message in the div with id: divGeneral and call method ClearDrugtbl();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');ClearDrugtbl();", true);
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    protected void btnDrugUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    if (txtDrugId.Value.Trim() != "")
                    {
                        // get data from user and update Pat_Drugs_ud table
                        // if the returned value is equal to '4' that means successful operation
                        if (Pat_Drugs_ud.Update(new Pat_Drugs_ud
                        {
                            pat_drug_id = Convert.ToInt32(txtDrugId.Value),
                            pat_drug_name = txtDrugName.Value.Trim()
                        }) == 4)
                        {
                            BindDrugsGridView();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been updated successfully');ClearDrugtbl();", true);
                        }
                        else
                        {
                            //returned value is equal to '9' (!= 4) means that failed operation
                            // show the error message
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                // show the error message in the div with id: divGeneral
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }

    protected void btnDrugDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (txtDrugId.Value.Trim() != "")
                {
                    //if the returned value is equal to '4' that means successful operation
                    if (Pat_Drugs_ud.Delete(Convert.ToInt32(txtDrugId.Value)) == 4)
                    {
                        BindDrugsGridView();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been deleted successfully');ClearDrugtbl();", true);
                    }
                    else
                    {
                        // returned value is equal to '9' (!= 4) means that failed operation
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearDrugtbl();", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    #endregion

    #region Surgeries Tab 11

    protected void BindSurgeriesGridView()
    {
        try
        {
            // Bind Surgeries GridView
            WorkParams_ud.BindGridView(gvSurgery, Pat_Surgeries_ud.SelectAll(Convert.ToInt32(hfPatId.Value)));
            upSurgery.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnSurgerySave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    // get the data from user and insert into Pat_Surgeries_ud table
                    // if the returned value is equal to '4' that means successful operation
                    if (Pat_Surgeries_ud.Insert(new Pat_Surgeries_ud
                    {
                        pat_id = Convert.ToInt32(hfPatId.Value),
                        pat_surgery_name = txtSurgeryName.Value.Trim(),
                        pat_surgery_date = txtSurgeryDate.Value
                    }) == 4)
                    {
                        BindSurgeriesGridView();
                        // Show the success message in the div with id: divGeneral and call method ClearSurgerytbl();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');ClearSurgerytbl();", true);
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    protected void btnSurgeryUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    if (txtSurgeryId.Value.Trim() != "")
                    {
                        // get data from user and update Pat_Surgeries_ud table
                        // if the returned value is equal to '4' that means successful operation
                        if (Pat_Surgeries_ud.Update(new Pat_Surgeries_ud
                        {
                            pat_surgery_id = Convert.ToInt32(txtSurgeryId.Value),
                            pat_surgery_name = txtSurgeryName.Value.Trim(),
                            pat_surgery_date = txtSurgeryDate.Value
                        }) == 4)
                        {
                            BindSurgeriesGridView();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been updated successfully');ClearSurgerytbl();", true);
                        }
                        else
                        {
                            //returned value is equal to '9' (!= 4) means that failed operation
                            // show the error message
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                // show the error message in the div with id: divGeneral
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }

    protected void btnSurgeryDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (txtSurgeryId.Value.Trim() != "")
                {
                    //if the returned value is equal to '4' that means successful operation
                    if (Pat_Surgeries_ud.Delete(Convert.ToInt32(txtSurgeryId.Value)) == 4)
                    {
                        BindSurgeriesGridView();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been deleted successfully');ClearSurgerytbl();", true);
                    }
                    else
                    {
                        // returned value is equal to '9' (!= 4) means that failed operation
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearSurgerytbl();", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    #endregion

    #region Transfusion Tab 12

    protected void BindTransfusionGridView()
    {
        try
        {
            // Bind Transfusion GridView
            WorkParams_ud.BindGridView(gvTransfusion, Pat_Transfusion_ud.SelectAll(Convert.ToInt32(hfPatId.Value)));
            upTransfusion.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnTransfusionSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    // get the data from user and insert into Pat_Transfusion_ud table
                    // if the returned value is equal to '4' that means successful operation
                    if (Pat_Transfusion_ud.Insert(new Pat_Transfusion_ud
                    {
                        pat_id = Convert.ToInt32(hfPatId.Value),
                        Pat_Transfusion_ud_date = txtTransfusionDate.Value
                    }) == 4)
                    {
                        BindTransfusionGridView();
                        // Show the success message in the div with id: divGeneral and call method ClearTransfusiontbl();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');ClearTransfusiontbl();", true);
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    protected void btnTransfusionUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    if (txtTransfusionId.Value.Trim() != "")
                    {
                        // get data from user and update Pat_Transfusion_ud table
                        // if the returned value is equal to '4' that means successful operation
                        if (Pat_Transfusion_ud.Update(new Pat_Transfusion_ud
                        {
                            Pat_Transfusion_ud_id = Convert.ToInt32(txtTransfusionId.Value),
                            Pat_Transfusion_ud_date = txtTransfusionDate.Value
                        }) == 4)
                        {
                            BindTransfusionGridView();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been updated successfully');ClearTransfusiontbl();", true);
                        }
                        else
                        {
                            //returned value is equal to '9' (!= 4) means that failed operation
                            // show the error message
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                // show the error message in the div with id: divGeneral
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }

    protected void btnTransfusionDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (txtTransfusionId.Value.Trim() != "")
                {
                    //if the returned value is equal to '4' that means successful operation
                    if (Pat_Transfusion_ud.Delete(Convert.ToInt32(txtTransfusionId.Value)) == 4)
                    {
                        BindTransfusionGridView();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been deleted successfully');ClearTransfusiontbl();", true);
                    }
                    else
                    {
                        // returned value is equal to '9' (!= 4) means that failed operation
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearTransfusiontbl();", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    #endregion

    #region Pat_Hospital_Admission_ud Tab 13

    protected void BindHospitalGridView()
    {
        try
        {
            // Bind Hospital GridView
            WorkParams_ud.BindGridView(gvHospital, Pat_Hospital_Admission_ud.SelectAll(Convert.ToInt32(hfPatId.Value)));
            upHospital.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void btnHospitalSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    // get the data from user and insert into Pat_Hospital_Admission_ud table
                    // if the returned value is equal to '4' that means successful operation
                    if (Pat_Hospital_Admission_ud.Insert(new Pat_Hospital_Admission_ud
                    {
                        pat_id = Convert.ToInt32(hfPatId.Value),
                        pat_hospital_reason = txtHospitalReason.Value.Trim()
                    }) == 4)
                    {
                        BindHospitalGridView();
                        // Show the success message in the div with id: divGeneral and call method ClearHospitaltbl();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');ClearHospitaltbl();", true);
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    protected void btnHospitalUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    if (txtHospitalId.Value.Trim() != "")
                    {
                        // get data from user and update Pat_Pat_Hospital_Admission_ud table
                        // if the returned value is equal to '4' that means successful operation
                        if (Pat_Hospital_Admission_ud.Update(new Pat_Hospital_Admission_ud
                        {
                            pat_hospital_id = Convert.ToInt32(txtHospitalId.Value),
                            pat_hospital_reason = txtHospitalReason.Value.Trim()
                        }) == 4)
                        {
                            BindHospitalGridView();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been updated successfully');ClearHospitaltbl();", true);
                        }
                        else
                        {
                            //returned value is equal to '9' (!= 4) means that failed operation
                            // show the error message
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
                }
            }
            catch (Exception ex)
            {
                // show the error message in the div with id: divGeneral
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }

    protected void btnHospitalDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (txtHospitalId.Value.Trim() != "")
                {
                    //if the returned value is equal to '4' that means successful operation
                    if (Pat_Hospital_Admission_ud.Delete(Convert.ToInt32(txtHospitalId.Value)) == 4)
                    {
                        BindHospitalGridView();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been deleted successfully');ClearHospitaltbl();", true);
                    }
                    else
                    {
                        // returned value is equal to '9' (!= 4) means that failed operation
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearHospitaltbl();", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    #endregion

    #region Images Tab 14

    protected void BindImagesGridView()
    {
        try
        {
            // Bind Images GridView
            WorkParams_ud.BindGridView(gvImage, Pat_Images_ud.SelectAll(Convert.ToInt32(hfPatId.Value)));
            upImage.Update();
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void FileUploadComplete(object sender, AsyncFileUploadEventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (AsyncFileUpload1.HasFile)
                {
                    if (int.Parse(e.FileSize) <= 3145728)
                    {
                        // get img_id from DB
                        int img_id = Pat_Images_ud.GetImageID();
                        // save img_id in a session
                        Session["img_id"] = img_id;
                        string fileName = AsyncFileUpload1.FileName;
                        // get image extension
                        string fileExtention = fileName.Substring(fileName.LastIndexOf('.'));
                        // rename image as follow: pat_id-img_id.extension
                        string imgName = hfPatId.Value + '-' + img_id + fileExtention;
                        AsyncFileUpload1.SaveAs(Server.MapPath("~/images/") + imgName);
                        // save image extension in a session so i can access it when user click Save Button
                        Session["fileExtention"] = fileExtention;
                        // save image name in a session
                        // Saving Image are done by three steps
                        // Step 1 : user select a patient and write a description for the image
                        // Step 2 : user select an image and it will be immediately saved to the server
                        // Step 3 : from javascript i fire btnSaveImage to save image info to DB
                        // there is possibility that user select an image so it will be saved to the server
                        // but suddenly an error occure when trying to save image info into DB
                        // so i want to delete the image from the server
                        // so i save image name in a session
                        // depending on saving image status i will decide either delete the image from server or not
                        // then i delete that session later and other sessions
                        Session["imgName"] = imgName;
                    }
                    else
                    {
                        // doesnot work , why ? i don't know
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' Image size should not be greater than 3MB');", true);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }

    }

    protected void btnImageSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    // get the data from user and insert into Pat_Images_ud table
                    // if the returned value is equal to '4' that means successful operation
                    if (Pat_Images_ud.Insert(new Pat_Images_ud
                    {
                        pat_img_id = Convert.ToInt32(Session["img_id"]),
                        pat_id = Convert.ToInt32(hfPatId.Value),
                        pat_img_url = Session["fileExtention"].ToString(),
                        pat_img_desc = txtImageDesc.Value.Trim(),
                        pat_img_date = DateTime.Now.ToString("dd/MM/yyyy")
                    }) == 4)
                    {

                        BindImagesGridView();
                        txtImageDesc.Value = "";
                        // Remove sessions
                        Session.Remove("img_id");
                        Session.Remove("fileExtention");
                        Session.Remove("imgName");
                        // Show the success message in the div with id: divGeneral and call method ClearImagetbl();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been saved successfully');ClearImagetbl();", true);
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        DeleteImageFromServer();
                        // show the error message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearImagetbl();", true);
                    }

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');ClearImagetbl();", true);
                }
            }
            catch (Exception ex)
            {
                DeleteImageFromServer();
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }
    protected void btnImageUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (hfPatId.Value != "")
                {
                    if (txtImageId.Value.Trim() != "")
                    {
                        // get data from user and update Pat_Images_ud table
                        // if the returned value is equal to '4' that means successful operation
                        if (Pat_Images_ud.Update(new Pat_Images_ud
                        {
                            pat_img_id = Convert.ToInt32(txtImageId.Value),
                            pat_img_desc = txtImageDesc.Value.Trim()
                        }) == 4)
                        {
                            BindImagesGridView();
                            txtImageDesc.Value = "";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been updated successfully');ClearImagetbl();", true);
                        }
                        else
                        {
                            //returned value is equal to '9' (!= 4) means that failed operation
                            // show the error message
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearImagetbl();", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');ClearImagetbl();", true);
                }
            }
            catch (Exception ex)
            {
                // show the error message in the div with id: divGeneral
                string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
            }
        }
    }

    protected void btnImageDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfPatId.Value != "")
            {
                if (txtImageId.Value.Trim() != "")
                {
                    // returned value will be string like this '4,1-15.jpg'
                    // so i split it into an array with char(',')
                    // arr[0]=4 -- that means successful operation
                    // arr[1]=1-15.jpg -- that represent image name
                    string status = Pat_Images_ud.Delete(Convert.ToInt32(txtImageId.Value));
                    if (status != "")
                    {
                        string[] arr = status.Split(',');
                        if (arr[0] == "4")
                        {
                            // delete image from the server
                            string imgPath = Server.MapPath("~/images/");
                            string imgName = arr[1];
                            string strFileFullPath = imgPath + imgName;
                            if (File.Exists(strFileFullPath))
                            {
                                File.Delete(strFileFullPath);
                            }
                            BindImagesGridView();
                            txtImageDesc.Value = "";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(1,' Record has been deleted successfully');ClearImagetbl();", true);
                        }
                        else
                        {
                            // returned value is equal to '9' (!= 4) means that failed operation
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(2,' An error has occurred');ClearImagetbl();", true);
                        }
                    }
                    else
                    {
                        // this is very rare possibility but it may happens
                        // the idea is two Users_ud try to delete the image in the same time
                        // the fisrt request will be executed successfully 
                        // the second request will return empty string (status)
                        // so i bind the images gridview 
                        BindImagesGridView();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' This record already deleted before');ClearImagetbl();", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "$('#divGeneral').mShowStatus(3,' You must select a patient first');ClearImagetbl();", true);
            }
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
        }
    }

    protected void DeleteImageFromServer()
    {
        try
        {
            // delete image from server
            string strPhysicalFolder = Server.MapPath("~/images/");

            string strFileFullPath = strPhysicalFolder + Session["imgName"].ToString();

            if (File.Exists(strFileFullPath))
            {
                File.Delete(strFileFullPath);
            }
            // Remove sessions
            Session.Remove("img_id");
            Session.Remove("fileExtention");
            Session.Remove("imgName");
        }
        catch (Exception ex)
        {
            string str = string.Format("{0}{1}{2}", "$('#divGeneral').mShowStatus(2, '", ex.Message.Replace("'", " "), "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", str, true);
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
                    Response.Redirect("~/Default.aspx",false);
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