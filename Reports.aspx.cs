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

public partial class Reports : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    protected override void InitializeCulture()
    {
        if (Session["lang"] != null)
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["lang"].ToString());
        else
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("ar");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //this code to find language link button in ucReports user control
        //UserControl uc = this.ucReports;
        //LinkButton lnkLang = (LinkButton)uc.FindControl("lnklang");
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
                //phReports.Controls.Add(new Literal()
                //{
                //    Text = "<li class='lightgrey'><a href='ReceptionReports.aspx'><span><i class='glyphicon-blog'></i></span><span class='name'>Reception Reports</span></a></li>"
                //});
                //phReports.Controls.Add(new Literal()
                //{
                //    Text = "<li class='blue'><a href='ClinicReports.aspx'><span><i class='glyphicon-notes_2'></i></span><span class='name'>Clinic_ud Reports</span></a></li>"
                //});
                //phReports.Controls.Add(new Literal()
                //{
                //    Text = "<li class='darkblue'><a href='SystemReports.aspx'><span><i class='glyphicon-dashboard'></i></span><span class='name'>System Reports</span></a></li>"
                //});
                if (language == "en")
                {
                    phReports.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='FinancialsReports.aspx'><span><i class='glyphicon-coins'></i></span><span class='name'>Financials Reports</span></a></li>"
                    });
                }
                else
                {
                    phReports.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='FinancialsReports.aspx'><span><i class='glyphicon-coins'></i></span><span class='name'>التقارير المالية</span></a></li>"
                    });
                }
                if (language == "en")
                {
                    phReports.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='ClinicReports.aspx'><span><i class='icon-hospital'></i></span><span class='name'>Clinic_ud Reports</span></a></li>"
                    });
                }
                else
                {
                    phReports.Controls.Add(new Literal()
                    {
                        Text = "<li class='grey'><a href='ClinicReports.aspx'><span><i class='icon-hospital'></i></span><span class='name'>تقارير العيادة</span></a></li>"
                    });
                }
            }
            else
            {


                using (DataTable dt = Users_ud_Permissions.SelectUsers_udPermPages(user.user_id, "5"))
                {
                    if (dt.Rows.Count > 0)
                    {
                        if (language == "AR")
                        {
                            foreach (DataRow row in dt.Rows)
                            {
                                switch (row["page_name_en"].ToString())
                                {
                                    case "ReceptionReports.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReports.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='lightgrey'><a href='ReceptionReports.aspx'><span><i class='glyphicon-blog'></i></span><span class='name'>Reception Reports</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "ClinicReports.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReports.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='ClinicReports.aspx'><span><i class='glyphicon-notes_2'></i></span><span class='name'>Clinic_ud Reports</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "SystemReports.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReports.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='SystemReports.aspx'><span><i class='glyphicon-dashboard'></i></span><span class='name'>System Reports</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "FinancialsReports.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReports.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='FinancialsReports.aspx'><span meta:resourcekey='Reports' runat='server'><i class='glyphicon-coins'></i></span><span class='name' meta:resourcekey='Financials_Reports' runat='server'>Financials Reports</span></a></li>"
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
                                    case "ReceptionReports.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReports.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='lightgrey'><a href='ReceptionReports.aspx'><span><i class='glyphicon-blog'></i></span><span class='name'>تقارير الاستقبال</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "ClinicReports.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReports.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='ClinicReports.aspx'><span><i class='glyphicon-notes_2'></i></span><span class='name'>تقارير العيادة</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "SystemReports.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReports.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='SystemReports.aspx'><span><i class='glyphicon-dashboard'></i></span><span class='name'>تقارير النظام</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "FinancialsReports.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phReports.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='grey'><a href='FinancialsReports.aspx'><span meta:resourcekey='Reports' runat='server'><i class='glyphicon-coins'></i></span><span class='name' meta:resourcekey='Financials_Reports' runat='server'>التقارير المالية</span></a></li>"
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
                    Response.Redirect("~/Default.aspx", false);
                    return null;
                }
            }
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
                userTheme = "theme-darkblue";
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
    }
    protected void btnSaveTheme_Click(object sender, EventArgs e)
    {
        Session["theme"] = "theme-" + hfTheme.Value;
    }
    #endregion
}