using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Hospital_Admission_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Hospital_Admission_ud
{
	public Pat_Hospital_Admission_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int pat_hospital_id { get; set; }
    public int pat_id { get; set; }
    public string pat_hospital_reason { get; set; }
    #endregion


    public static DataTable SelectAll(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_pat_hospital_slc_all",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }


    public static int Insert(Pat_Hospital_Admission_ud hospital)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_hospital_insert",
            DBClass_ud.CreateParameter("pat_id", hospital.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_hospital_reason", hospital.pat_hospital_reason, SqlDbType.VarChar));
    }

    public static int Update(Pat_Hospital_Admission_ud hospital)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_hospital_update",
            DBClass_ud.CreateParameter("pat_hospital_id", hospital.pat_hospital_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_hospital_reason", hospital.pat_hospital_reason, SqlDbType.VarChar));
    }

    public static int Delete(int pat_hospital_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_hospital_delete",
           DBClass_ud.CreateParameter("pat_hospital_id", pat_hospital_id, SqlDbType.Int));
    }
}