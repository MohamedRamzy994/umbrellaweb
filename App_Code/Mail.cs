using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;
using System.Net.Mail;

/// <summary>
/// Summary description for Mail
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class Mail
{
	public Mail()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static void SendMail(string Subject,string mailTo , string content, bool IsHtml)
    {
        //Create Mail Message Object with content that you want to send with mail.
        System.Net.Mail.MailMessage MyMailMessage = new System.Net.Mail.MailMessage("ramzymohamed790@gmail.com", mailTo, Subject, content);

        MyMailMessage.IsBodyHtml = IsHtml;

        //Proper Authentication Details need to be passed when sending email from gmail
        System.Net.NetworkCredential mailAuthentication = new System.Net.NetworkCredential("ramzymohamed790@gmail.com", "Ruzell7777");

        //Smtp Mail server of Gmail is "smpt.gmail.com" and it uses port no. 587
        System.Net.Mail.SmtpClient mailClient = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587);

        //Enable SSL
        mailClient.EnableSsl = true;

        mailClient.UseDefaultCredentials = false;

        mailClient.Credentials = mailAuthentication;

        mailClient.Send(MyMailMessage);
    }
}
