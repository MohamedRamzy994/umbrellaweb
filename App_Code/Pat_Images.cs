using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Images_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Images_ud
{
    public Pat_Images_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }


    #region Properties
    public int pat_img_id { get; set; }
    public int pat_id { get; set; }
    public string pat_img_url { get; set; }
    public string pat_img_desc { get; set; }
    public string pat_img_date { get; set; }
    #endregion

    public static DataTable SelectAllimgs()
    {
        return DBClass_ud.ExecuteTable("sp_imgs_slc_all");
    }

    public static DataTable PatImages(int pat_id,string path)
    {
        return DBClass_ud.ExecuteTable("sp_rpt_Pat_Images_slc",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int),
               DBClass_ud.CreateParameter("path", path, SqlDbType.VarChar));
    }
    public static object Selectimgs_id(int id)
    {
        return DBClass_ud.ExecuteScalar("sp_imgs_slc_id",
               DBClass_ud.CreateParameter("id", id, SqlDbType.Int));
    }
    public static int Insertimgs(byte[] img)
    {
        return DBClass_ud.ExecuteNonQuery("sp_imgs_insert",
            DBClass_ud.CreateParameter("img", img, SqlDbType.Image));
    }

    public static DataTable SelectAll(int pat_id)
    {
        return DBClass_ud.ExecuteTable("sp_Pat_Images_slc_all",
               DBClass_ud.CreateParameter("pat_id", pat_id, SqlDbType.Int));
    }

    public static Pat_Images_ud SelectByID(int pat_img_id)
    {
        using (DataTable dt = DBClass_ud.ExecuteTable("sp_Pat_Images_slc_id",
            DBClass_ud.CreateParameter("pat_img_id", pat_img_id, SqlDbType.Int)))
        {
            if (dt.Rows.Count > 0)
            {
                return new Pat_Images_ud
                {
                    pat_img_id = Convert.ToInt32(dt.Rows[0]["pat_img_id"].ToString()),
                    pat_id = Convert.ToInt32(dt.Rows[0]["pat_id"].ToString()),
                    pat_img_url = dt.Rows[0]["pat_img_url"].ToString(),
                    pat_img_desc = dt.Rows[0]["pat_img_desc"].ToString(),
                    pat_img_date = dt.Rows[0]["pat_img_date"].ToString()
                };
            }
            else
                return null;
        }
    }

    public static int GetImageID()
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Images_get_img_id");
    }
    public static int Insert(Pat_Images_ud img)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Images_insert",
            DBClass_ud.CreateParameter("pat_img_id", img.pat_img_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_id", img.pat_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_img_url", img.pat_img_url, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_img_desc", img.pat_img_desc, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("pat_img_date", img.pat_img_date, SqlDbType.VarChar));
    }

    public static int Update(Pat_Images_ud img)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Images_update",
            DBClass_ud.CreateParameter("pat_img_id", img.pat_img_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("pat_img_desc", img.pat_img_desc, SqlDbType.VarChar));
    }

    public static string Delete(int pat_img_id)
    {
        return (DBClass_ud.ExecuteScalar("sp_Pat_Images_delete",
           DBClass_ud.CreateParameter("pat_img_id", pat_img_id, SqlDbType.Int))).ToString();
    }
}