using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Clinic_ud
/// Eng.Moustafa Ebrahem
/// </summary>
public class Clinic_ud
{
	public Clinic_ud()
	{
		//
		// TODO: Add constructor logic here
		//
        
    }

    #region Properties
    public int Clinic_ud_id { get; set; }
    public string Clinic_ud_name { get; set; }
    public string header_line1 { get; set; }
    public string header_line2 { get; set; }
    public string header_line3 { get; set; }
    public string header_line4 { get; set; }
    public string footer_line1 { get; set; }
    public string footer_line2 { get; set; }
    public string footer_line3 { get; set; }
    #endregion

    public static DataTable SelectFinancials(string lang)
    {
        return DBClass_ud.ExecuteTable("sp_Clinic_slc",
               DBClass_ud.CreateParameter("lang", lang, SqlDbType.NVarChar));
    }
    public static Clinic_ud SelectByID()
    {
        using (DataTable dt = DBClass_ud.ExecuteTable("sp_Clinic_slc_by_id"))
        {
            if (dt.Rows.Count > 0)
            {
                return new Clinic_ud
                {
                    Clinic_ud_id = Convert.ToInt32(dt.Rows[0]["Clinic_id"].ToString()),
                    Clinic_ud_name = dt.Rows[0]["Clinic_name"].ToString(),
                    header_line1 = dt.Rows[0]["header_line1"].ToString(),
                    header_line2 = dt.Rows[0]["header_line2"].ToString(),
                    header_line3 = dt.Rows[0]["header_line3"].ToString(),
                    header_line4 = dt.Rows[0]["header_line4"].ToString(),
                    footer_line1 = dt.Rows[0]["footer_line1"].ToString(),
                    footer_line2 = dt.Rows[0]["footer_line2"].ToString(),
                    footer_line3 = dt.Rows[0]["footer_line3"].ToString()
                };
            }
            else
                return null;
        }
    }

    public static int Update(Clinic_ud Clinic_ud)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Clinic_update",
            DBClass_ud.CreateParameter("header_line1", Clinic_ud.header_line1, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("header_line2", Clinic_ud.header_line2, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("header_line3", Clinic_ud.header_line3, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("header_line4", Clinic_ud.header_line4, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("footer_line1", Clinic_ud.footer_line1, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("footer_line2", Clinic_ud.footer_line2, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("footer_line3", Clinic_ud.footer_line3, SqlDbType.VarChar));
    }
}