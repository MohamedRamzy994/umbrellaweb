using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Complaints_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Complaints_ud
{
	public Pat_Complaints_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int pat_complaint_id { get; set; }
    public int pat_visit_id { get; set; }
    public string pat_complaint_name { get; set; }
    public string pat_complaint_note { get; set; }
    #endregion


    public static DataTable SelectPatientComplaint(int pat_visit_id)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Complaints_slc",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
    }

    public static int Insert(Pat_Complaints_ud complaint)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Complaints_insert",
            DBClass_ud.CreateParameter("pat_visit_id", complaint.pat_visit_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_complaint_name", complaint.pat_complaint_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_complaint_note", complaint.pat_complaint_note, SqlDbType.VarChar));
    }

    public static int Update(Pat_Complaints_ud complaint)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Complaints_update",
            DBClass_ud.CreateParameter("pat_complaint_id", complaint.pat_complaint_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_complaint_name", complaint.pat_complaint_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_complaint_note", complaint.pat_complaint_note, SqlDbType.VarChar));
    }

    public static int Delete(int pat_complaint_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Complaints_delete",
           DBClass_ud.CreateParameter("pat_complaint_id", pat_complaint_id, SqlDbType.Int));
    }
}