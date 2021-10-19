

using System;

using System.Collections.Generic;




using System;

using System.Collections.Generic;

using System.Data.SqlClient;
using System.Data;

using System.Web.Services;
using Newtonsoft.Json;

using CrystalDecisions.CrystalReports.Engine;


using System.Collections;
public partial class ReportNurseryFeesCollection : System.Web.UI.Page
{

    string drClass, drSection,fromdate, todate, sql , trans_type;
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

            da.Fill(ds, "SectionTab");
           

            //  List<DistricData> tehsil = new List<DistricData>();

         
            if (ds.Tables["SectionTab"].Rows.Count > 0)
            {
              
                  ddlClass.DataSource = ds.Tables["SectionTab"];
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
        //crystalReport.Dispose();
        GC.Collect();
    }



    //[WebMethod]
    //public static string GetData()
    //{

    //    string sql;
    //    sql = "SELECT  distinct [Class] FROM SectionTab ";
    //    // sql = "SELECT * FROM TehsilMaster   ";
    //    DataSet ds = new DataSet();
    //    SqlConnection conn = new SqlConnection(Connection.ConString);
    //    SqlDataAdapter da = new SqlDataAdapter(sql, conn);

    //    da.Fill(ds, "ClassName");
    //    int i;

    //    //  List<DistricData> tehsil = new List<DistricData>();

    //    string _data = "";
    //    if (ds.Tables["ClassName"].Rows.Count > 0)
    //    {
    //        _data = JsonConvert.SerializeObject(ds.Tables["ClassName"]);
    //    }
    //    return _data;


    //}

    //[WebMethod]
    //public static string GetSection(string class_name)
    //{

    //    string sql;
    //    sql = "SELECT distinct[section] FROM SectionTab where [Class] ='" + class_name + "' ";
    //    //  sql = "SELECT distinct[section] FROM SectionTab ";
    //    // sql = "SELECT * FROM TehsilMaster   ";
    //    DataSet ds = new DataSet();
    //    SqlConnection conn = new SqlConnection(Connection.ConString);
    //    SqlDataAdapter da = new SqlDataAdapter(sql, conn);

    //    da.Fill(ds, "SectionName");
    //    int i;

    //    //  List<DistricData> tehsil = new List<DistricData>();

    //    string _data = "";
    //    if (ds.Tables["SectionName"].Rows.Count > 0)
    //    {
    //        _data = JsonConvert.SerializeObject(ds.Tables["SectionName"]);
    //    }
    //    return _data;


    //}


    protected void Page_PreInit(object sender, EventArgs e)
    {


        drClass = Request.Form["ddlClass"];
        drSection = Request.Form["ddlSection"];
        fromdate = Request.Form["txtFromDate"];
        todate = Request.Form["txtToDate"];
        trans_type = Request.Form["drTransaction"];
        BindReport();


    }

    private void BindReport()
    {





        string sql="";

        
        //{
        //    sql = "Select * from NurseryFeeCollection_2122      where [Class]='" + drClass + "' and  ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";

        //}




if (drClass != "All" && drSection != "All")
        {
            sql = "Select * from NurseryFeeCollection_2122  where [Class]='" + drClass + "' and   [Section]='" + drSection + "' and  ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";

        }
        else if (drClass == "All" && drSection != "All")
        {
            sql = "Select * from NurseryFeeCollection_2122  where  [Section]='" + drSection + "' and  ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";

        }

        else if (drClass == "All" && drSection == "All")
        {
            sql = "Select * from NurseryFeeCollection_2122  where   ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";

        }
        else if (drClass != "All" && drSection == "All")
        {
            if (drClass == "Nursery-KG2" && drSection == "All")
            {
                sql = "Select * from NurseryFeeCollection_2122  where [Class] in('Nursery','KG1','KG2') and  ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";

            }
            else if (drClass == "1-12" && drSection == "All")
            {
                sql = "Select * from NurseryFeeCollection_2122  where [Class] Not In('Nursery','KG1','KG2') and  ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";

            }
            else 
            {
                sql = "Select * from NurseryFeeCollection_2122      where [Class]='" + drClass + "' and  ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";

            }
        }

        


        if (trans_type != "All")
        {
            sql = sql + " and  TransactionType='" + trans_type + "'  order by  ReceiptDate";
        }
        else
        {
            sql = sql + "  order by  ReceiptDate";
        }


        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "NurseryFeeCollection_2122");


         crystalReport = new ReportDocument();
        crystalReport.Load(Server.MapPath("~/CrFeesCollection.rpt"));



        crystalReport.SetDataSource(ds.Tables["NurseryFeeCollection_2122"]);
        crystalReport.SetParameterValue("FromDate", txtFromDate.Text); 
        crystalReport.SetParameterValue("ToDate",txtToDate.Text);

        crystalReport.SetParameterValue("Section_Name", ddlSection.SelectedValue );
        crystalReport.SetParameterValue("Class_Name", ddlClass.SelectedValue);
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


    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {


    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {

        sql = "SELECT distinct[Section] Section_Name  FROM SectionTab where [Class] ='" + ddlClass.SelectedValue + "' ";
        //  sql = "SELECT distinct[section] FROM SectionTab ";
        // sql = "SELECT * FROM TehsilMaster   ";
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "Section_Name");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();


        if (ds.Tables["Section_Name"].Rows.Count > 0)
        {

            ddlSection.DataSource = ds.Tables["Section_Name"];
            ddlSection.DataBind();
            ddlSection.DataTextField = "Section_Name";
            ddlSection.DataValueField = "Section_Name";
            ddlSection.DataBind();
            ddlSection.Items.Insert(0, "All");
            
        }
        else
        {
            ddlSection.Items.Clear();
            ddlSection.Items.Insert(0, "All");
        }

    }

    protected void CrystalReportViewer1_Init(object sender, EventArgs e)
    {

    }
}


