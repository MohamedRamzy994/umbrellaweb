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

public partial class Financials : BasePage
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
            // lblUserName.Text = user.user_name;
            if (user.admin == 1)
            {
                LinkButton lb = ucFinancials.FindControl("lnklang") as LinkButton;
                // ((this.Master.FindControl("usercontrol") as UserControl).FindControl("txtname") as TextBox).Text="";
                if (lb.Text == "AR")
                {
                    phFinancial.Controls.Add(new Literal()
                    {
                        Text = " <li class='grey'><a href='DailySummary.aspx'><span><i class='glyphicon-stats'></i></span><span class='name'>Daily Summary</span></a></li>"
                    });
                    phFinancial.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='EncashmentVoucher.aspx'><span><i class='glyphicon-cart_in'></i></span><span class='name'>Encashment Voucher</span></a></li>"
                    });
                    phFinancial.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='PaymentVoucher.aspx'><span><i class='glyphicon-cart_out'></i></span><span class='name'>Payment Voucher</span></a></li>"
                    });
                    phFinancial.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='Withdrawals.aspx'><span><i class='glyphicon-credit_card'></i></span><span class='name'>Withdrawals</span></a></li>"
                    });
                }
                else
                {
                    phFinancial.Controls.Add(new Literal()
                    {
                        Text = " <li class='grey'><a href='DailySummary.aspx'><span><i class='glyphicon-stats'></i></span><span class='name'>الملخــص اليـومـي</span></a></li>"
                    });
                    phFinancial.Controls.Add(new Literal()
                    {
                        Text = "<li class='blue'><a href='EncashmentVoucher.aspx'><span><i class='glyphicon-cart_in'></i></span><span class='name'>أوراق القبـض</span></a></li>"
                    });
                    phFinancial.Controls.Add(new Literal()
                    {
                        Text = "<li class='darkblue'><a href='PaymentVoucher.aspx'><span><i class='glyphicon-cart_out'></i></span><span class='name'>أوراق الـدفـع</span></a></li>"
                    });
                    phFinancial.Controls.Add(new Literal()
                    {
                        Text = "<li class='lightgrey'><a href='Withdrawals.aspx'><span><i class='glyphicon-credit_card'></i></span><span class='name'>المسحـوبـات</span></a></li>"
                    });
                }

            }
            else
            {
                using (DataTable dt = Users_ud_Permissions.SelectUsers_udPermPages(user.user_id, "4"))
                {
                    if (dt.Rows.Count > 0)
                    {
                        LinkButton lb = ucFinancials.FindControl("lnklang") as LinkButton;
                        if (lb.Text == "AR")
                        {
                            foreach (DataRow row in dt.Rows)
                            {
                                switch (row["page_name_en"].ToString())
                                {
                                    case "DailySummary.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phFinancial.Controls.Add(new Literal()
                                            {
                                                Text = " <li class='grey'><a href='DailySummary.aspx'><span><i class='glyphicon-stats'></i></span><span class='name'>Daily Summary</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "EncashmentVoucher.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phFinancial.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='EncashmentVoucher.aspx'><span><i class='glyphicon-cart_in'></i></span><span class='name'>Encashment Voucher</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PaymentVoucher.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phFinancial.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='PaymentVoucher.aspx'><span><i class='glyphicon-cart_out'></i></span><span class='name'>Payment Voucher</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "Withdrawals.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phFinancial.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='lightgrey'><a href='Withdrawals.aspx'><span><i class='glyphicon-credit_card'></i></span><span class='name'>Withdrawals</span></a></li>"
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
                                    case "DailySummary.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phFinancial.Controls.Add(new Literal()
                                            {
                                                Text = " <li class='grey'><a href='DailySummary.aspx'><span><i class='glyphicon-stats'></i></span><span class='name'>الملخــص اليـومـي</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "EncashmentVoucher.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phFinancial.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='blue'><a href='EncashmentVoucher.aspx'><span><i class='glyphicon-cart_in'></i></span><span class='name'>أوراق القبـض</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "PaymentVoucher.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phFinancial.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='darkblue'><a href='PaymentVoucher.aspx'><span><i class='glyphicon-cart_out'></i></span><span class='name'>أوراق الـدفـع</span></a></li>"
                                            });
                                        }
                                        break;
                                    case "Withdrawals.aspx":
                                        if (Convert.ToBoolean(row["can_view"]))
                                        {
                                            phFinancial.Controls.Add(new Literal()
                                            {
                                                Text = "<li class='lightgrey'><a href='Withdrawals.aspx'><span><i class='glyphicon-credit_card'></i></span><span class='name'>المسحـوبـات</span></a></li>"
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