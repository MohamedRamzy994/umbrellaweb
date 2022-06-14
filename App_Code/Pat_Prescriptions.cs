using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Prescriptions_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Prescriptions_ud
{
	public Pat_Prescriptions_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int pat_prescription_id { get; set; }
    public int pat_visit_id { get; set; }
    public int pat_prescription_det_id { get; set; }
    public int medicine_id { get; set; }
    public int dose_id { get; set; }
    public string note { get; set; }
    #endregion


    public static DataTable SelectVisitPrescription(int pat_visit_id)
    {
        return DBClass_ud.ExecuteTable("sp_prescription_visit_slc",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
    }

    public static int InsertMedicines_ud(Pat_Prescriptions_ud prescription)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_prescription_insert",
            DBClass_ud.CreateParameter("pat_visit_id", prescription.pat_visit_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("medicine_id", prescription.medicine_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("dose_id", prescription.dose_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("note", prescription.note, SqlDbType.VarChar));
    }

    public static int UpdateMedicines_ud(Pat_Prescriptions_ud prescription)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_prescription_update",
            DBClass_ud.CreateParameter("pat_prescription_det_id", prescription.pat_prescription_det_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("medicine_id", prescription.medicine_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("dose_id", prescription.dose_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("note", prescription.note, SqlDbType.VarChar));
    }

    public static int DeleteMedicine(int pat_prescription_det_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_prescription_delete",
           DBClass_ud.CreateParameter("pat_prescription_det_id", pat_prescription_det_id, SqlDbType.Int));
    }
}