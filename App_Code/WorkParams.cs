using System;
using System.Collections.Generic;
using System.Xml;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web;
using System.Drawing;
/// <summary>
/// Eng.Moustafa Ebrahem
/// Eng.Moustafa20@Gmail.com
/// </summary>
public class WorkParams_ud
{
    static int result = 0;

    public WorkParams_ud()
    {

    }

    #region Age Operations
    public static string GetAge(string dt)
    {
        DateTime dtn = new DateTime(0);
        DateTime futureDate = dtn.AddDays(DateTime.Now.Subtract(Convert.ToDateTime(dt)).TotalDays);

        int year = futureDate.Year - dtn.Year;
        int month = futureDate.Month - dtn.Month;
        int Days_ud = futureDate.Day - dtn.Day;
        return year.ToString() + " Years " + month.ToString() + " Months " + Days_ud.ToString() + " Days_ud";
    }

    public static string GetMonthsAge(string dt)
    {
        double Days_ud = DateTime.Now.Subtract(Convert.ToDateTime(dt)).TotalDays;

        int months = (int)(Days_ud / 30.4166666667);

        double rest = Days_ud % 30.4166666667;

        if (rest >= 16)
            months = months + 1;


        return months.ToString();
    }

    public static string GetYearsAge(string dt)
    {
        double Days_ud = DateTime.Now.Subtract(Convert.ToDateTime(dt)).TotalDays;

        int months = (int)(Days_ud / 30.4166666667);
        double rem_months = Days_ud % 30.4166666667;
        if (rem_months >= 16)
            months = months + 1;

        int years = (int)(months / 12);
        double rem_years = months % 12;
        if (rem_years >= 0 && rem_years <= 1)
            return years.ToString();
        else if (rem_years >= 2 && rem_years <= 4)
            return (years + 0.25).ToString();
        else if (rem_years >= 5 && rem_years <= 7)
            return (years + 0.50).ToString();
        else if (rem_years >= 8 && rem_years <= 10)
            return (years + 0.75).ToString();
        else if (rem_years >= 11 && rem_years <= 12)
            return (years + 1).ToString();
        else
            return "error";

    }
    #endregion

    #region Page Methods

    // method to get page links from the xml file
    public static string GetLink(string name)
    {
        XmlDocument doc = new XmlDocument();

        BasePage p = new BasePage();

        doc.Load(p.Server.MapPath("~/Links.xml"));

        return doc.SelectSingleNode(@"/links/link[@name='" + name + "']").InnerText;
    }

    public static void RedirectTo(BasePage pg, string url)
    {
        string redirectURL = pg.ResolveClientUrl(url);
        string script = "window.location = '" + redirectURL + "';";
        System.Web.UI.ScriptManager.RegisterStartupScript(pg, typeof(BasePage), "RedirectTo", script, true);
    }
    #endregion

    #region Date Conversion Methods
    // method to convert Gregorian date to Hijri date
    // we want to convert this method to an extension method later
    public static string ToHijriDate(DateTime DateConv)
    {
        DateTimeFormatInfo DTFormat;

        DTFormat = new System.Globalization.CultureInfo("ar-sa", false).DateTimeFormat;

        DTFormat.Calendar = new System.Globalization.HijriCalendar();

        DTFormat.ShortDatePattern = "dd/MM/yyyy";

        return (DateConv.Date.ToString("dd/MM/yyyy", DTFormat));
    }

    public static string ToHijriDate(string dat)
    {
        DateTime DateConv = Convert.ToDateTime(dat);

        DateTimeFormatInfo DTFormat;

        DTFormat = new System.Globalization.CultureInfo("ar-sa", false).DateTimeFormat;

        DTFormat.Calendar = new System.Globalization.HijriCalendar();

        DTFormat.ShortDatePattern = "dd/MM/yyyy";

        return (DateConv.Date.ToString("dd/MM/yyyy", DTFormat));
    }

    public static string ToGregorianDate(DateTime DateConv)
    {
        DateTimeFormatInfo DTFormat;

        DTFormat = new System.Globalization.CultureInfo("en-us", false).DateTimeFormat;

        DTFormat.Calendar = new System.Globalization.GregorianCalendar();

        DTFormat.ShortDatePattern = "dd/MM/yyyy";

        return (DateConv.Date.ToString());
    }

    public static string ToGregorianDate(string DateConv)
    {
        CultureInfo arCul = new CultureInfo("ar-SA");

        CultureInfo enCul = new CultureInfo("en-au");

        string[] allFormats ={"yyyy/MM/dd","yyyy/M/d",
                "dd/MM/yyyy","d/M/yyyy",
                "dd/M/yyyy","d/MM/yyyy","yyyy-MM-dd",
                "yyyy-M-d","dd-MM-yyyy","d-M-yyyy",
                "dd-M-yyyy","d-MM-yyyy","yyyy MM dd",
                "yyyy M d","dd MM yyyy","d M yyyy",
                "dd M yyyy","d MM yyyy","MM/dd/yyyy"};

        arCul.DateTimeFormat.Calendar = new System.Globalization.HijriCalendar();

        DateTime tempDate = DateTime.ParseExact(DateConv, allFormats, arCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);

        return tempDate.ToString("dd/MM/yyyy", enCul.DateTimeFormat);
    }
    #endregion

    #region Bind Methods

    public static DataTable GetStructure(params string[] Coloums)
    {
        using (DataTable dt = new DataTable())
        {
            if (Coloums.Length > 0)
            {
                for (int i = 0; i < Coloums.Length; i++)
                {
                    dt.Columns.Add(new DataColumn() { ColumnName = Coloums[i] });
                }

                dt.PrimaryKey = new DataColumn[] { dt.Columns[0] };
            }
            return dt;
        }
    }

    public static void BindDropDownList(DropDownList ddl, DataTable data_source, string txtFiled, string txtValue, params string[] txtDefault)
    {

        using (data_source)
        {
            if (data_source.Rows.Count > 0)
            {
                ddl.DataSource = data_source;
                ddl.DataTextField = txtFiled;
                ddl.DataValueField = txtValue;
                ddl.DataBind();

            }
            else
            {
                ddl.DataSource = null;
                ddl.DataBind();
            }
        }

        if (txtDefault != null)
        {
            if (ddl.Items.Count > 0)
                ddl.Items.Insert(0, new ListItem(txtDefault[0], txtDefault[1]));
            else
                ddl.Items.Add(new ListItem(txtDefault[0], txtDefault[1]));
        }


    }

    public static void BindDropDownList(System.Web.UI.HtmlControls.HtmlSelect ddl, DataTable data_source, string txtFiled, string txtValue, params string[] txtDefault)
    {
        using (data_source)
        {
            if (data_source.Rows.Count > 0)
            {
                ddl.DataSource = data_source;
                ddl.DataTextField = txtFiled;
                ddl.DataValueField = txtValue;
                ddl.DataBind();
            }
            else
            {
                ddl.DataSource = null;
                ddl.DataBind();
            }
        }

        if (txtDefault != null)
        {
            if (ddl.Items.Count > 0)
                ddl.Items.Insert(0, new ListItem(txtDefault[0], txtDefault[1]));
            else
                ddl.Items.Add(new ListItem(txtDefault[0], txtDefault[1]));
        }
    }

    public static void BindGridView(GridView grd, DataTable data_source)
    {
        grd.SelectedIndex = -1;

        using (data_source)
        {
            if (data_source.Rows.Count > 0)
            {
                grd.DataSource = data_source;
                grd.DataBind();
            }
            else
            {
                grd.DataSource = null;
                grd.DataBind();
            }
        }
    }

    public static string BindGridViewRows(GridView grd, DataTable data_source)
    {
        grd.SelectedIndex = -1;

        using (data_source)
        {
            if (data_source.Rows.Count > 0)
            {
                grd.DataSource = data_source;
                grd.DataBind();
            }
            else
            {
                grd.DataSource = null;
                grd.DataBind();
            }
            return data_source.Rows.Count.ToString();
        }
    }

    public static void ClearGridView(params GridView[] grds)
    {
        foreach (GridView grd in grds)
        {
            grd.SelectedIndex = -1;
            grd.DataSource = null;
            grd.DataBind();
        }
    }

    public static void SortGridView(GridView grd)
    {
        GridViewSortEventArgs e = new GridViewSortEventArgs(grd.SortExpression, grd.SortDirection);

        DataTable dataTable = grd.DataSource as DataTable;

        if (dataTable != null)
        {
            DataView dataView = new DataView(dataTable);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            grd.DataSource = dataView;
            grd.DataBind();
        }
    }

    public static string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;

        switch (sortDirection)
        {
            case SortDirection.Ascending:
                newSortDirection = "ASC";
                break;

            case SortDirection.Descending:
                newSortDirection = "DESC";
                break;
        }
        return newSortDirection;
    }

    public static void BindListView(object data_source, params ListView[] lst)
    {
        foreach (ListView ls in lst)
        {
            ls.DataSource = data_source;
            ls.DataBind();
        }
    }

    public static string BindListViewRows(ListView lst, DataTable data_source)
    {
        lst.SelectedIndex = -1;

        using (data_source)
        {
            if (data_source.Rows.Count > 0)
            {
                lst.DataSource = data_source;
                lst.DataBind();
            }
            else
            {
                lst.DataSource = null;
                lst.DataBind();
            }
            return data_source.Rows.Count.ToString();
        }
    }

    public static string BindListBoxs(ListBox lb, DataTable data_source,string txt_field,string value_field)
    {
        lb.SelectedIndex = -1;

        using (data_source)
        {
            if (data_source.Rows.Count > 0)
            {
                lb.DataSource = data_source;
                lb.DataTextField = txt_field;
                lb.DataValueField = value_field;
                lb.DataBind();
            }
            else
            {
                lb.DataSource = null;
                lb.DataBind();
            }
            return data_source.Rows.Count.ToString();
        }
    }

    #endregion

    public static void RedirectToNewTap(BasePage pg, string url)
    {
        string redirectURL = pg.ResolveClientUrl(url);
       // Random r = new Random();
        string script = "window.open('" + redirectURL + "','_newtab')";
        System.Web.UI.ScriptManager.RegisterStartupScript(pg, typeof(BasePage), "RedirectTo", script, true);
    }

    public static bool IsNumber(string num)
    {
        return int.TryParse(num, out result);
    }


    public static DateTime ConvertToDate(string dt)
    {
        string[] formats = { "dd/MM/yyyy" };
        return DateTime.ParseExact(dt, formats, new CultureInfo("en-US"), DateTimeStyles.None);
    }


    public static void CreateImage(string srcFile, string newFile, int width, int height)
    {
        Bitmap bmp = new Bitmap(srcFile);
        Bitmap bmpOut = new Bitmap(width, height);
        Graphics g = Graphics.FromImage(bmpOut);
        g.DrawImage(bmp, 0, 0, width, height);
        bmpOut.Save(newFile);
        bmp.Dispose();
        g.Dispose();
    }

    public static void UpdatePanels(params UpdatePanel[] UpdatePanels)
    {
        foreach (UpdatePanel up in UpdatePanels)
        {
            up.Update();
        }
    }

}