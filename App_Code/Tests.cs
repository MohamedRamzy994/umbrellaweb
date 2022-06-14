using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Tests
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Tests
{
	public Tests()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    #region Properties
    public int test_id { get; set; }
    public string test_name { get; set; }
    public string test_type { get; set; }
    public Int16 active { get; set; }
    #endregion

    /// <summary>
    /// center_type : b for Blood Tests
    /// center_type : s for Scan Tests
    /// ///////////////////////////////
    /// status : 0 for inactive tests
    /// status : 1 for active tests
    /// status : 2 for both active & inactive tests
    /// </summary>
    /// <param name="test_type"></param>
    /// <returns></returns>
    public static DataTable SelectAll(string test_type,int status)
    {
        return DBClass_ud
            
            .ExecuteTable("sp_tests_slc_all",
               DBClass_ud.CreateParameter("test_type", test_type, SqlDbType.VarChar),
               DBClass_ud.CreateParameter("status", status, SqlDbType.Int));
    }

    public static int Insert(Tests test)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_tests_insert",
            DBClass_ud.CreateParameter("test_name", test.test_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("test_type", test.test_type, SqlDbType.VarChar));
    }

    public static int Update(Tests test)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_tests_update",
            DBClass_ud.CreateParameter("test_id", test.test_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("test_name", test.test_name, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("active", test.active, SqlDbType.Bit));
    }

    public static int Delete(int test_id)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_tests_delete",
           DBClass_ud.CreateParameter("test_id", test_id, SqlDbType.Int));
    }
}