using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Days_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Days_ud
{
    public Days_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region Properties
    public int day_id { get; set; }
    public int day_det_id { get; set; }
    public string time_from { get; set; }
    public string time_to { get; set; }
    #endregion

    /// <summary>
    /// status : 0 for inactive Days_ud
    /// status : 1 for active Days_ud
    /// status : 2 for both active & inactive Days_ud
    /// </summary>
    /// <returns></returns>
    public static DataTable SelectDays_ud(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Days_slc_all",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
        
    }

    public static DataTable SelectDayDetails(string day_id)
    {
        return DBClass_ud.ExecuteTable("sp_Days_det_slc",
               DBClass_ud.CreateParameter("day_id", day_id, SqlDbType.Int));
    }

    public static DataTable SelectDoctorAppointments()
    {
        return DBClass_ud.ExecuteTable("sp_Days_doctor_slc");
    }

    public static int Days_udSave(int day_id,Int16 active)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Days_save",
            DBClass_ud.CreateParameter("day_id", day_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("active", active, SqlDbType.SmallInt));
    }
    public static int InsertDayDetails(Days_ud day)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Days_det_insert",
            DBClass_ud.CreateParameter("day_id", day.day_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("time_from", day.time_from, SqlDbType.Time),
            DBClass_ud.CreateParameter("time_to", day.time_to, SqlDbType.Time));
    }

    public static int UpdateDayDetails(Days_ud day)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Days_det_update",
            DBClass_ud.CreateParameter("day_id", day.day_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("day_det_id", day.day_det_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("time_from", day.time_from, SqlDbType.Time),
            DBClass_ud.CreateParameter("time_to", day.time_to, SqlDbType.Time));
    }

    public static int DeleteDayDetails(string day_det_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Days_det_delete",
           DBClass_ud.CreateParameter("day_det_id", day_det_id, SqlDbType.Int));
    }
}