using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Patients_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Patients_ud
{
    public Patients_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    #region Properties
    public int pat_id { get; set; }
    public string pat_name { get; set; }
    public string pat_birthdate { get; set; }
    public string pat_age { get; set; }
    public string pat_address { get; set; }
    public string pat_gender { get; set; }
    public string pat_mobile { get; set; }
    public string pat_phone { get; set; }
    public string pat_job { get; set; }
    public Int16 marital_id { get; set; }
    public Int16 blood_id { get; set; }
    public Int16 pat_smoker { get; set; }
    public Int16 pat_dm { get; set; }
    public Int16 pat_htn { get; set; }
    public string created_date { get; set; }
    public int created_by { get; set; }
    public string modified_date { get; set; }
    public int modified_by { get; set; }
    public Int16 active { get; set; }
    #endregion

    /// <summary>
    /// status : 0 for inactive Patients_ud
    /// status : 1 for active Patients_ud
    /// status : 2 for both active & Inactive Patients_ud
    /// </summary>
    /// <param name="status"></param>
    /// <returns></returns>
    public static DataTable SelectAll(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Patients_slc_all",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }

    public static DataTable SelectInfo(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Patients_slc_info",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }

    public static DataTable Patients_udSearch(string col, string txt, string gender, string status)
    {
        return DBClass_ud.ExecuteTable("sp_Patients_search",
               DBClass_ud.CreateParameter("col", col, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("txt", txt, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("gender", gender, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("status", status, SqlDbType.VarChar));
    }
    //this method return only one patient according to Pat_id (created by saad)
    public static DataTable Patients_udearch(int id)
    {
        return DBClass_ud.ExecuteTable("sp_patient_search", DBClass_ud.CreateParameter("pat_id", id, SqlDbType.Int));
    }
    public static DataTable Companies_udPatients_udSearch(int company_id, string col, string txt, string gender, string status)
    {
        return DBClass_ud.ExecuteTable("sp_Patients_search_comp",
               DBClass_ud.CreateParameter("company_id", company_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("col", col, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("txt", txt, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("gender", gender, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("status", status, SqlDbType.VarChar));
    }

    public static Patients_ud SelectByID(int pat_id)
    {
        using (DataTable dt = DBClass_ud.ExecuteTable("sp_Patients_slc_id",
            DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int)))
        {
            if (dt.Rows.Count > 0)
            {
                return new Patients_ud
                {
                    pat_id = Convert.ToInt32(dt.Rows[0]["pat_id"].ToString()),
                    pat_name = dt.Rows[0]["pat_name"].ToString(),
                    pat_age = dt.Rows[0]["pat_age"].ToString(),
                    pat_gender = dt.Rows[0]["pat_gender"].ToString(),
                    marital_id = Convert.ToInt16(dt.Rows[0]["marital_id"].ToString()),
                    blood_id = Convert.ToInt16(dt.Rows[0]["blood_id"].ToString()),
                    pat_smoker = Convert.ToInt16(dt.Rows[0]["pat_smoker"].ToString()),
                    pat_dm = Convert.ToInt16(dt.Rows[0]["pat_dm"].ToString()),
                    pat_htn = Convert.ToInt16(dt.Rows[0]["pat_htn"].ToString())
                };
            }
            else
                return null;
        }
    }

    /// <summary>
    /// Gender: 0 for Male
    /// Gender: 1 for Female
    /// </summary>
    /// <param name="pat"></param>
    /// <returns></returns>
    public static int Insert(Patients_ud pat)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Patients_insert",
            DBClass_ud.CreateParameter("pat_name", pat.pat_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_birthdate", pat.pat_birthdate, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_address", pat.pat_address, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_gender", pat.pat_gender, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_mobile", pat.pat_mobile, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_phone", pat.pat_phone, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_job", pat.pat_job, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("marital_id", pat.marital_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("blood_id", pat.blood_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_smoker", pat.pat_smoker, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("pat_dm", pat.pat_dm, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("pat_htn", pat.pat_htn, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("created_date", pat.created_date, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("created_by", pat.created_by, SqlDbType.Int),
            DBClass_ud.CreateParameter("modified_date", pat.modified_date, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("modified_by", pat.modified_by, SqlDbType.Int));
    }

    /// <summary>
    /// Gender: 0 for Male
    /// Gender: 1 for Female
    /// </summary>
    /// <param name="pat"></param>
    /// <returns></returns>
    public static int Update(Patients_ud pat)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Patients_update",
            DBClass_ud.CreateParameter("pat_id", pat.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_name", pat.pat_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_birthdate", pat.pat_birthdate, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_address", pat.pat_address, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_gender", pat.pat_gender, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_mobile", pat.pat_mobile, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_phone", pat.pat_phone, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_job", pat.pat_job, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("marital_id", pat.marital_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("blood_id", pat.blood_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_smoker", pat.pat_smoker, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("pat_dm", pat.pat_dm, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("pat_htn", pat.pat_htn, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("modified_date", pat.modified_date, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("modified_by", pat.modified_by, SqlDbType.Int),
            DBClass_ud.CreateParameter("active", pat.active, SqlDbType.SmallInt));
    }

    public static int Delete(int pat_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Patients_delete",
           DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }
}