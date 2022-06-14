using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Doses_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Doses_ud
{
	public Doses_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    

    #region Properties
    public int dose_id { get; set; }
    public string dose_name { get; set; }
    public Int16 active { get; set; }
    #endregion

    /// <summary>
    /// status : 0 for inactive Doses_ud
    /// status : 1 for active dianosis
    /// status : 2 for both active & inactive Diagnosis_ud
    /// </summary>
    /// <returns></returns>
    public static DataTable SelectAll(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Doses_slc_all",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }


    public static int Insert(Doses_ud dose)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Doses_insert",
            DBClass_ud.CreateParameter("dose_name", dose.dose_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("active", dose.active, SqlDbType.SmallInt));
    }

    public static int Update(Doses_ud dose)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Doses_update",
            DBClass_ud.CreateParameter("dose_id", dose.dose_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("dose_name", dose.dose_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("active", dose.active, SqlDbType.SmallInt));
    }

    public static int Delete(int dose_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Doses_delete",
           DBClass_ud.CreateParameter("dose_id", dose_id, SqlDbType.Int));
    }
}