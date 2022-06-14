using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Employee_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Employee_ud
{
	public Employee_ud()
	{
		//
		// TODO: Add constructor logic here
		//
    }

    #region Properties
    public int emp_id { get; set; }
    public string emp_name { get; set; }
    public string emp_address { get; set; }
    public string emp_job { get; set; }
    public string emp_identity_no { get; set; }
    public string emp_mobile { get; set; }
    public string emp_phone { get; set; }
    public string emp_birthdate { get; set; }
    public string emp_hiredate { get; set; }
    public string emp_salary { get; set; }
    public Int16 active { get; set; }
    #endregion

    /// <summary>
    /// status : 0 for inactive Employee_uds
    /// status : 1 for active Employee_uds
    /// status : 2 for both active & Inactive Employee_uds
    /// </summary>
    /// <param name="status"></param>
    /// <returns></returns>
    public static DataTable SelectAll(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Employee_slc_all",
               DBClass_ud.CreateParameter("status",status,SqlDbType.Int));
    }

    public static DataTable SelectNotUser()
    {
        return DBClass_ud.ExecuteTable("sp_emp_slc_not_user");
    }

    public static Employee_ud SelectByID(int emp_id)
    {
        using (DataTable dt = DBClass_ud.ExecuteTable("sp_Employee_slc_id",
            DBClass_ud.CreateParameter("emp_id", emp_id, SqlDbType.Int)))
        {
            if (dt.Rows.Count > 0)
            {
                return new Employee_ud
                {
                    emp_id = Convert.ToInt32(dt.Rows[0]["emp_id"].ToString()),
                    emp_name = dt.Rows[0]["emp_name"].ToString(),
                    emp_address = dt.Rows[0]["emp_address"].ToString(),
                    emp_job= dt.Rows[0]["emp_job"].ToString(),
                    emp_identity_no = dt.Rows[0]["emp_identity_no"].ToString(),
                    emp_mobile = dt.Rows[0]["emp_mobile"].ToString(),
                    emp_phone = dt.Rows[0]["emp_phone"].ToString(),
                    emp_birthdate = dt.Rows[0]["emp_birthdate"].ToString(),
                    emp_hiredate = dt.Rows[0]["emp_hiredate"].ToString(),
                    emp_salary = dt.Rows[0]["emp_salary"].ToString(),
                    active = Convert.ToInt16(dt.Rows[0]["active"].ToString())
                };
            }
            else
                return null;
        }
    }

    public static int Insert(Employee_ud emp)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Employee_insert",
            DBClass_ud.CreateParameter("emp_name", emp.emp_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_address", emp.emp_address, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_job", emp.emp_job, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_identity_no", emp.emp_identity_no, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_mobile", emp.emp_mobile, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_phone", emp.emp_phone, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_birthdate", emp.emp_birthdate, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_hiredate", emp.emp_hiredate, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_salary", emp.emp_salary, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("active", emp.active, SqlDbType.SmallInt));
    }

    public static int Update(Employee_ud emp)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Employee_update",
            DBClass_ud.CreateParameter("emp_id", emp.emp_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("emp_name", emp.emp_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_address", emp.emp_address, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_job", emp.emp_job, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_identity_no", emp.emp_identity_no, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_mobile", emp.emp_mobile, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_phone", emp.emp_phone, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_birthdate", emp.emp_birthdate, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_hiredate", emp.emp_hiredate, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("emp_salary", emp.emp_salary, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("active", emp.active, SqlDbType.SmallInt));
    }

    public static int Delete(int emp_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Employee_delete",
           DBClass_ud.CreateParameter("emp_id", emp_id, SqlDbType.Int));
    }
}