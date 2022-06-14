using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Drawing;

public partial class ForgotPassword : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    protected void Page_Load(object sender, EventArgs e)
    {
        if (user != null)
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }
    }

    protected void btnSendEmail_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (Users_ud.CheckMailFound(txtEmail.Value.Trim()))
                {
                    Users_ud user = Users_ud.SelectByUserEmail(txtEmail.Value.Trim());
                    StringBuilder emailMessage = new StringBuilder();
                    emailMessage.Append("<b>Hello, ");
                    emailMessage.Append("<i>");
                    emailMessage.Append(user.user_name);
                    emailMessage.Append("</i>");
                    emailMessage.Append("</b>");
                    emailMessage.Append("<br />");
                    emailMessage.Append("<br />");
                    emailMessage.Append("<b>According to your request,your login information to Umbrella application are:");
                    emailMessage.Append("</b>");
                    emailMessage.Append("<br />");
                    emailMessage.Append("<br />");
                    emailMessage.Append("<b>UserName: ");
                    emailMessage.Append("</b>");
                    emailMessage.Append(user.user_name);
                    emailMessage.Append("<br />");
                    emailMessage.Append("<b>Password: ");
                    emailMessage.Append("</b>");
                    emailMessage.Append(user.user_password);
                    emailMessage.Append("<br />");
                    emailMessage.Append("<br />");
                    emailMessage.Append("<b>If you still unable to login to the system please contact your administrator");
                    emailMessage.Append("</b>");
                    emailMessage.Append("<br />");
                    emailMessage.Append("<br />");
                    emailMessage.Append("<b>If you have further questions feel free to contact us on this email:");
                    emailMessage.Append("<br />");
                    emailMessage.Append("DeltaMedIt@Gmail.com");
                    emailMessage.Append("</b>");
                    emailMessage.Append("<br />");
                    emailMessage.Append("<br />");
                    emailMessage.Append("<b>Please follow us on facebook so you get our news");
                    emailMessage.Append("<br />");
                    emailMessage.Append("https://www.facebook.com/DeltaMedIT");
                    emailMessage.Append("</b>");
                    Mail.SendMail("Umbrella - Login Information", txtEmail.Value.Trim(), emailMessage.ToString(), true);
                    lblInfo.ForeColor = Color.Blue;
                    lblInfo.Text = "Login informatin has been sent to your email";
                }
                else
                {
                    lblInfo.ForeColor = Color.Red;
                    lblInfo.Text = "No account found with this Email address";
                }

            }
            catch (Exception ex)
            {
                lblInfo.ForeColor = Color.Red;
                lblInfo.Text = ex.Message;
            }
        }
    }

    #region User Session
    /// <summary>
    /// Property for current User's Information
    /// </summary>
    public Users_ud user
    {
        get
        {
            if (Session["user"] != null)
            {
                return (Users_ud)Session["user"];
            }
            else
            {
                // that means the session is timeout so should check cookie
                HttpCookie infoCookie = HttpContext.Current.Request.Cookies["info"];
                if (infoCookie != null)
                {
                    Users_ud user = Users_ud.SelectByUserName(mEncryption_ud.Decrypt(infoCookie.Value));
                    Session["user"] = user;
                    return user;
                }
                else
                {
                    // that means the session is timeout so user must be directed to Default Page
                    return null;
                }
            }
        }
    }
    #endregion
}