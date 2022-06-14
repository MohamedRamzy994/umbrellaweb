using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Transactions_
/// 
/// 
/// 
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// * account_id: represent id of (patient or company or Clinic_ud) according to state of transaction
/// * account_code : represent code of (patient or company or Clinic_ud) according to state of transaction
/// * transac_desc: represent one of the following states:
///  1: examination قيمة كشف
///  2: returned examination كشف مرتجع
///  3: encashment voucher سند قبض
///  4: payment voucher سند صرف
///  5: withdrawals المسحوبات
///  * transact_type: 
///  1: credit دائن
///  represent the Transactions_ud that cause decreasing the cash 
///  2: dept مدين
///  represent the Transactions_ud that cause increasing the cash
///  * last_acc_balance : represent the last balance of the current account before executing the transaction
///  * last_clc_balance : represent the last balance of the Clinic_ud (cash) before executing the transaction
///  * Clinic_ud_id : represent the id of the Clinic_ud (cash)
///  * pat_visit_id : represent the id of the visit (may be null in some cases)
///  * transact_note : note on the transaction
/// </summary>
public class Transactions_ud
{
    public Transactions_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    #region Properties
    public int transact_id { get; set; }
    public DateTime transact_date { get; set; }
    public int account_id { get; set; }
    public string account_code { get; set; }
    public string transact_desc { get; set; }
    public decimal transact_amount { get; set; }
    public decimal last_acc_balance { get; set; }
    public decimal last_clc_balance { get; set; }
    public int Clinic_ud_id { get; set; }
    public int pat_visit_id { get; set; }
    public int user_id { get; set; }
    public string transact_note { get; set; }
    #endregion

    /// <summary>
    /// txt : (c) for Companies_ud encashment vouchers
    /// txt : (p) for Patients_ud encashment vouchers
    /// </summary>
    /// <param name="txt"></param>
    /// <returns></returns>
    public static DataTable SelectEncashmentVouchers(string txt)
    {
        return DBClass_ud.ExecuteTable("sp_Transactions_slc_encashment",
               DBClass_ud.CreateParameter("txt", txt, SqlDbType.VarChar));
    }

    /// <summary>
    /// txt : (c) for Companies_ud payment vouchers
    /// txt : (p) for Patients_ud payment vouchers
    /// txt : (e) for Examinations_ud payment vouchers
    /// </summary>
    /// <param name="txt"></param>
    /// <returns></returns>
    public static DataTable SelectPaymentVouchers(string txt)
    {
        return DBClass_ud.ExecuteTable("sp_Transactions_slc_payment",
               DBClass_ud.CreateParameter("txt", txt, SqlDbType.VarChar));
    }

    public static DataTable SelectWithdrawals()
    {
        return DBClass_ud.ExecuteTable("sp_Transactions_slc_withdrawals");
    }
    /// <summary>
    /// txt : (c) for Companies_ud payment vouchers
    /// txt : (p) for Patients_ud payment vouchers
    /// </summary>
    /// <param name="txt"></param>
    /// <param name="account_id"></param>
    /// <param name="account_code"></param>
    /// <param name="transact_note"></param>
    /// <param name="transact_amount"></param>
    /// <returns></returns>
    public static int SaveEncashmentVoucher(string txt,int account_id,string account_code,string transact_note,decimal transact_amount,int user_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Transactions_save_encashment",
            DBClass_ud.CreateParameter("txt", txt, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("account_id", account_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("account_code", account_code, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("transact_note", transact_note, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("transact_amount", transact_amount, SqlDbType.Decimal),
            DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int));
    }

    /// <summary>
    /// txt : (c) for Companies_ud payment vouchers
    /// txt : (p) for Patients_ud payment vouchers
    /// txt : (e) for Examinations_ud payment vouchers
    /// </summary>
    /// <param name="txt"></param>
    /// <param name="account_id"></param>
    /// <param name="account_code"></param>
    /// <param name="transact_note"></param>
    /// <param name="transact_amount"></param>
    /// <returns></returns>
    public static int SavePaymentVoucher(string txt, int account_id, string account_code, string transact_note, decimal transact_amount,int user_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Transactions_save_payment",
            DBClass_ud.CreateParameter("txt", txt, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("account_id", account_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("account_code", account_code, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("transact_note", transact_note, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("transact_amount", transact_amount, SqlDbType.Decimal),
            DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int));
    }

    public static int SaveWithdrawals(int account_id, string account_code, string transact_note, decimal transact_amount, int user_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Transactions_save_withdrawals",
            DBClass_ud.CreateParameter("account_id", account_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("account_code", account_code, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("transact_note", transact_note, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("transact_amount", transact_amount, SqlDbType.Decimal),
            DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int));
    }

    /// <summary>
    /// Datatable [0] : Totals of start_balance & income & outcome & withdrawals & balance
    /// Datatable [1] : visits_count , visits_total
    /// Datatable [2] : ret_visits_count , ret_visits_total
    /// Datatable [3] : encash_count , encash_total
    /// Datatable [4] : pay_count , pay_total
    /// Datatable [5] : with_count , with_total
    /// </summary>
    /// <param name="date"></param>
    /// <returns></returns>
    public static DataSet GetDailySummary(string date)
    {
        return DBClass_ud.ExecuteDataSet("sp_Transactions_daily",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }

    /// <summary>
    /// Datatable [0],[1]   : visits
    /// Datatable [2],[3]   : Encashment Vouchers from Companies_ud
    /// Datatable [4],[5]   : Encashment Vouchers from Pateints
    /// Datatable [6],[7]   : returned visits
    /// Datatable [8],[9]   : Payment Vouchers for Companies_ud
    /// Datatable [10],[11] : Payment Vouchers for Patients_ud
    /// Datatable [12],[13] : Payment Vouchers for Examinations_ud
    /// Datatable [14],[15] : withdrawals
    /// </summary>
    /// <param name="date"></param>
    /// <returns></returns>
    public static DataSet GetDailySummarDetails(string date)
    {
        return DBClass_ud.ExecuteDataSet("sp_Transactions_daily_det",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }


    public static DataTable rptDailySummaryWithinPeriod(string date_from,string date_to)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_period",
               DBClass_ud.CreateParameter("date_from", date_from, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("date_to", date_to, SqlDbType.VarChar));
    }

    public static DataTable rptDailySummaryDetailsWithinPeriod(string date_from, string date_to)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_det_period",
               DBClass_ud.CreateParameter("date_from", date_from, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("date_to", date_to, SqlDbType.VarChar));
    }
    //(created by saad)
    public static DataTable rptPatientVisits(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_select_Pat_Visits",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }
    public static DataTable rptPatients_udearch(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_patient_search",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }
    
    public static DataTable rptDailyDetVisits(string date)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_det_visits",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }

    public static DataTable rptDailyDetEncashCompanies_ud(string date)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_det_encash_comp",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }

    public static DataTable rptDailyDetEncashPatients_ud(string date)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_det_encash_pat",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }

    public static DataTable rptDailyDetReturnedVisits(string date)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_det_ret_visits",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }

    public static DataTable rptDailyDetPayCompanies_ud(string date)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_det_pay_comp",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }

    public static DataTable rptDailyDetPayPatients_ud(string date)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_det_pay_pat",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }

    public static DataTable rptDailyDetPayExaminations_ud(string date)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_det_pay_exp",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }

    public static DataTable rptDailyDetWithdrawals(string date)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_daily_det_with",
               DBClass_ud.CreateParameter("date", date, SqlDbType.VarChar));
    }
}