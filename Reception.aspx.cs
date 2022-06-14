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
public partial class Reception : BasePage
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
                LinkButton lb = ucReception.FindControl("lnklang") as LinkButton;
                if (lb.Text == "AR")
                {
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='PatientsSettings.aspx'><span><i class='glyphicon-parents'></i></span><span class='name'>Patients_ud Settings</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='PatientsVisits.aspx'><span><i class='glyphicon-nameplate'></i></span><span class='name'>New Visits</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='PatientsofCompanies_ud.aspx'><span><i class='glyphicon-group'></i></span><span class='name'>Patients_ud of Companies_ud</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='VisitsViaCompany.aspx'><span><i class='glyphicon-building'></i></span><span class='name'>Visits of Companies_ud</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='satblue'><a href='PatientsCurrentVisits.aspx'><span><i class='glyphicon-roundabout'></i></span><span class='name'>Follow up Visits</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='WaitingList.aspx'><span><i class='glyphicon-stopwatch'></i></span><span class='name'>Waiting List</span></a></li>"
                    });
                }
                else
                {
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='PatientsSettings.aspx'><span><i class='glyphicon-parents'></i></span><span class='name'>إعـدادات المـرضــى</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='PatientsVisits.aspx'><span><i class='glyphicon-nameplate'></i></span><span class='name'>الزيـارات الجـديــدة</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='PatientsofCompanies_ud.aspx'><span><i class='glyphicon-group'></i></span><span class='name'>مرضـى الشـركـات</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='VisitsViaCompany.aspx'><span><i class='glyphicon-building'></i></span><span class='name'>زيـارات الشـركـات</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='satblue'><a href='PatientsCurrentVisits.aspx'><span><i class='glyphicon-roundabout'></i></span><span class='name'>متـابعــة الـزيـارات</span></a></li>"
                    });
                    phReception.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='WaitingList.aspx'><span><i class='glyphicon-stopwatch'></i></span><span class='name'>قـائمــة الإنتـظــار</span></a></li>"
                    });
                }
               
            }
            else
            {
                using (DataTable dt = Users_ud_Permissions.SelectUsers_udPermPages(user.user_id, "1"))
                {
                    if (dt.Rows.Count > 0)
                    {
                        LinkButton lb = ucReception.FindControl("lnklang") as LinkButton;
                        if (lb.Text=="AR")
                        {
                            foreach (DataRow row in dt.Rows)
                            {
                                switch (row["page_name_en"].ToString())
                                {
                                    case "PatientsSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='PatientsSettings.aspx'><span><i class='glyphicon-parents'></i></span><span class='name'>Patients_ud Settings</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PatientsVisits.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='PatientsVisits.aspx'><span><i class='glyphicon-nameplate'></i></span><span class='name'>New Visits</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PatientsofCompanies_ud.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='PatientsofCompanies_ud.aspx'><span><i class='glyphicon-group'></i></span><span class='name'>Patients_ud of Companies_ud</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "VisitsViaCompany.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='lightgrey'><a href='VisitsViaCompany.aspx'><span><i class='glyphicon-building'></i></span><span class='name'>Visits of Companies_ud</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PatientsCurrentVisits.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='satblue'><a href='PatientsCurrentVisits.aspx'><span><i class='glyphicon-roundabout'></i></span><span class='name'>Follow up Visits</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "WaitingList.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='WaitingList.aspx'><span><i class='glyphicon-stopwatch'></i></span><span class='name'>Waiting List</span></a></li>"
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
                                    case "PatientsSettings.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='PatientsSettings.aspx'><span><i class='glyphicon-parents'></i></span><span class='name'>إعـدادات المـرضــى</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PatientsVisits.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='PatientsVisits.aspx'><span><i class='glyphicon-nameplate'></i></span><span class='name'>الزيـارات الجـديــدة</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PatientsofCompanies_ud.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='PatientsofCompanies_ud.aspx'><span><i class='glyphicon-group'></i></span><span class='name'>مرضـى الشـركـات</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "VisitsViaCompany.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='lightgrey'><a href='VisitsViaCompany.aspx'><span><i class='glyphicon-building'></i></span><span class='name'>زيـارات الشـركـات</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PatientsCurrentVisits.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='satblue'><a href='PatientsCurrentVisits.aspx'><span><i class='glyphicon-roundabout'></i></span><span class='name'>متـابعــة الـزيـارات</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "WaitingList.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReception.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='WaitingList.aspx'><span><i class='glyphicon-stopwatch'></i></span><span class='name'>قـائمــة الإنتـظــار</span></a></li>"
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