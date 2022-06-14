using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Globalization;

/// <summary>
/// Summary description for Contracts_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Contracts_ud
{
    public Contracts_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// contract_type : f for --> First Patient  /// contract period starts when firt patient perform a visit
    /// contract_type : k for --> Known Period   /// contratc period starts according to the known period   
    /// </summary>
    #region Properties
    public int contract_id { get; set; }
    public int company_id { get; set; }
    public string contract_type { get; set; }
    public int contract_period { get; set; }
    public string contract_date_from { get; set; }
    public string contract_date_to { get; set; }
    public int contract_discount { get; set; }
    public int contract_due_day { get; set; }
    public int warning { get; set; }
    public string flag_visits { get; set; }
    public string created_date { get; set; }
    public int created_by { get; set; }

    #endregion

 
    public static DataTable SelectAll(string lang)
    {
        return DBClass_ud.ExecuteTable("sp_contratcs_slc_all",
               DBClass_ud.CreateParameter("lang", lang, SqlDbType.NVarChar));
    }
    
    public static DataTable SelectValidContracts_ud(string company_id)
    {
        return DBClass_ud.ExecuteTable("sp_contratcs_slc_valid",
            DBClass_ud.CreateParameter("company_id", company_id, SqlDbType.Int));
    }
    public static Contracts_ud SelectByID(Contracts_ud contract_id)
    {
        using (DataTable dt = DBClass_ud.ExecuteTable("sp_Contracts_slc_id",
            DBClass_ud.CreateParameter("contract_id", contract_id, SqlDbType.Int)))
        {
            if (dt.Rows.Count > 0)
            {
                return new Contracts_ud
                {
                    contract_id = Convert.ToInt32(dt.Rows[0]["contract_id"].ToString()),
                    company_id = Convert.ToInt32(dt.Rows[0]["company_id"].ToString()),
                    contract_type = dt.Rows[0]["contract_type"].ToString(),
                    contract_date_from = dt.Rows[0]["contract_date_from"].ToString(),
                    contract_date_to = dt.Rows[0]["contract_date_to"].ToString(),
                    contract_period = Convert.ToInt32(dt.Rows[0]["contract_period"]),
                    contract_discount = Convert.ToInt32(dt.Rows[0]["contract_discount"]),
                    contract_due_day = Convert.ToInt32(dt.Rows[0]["contract_due_day"]),
                    warning = Convert.ToInt32(dt.Rows[0]["warning"]),
                    flag_visits = dt.Rows[0]["flag_visits"].ToString(),
                    created_date = dt.Rows[0]["created_date"].ToString(),
                    created_by = Convert.ToInt32(dt.Rows[0]["created_by"].ToString())
                };
            }
            else
                return null;
        }
    }

    public static int Insert(Contracts_ud contract)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Contracts_insert",
            DBClass_ud.CreateParameter("company_id", contract.company_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("contract_type", contract.contract_type, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("contract_period", contract.contract_period, SqlDbType.Int),
            DBClass_ud.CreateParameter("contract_date_from", contract.contract_date_from, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("contract_date_to", contract.contract_date_to, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("contract_discount", contract.contract_discount, SqlDbType.Int),
            DBClass_ud.CreateParameter("contract_due_day", contract.contract_due_day, SqlDbType.Int),
            DBClass_ud.CreateParameter("warning", contract.warning, SqlDbType.Int),
            DBClass_ud.CreateParameter("flag_visits", contract.flag_visits, SqlDbType.Bit),
            DBClass_ud.CreateParameter("created_date", contract.created_date, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("created_by", contract.created_by, SqlDbType.Int));
    }

    public static int Delete(int contract_id,int company_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Contracts_delete",
           DBClass_ud.CreateParameter("contract_id", contract_id, SqlDbType.Int),
           DBClass_ud.CreateParameter("company_id", company_id, SqlDbType.Int));
    }
}