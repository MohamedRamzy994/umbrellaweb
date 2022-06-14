using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Examinations_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Examinations_ud
{
	public Examinations_ud()
	{
        
		//d
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int exam_id { get; set; }
    public string exam_name { get; set; }
    public Int16 active { get; set; }
    public int exam_det_id { get; set; }
    public decimal exam_cost { get; set; }
    public Int16 active_det { get; set; }
    #endregion

    /// <summary>
    /// status : 0 for inactive Examinations_ud
    /// status : 1 for active Examinations_ud
    /// status : 2 for both active & inactive Examinations_ud
    /// </summary>
    /// <returns></returns>
    public static DataTable SelectAll(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Examinations_slc_all",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }


    public static int Insert(Examinations_ud exam)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Examinations_insert",
            DBClass_ud.CreateParameter("exam_name", exam.exam_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("exam_cost", exam.exam_cost, SqlDbType.Decimal));
    }

    public static int Update(Examinations_ud exam)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Examinations_update",
            DBClass_ud.CreateParameter("exam_id", exam.exam_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("exam_name", exam.exam_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("exam_cost", exam.exam_cost, SqlDbType.Decimal),
            DBClass_ud.CreateParameter("active", exam.active, SqlDbType.SmallInt));
    }

    public static int Delete(int exam_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Examinations_delete",
           DBClass_ud.CreateParameter("exam_id", exam_id, SqlDbType.Int));
    }
}