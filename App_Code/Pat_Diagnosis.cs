using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Diagnosis_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Diagnosis_ud
{
    public Pat_Diagnosis_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    
    #region Properties
    public int pat_Diagnosis_ud_id { get; set; }
    public int pat_visit_id { get; set; }
    public int Diagnosis_ud_id { get; set; }
    #endregion


    public static DataTable SelectPatientDiagnosis_ud(int pat_visit_id)
    {
        return DBClass_ud.ExecuteTable("sp_pat_Diagnosis_slc_all",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
    }


    public static int SaveComplaintsDiagnosis_ud(int pat_visit_id, string pat_complaint_name, string pat_complaint_note, string pat_Diagnosis_ud_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Complaints_Diagnosis_save",
            DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_complaint_name", pat_complaint_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_complaint_note", pat_complaint_note, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_Diagnosis_id", pat_Diagnosis_ud_id, SqlDbType.VarChar));
    }
    public static int InsertUpdate(int pat_visit_id, string pat_Diagnosis_ud_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_Diagnosis_insert_update",
            DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_Diagnosis_id", pat_Diagnosis_ud_id, SqlDbType.VarChar));
    }
}