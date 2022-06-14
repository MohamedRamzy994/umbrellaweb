using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Drugs_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Drugs_ud
{
	public Pat_Drugs_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int pat_drug_id { get; set; }
    public int pat_id { get; set; }
    public string pat_drug_name { get; set; }
    #endregion


    public static DataTable SelectAll(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Drugs_slc_all",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }


    public static int Insert(Pat_Drugs_ud drug)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Drugs_insert",
            DBClass_ud.CreateParameter("pat_id", drug.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_drug_name", drug.pat_drug_name, SqlDbType.VarChar));
    }

    public static int Update(Pat_Drugs_ud drug)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Drugs_update",
            DBClass_ud.CreateParameter("pat_drug_id", drug.pat_drug_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_drug_name", drug.pat_drug_name, SqlDbType.VarChar));
    }

    public static int Delete(int pat_drug_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Drugs_delete",
           DBClass_ud.CreateParameter("pat_drug_id", pat_drug_id, SqlDbType.Int));
    }
}