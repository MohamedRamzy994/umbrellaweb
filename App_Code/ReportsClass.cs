using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for ReportsClass
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class ReportsClass
{
    public ReportsClass()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static DataTable GetBasicInfo()
    {
        return DBClass_ud.ExecuteTable("sp_rpt_basic_info");
    }

    public static DataTable VisitPrescription(int pat_visit_id)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_prescription_slc",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
    }

    public static DataTable VisitRequest(int pat_visit_id)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_request_slc",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
    }
    public static DataSet VisitDiagnosis_ud(int pat_visit_id)
    {
        return DBClass_ud.ExecuteDataSet("sp_rpt_complaint_Diagnosis_slc",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
               
    }
    public static DataTable VisitVitalSigns(int pat_visit_id)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_vital_signs_slc",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
    }
    public static DataTable GetPatientInfo(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_patient_info",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }
    public static DataTable PatVisit(int pat_visit_id)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_visit_slc",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
    }
    
}