using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
/// <summary>
/// Done By: Eng.Moustafa Ebrahem
/// Date : 23/12/2013
/// Summary description for DBClass_ud
/// </summary>
public class DBClass_ud
{
    
    static string connectionString = ConfigurationManager.ConnectionStrings["UmbrellaConnectionString"].ToString();

    public static SqlParameter CreateParameter(string name,object value,SqlDbType type)
    {
        SqlParameter pr = new SqlParameter(name, value);
        pr.SqlDbType = type;
        return pr;
    }

    public static SqlParameter CreateParameterOut(string name, object value, SqlDbType type)
    {
        SqlParameter pr = new SqlParameter(name, value);
        pr.SqlDbType = type;
        pr.Direction = ParameterDirection.InputOutput;
        return pr;
    }
    static SqlDataAdapter CreateAdapter(string query, params SqlParameter[] prmArray)
    {
        SqlDataAdapter sqlDa = new SqlDataAdapter(query, connectionString);
        if (!query.Contains(" "))
        {
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            if (prmArray.Length > 0)
                sqlDa.SelectCommand.Parameters.AddRange(prmArray);
        }
        
        return sqlDa;
    }

    public static DataTable ExecuteTable(string query, params SqlParameter[] prmArray)
    {
        SqlDataAdapter sqlDa = CreateAdapter(query, prmArray);
        DataTable dt = new DataTable();
        sqlDa.Fill(dt);
        return dt;
    }

    public static List<object> ExecuteTableOutParameter(string query,string OutParameterName ,params SqlParameter[] prmArray)
    {
        SqlDataAdapter sqlDa = CreateAdapter(query, prmArray);
        DataTable dt = new DataTable();
        sqlDa.Fill(dt);
        object OutParameter = sqlDa.SelectCommand.Parameters[OutParameterName].Value;
        List<object> lst = new List<object>(2);
        lst.Add(dt);
        lst.Add(OutParameter);
        return lst;
    }

    public static DataSet ExecuteDataSet(string query, params SqlParameter[] prmArray)
    {
        SqlDataAdapter sqlDa = CreateAdapter(query, prmArray);
        DataSet ds = new DataSet();
        sqlDa.Fill(ds);
        return ds;
    }

    static SqlCommand CreateCommand(string query, params SqlParameter[] prmArray)
    {
        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(query, con);
        if (!query.Contains(' '))
            cmd.CommandType = CommandType.StoredProcedure;
        if (prmArray.Length > 0)
            cmd.Parameters.AddRange(prmArray);
        con.Open();
        return cmd;
    }

    public static int ExecuteNonQuery(string query, params SqlParameter[] prmArray)
    {
        SqlCommand cmd = CreateCommand(query, prmArray);

        int count = cmd.ExecuteNonQuery();
        cmd.Connection.Close();
        return count;
    }

    public static int ExecuteNonQueryReturnValue(string query, params SqlParameter[] prmArray)
    {
        SqlCommand cmd = CreateCommand(query, prmArray);
        var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
        returnParameter.Direction = ParameterDirection.ReturnValue;
        cmd.ExecuteNonQuery();
        var result = returnParameter.Value;
        return (int)result;
    }

    public static object ExecuteScalar(string query, params SqlParameter[] prmArray)
    {
        SqlCommand cmd = CreateCommand(query, prmArray);
        object  scalar = cmd.ExecuteScalar();
        cmd.Connection.Close();
        return scalar;
    }

    public static SqlDataReader ExecuteReader(string query, params SqlParameter[] prmArray)
    {
        SqlCommand cmd = CreateCommand(query, prmArray);
        SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);        
        return reader;
    }
}