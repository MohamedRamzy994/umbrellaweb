using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Threading;
using System.Globalization;
using System.IO;

public partial class Home : BasePage
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
    protected override void OnLoad(EventArgs e)
    {
        if (user !=null && user.sounds == 1)
        {
            Page.Header.Controls.Add(mNotifications.CreateJavaScriptLink("~/js/mSounds.js"));
        }
        base.OnLoad(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (user == null)
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }
        else
        {
            lblUserName.Text = user.user_name;
            if (user.admin == 1)
            {
                if (lnklang.Text == "AR")
                {
                    phAppSections.Controls.Add(new Literal()
                    {

                        Text = "<li class='grey'><a href='Reception.aspx'><span><i class='icon-ambulance'></i></span><span class='name'>Reception</span></a></li>"
                    });
                    phAppSections.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='GeneralClinic.aspx'><span><i class='icon-hospital'></i></span><span class='name'>General Clinic_ud</span></a></li>"
                    });
                    phAppSections.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='ControlPanel.aspx'><span><i class='icon-wrench'></i></span><span class='name'>Control Panel</span></a></li>"
                    });
                    phAppSections.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='Financials.aspx'><span><i class='icon-usd'></i></span><span class='name'>Financials</span></a></li>"
                    });
                    phAppSections.Controls.Add(new Literal()
                    {
                        Text = "<li class='satblue'><a href='Reports.aspx'><span><i class='icon-tasks'></i></span><span class='name'>Reports</span></a></li>"
                    });
                }
                else
                {
                    phAppSections.Controls.Add(new Literal()
                    {

                        Text = "<li class='grey'><a href='Reception.aspx'><span><i class='icon-ambulance'></i></span><span class='name'>الإستقبــال</span></a></li>"
                    });
                    phAppSections.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='GeneralClinic.aspx'><span><i class='icon-hospital'></i></span><span class='name'>العيـادة العـامـة</span></a></li>"
                    });
                    phAppSections.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='ControlPanel.aspx'><span><i class='icon-wrench'></i></span><span class='name'>لـوحــة التحـكــم</span></a></li>"
                    });
                    phAppSections.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='Financials.aspx'><span><i class='icon-usd'></i></span><span class='name'>المـاليــات</span></a></li>"
                    });
                    phAppSections.Controls.Add(new Literal()
                    {
                        Text = "<li class='satblue'><a href='Reports.aspx'><span><i class='icon-tasks'></i></span><span class='name'>التقـاريــر</span></a></li>"
                    });
                }


            }
            else
            {
                using (DataTable dt = Users_ud_Permissions.SelectUsers_udPermSections(user.user_id))
                {
                    if (dt.Rows.Count > 0)
                    {
                        if (lnklang.Text == "AR")
                        {
                            foreach (DataRow row in dt.Rows)
                            {
                                switch (row["section_id"].ToString())
                                {
                                    case "1":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='grey'><a href='Reception.aspx'><span><i class='icon-ambulance'></i></span><span class='name'>Reception</span></a></li>"
                                        });
                                        break;
                                    case "2":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='blue'><a href='GeneralClinic.aspx'><span><i class='icon-hospital'></i></span><span class='name'>General Clinic_ud</span></a></li>"
                                        });
                                        break;
                                    case "3":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='darkblue'><a href='ControlPanel.aspx'><span><i class='icon-wrench'></i></span><span class='name'>Control Panel</span></a></li>"
                                        });
                                        break;
                                    case "4":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='lightgrey'><a href='Financials.aspx'><span><i class='icon-usd'></i></span><span class='name'>Financials</span></a></li>"
                                        });
                                        break;
                                    case "5":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='satblue'><a href='Reports.aspx'><span><i class='icon-tasks'></i></span><span class='name'>Reports</span></a></li>"
                                        });
                                        break;
                                }
                            }
                        }
                        else
                        {
                            foreach (DataRow row in dt.Rows)
                            {
                                switch (row["section_id"].ToString())
                                {
                                    case "1":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='grey'><a href='Reception.aspx'><span><i class='icon-ambulance'></i></span><span class='name'>الإستقبــال</span></a></li>"
                                        });
                                        break;
                                    case "2":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='blue'><a href='GeneralClinic.aspx'><span><i class='icon-hospital'></i></span><span class='name'>العيـادة العـامـة</span></a></li>"
                                        });
                                        break;
                                    case "3":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='darkblue'><a href='ControlPanel.aspx'><span><i class='icon-wrench'></i></span><span class='name'>لـوحــة التحـكــم</span></a></li>"
                                        });
                                        break;
                                    case "4":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='lightgrey'><a href='Financials.aspx'><span><i class='icon-usd'></i></span><span class='name'>المـاليــات</span></a></li>"
                                        });
                                        break;
                                    case "5":
                                        phAppSections.Controls.Add(new Literal()
                                        {
                                            Text = "<li class='satblue'><a href='Reports.aspx'><span><i class='icon-tasks'></i></span><span class='name'>التقـاريــر</span></a></li>"
                                        });
                                        break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    protected void lnkSounds_Click(object sender, EventArgs e)
    {
        try
        {
            string user_name = user.user_name;
            if (Users_ud.UpdateSounds(user_name) == 4)
            {
                Session["user"] = Users_ud.SelectByUserName(user_name);
                Response.Redirect(Path.GetFileName(Request.Url.AbsolutePath), false);
                return;
            }
            else
            {
                mNotifications.Notify(this, mNotifications.mNotifyType.error_general, "", true, null);
            }
        }
        catch (Exception ex)
        {

            mNotifications.Notify(this, mNotifications.mNotifyType.error_general, ex.Message, true, null);
        }
    }
    public PlaceHolder BottomScriptsPlaceHolder
    {
        get
        {
            return phBottomScripts;
        }
    }

    //#region User Theme
    ///// <summary>
    ///// Property for Current User's Theme
    ///// </summary>
    //private string userTheme;
    //public string UserTheme
    //{
    //    get
    //    {
    //        if (Session["theme"] == null)
    //        {
    //            userTheme = "theme-darkblue";
    //        }
    //        else
    //        {
    //            userTheme = Session["theme"].ToString();
    //        }
    //        return userTheme;
    //    }
    //    set { userTheme = value; }
    //}

    //#endregion

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

    protected void lbSignOut_Click(object sender, EventArgs e)
    {
        HttpCookie infoCookie = HttpContext.Current.Request.Cookies["info"];
        if (infoCookie != null)
        {
            infoCookie.Expires = DateTime.Now.AddDays(-1d);
            Response.Cookies.Add(infoCookie);
        }
        Session.Clear();
        Session.Abandon();
        Response.Redirect("~/Default.aspx", false);
        return;
    }

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

    protected void lnklang_Click(object sender, EventArgs e)
    {
        if (lnklang.Text == "EN")
        {
            Session["lang"] = "en";
        }
        else
        {
            Session["lang"] = "ar";
        }
        Response.Redirect(Path.GetFileName(Request.Url.AbsolutePath), false);
        return;
    }
    #endregion

}