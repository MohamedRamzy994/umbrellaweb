using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Medicines_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Medicines_ud
{
    public Medicines_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region Properties
    public int medicine_id { get; set; }
    public string medicine_name { get; set; }
    public Int16 active { get; set; }
    public Int16 common { get; set; }
    #endregion

    /// <summary>
    /// status : 0 for inactive Medicines_ud
    /// status : 1 for active Medicines_ud
    /// status : 2 for both active & inactive Medicines_ud
    /// </summary>
    /// <returns></returns>
    public static DataTable SelectAll(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Medicines_slc_all",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }

    public static DataTable SearchMedicines_ud(string txt, string active, string common)
    {
        return DBClass_ud.ExecuteTable("sp_Medicines_search",
               DBClass_ud.CreateParameter("txt", txt, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("active", active, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("common", common, SqlDbType.VarChar));
    }

    public static int Insert(Medicines_ud medicine)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Medicines_insert",
               DBClass_ud.CreateParameter("medicine_name", medicine.medicine_name, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("active", medicine.active, SqlDbType.SmallInt),
               DBClass_ud.CreateParameter("common", medicine.common, SqlDbType.SmallInt));
    }

    public static int Update(Medicines_ud medicine)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Medicines_update",
               DBClass_ud.CreateParameter("medicine_id", medicine.medicine_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("medicine_name", medicine.medicine_name, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("active", medicine.active, SqlDbType.SmallInt),
               DBClass_ud.CreateParameter("common", medicine.common, SqlDbType.SmallInt));
    }

    public static int UpdateCommon(int medicine_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Medicines_update_common",
               DBClass_ud.CreateParameter("medicine_id", medicine_id, SqlDbType.Int));
    }
    public static int Delete(int medicine_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Medicines_delete",
               DBClass_ud.CreateParameter("medicine_id", medicine_id, SqlDbType.Int));
    }
}