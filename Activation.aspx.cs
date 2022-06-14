using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Drawing;

public partial class Activation : BasePage
{
    /// Eng.Moustafa Ebrahem
    /// Eng.Moustafa20@Gmail.com
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (License_ud.CheckLicense_ud())
                {
                    Session["chk"] = "Moustafa_Ebrahem";
                    Response.Redirect("~/Default.aspx", false);
                    return;
                }
                if (Session["chk"] == null)
                {
                    Response.Redirect("~/Default.aspx", false);
                    return;
                }
                else
                {
                    txtMachineCode.Value = License_ud.GetMachineCode();
                }
            }
            catch(Exception ex)
            {
                btnActivation.Visible = false;
                lblInfo.ForeColor = Color.Red;
                lblInfo.Text = ex.Message;
            }
        }
    }
    protected void btnActivation_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            try
            {
                string str = License_ud.GetActivateCode(License_ud.GetMachineCode());
                if (txtActivationCode.Value.Trim() == str)
                {
                    License_ud.SaveLicense_ud(str);
                    Response.Redirect("~/Default.aspx", false);
                    return;
                }
                else
                {
                    lblInfo.Text = "Activation Code is incorrect";
                }
            }
            catch (Exception ex)
            {
                lblInfo.ForeColor = Color.Red;
                lblInfo.Text = ex.Message;
            }
        }
    }
}