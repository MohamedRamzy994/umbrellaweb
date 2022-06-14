using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Diagnosis_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Diagnosis_ud
{
	public Diagnosis_ud()
	{
        
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int Diagnosis_ud_id { get; set; }
    public string Diagnosis_ud_name { get; set; }
    public Int16 active { get; set; }
    #endregion

    /// <summary>
    /// status : 0 for inactive Diagnosis_ud
    /// status : 1 for active Diagnosis_ud
    /// status : 2 for both active & inactive Diagnosis_ud
    /// </summary>
    /// <param name="status"></param>
    /// <returns></returns>
    public static DataTable SelectAll(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Diagnosis_slc_all",
               DBClass_ud.CreateParameter("status",status,SqlDbType.Int));
    }

    public static int Insert(Diagnosis_ud Diagnosis_ud)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Diagnosis_insert",
            DBClass_ud.CreateParameter("Diagnosis_ud_name", Diagnosis_ud.Diagnosis_ud_name, SqlDbType.VarChar));
    }

    public static int Update(Diagnosis_ud Diagnosis_ud)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Diagnosis_update",
            DBClass_ud.CreateParameter("Diagnosis_id", Diagnosis_ud.Diagnosis_ud_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("Diagnosis_name", Diagnosis_ud.Diagnosis_ud_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("active", Diagnosis_ud.active, SqlDbType.SmallInt));
    }

    public static int Delete(int Diagnosis_ud_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Diagnosis_delete",
           DBClass_ud.CreateParameter("Diagnosis_id", Diagnosis_ud_id, SqlDbType.Int));
    }
}