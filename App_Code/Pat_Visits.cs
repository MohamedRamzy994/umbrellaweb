using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Visits_
/// 
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Visits_ud
{
    public Pat_Visits_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region Properties
    public int pat_visit_id { get; set; }
    public int pat_id { get; set; }
    public string pat_visit_date { get; set; }
    public string pat_visit_time { get; set; }
    public int pat_visit_no { get; set; }
    public int exam_det_id { get; set; }
    public Int16 viacompany { get; set; }
    public int? company_id { get; set; }
    public int? contract_id { get; set; }
    public Int16 paid_status { get; set; }
    public Int16 visit_status { get; set; }
    public int user_id { get; set; }
    public decimal paid_amount { get; set; }
    #endregion


    public static DataTable SelectPatVisits(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Visits_slc_all",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }

    public static DataTable SelectNewVisits(string pat_id,string viacompany)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Visits_slc_new",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("viacompany", viacompany, SqlDbType.SmallInt));
    }

    public static DataTable SelectCurrentVisits(string visit_Date)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Visits_slc_current",
               DBClass_ud.CreateParameter("visit_Date", visit_Date, SqlDbType.VarChar));
    }
    /// <summary>
    /// visit_status : 0 new visits
    /// visit_status : 1 pending visits
    /// visit_status : 2 finished visits
    /// </summary>
    /// <param name="visit_status"></param>
    /// <returns></returns>
    public static DataTable SelectWaitingListNew(string visit_Date, Int16 visit_status)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Visits_slc_wl",
               DBClass_ud.CreateParameter("visit_Date", visit_Date, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("visit_status", visit_status, SqlDbType.SmallInt));
    }

    /// <summary>
    /// waiting list for dropdownlist in General Clinic_ud
    /// it select new visits & pending visits (names of Patients_ud only)
    /// </summary>
    /// <param name="visit_Date"></param>
    /// <param name="visit_status"></param>
    /// <returns></returns>
    public static DataTable SelectWaitingListClinic_ud(string visit_Date)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Visits_slc_wl_clc",
               DBClass_ud.CreateParameter("visit_Date", visit_Date, SqlDbType.VarChar));
    }

    public static DataTable GetPatientsVisits(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Visits_slc_clc",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }
    //created by saad 8-10-2014
    public static DataTable GetPatientVisits(int pat_id, string DateFrom, string DateTo)
    {
        return DBClass_ud.ExecuteTable("sp_select_Pat_Visits",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("created_dateFrom", DateFrom, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("created_dateTo", DateTo, SqlDbType.VarChar)
               );
    }
    
    public static string Insert(Pat_Visits_ud visit)
    {
        return DBClass_ud.ExecuteScalar("sp_Pat_Visits_insert",
            DBClass_ud.CreateParameter("pat_id", visit.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_visit_date", visit.pat_visit_date, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_visit_time", visit.pat_visit_time, SqlDbType.Time),
            DBClass_ud.CreateParameter("exam_det_id", visit.exam_det_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("paid_status", visit.paid_status, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("paid_amount", visit.paid_amount, SqlDbType.Decimal),
            DBClass_ud.CreateParameter("user_id", visit.user_id, SqlDbType.Int)).ToString();
    }

    public static string InsertCompanyVisit(Pat_Visits_ud visit, int company_id)
    {
        return DBClass_ud.ExecuteScalar("sp_Pat_Visits_insert_comp",
            DBClass_ud.CreateParameter("pat_id", visit.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("company_id", company_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_visit_date", visit.pat_visit_date, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_visit_time", visit.pat_visit_time, SqlDbType.Time),
            DBClass_ud.CreateParameter("exam_det_id", visit.exam_det_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("paid_status", visit.paid_status, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("paid_amount", visit.paid_amount, SqlDbType.Decimal),
            DBClass_ud.CreateParameter("user_id", visit.user_id, SqlDbType.Int)).ToString();
    }
    public static int UpdateDateTime(Pat_Visits_ud visit)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Visits_update",
            DBClass_ud.CreateParameter("pat_visit_id", visit.pat_visit_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_id", visit.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_visit_date", visit.pat_visit_date, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_visit_time", visit.pat_visit_time, SqlDbType.Time));
    }

    public static int UpdatePaidDetails(Pat_Visits_ud visit)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Visits_update_paid",
            DBClass_ud.CreateParameter("pat_visit_id", visit.pat_visit_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("paid_status", visit.paid_status, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("paid_amount", visit.paid_amount, SqlDbType.Decimal),
            DBClass_ud.CreateParameter("user_id", visit.user_id, SqlDbType.Int));
    }


    public static int FinishVisit(int pat_visit_id, int user_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Visits_finish",
           DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int),
           DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int));
    }
    public static string DeleteVisit(int pat_visit_id, int user_id)
    {
        return DBClass_ud.ExecuteScalar("sp_Pat_Visits_delete",
           DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int),
           DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int)).ToString();
    }
    public static int DeleteOldVisits()
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Visits_old_del",
            DBClass_ud.CreateParameter("visit_date", DateTime.Now.AddDays(-3).ToString("dd/MM/yyyy"), SqlDbType.VarChar));
    }

}