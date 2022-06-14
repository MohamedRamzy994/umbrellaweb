using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Company_Pat_Det_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Company_Pat_Det_ud
{
	public Company_Pat_Det_ud()
	{
		//
		// TODO: Add constructor logic here
		//
       
	}
    #region Properties
    public int company_id { get; set; }
    public int pat_id { get; set; }
    #endregion


    public static DataTable SelectCompanies_ud(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Companies_slc",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }

    public static DataTable SelectPatients_udOfCompany(int company_id)
    {
        return DBClass_ud.ExecuteTable("sp_Company_Pat_Det_slc",
               DBClass_ud.CreateParameter("company_id", company_id, SqlDbType.Int));
    }

    public static DataTable SelectAllPatients_ud()
    {
        return DBClass_ud.ExecuteTable("sp_Company_Pat_Det_slc_all");
    }

    public static int Insert(Company_Pat_Det_ud comp)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Company_Pat_Det_insert",
               DBClass_ud.CreateParameter("company_id", comp.company_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("pat_id", comp.pat_id, SqlDbType.Int));
    }

    public static int Delete(int Company_Pat_Det_ud_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Company_Pat_Det_delete",
               DBClass_ud.CreateParameter("Company_Pat_Det_id", Company_Pat_Det_ud_id, SqlDbType.Int));
    }
}