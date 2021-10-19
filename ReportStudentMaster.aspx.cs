
using System;

using System.Collections.Generic;

using System.Data.SqlClient;
using System.Data;

using System.Web.Services;
using Newtonsoft.Json;

using CrystalDecisions.CrystalReports.Engine;


using System.Collections;
public partial class frmReportStudentMaster : System.Web.UI.Page
{
    


    string drClass, drSection, fromdate, todate, sql, category;
    static DBConnection Connection = new DBConnection();
    SqlConnection conn;
    ReportDocument crystalReport;

    protected static Queue reportQueue = new Queue();

    protected static ReportClass CreateReport(Type reportClass)
    {
        object report = Activator.CreateInstance(reportClass);
        reportQueue.Enqueue(report);
        return (ReportClass)report;
    }

    public static ReportClass GetReport(Type reportClass)
    {

        //75 is my print job limit.
        if (reportQueue.Count > 75) ((ReportClass)reportQueue.Dequeue()).Dispose();
        return CreateReport(reportClass);
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            string sql;
            sql = "SELECT  distinct [Class] Class_Name FROM SectionTab ";

            DataSet ds = new DataSet();
            SqlConnection conn = new SqlConnection(Connection.ConString);
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);

            da.Fill(ds, "ClassName");


            //  List<DistricData> tehsil = new List<DistricData>();


            if (ds.Tables["ClassName"].Rows.Count > 0)
            {

                ddlClass.DataSource = ds;
                ddlClass.DataBind();
                ddlClass.DataTextField = "Class_Name";
                ddlClass.DataValueField = "Class_Name";
                ddlClass.DataBind();
                ddlClass.Items.Insert(0, "All");
                ddlSection.Items.Insert(0, "All");
            }
            ds.Dispose();


        }

    }

    protected void Page_Unload(object sender, EventArgs e)
    {

        //crystalReport.Close();
        // crystalReport.Dispose();
        GC.Collect();
    }



    [WebMethod]
    public static string GetData()
    {

        string sql;
        sql = "SELECT  distinct [Class] FROM SectionTab ";
        // sql = "SELECT * FROM TehsilMaster   ";
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "ClassName");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables["ClassName"].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables["ClassName"]);
        }
        return _data;


    }

    [WebMethod]
    public static string GetSection(string class_name)
    {

        string sql;
        sql = "SELECT distinct[section] FROM SectionTab where [Class] ='" + class_name + "' ";
        //  sql = "SELECT distinct[section] FROM SectionTab ";
        // sql = "SELECT * FROM TehsilMaster   ";
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "SectionName");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables["SectionName"].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables["SectionName"]);
        }
        return _data;


    }


    protected void Page_PreInit(object sender, EventArgs e)
    {


       drClass = Request.Form["ddlClass"];
        drSection = Request.Form["ddlSection"];
        category = Request.Form["drCategory"];
        BindReport();


    }

    private void BindReport()
    {





        string sql = "";


        if (drClass != "All" && drSection != "All")
        {
            sql = "Select * from StudentMaster    where [Class]='" + drClass + "' and   [Section]='" + drSection + "'  ";

        }
        else if (drClass == "All" && drSection != "All")
        {
            
            sql = "Select * from StudentMaster where  [Section]='" + drSection + "'  ";

        }

        else if (drClass == "All" && drSection == "All")
        {
            sql = "Select * from StudentMaster   where StudentName  like'%%' ";

        }
        else if (drClass != "All" && drSection == "All")
        {
            
                sql = " Select * from StudentMaster where [Class]='" + drClass + "' ";

            
        }




        if (category != "All")
        {
            sql = sql + " and  Category='" + category + "'  Order By [Class] ,[Section]";
        }
        else
        {
            sql = sql + "  Order By [Class] ,[Section]";
        }


        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "StudentMaster");


        crystalReport = new ReportDocument();
        crystalReport.Load(Server.MapPath("~/CrStudentMaster.rpt"));



        crystalReport.SetDataSource(ds.Tables[0]);
        //crystalReport.SetParameterValue("FromDate", txtFromDate.Text);
        //crystalReport.SetParameterValue("ToDate", txtToDate.Text);

        //crystalReport.SetParameterValue("Section_Name", ddlSection.SelectedValue);
        //crystalReport.SetParameterValue("Class_Name", ddlClass.SelectedValue);
        CrystalReportViewer1.ReportSource = crystalReport;

        // CrystalReportPartsViewer1.DisplayGroupTree = false;


        //crystalReport.Close();
        //crystalReport.Dispose();
        GC.Collect();
    }




    protected void btnShowFees_Click(object sender, EventArgs e)
    {



        //fromdate = Request.Form["txtFromDate"];
        //todate = Request.Form["txtToDate"];
        BindReport();


    }



    protected void btnShowFees_Click1(object sender, EventArgs e)
    {
        BindReport();
    }
}



//    protected void Page_Load(object sender, EventArgs e)
//    {
//        //conn = new SqlConnection(Connection.ConString);

//        //if (!IsPostBack)
//        //{
//        //    this.BindReport();
//        //}
//        //else
//        //{
//        //    BindReport();
//        //}
//    }

//    protected void Page_PreInit(object sender, EventArgs e)
//    {
//        //string sql;
//        //sql = "Select * from StudentMaster  ";



//        //DataSet ds = new DataSet();
//        //SqlConnection conn = new SqlConnection(Connection.ConString);
//        //SqlDataAdapter da = new SqlDataAdapter(sql, conn);

//        //da.Fill(ds, "StudentMaster");


//        //ReportDocument crystalReport = new ReportDocument();
//        //crystalReport.Load(Server.MapPath("~/CrStudentMaster.rpt"));

//        //crystalReport.SetDataSource(ds.Tables[0]);
//        //CrystalReportViewer1.ReportSource = crystalReport;

//        BindReport();


//    }

//    private void BindReport()
//    {





//        string sql;
//        sql = "Select * from StudentMaster   Order By [Class] ,[Section]";



//        DataSet ds = new DataSet();
//        SqlConnection conn = new SqlConnection(Connection.ConString);
//        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

//        da.Fill(ds, "StudentMaster");


//        ReportDocument crystalReport = new ReportDocument();
//        crystalReport.Load(Server.MapPath("~/CrStudentMaster.rpt"));

//        crystalReport.SetDataSource(ds.Tables[0]);
//        CrystalReportViewer1.ReportSource = crystalReport;
//        // CrystalReportPartsViewer1.DisplayGroupTree = false;
//    }
//}