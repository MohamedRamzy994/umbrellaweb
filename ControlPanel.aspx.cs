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

public partial class ControlPanel : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    /// 
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
        else
        {
            // bind Current UserName
            //lblUserName.Text = user.user_name;
            if (user.admin == 1)
            {
                LinkButton lb = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
                if (lb.Text=="AR")
                {
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='Clinic_udSettings.aspx'><span><i class='icon-tasks'></i></span><span class='name'>Reports Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='Examinations_udSettings.aspx'><span><i class='glyphicon-pen'></i></span><span class='name'>Examinations_ud Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='Days_udSettings.aspx'><span><i class='glyphicon-calendar'></i></span><span class='name'>Appointments Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='MedicinesSettings.aspx'><span><i class='glyphicon-hospital'></i></span><span class='name'>Medicines_ud Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='satblue'><a href='DosesSettings.aspx'><span><i class='glyphicon-eyedropper'></i></span><span class='name'>Doses_ud Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='DiagnosisSettings.aspx'><span><i class='glyphicon-notes_2'></i></span><span class='name'>Diagnosis_ud Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='TestsSettings.aspx'><span><i class='glyphicon-tint'></i></span><span class='name'>Tests Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='Companies_udSettings.aspx'><span><i class='glyphicon-building'></i></span><span class='name'>Companies_ud Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='UsersSettings.aspx'><span><i class='glyphicon-user'></i></span><span class='name'>Users_ud Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='satblue'><a href='PermissionsSettings.aspx'><span><i class='glyphicon-lock'></i></span><span class='name'>Permissions Settings</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='EmployeesSettings.aspx'><span><i class='glyphicon-parents'></i></span><span class='name'>Employee_uds Settings</span></a></li>"
                    });
                }
                else
                {
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='Clinic_udSettings.aspx'><span><i class='icon-tasks'></i></span><span class='name'>إعـدادت التقـاريـر</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='Examinations_udSettings.aspx'><span><i class='glyphicon-pen'></i></span><span class='name'>إعـدادت الفحوصـات</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='Days_udSettings.aspx'><span><i class='glyphicon-calendar'></i></span><span class='name'>إعـدادت المـواعيـد</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='MedicinesSettings.aspx'><span><i class='glyphicon-hospital'></i></span><span class='name'>إعـدادات الأدويـة</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='satblue'><a href='DosesSettings.aspx'><span><i class='glyphicon-eyedropper'></i></span><span class='name'>إعـدادت الجـرعـات</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='DiagnosisSettings.aspx'><span><i class='glyphicon-notes_2'></i></span><span class='name'>إعـدادت التشخيصـات</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='TestsSettings.aspx'><span><i class='glyphicon-tint'></i></span><span class='name'>إعـدادت الإختبـارات</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='Companies_udSettings.aspx'><span><i class='glyphicon-building'></i></span><span class='name'>إعـدادت الشـركـات</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='UsersSettings.aspx'><span><i class='glyphicon-user'></i></span><span class='name'>إعـدادت الـمستـخدميـن</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='satblue'><a href='PermissionsSettings.aspx'><span><i class='glyphicon-lock'></i></span><span class='name'>إعـدادت الصـلاحيـات</span></a></li>"
                    });
                    phControlPanel.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='EmployeesSettings.aspx'><span><i class='glyphicon-parents'></i></span><span class='name'>إعـدادت الـموظفـين</span></a></li>"
                    });
                }
            }
            else
            {
                using (DataTable dt = Users_ud_Permissions.SelectUsers_udPermPages(user.user_id,"3"))
                {
                    if (dt.Rows.Count > 0)
                    {
                        LinkButton lb = ucMenuControlPanel.FindControl("lnklang") as LinkButton;
                        if (lb.Text == "AR")
                        {
                            foreach (DataRow row in dt.Rows)
                            {
                                switch (row["page_name_en"].ToString())
                                {
                                    case "Clinic_udSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='Clinic_udSettings.aspx'><span><i class='icon-tasks'></i></span><span class='name'>Reports Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "Examinations_udSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='Examinations_udSettings.aspx'><span><i class='glyphicon-pen'></i></span><span class='name'>Examinations_ud Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "Days_udSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='Days_udSettings.aspx'><span><i class='glyphicon-calendar'></i></span><span class='name'>Appointments Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "MedicinesSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='lightgrey'><a href='MedicinesSettings.aspx'><span><i class='glyphicon-hospital'></i></span><span class='name'>Medicines_ud Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "DosesSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='satblue'><a href='DosesSettings.aspx'><span><i class='glyphicon-eyedropper'></i></span><span class='name'>Doses_ud Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "DiagnosisSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='DiagnosisSettings.aspx'><span><i class='glyphicon-notes_2'></i></span><span class='name'>Diagnosis_ud Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "TestsSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='TestsSettings.aspx'><span><i class='glyphicon-tint'></i></span><span class='name'>Tests Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "Companies_udSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='Companies_udSettings.aspx'><span><i class='glyphicon-building'></i></span><span class='name'>Companies_ud Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "UsersSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='lightgrey'><a href='UsersSettings.aspx'><span><i class='glyphicon-user'></i></span><span class='name'>Users_ud Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PermissionsSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='satblue'><a href='PermissionsSettings.aspx'><span><i class='glyphicon-lock'></i></span><span class='name'>Permissions Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "EmployeesSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='EmployeesSettings.aspx'><span><i class='glyphicon-parents'></i></span><span class='name'>Employee_uds Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                }
                            }
                        }
                        else
                        {
                            foreach (DataRow row in dt.Rows)
                            {
                                switch (row["page_name_en"].ToString())
                                {
                                    case "Clinic_udSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='Clinic_udSettings.aspx'><span><i class='icon-tasks'></i></span><span class='name'>إعـدادت التقـاريـر</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "Examinations_udSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='Examinations_udSettings.aspx'><span><i class='glyphicon-pen'></i></span><span class='name'>إعـدادت الفحوصـات</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "Days_udSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='Days_udSettings.aspx'><span><i class='glyphicon-calendar'></i></span><span class='name'>إعـدادت المـواعيـد</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "MedicinesSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='lightgrey'><a href='MedicinesSettings.aspx'><span><i class='glyphicon-hospital'></i></span><span class='name'>إعـدادات الأدويـة</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "DosesSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='satblue'><a href='DosesSettings.aspx'><span><i class='glyphicon-eyedropper'></i></span><span class='name'>إعـدادت الجـرعـات</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "DiagnosisSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='DiagnosisSettings.aspx'><span><i class='glyphicon-notes_2'></i></span><span class='name'>إعـدادت التشخيصـات</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "TestsSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='TestsSettings.aspx'><span><i class='glyphicon-tint'></i></span><span class='name'>إعـدادت الإختبـارات</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "Companies_udSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='Companies_udSettings.aspx'><span><i class='glyphicon-building'></i></span><span class='name'>إعـدادت الشـركـات</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "UsersSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                               Text= "<li class='lightgrey'><a href='UsersSettings.aspx'><span><i class='glyphicon-user'></i></span><span class='name'>إعـدادت الـمستـخدميـن</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PermissionsSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='satblue'><a href='PermissionsSettings.aspx'><span><i class='glyphicon-lock'></i></span><span class='name'>إعـدادت الصـلاحيـات</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "EmployeesSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phControlPanel.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='EmployeesSettings.aspx'><span><i class='glyphicon-parents'></i></span><span class='name'>إعـدادت الـموظفـين</span></a></li>"
                                            });
                                        }
                                        break;
                                }
                            }
                        }
                    }
                }
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