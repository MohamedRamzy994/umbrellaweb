using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.Management;
using System.Web.Security;
using System.Security.Cryptography;

/// <summary>
/// Summary description for License_ud
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class License_ud
{
    public License_ud()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static Boolean CheckLicense_ud()
    {
        if (ReadLicense_ud() == GetActivateCode(GetMachineCode()))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public static string GetMachineCode()
    {
        string cpuInfo = string.Empty;
      
        ManagementClass mc = new ManagementClass("win32_processor");
        ManagementObjectCollection moc = mc.GetInstances();

        foreach (ManagementObject mo in moc)
        {
            cpuInfo = mo.Properties["processorID"].Value.ToString();
            break;
        }
        return FormsAuthentication.HashPasswordForStoringInConfigFile(cpuInfo, "MD5");
    }

    public static string GetActivateCode(string code)
    {
        //return FormsAuthentication.HashPasswordForStoringInConfigFile(code, "MD5");
        byte[] bytes = Encoding.Unicode.GetBytes(code);
        byte[] inArray = HashAlgorithm.Create("SHA1").ComputeHash(bytes);
        return Convert.ToBase64String(inArray);
    }
    public static string ReadLicense_ud()
    {
        StringBuilder cmd = new StringBuilder();
        cmd.Append("select convert(varchar(max),DecryptByPassPhrase('maradona', code )) as code");
        cmd.Append(" from code");
        return DBClass_ud.ExecuteScalar(cmd.ToString()).ToString();
    }

    public static int SaveLicense_ud(string Code)
    {
        StringBuilder cmd = new StringBuilder();
        cmd.Append("declare @enc_code varbinary(max)");
        cmd.Append(" set @enc_code=EncryptByPassPhrase('maradona','");
        cmd.Append(Code);
        cmd.Append("')");
        cmd.Append(" update code set code=@enc_code");
        return DBClass_ud.ExecuteNonQuery(cmd.ToString());
    }
}