using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Chronic_Diseases_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Chronic_Diseases_ud
{
	public Pat_Chronic_Diseases_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int pat_chronic_id { get; set; }
    public int pat_id { get; set; }
    public string pat_chronic_name { get; set; }
    #endregion


    public static DataTable SelectAll(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_pat_chronic_slc_all",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }


    public static int Insert(Pat_Chronic_Diseases_ud chronic)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_chronic_insert",
            DBClass_ud.CreateParameter("pat_id", chronic.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_chronic_name", chronic.pat_chronic_name, SqlDbType.VarChar));
    }

    public static int Update(Pat_Chronic_Diseases_ud chronic)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_chronic_update",
            DBClass_ud.CreateParameter("pat_chronic_id", chronic.pat_chronic_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_chronic_name", chronic.pat_chronic_name, SqlDbType.VarChar));
    }

    public static int Delete(int pat_chronic_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_chronic_delete",
           DBClass_ud.CreateParameter("pat_chronic_id", pat_chronic_id, SqlDbType.Int));
    }
}