using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Pat_Requests_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Pat_Requests_ud
{
    public Pat_Requests_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region Properties
    public int pat_request_id { get; set; }
    public int pat_visit_id { get; set; }
    public int pat_request_det_id { get; set; }
    public int test_id { get; set; }
    #endregion

    /// <summary>
    /// Datatable[0] : Blood Test Requests
    /// Datatable[1] : Scans Requests
    /// </summary>
    /// <param name="pat_visit_id"></param>
    /// <returns></returns>
    public static DataSet SelectRequests(int pat_visit_id)
    {
        return DBClass_ud.ExecuteDataSet("sp_Pat_Requests_ud_slc",
               DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int));
    }

    public static int SaveRequests(int pat_visit_id,string test_id,string test_type)
    {
        return DBClass_ud.ExecuteNonQueryReturnValue("sp_Pat_Requests_ud_save",
            DBClass_ud.CreateParameter("pat_visit_id", pat_visit_id, SqlDbType.Int),
            DBClass_ud.CreateParameter("test_id",test_id, SqlDbType.VarChar),
            DBClass_ud.CreateParameter("test_type", test_type, SqlDbType.VarChar));
    }
}