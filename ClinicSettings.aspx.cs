using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Threading;
using System.Globalization;

public partial class Clinic_udSettings : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    List<System.Web.UI.WebControls.Button> btns_lst = new List<System.Web.UI.WebControls.Button>();
    private void FindButtons(ControlCollection cc)
    {
        foreach (Control c in cc)
        {
            if (c is System.Web.UI.WebControls.Button)
                btns_lst.Add(c as System.Web.UI.WebControls.Button);
            else if (c.Controls.Count > 0)
                FindButtons(c.Controls);
        }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check Session["user"] that contains Current User's Information
        if (user == null)
        {
            
            Response.Redirect("~/Default.aspx", false);
            return;
        }
        if (!IsPostBack)
        {
            if (user.admin == 1)
            {
                // bind Current UserName
                //lblUserName.Text = user.user_name;
                BindClinic_udData();
            }
            else
            {
                using (DataTable dt = Users_ud_Permissions.GetUserPagePerm(user.user_id, Path.GetFileName(Request.Url.AbsolutePath)))
                {
                    if (dt.Rows.Count > 0)
                    {
                        if (Convert.ToBoolean(dt.Rows[0]["can_view"]))
                        {
                            FindButtons(Page.Controls);
                            Users_ud_Permissions.ApplyPagePerm(btns_lst, dt);
                            // bind Current UserName
                            // lblUserName.Text = user.user_name;
                            BindClinic_udData();
                        }
                        else
                        {
                            Response.Redirect("~/NoPerm.aspx", false);
                            return;
                        }
                    }
                    else
                    {
                        Response.Redirect("~/NoPerm.aspx", false);
                        return;
                    }
                }
            }

        }
    }

    #region Clinic_uds Tab
    protected void BindClinic_udData()
    {
        try
        {
            Clinic_ud clc = Clinic_ud.SelectByID();
            txtHeadeLine1.Value = clc.header_line1;
            txtHeaderLine2.Value = clc.header_line2;
            txtHeaderLine3.Value = clc.header_line3;
            txtHeaderLine4.Value = clc.header_line4;
            txtFooterLine1.Value = clc.footer_line1;
            txtFooterLine2.Value = clc.footer_line2;
            txtFooterLine3.Value = clc.footer_line3;
        }
        catch (Exception ex)
        {
            // show the error message
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    protected void btnClinic_udSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                // get the data from user and insert into Clinic_uds table
                // if the returned value is equal to '4' that means successful operation
                if (Clinic_ud.Update(new Clinic_ud
                {
                    header_line1 = txtHeadeLine1.Value,
                    header_line2 = txtHeaderLine2.Value,
                    header_line3 = txtHeaderLine3.Value,
                    header_line4 = txtHeaderLine4.Value,
                    footer_line1 = txtFooterLine1.Value,
                    footer_line2 = txtFooterLine2.Value,
                    footer_line3 = txtFooterLine3.Value
                }) == 4)
                {
                    // Show the success message 
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true,null);
                }
                else
                {
                    BindClinic_udData();
                    //returned value is equal to '9' (!= 4) means that failed operation
                    // show the error message
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, null);
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }

    #endregion


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
                try
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
                        Response.Redirect("~/Default.aspx",false);
                        return null;
                    }
                }
                catch (Exception ex)
                {

                    mNotifications.Notify(this.Page, mNotifications.mNotifyType.error_general, ex.Message, true, null);
                    return null;
                }

            }
        }
    }
    #endregion

    #region Link Buttons
    protected void btnSaveTheme_Click(object sender, EventArgs e)
    {
        try
        {
            Users_ud.UpdateTheme(user.user_name, "theme-" + hfTheme.Value);
            Session["user"] = Users_ud.SelectByUserName(user.user_name);
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    #endregion
}