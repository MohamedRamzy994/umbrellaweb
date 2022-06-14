using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Vital_Signs_
/// 
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Vital_Signs_ud
{
	public Pat_Vital_Signs_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int vital_id { get; set; }
    public int pat_visit_id { get; set; }
    public string vital_weight { get; set; }
    public string vital_height { get; set; }
    public string vital_temp { get; set; }
    public string vital_pulse { get; set; }
    public string vital_respiratory { get; set; }
    public string vital_blood { get; set; }
    public string vital_pupil { get; set; }
    public string vital_skin { get; set; }
    public string vital_notes { get; set; }
    #endregion


    public static DataTable SelectVitalSigns(int pat_visit_id)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Vital_Signs_slc",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
    }


    public static int SaveVitalSigns(Pat_Vital_Signs_ud vital)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Vital_Signs_save",
            DBClass_ud.CreateParameter("pat_visit_id", vital.pat_visit_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("vital_weight", vital.vital_weight, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("vital_height", vital.vital_height, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("vital_temp", vital.vital_temp, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("vital_pulse", vital.vital_pulse, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("vital_respiratory", vital.vital_respiratory, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("vital_blood", vital.vital_blood, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("vital_pupil", vital.vital_pupil, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("vital_skin", vital.vital_skin, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("vital_notes", vital.vital_notes, SqlDbType.VarChar));
    }
}