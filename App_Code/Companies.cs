using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Companies_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Companies_ud
{
	public Companies_ud()
	{
        
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int company_id { get; set; }
    public string company_name { get; set; }
    public string company_address { get; set; }
    public string company_phone { get; set; }
    public string company_mobile { get; set; }
    public string company_email { get; set; }
    public string company_website { get; set; }
    public string created_date { get; set; }
    public int created_by { get; set; }
    public Int16 active { get; set; }

    #endregion

    /// <summary>
    /// Get Company_ID & Company_Name & Status
    /// status : 0 for inactive Companies_ud
    /// status : 1 for active Companies_ud
    /// status : 2 for both active & inactive Companies_ud
    /// </summary>
    /// <returns></returns>
    public static DataTable SelectCompanies_ud(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Companies_slc",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }

    /// <summary>
    /// Get All Data of Companies_ud
    /// status : 0 for inactive Companies_ud
    /// status : 1 for active Companies_ud
    /// status : 2 for both active & inactive Companies_ud
    /// </summary>
    /// <param name="status"></param>
    /// <returns></returns>
    public static DataTable SelectAllData(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Companies_slc_all",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }

    public static Companies_ud SelectByID(Companies_ud company_id)
    {
        using (DataTable dt = DBClass_ud.ExecuteTable("sp_Companies_slc_id",
            DBClass_ud.CreateParameter("company_id", company_id, SqlDbType.Int)))
        {
            if (dt.Rows.Count > 0)
            {
                return new Companies_ud
                {
                   
                    company_id = Convert.ToInt32(dt.Rows[0]["company_id"].ToString()),
                    company_name = dt.Rows[0]["company_name"].ToString(),
                    company_address = dt.Rows[0]["company_address"].ToString(),
                    company_phone = dt.Rows[0]["company_phone"].ToString(),
                    company_mobile = dt.Rows[0]["company_mobile"].ToString(),
                    company_email = dt.Rows[0]["company_email"].ToString(),
                    company_website = dt.Rows[0]["company_website"].ToString(),
                    created_date = dt.Rows[0]["created_date"].ToString(),
                    created_by = Convert.ToInt32(dt.Rows[0]["created_by"].ToString()),
                    active = Convert.ToInt16(dt.Rows[0]["active"].ToString())
                };
            }
            else
                return null;
        }
    }

    public static int Insert(Companies_ud company)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Companies_insert",
            DBClass_ud.CreateParameter("company_name", company.company_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_address", company.company_address, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_phone", company.company_phone, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_mobile", company.company_mobile, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_email", company.company_email, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_website", company.company_website, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("created_date", company.created_date, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("created_by", company.created_by, SqlDbType.Int));
    }

    public static int Update(Companies_ud company)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Companies_update",
            DBClass_ud.CreateParameter("company_id", company.company_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("company_name", company.company_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_address", company.company_address, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_phone", company.company_phone, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_mobile", company.company_mobile, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_email", company.company_email, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("company_website", company.company_website, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("active", company.active, SqlDbType.SmallInt));
    }

    public static int Delete(int company_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Companies_delete",
           DBClass_ud.CreateParameter("company_id", company_id, SqlDbType.Int));
    }
}