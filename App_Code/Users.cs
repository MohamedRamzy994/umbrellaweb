using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Security;

/// <summary>
/// Summary description for Users_
/// 
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Users_ud
{
    public Users_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region Properties
    public int user_id { get; set; }
    public int emp_id { get; set; }
    public string user_name { get; set; }
    public string user_password { get; set; }
    public string user_email { get; set; }
    public Int16 admin { get; set; }
    public Int16 active { get; set; }
    public Int16 sounds { get; set; }
    public string msounds { get; set; }
    public string theme { get; set; }

    #endregion

    /// <summary>
    /// status:0 for inactive Users_ud
    /// status:1 for active Users_ud
    /// status:2 for both active & inactive Users_ud
    /// </summary>
    /// <returns></returns>
    public static DataTable SelectAll(int status)
    {
        return DBClass_ud.ExecuteTable("sp_Users_slc_all",
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }

    /// <summary>
    /// return 4 : user is exists
    /// return 9 : user is not exists
    /// return 44: password admin
    /// return 99 : account is disabled
    /// </summary>
    /// <param name="user_name"></param>
    /// <param name="user_password"></param>
    /// <returns></returns>
    public static int Login(string user_name, string user_password)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Users_login",
            DBClass_ud.CreateParameter("user_name", user_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("user_password",user_password, SqlDbType.VarChar));
    }

    public static bool CheckMailFound(string user_email)
    {
        return Convert.ToBoolean(DBClass_ud.ExecuteScalar("sp_Users_check_email", DBClass_ud.CreateParameter("user_email", user_email, SqlDbType.VarChar)));
    }

    public static bool CheckUserNameFound(string user_name)
    {
        return Convert.ToBoolean(DBClass_ud.ExecuteScalar("sp_Users_check_username", DBClass_ud.CreateParameter("user_name", user_name, SqlDbType.VarChar)));
    }

    public static bool CheckMailFoundUpdate(int user_id,string user_email)
    {
        return Convert.ToBoolean(DBClass_ud.ExecuteScalar("sp_Users_check_email_u",
            DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("user_email", user_email, SqlDbType.VarChar)));
    }

    public static bool CheckUserNameFoundUpdate(int user_id,string user_name)
    {
        return Convert.ToBoolean(DBClass_ud.ExecuteScalar("sp_Users_check_username_u",
            DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("user_name", user_name, SqlDbType.VarChar)));
    }

    public static Users_ud SelectByID(int user_id)
    {
        using (DataTable dt = DBClass_ud.ExecuteTable("sp_Users_slc_id",
            DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int)))
        {
            if (dt.Rows.Count > 0)
            {
                return new Users_ud
                {
                    user_id = Convert.ToInt32(dt.Rows[0]["user_id"].ToString()),
                    emp_id = Convert.ToInt32(dt.Rows[0]["emp_id"].ToString()),
                    user_name = dt.Rows[0]["user_name"].ToString(),
                    user_email = dt.Rows[0]["user_email"].ToString(),
                    admin = Convert.ToInt16(dt.Rows[0]["admin"].ToString()),
                    active = Convert.ToInt16(dt.Rows[0]["active"].ToString()),
                    sounds = Convert.ToInt16(dt.Rows[0]["sounds"].ToString()),
                    msounds = dt.Rows[0]["msounds"].ToString(),
                    theme = dt.Rows[0]["theme"].ToString()
                };
            }
            else
                return null;
        }
    }

    public static Users_ud SelectByUserName(string user_name)
    {
        using (DataTable dt = DBClass_ud.ExecuteTable("sp_Users_slc_username",
            DBClass_ud.CreateParameter("user_name", user_name, SqlDbType.VarChar)))
        {
            if (dt.Rows.Count > 0)
            {
                return new Users_ud
                {
                    user_id = Convert.ToInt32(dt.Rows[0]["user_id"].ToString()),
                    user_name = dt.Rows[0]["user_name"].ToString(),
                    user_email = dt.Rows[0]["user_email"].ToString(),
                    admin = Convert.ToInt16(dt.Rows[0]["admin"].ToString()),
                    active = Convert.ToInt16(dt.Rows[0]["active"].ToString()),
                    sounds = Convert.ToInt16(dt.Rows[0]["sounds"].ToString()),
                    msounds = dt.Rows[0]["msounds"].ToString(),
                    theme = dt.Rows[0]["theme"].ToString()
                };
            }
            else
                return null;
        }
    }

    public static Users_ud SelectByUserEmail(string user_email)
    {
        using (DataTable dt = DBClass_ud.ExecuteTable("sp_Users_slc_by_email",
            DBClass_ud.CreateParameter("user_email", user_email, SqlDbType.VarChar)))
        {
            if (dt.Rows.Count > 0)
            {
                return new Users_ud
                {
                    user_name = dt.Rows[0]["user_name"].ToString(),
                    user_password = dt.Rows[0]["user_password"].ToString(),
                };
            }
            else
                return null;
        }
    }

    public static int Insert(Users_ud user)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Users_insert",
            DBClass_ud.CreateParameter("user_name", user.user_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("user_password", user.user_password, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("user_email", user.user_email, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("admin", user.admin, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("active", user.active, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("sounds","1", SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("theme", "theme-grey", SqlDbType.NVarChar));
    }

    public static int Update(Users_ud user)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Users_update",
            DBClass_ud.CreateParameter("user_id", user.user_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("user_name", user.user_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("user_password", user.user_password, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("user_email", user.user_email, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("admin", user.admin, SqlDbType.SmallInt),
            DBClass_ud.CreateParameter("active", user.active, SqlDbType.SmallInt));
    }

    public static int UpdateInfo(int user_id, string user_email)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Users_update_info",
            DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("user_email", user_email, SqlDbType.VarChar));
    }

    public static int UpdateSounds(string user_name)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Users_update_sounds",
            DBClass_ud.CreateParameter("user_name", user_name, SqlDbType.NVarChar));
    }

    public static int UpdateTheme(string user_name,string theme)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Users_update_theme",
            DBClass_ud.CreateParameter("user_name", user_name, SqlDbType.NVarChar),
            DBClass_ud.CreateParameter("theme", theme, SqlDbType.NVarChar));
    }
    public static int UpdatePassword(int user_id, string old_password, string new_password)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Users_update_pass",
            DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("old_password", old_password, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("new_password", new_password, SqlDbType.VarChar));
    }

    public static int Delete(int user_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Users_delete",
           DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int));
    }

}