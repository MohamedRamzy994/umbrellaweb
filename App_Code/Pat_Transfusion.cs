using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Transfusion_
/// 
/// 
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Transfusion_ud
{
	public Pat_Transfusion_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int Pat_Transfusion_ud_id { get; set; }
    public int pat_id { get; set; }
    public string Pat_Transfusion_ud_date { get; set; }
    #endregion


    public static DataTable SelectAll(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Transfusion_slc_all",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }


    public static int Insert(Pat_Transfusion_ud transfusion)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Transfusion_insert",
            DBClass_ud.CreateParameter("pat_id", transfusion.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("Pat_Transfusion_date", transfusion.Pat_Transfusion_ud_date, SqlDbType.VarChar));
    }

    public static int Update(Pat_Transfusion_ud transfusion)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Transfusion_update",
            DBClass_ud.CreateParameter("Pat_Transfusion_id", transfusion.Pat_Transfusion_ud_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("Pat_Transfusion_date", transfusion.Pat_Transfusion_ud_date, SqlDbType.VarChar));
    }

    public static int Delete(int Pat_Transfusion_ud_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Transfusion_delete",
           DBClass_ud.CreateParameter("Pat_Transfusion_id", Pat_Transfusion_ud_id, SqlDbType.Int));
    }
}