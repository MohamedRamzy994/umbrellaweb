using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Family_History_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Family_History_ud
{
	public Pat_Family_History_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int pat_family_id { get; set; }
    public int pat_id { get; set; }
    public Int16 relationship { get; set; }
    public string pat_family_disease_name { get; set; }
    #endregion


    public static DataTable SelectAll(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_pat_family_slc_all",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }
    public static DataTable SlcWithNames(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_pat_family_slc_name",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }

    public static int Insert(Pat_Family_History_ud family)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_family_insert",
            DBClass_ud.CreateParameter("pat_id", family.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("relationship", family.relationship, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("pat_family_disease_name", family.pat_family_disease_name, SqlDbType.VarChar));
    }

    public static int Update(Pat_Family_History_ud family)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_family_update",
                   DBClass_ud.CreateParameter("pat_family_id", family.pat_family_id, SqlDbType.Int),
                   DBClass_ud.CreateParameter("relationship", family.relationship, SqlDbType.SmallInt),
                   DBClass_ud.CreateParameter("pat_family_disease_name", family.pat_family_disease_name, SqlDbType.VarChar));
    }

    public static int Delete(int pat_family_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_pat_family_delete",
           DBClass_ud.CreateParameter("pat_family_id", pat_family_id, SqlDbType.Int));
    }
}