using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Threading;
using System.Globalization;
using System.Web.UI.HtmlControls;

public partial class TestsSettings : BasePage
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
    protected override void InitializeCulture()
    {
        if (Session["lang"] != null)
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["lang"].ToString());
        else
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("ar");
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
                // Bind Blood Tests GridView
                BindBloodGridView();
                // Bind Scans GridView
                BindScansGridView();
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
                            //lblUserName.Text = user.user_name;
                            // Bind Blood Tests GridView
                            BindBloodGridView();
                            // Bind Scans GridView
                            BindScansGridView();

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

    #region Blood Tests Tab1
    protected void BindBloodGridView()
    {
        try
        {
            // Bind Blood Tests GridView
            WorkParams_ud.BindGridView(gvBloodTests, Tests.SelectAll("b", 2));
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    protected void btnBloodSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtBloodID.Value.Trim() == "")
                {
                    // get the data from user and insert into Tests Table 
                    // if the returned value is equal to '4' that means successful operation
                    if (Tests.Insert(new Tests
                    {
                        test_name = txtBloodName.Value,
                        test_type = "b"
                    }) == 4)
                    {
                        BindBloodGridView();
                        // Show the success message in the div with id: t1 and call method ClearBloodtbl(); and reset drpSearchgvBlood control to default value
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearBloodtbl();", "ClearSearchAttrBlood();");
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        BindBloodGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearBloodtbl();", "ClearSearchAttrBlood();");
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }
    protected void btnBloodUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtBloodID.Value.Trim() != "")
                {
                    // if the returned value is equal to '4' that means successful operation
                    if (Tests.Update(new Tests
                    {
                        test_id = Convert.ToInt32(txtBloodID.Value),
                        test_name = txtBloodName.Value.Trim(),
                        active = Convert.ToInt16(drpBloodStatus.SelectedValue)
                    }) == 4)
                    {
                        BindBloodGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "", true, "ClearBloodtbl();", "ClearSearchAttrBlood();");
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        BindBloodGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearBloodtbl();", "ClearSearchAttrBlood();");
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }

        }
    }
    protected void btnBloodDelete_Click(object sender, EventArgs e)
    {

        try
        {
            if (txtBloodID.Value.Trim() != "")
            {
                // if the returned value is equal to '4' that means successful operation
                if (Tests.Delete(Convert.ToInt32(txtBloodID.Value)) == 4)
                {
                    BindBloodGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true, "ClearBloodtbl();", "ClearSearchAttrBlood();");
                }
                else
                {
                    // returned value is equal to '9' (!= 4) means that failed operation
                    // that means that this record are used in other place so it will be set to Inactive
                    BindBloodGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_delete, "", true, "ClearBloodtbl();", "ClearSearchAttrBlood();");
                }
            }
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    #endregion

    #region Scans Tab2
    protected void BindScansGridView()
    {
        try
        {
            WorkParams_ud.BindGridView(gvScans, Tests.SelectAll("s", 2));
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    protected void btnScanSave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtScanID.Value.Trim() == "")
                {

                    if (Tests.Insert(new Tests
                    {
                        test_name = txtScanName.Value.Trim(),
                        test_type = "s"
                    }) == 4)
                    {
                        BindScansGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearScantbl();", "ClearSearchAttrScan();");
                    }
                    else
                    {
                        BindScansGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearScantbl();", "ClearSearchAttrScan();");
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }
    protected void btnScanUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtScanID.Value.Trim() != "")
                {
                    if (Tests.Update(new Tests
                    {
                        test_id = Convert.ToInt32(txtScanID.Value),
                        test_name = txtScanName.Value.Trim(),
                        active = Convert.ToInt16(drpScanStatus.SelectedValue)
                    }) == 4)
                    {
                        BindScansGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "", true, "ClearScantbl();", "ClearSearchAttrScan();");
                    }
                    else
                    {
                        BindScansGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearScantbl();", "ClearSearchAttrScan();");
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }

        }
    }
    protected void btnScanDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtScanID.Value.Trim() != "")
            {
                if (Tests.Delete(Convert.ToInt32(txtScanID.Value)) == 4)
                {
                    BindScansGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true, "ClearScantbl();", "ClearSearchAttrScan();");
                }
                else
                {
                    BindScansGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_delete, "", true, "ClearScantbl();", "ClearSearchAttrScan();");
                }
            }
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    #endregion

    #region User Theme
    /// <summary>
    /// Property for Current User's Theme
    /// </summary>
    private string userTheme;
    public string UserTheme
    {
        get
        {
            if (Session["theme"] == null)
            {
                userTheme = "theme-grey";
            }
            else
            {
                userTheme = Session["theme"].ToString();
            }
            return userTheme;
        }
        set { userTheme = value; }
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