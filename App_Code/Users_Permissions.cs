using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;

/// <summary>
/// Summary description for Users_ud_Permissions
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Users_ud_Permissions
{
    public Users_ud_Permissions()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region Properties
    public int user_id { get; set; }
    public int page_id { get; set; }
    public bool can_view { get; set; }
    public bool can_save { get; set; }
    public bool can_update { get; set; }
    public bool can_delete { get; set; }
    public bool can_print { get; set; }
    #endregion

    public static DataTable SelectUsers_udPermSections(int user_id)
    {
        return DBClass_ud.ExecuteTable("sp_Users_perm_sections",
               DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int));
    }

    public static DataTable SelectPermPages(string section_id)
    {
        return DBClass_ud.ExecuteTable("sp_Users_perm_pages",
               DBClass_ud.CreateParameter("section_id", section_id, SqlDbType.VarChar));
    }

    public static DataTable SelectPermPagesLang(string section_id,string lang)
    {
        return DBClass_ud.ExecuteTable("sp_Users_perm_pages_lang",
               DBClass_ud.CreateParameter("section_id", section_id, SqlDbType.NVarChar),
               DBClass_ud.CreateParameter("lang", lang, SqlDbType.NVarChar));
    }
    public static DataTable SelectUsers_udPermPages(int user_id,string section_id)
    {
        return DBClass_ud.ExecuteTable("sp_Users_perm_by_sec",
               DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("section_id", section_id, SqlDbType.VarChar));
    }
    
    public static DataTable SelectUsers_udSectionPerm(string user_id, string section_id)
    {
        return DBClass_ud.ExecuteTable("sp_Users_perm_slc_all",
               DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("section_id", section_id, SqlDbType.Int));
    }

    public static DataTable SelectUsers_udPermAll(int user_id)
    {
        return DBClass_ud.ExecuteTable("sp_Users_perm_pages_sec",
               DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int));
    }
    public static int SaveUsers_udPerm(Users_ud_Permissions usr)
    {
        return DBClass_ud.ExecuteNonQuery("sp_Users_perm_save",
               DBClass_ud.CreateParameter("user_id", usr.user_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("page_id", usr.page_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("can_view", usr.can_view, SqlDbType.Bit),
               DBClass_ud.CreateParameter("can_save", usr.can_save, SqlDbType.Bit),
               DBClass_ud.CreateParameter("can_update", usr.can_update, SqlDbType.Bit),
               DBClass_ud.CreateParameter("can_delete", usr.can_delete, SqlDbType.Bit),
               DBClass_ud.CreateParameter("can_print", usr.can_print, SqlDbType.Bit));
    }

    public static DataTable GetUserPagePerm(int user_id, string page_name)
    {
        return DBClass_ud.ExecuteTable("sp_Users_perm_slc_page",
       DBClass_ud.CreateParameter("user_id", user_id, SqlDbType.Int),
       DBClass_ud.CreateParameter("page_name", page_name, SqlDbType.VarChar));
    }

    public static void ApplyPagePerm(List<System.Web.UI.WebControls.Button> btns_lst, DataTable dt)
    {
        if (btns_lst.Count > 0 && dt.Rows.Count > 0)
        {
            foreach (Button btn in btns_lst)
            {
                if (btn != null)
                {
                    if (!Convert.ToBoolean(dt.Rows[0]["can_save"]))
                    {
                        if (btn.CommandArgument == "save")
                        {
                            btn.Visible = false;
                        }
                    }
                    if (!Convert.ToBoolean(dt.Rows[0]["can_update"]))
                    {
                        if (btn.CommandArgument == "update")
                        {
                            btn.Visible = false;
                        }
                    }
                    if (!Convert.ToBoolean(dt.Rows[0]["can_delete"]))
                    {
                        if (btn.CommandArgument == "delete")
                        {
                            btn.Visible = false;
                        }
                    }
                    if (!Convert.ToBoolean(dt.Rows[0]["can_print"]))
                    {
                        if (btn.CommandArgument == "print")
                        {
                            btn.Visible = false;
                        }
                    }
                }
            }
        }
    }
    public static string[] GetUserAllPagesPerm(string page_name, DataTable dt)
    {
        string[] perm = new string[5];
        if (dt != null)
        {
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row["page_name_en"].ToString() == page_name)
                    {
                        if (Convert.ToBoolean(row["can_view"]))
                        {
                            perm[0] = "1";
                        }
                        else
                        {
                            perm[0] = "0";
                        }
                        if (Convert.ToBoolean(row["can_save"]))
                        {
                            perm[1] = "1";
                        }
                        else
                        {
                            perm[1] = "0";
                        }
                        if (Convert.ToBoolean(row["can_update"]))
                        {
                            perm[2] = "1";
                        }
                        else
                        {
                            perm[2] = "0";
                        }
                        if (Convert.ToBoolean(row["can_delete"]))
                        {
                            perm[3] = "1";
                        }
                        else
                        {
                            perm[3] = "0";
                        }
                        if (Convert.ToBoolean(row["can_print"]))
                        {
                            perm[4] = "1";
                        }
                        else
                        {
                            perm[4] = "0";
                        }
                        break;
                    }
                }
                return perm;
            }
            else
            {
                return perm = null;
            }
        }
        else
        {
            return perm = null;
        }
    }
    public static void ApplyUserPagePerm(List<System.Web.UI.WebControls.Button> btns_lst, string[] perm)
    {
        if (perm.Length > 0)
        {
            foreach (Button btn in btns_lst)
            {
                if (btn != null)
                {
                    if (perm[1] == "0")
                    {
                        if (btn.CommandArgument == "save")
                        {
                            btn.Visible = false;
                        }
                    }
                    if (perm[2] == "0")
                    {
                        if (btn.CommandArgument == "update")
                        {
                            btn.Visible = false;
                        }
                    }
                    if (perm[3] == "0")
                    {
                        if (btn.CommandArgument == "delete")
                        {
                            btn.Visible = false;
                        }
                    }
                    if (perm[4] == "0")
                    {
                        if (btn.CommandArgument == "print")
                        {
                            btn.Visible = false;
                        }
                    }
                }
            }
        }
    }
}