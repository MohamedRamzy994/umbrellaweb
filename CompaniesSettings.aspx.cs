using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Data;
using System.IO;
using System.Threading;
using System.Globalization;

public partial class Companies_udSettings : BasePage
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
                // Bind Companies_ud GridView
                BindCompanies_udGridView();
                // Bind Companies_ud DropDownList
                BindCompanies_udDrp();
                // Bind Contract GridView
                BindContractGridView();
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
                            // Bind Companies_ud GridView
                            BindCompanies_udGridView();
                            // Bind Companies_ud DropDownList
                            BindCompanies_udDrp();
                            // Bind Contract GridView
                            BindContractGridView();
                        }
                        else
                        {
                            Response.Redirect("~/NoPerm.aspx",false);
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

    #region Compnaies Tab
    protected void BindCompanies_udGridView()
    {
        try
        {
            // Bind Companies_ud GridView
            WorkParams_ud.BindGridView(gvCompanies_ud, Companies_ud.SelectAllData(2));
            upCompanies_ud.Update();
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }

    }
    protected void btnCompanySave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtCompanyId.Value.Trim() != "")
                {
                    return;
                }
                // get the data from user and insert into Companies_ud table
                // if the returned value is equal to '4' that means successful operation
                if (Companies_ud.Insert(new Companies_ud
                {
                    company_name = txtCompanyName.Value.Trim(),
                    company_address = txtCompanyAddress.Value.Trim(),
                    company_phone = txtCompanyPhone.Value.Trim(),
                    company_mobile = txtCompanyMobile.Value.Trim(),
                    company_email = txtCompanyEmail.Value.Trim(),
                    company_website = txtCompanyWebsite.Value.Trim(),
                    created_date = DateTime.Now.ToString("dd/MM/yyyy"),
                    created_by = user.user_id
                }) == 4)
                {
                    BindCompanies_udGridView();
                    BindCompanies_udDrp();
                    BindContractGridView();
                    // Show the success message in the div with id: t1 and call method ClearDosetbl(); and reset drpSearchgvDose control to default value
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearCompanytbl();", "ClearSearchAttr();", "ClearContracttbl();");
                }
                else
                {
                    //returned value is equal to '9' (!= 4) means that failed operation
                    // show the error message
                    BindCompanies_udGridView();
                    BindCompanies_udDrp();
                    BindContractGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearCompanytbl();", "ClearSearchAttr();", "ClearContracttbl();");
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }
    protected void btnCompanyUpdate_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtCompanyId.Value.Trim() != "")
                {
                    // if the returned value is equal to '4' that means successful operation
                    if (Companies_ud.Update(new Companies_ud
                    {
                        company_id = Convert.ToInt32(txtCompanyId.Value),
                        company_name = txtCompanyName.Value.Trim(),
                        company_address = txtCompanyAddress.Value.Trim(),
                        company_phone = txtCompanyPhone.Value.Trim(),
                        company_mobile = txtCompanyMobile.Value.Trim(),
                        company_email = txtCompanyEmail.Value.Trim(),
                        company_website = txtCompanyWebsite.Value.Trim(),
                        active = Convert.ToInt16(drpCompanyStatus.SelectedValue)
                    }) == 4)
                    {
                        BindCompanies_udGridView();
                        BindCompanies_udDrp();
                        BindContractGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.success_update, "", true, "ClearCompanytbl();", "ClearSearchAttr();", "ClearContracttbl();");
                    }
                    else
                    {
                        //returned value is equal to '9' (!= 4) means that failed operation
                        // show the error message
                        BindCompanies_udGridView();
                        BindCompanies_udDrp();
                        BindContractGridView();
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearCompanytbl();", "ClearSearchAttr();", "ClearContracttbl();");
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }

        }
    }

    protected void btnCompanyDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtCompanyId.Value.Trim() != "")
            {
                //if the returned value is equal to '4' that means successful operation
                if (Companies_ud.Delete(Convert.ToInt32(txtCompanyId.Value)) == 4)
                {
                    BindCompanies_udGridView();
                    BindCompanies_udDrp();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true, "ClearCompanytbl();", "ClearSearchAttr();", "ClearContracttbl();");
                }
                else
                {
                    // returned value is equal to '9' (!= 4) means that failed operation
                    // that means that this record are used in other place
                    BindCompanies_udGridView();
                    BindCompanies_udDrp();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_delete, "", true, "ClearCompanytbl();", "ClearSearchAttr();", "ClearContracttbl();");
                }
            }
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    #endregion

    #region Contracts_ud Tab

    protected void BindCompanies_udDrp()
    {
        try
        {
            LinkButton lnk = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
            if (lnk != null && lnk.Text == "EN")
            {
                WorkParams_ud.BindDropDownList(drpCompanies_ud, Companies_ud.SelectCompanies_ud(1), "company_name", "company_id", new string[] { "اختــر شـركــة", "0" });
                upContracts_ud.Update();
            }
            else
            {
                WorkParams_ud.BindDropDownList(drpCompanies_ud, Companies_ud.SelectCompanies_ud(1), "company_name", "company_id", new string[] { "Select a Company", "0" });
                upContracts_ud.Update();
            }
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    protected void BindContractGridView()
    {
        try
        {
            if (Session["lang"]!=null)
            {
                WorkParams_ud.BindGridView(gvContract, Contracts_ud.SelectAll(Session["lang"].ToString()));
                upContracts_ud.Update();
            }
            else
            {
                WorkParams_ud.BindGridView(gvContract, Contracts_ud.SelectAll("ar"));
                upContracts_ud.Update();
            }
           
        }
        catch (Exception ex)
        {
            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }

    protected void btnContracts_udave_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                if (txtContractId.Value != "" || drpCompanies_ud.SelectedIndex != 0)
                {
                    return;
                }
                ////////////
                txtWarning.Value = "15";
                txtDueDay.Value = "5";
                ////////////
                // Perform required validation on server to prevent errors
                if (drpCompanies_ud.SelectedIndex != 0)
                {
                    int period = Convert.ToInt32(txtPeriod.Value);
                    int due_day = Convert.ToInt32(txtDueDay.Value);
                    int warning = Convert.ToInt32(txtWarning.Value);
                    if (period > 99 || due_day > 99 || warning > 99)
                    {
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "Some fields has invalid value please try again", true, null);
                        return;
                    }
                    int discount = Convert.ToInt32(txtDiscount.Value);
                    if (discount > 100)
                    {
                        mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "Discount field has invalid value please try again", true, null);
                        return;
                    }

                    string type = "";
                    if (drpType.SelectedIndex == 0)
                    {
                        type = "k";
                        DateTime date_from = DateTime.ParseExact(txtDateFrom.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        DateTime now = DateTime.Now;
                        if (date_from > now || date_from.ToString("dd/MM/yyyy") == now.ToString("dd/MM/yyyy"))
                        {
                            string date_to = date_from.AddMonths(period).ToString("dd/MM/yyyy");

                            int status = Contracts_ud.Insert(new Contracts_ud
                            {
                                company_id = Convert.ToInt32(drpCompanies_ud.Value),
                                contract_type = type,
                                contract_period = period,
                                contract_date_from = txtDateFrom.Value,
                                contract_date_to = date_to,
                                contract_discount = discount,
                                contract_due_day = due_day,
                                warning = warning,
                                flag_visits = drpFlag.Value,
                                created_date = DateTime.Now.ToString("dd/MM/yyyy"),
                                created_by = user.user_id

                            });
                            if (status == 4)
                            {
                                BindContractGridView();
                                mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearContracttbl();");
                            }
                            else if (status == 5)
                            {
                                BindContractGridView();
                                LinkButton lnk = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
                                if (lnk != null && lnk.Text == "EN")
                                {
                                    mNotifications.Notify(this, mNotifications.mNotifyType.info, "يـوجـد بالفعـل عقـد سـاري لهـذه الشـركـة", true, "ClearContracttbl();");
                                    return;
                                }
                                else
                                {
                                    mNotifications.Notify(this, mNotifications.mNotifyType.info, "There is already an active contract belongs to this company", true, "ClearContracttbl();");
                                    return;
                                }
                            }
                            else if (status == 9)
                            {
                                BindContractGridView();
                                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearContracttbl();");
                            }
                        }
                        else
                        {
                            LinkButton lnk = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
                            if (lnk != null && lnk.Text == "EN")
                            {
                                mNotifications.Notify(this, mNotifications.mNotifyType.info, "يـرجـى إدخـال تـاريـخ صحيـح", true, null);
                                return;
                            }
                            else
                            {
                                mNotifications.Notify(this, mNotifications.mNotifyType.info, "Please enter a valid date", true, null);
                                return;
                            }
                        }

                    }
                    else if (drpType.SelectedIndex == 1)
                    {
                        type = "f";
                        int status = Contracts_ud.Insert(new Contracts_ud
                        {
                            company_id = Convert.ToInt32(drpCompanies_ud.Value),
                            contract_type = type,
                            contract_period = period,
                            contract_date_from = null,
                            contract_date_to = null,
                            contract_discount = discount,
                            contract_due_day = due_day,
                            warning = warning,
                            flag_visits = drpFlag.Value,
                            created_date = DateTime.Now.ToString("dd/MM/yyyy"),
                            created_by = user.user_id

                        });
                        if (status == 4)
                        {
                            BindContractGridView();
                            mNotifications.Notify(this, mNotifications.mNotifyType.success_save, "", true, "ClearContracttbl();");
                        }
                        else if (status == 5)
                        {
                            BindContractGridView();
                            LinkButton lnk = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
                            if (lnk != null && lnk.Text == "EN")
                            {
                                mNotifications.Notify(this, mNotifications.mNotifyType.info, "يـوجـد بالفعـل عقـد سـاري لهـذه الشـركـة", true, "ClearContracttbl();");
                                return;
                            }
                            else
                            {
                                mNotifications.Notify(this, mNotifications.mNotifyType.info, "There is already an active contract belongs to this company", true, "ClearContracttbl();");
                                return;
                            }
                        }
                        else if (status == 9)
                        {
                            BindContractGridView();
                            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, "ClearContracttbl();");
                        }
                    }
                    else
                    {
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
            }
        }
    }

    protected void btnContractDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtContractId.Value != "" && drpCompanies_ud.SelectedIndex != 0)
            {
                if (Contracts_ud.Delete(Convert.ToInt32(txtContractId.Value), Convert.ToInt32(drpCompanies_ud.Value)) == 4)
                {
                    BindContractGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.success_delete, "", true, "ClearContracttbl();");
                }
                else
                {
                    // returned value is equal to '9' (!= 4) means that failed operation
                    // that means that this record are used in other place
                    BindContractGridView();
                    mNotifications.Notify(this, mNotifications.mNotifyType.error_delete, "", true, "ClearContracttbl();");
                }
            }
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