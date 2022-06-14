using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Surgeries_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Surgeries_ud
{
	public Pat_Surgeries_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int pat_surgery_id { get; set; }
    public int pat_id { get; set; }
    public string pat_surgery_name { get; set; }
    public string pat_surgery_date { get; set; }
    #endregion


    public static DataTable SelectAll(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_pat_surgery_slc_all",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }


    public static int Insert(Pat_Surgeries_ud surgery)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Surgeries_ud_insert",
            DBClass_ud.CreateParameter("pat_id", surgery.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_surgery_name", surgery.pat_surgery_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_surgery_date", surgery.pat_surgery_date, SqlDbType.VarChar));
    }

    public static int Update(Pat_Surgeries_ud surgery)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Surgeries_ud_update",
            DBClass_ud.CreateParameter("pat_surgery_id", surgery.pat_surgery_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_surgery_name", surgery.pat_surgery_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_surgery_date", surgery.pat_surgery_date, SqlDbType.VarChar));
    }

    public static int Delete(int pat_surgery_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Surgeries_ud_delete",
           DBClass_ud.CreateParameter("pat_surgery_id", pat_surgery_id, SqlDbType.Int));
    }
}