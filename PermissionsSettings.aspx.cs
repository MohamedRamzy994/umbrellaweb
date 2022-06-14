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

public partial class PermissionsSettings : BasePage
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
                // lblUserName.Text = user.user_name;
                // Bind Users_ud Drp
                BindUsers_udDrp();
                // Bind Permissions GridView
                BindPermGridView();
                // Get User Sections Perm
                GetUsers_udectionsPerm();
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
                            // Bind Users_ud Drp
                            BindUsers_udDrp();
                            // Bind Permissions GridView
                            BindPermGridView();
                            // Get User Sections Perm
                            GetUsers_udectionsPerm();
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

    #region Permissions Tab

    protected void BindUsers_udDrp()
    {
        try
        {
            WorkParams_ud.BindDropDownList(drpUsers_ud, Users_ud.SelectAll(1), "User_name", "user_id", null);
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    protected void BindPermGridView()
    {
        try
        {
            if (Session["lang"] != null)
            {
                WorkParams_ud.BindGridView(gvPerm, Users_ud_Permissions.SelectPermPagesLang(drpSections.SelectedValue, Session["lang"].ToString()));
            }
            else
            {
                WorkParams_ud.BindGridView(gvPerm, Users_ud_Permissions.SelectPermPagesLang(drpSections.SelectedValue, "ar"));
            }
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    protected void GetUsers_udectionsPerm()
    {
        try
        {
            using (DataTable dt = Users_ud_Permissions.SelectUsers_udSectionPerm(drpUsers_ud.SelectedValue, drpSections.SelectedValue))
            {
                if (dt.Rows.Count > 0)
                {
                    if (drpSections.SelectedValue == "1")
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["page_id"].ToString() == "2")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "3")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "4")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "5")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "6")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "7")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                        }
                    }
                    else if (drpSections.SelectedValue == "2")
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["page_id"].ToString() == "1")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                        }
                    }
                    else if (drpSections.SelectedValue == "3")
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["page_id"].ToString() == "8")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "9")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "10")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "11")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "12")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[4].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "13")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[5].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "14")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[6].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[6].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[6].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[6].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[6].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "15")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[7].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[7].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[7].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[7].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[7].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "16")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[8].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[8].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[8].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[8].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[8].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "17")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[9].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[8].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[9].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[9].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[9].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "18")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[10].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[10].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[10].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[10].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[10].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                        }
                    }
                    else if (drpSections.SelectedValue == "4")
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["page_id"].ToString() == "19")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "20")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[1].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "21")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[2].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                            else if (dt.Rows[i]["page_id"].ToString() == "22")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_save"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[3].FindControl("chksave") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_update"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[4].FindControl("chkupdate") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_delete"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[5].FindControl("chkdelete") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[3].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                        }
                    }
                    else if (drpSections.SelectedValue == "5")
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["page_id"].ToString() == "23")
                            {
                                if (dt.Rows[i]["can_view"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[2].FindControl("chkview") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                                if (dt.Rows[i]["can_print"].ToString() == "True")
                                {
                                    CheckBox chk = (CheckBox)gvPerm.Rows[0].Cells[6].FindControl("chkprint") as CheckBox;
                                    if (chk != null)
                                    {
                                        chk.Checked = true;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                }
            }
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    protected void drpPerm_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindPermGridView();
        GetUsers_udectionsPerm();
    }
    protected void drpUsers_ud_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindPermGridView();
        GetUsers_udectionsPerm();
    }
    protected void btnPermSave_Click(object sender, EventArgs e)
    {
        try
        {
            for (int i = 0; i < gvPerm.Rows.Count; i++)
            {
                int page_id = Convert.ToInt32(gvPerm.Rows[i].Cells[0].Text);
                bool view = false;
                CheckBox chkView = gvPerm.Rows[i].Cells[3].FindControl("chkview") as CheckBox;
                if (chkView != null && chkView.Enabled && chkView.Checked)
                {
                    view = true;
                }
                bool save = false;
                CheckBox chkSave = gvPerm.Rows[i].Cells[4].FindControl("chksave") as CheckBox;
                if (chkSave != null && chkSave.Enabled && chkSave.Checked)
                {
                    save = true;
                }
                bool update = false;
                CheckBox chkUpdate = gvPerm.Rows[i].Cells[5].FindControl("chkupdate") as CheckBox;
                if (chkUpdate != null && chkUpdate.Enabled && chkUpdate.Checked)
                {
                    update = true;
                }
                bool delete = false;
                CheckBox chkDelete = gvPerm.Rows[i].Cells[6].FindControl("chkdelete") as CheckBox;
                if (chkDelete != null && chkDelete.Enabled && chkDelete.Checked)
                {
                    delete = true;
                }
                bool print = false;
                CheckBox chkPrint = gvPerm.Rows[i].Cells[7].FindControl("chkprint") as CheckBox;
                if (chkPrint != null && chkPrint.Enabled && chkPrint.Checked)
                {
                    print = true;
                }
                Users_ud_Permissions.SaveUsers_udPerm(new Users_ud_Permissions
                {
                    user_id = Convert.ToInt32(drpUsers_ud.SelectedValue),
                    page_id = page_id,
                    can_view = view,
                    can_save = save,
                    can_update = update,
                    can_delete = delete,
                    can_print = print
                });
            }
            mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, null);
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
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