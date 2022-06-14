using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;

public partial class _Default : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //try
            //{
            //    if (!License_ud.CheckLicense_ud())
            //    {
            //        Session["chk"] = "Moustafa_Ebrahem";
            //        Response.Redirect("~/Activation.aspx", false);
            //        return;
            //    }
            //}
            //catch (Exception)
            //{
            //    Session["chk"] = "Moustafa_Ebrahem";
            //    Response.Redirect("~/Activation.aspx", false);
            //    return;
            //}
            try
            {
                if (Session["user"] == null)
                {
                    HttpCookie infoCookie = HttpContext.Current.Request.Cookies["info"];
                    if (infoCookie != null)
                    {
                        Session["user"] = Users_ud.SelectByUserName(mEncryption_ud.Decrypt(infoCookie.Value));
                        Response.Redirect("~/Home.aspx", false);
                        return;
                    }
                    else
                    {
                        //
                    }
                }
                else
                {
                    Response.Redirect("~/Home.aspx", false);
                    return;
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "Exception('" + ex.Message.Replace("'", " ") + "')", true);
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                UserLogin();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "Exception('" + ex.Message.Replace("'", " ") + "')", true);
            }
        }
    }
    protected void UserLogin()
    {

        int state = Users_ud.Login(txtUserName.Value.Trim(), txtPassword.Value);
        if (state == 4)
        {
            if (chkRememberMe.Checked)
            {
                HttpCookie infoCookie = new HttpCookie("info", mEncryption_ud.Encrypt(txtUserName.Value.Trim()));
                infoCookie.Expires = DateTime.Now.AddDays(7);
                Response.Cookies.Add(infoCookie);
            }
            else
            {
                HttpCookie infoCookie = new HttpCookie("info", mEncryption_ud.Encrypt(txtUserName.Value.Trim()));
                infoCookie.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(infoCookie);
            }
            Users_ud user = Users_ud.SelectByUserName(txtUserName.Value.Trim());
            Session["user"] = user;
            Response.Redirect("~/Home.aspx", false);
            return;
        }
        else if (state == 9)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "LoginError();", true);
        }
        else if (state == 99)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "AccountDisabled();", true);
        }
        else if (state == 44)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "PasswordReset();", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ErrorM();", true);
        }
    }
}