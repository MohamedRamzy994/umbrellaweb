using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Expenses_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Expenses_ud
{
	public Expenses_ud()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties
    public int expense_id { get; set; }
    public string expense_name { get; set; }
    public string expense_code { get; set; }
    public decimal expense_balance { get; set; }
    #endregion

    public static DataTable SelectAll(string lang)
    {
        return DBClass_ud.ExecuteTable("sp_Expenses_slc_all",
               DBClass_ud.CreateParameter("lang", lang, SqlDbType.NVarChar));
    }
}