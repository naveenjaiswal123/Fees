using System;

using System.Collections.Generic;

using System.Data.SqlClient;
using System.Data;

using System.Web.Services;
using Newtonsoft.Json;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class FrmPrintFeesReceipt : System.Web.UI.Page
{
    string drClass, fromdate, todate, sql,receiptno, transtype;
    static DBConnection Connection = new DBConnection();
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string PrintReceipt(string receipt_no)
    {
      
        string sql;
        sql = "SELECT  * from  NurseryFeeCollection_Receipt  where ReceiptNo='" + receipt_no + "' ";

        //sql = "SELECT distinct[section] FROM SectionTab ";
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
        
     
        receiptno = Request.QueryString["Receipt_No"];

        transtype = Request.QueryString["Trans_Type"];

        if ( (String.IsNullOrEmpty(receiptno)==false ) && (String.IsNullOrEmpty(transtype)==false))
        {
            Global.ReceiptNo_Global = receiptno;
            Global.TransType_Global = transtype;
          
        }


        BindReport();

    }

    private void BindReport()
    {




       
        string sql;

       
            sql = "Select * from NurseryFeeCollection_Receipt  where Receiptno='" + Global.ReceiptNo_Global  + "'  and TransactionType='"+ Global.TransType_Global + "' ";

       
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "NurseryFeeCollection_Receipt");


        ReportDocument crystalReport = new ReportDocument();
        crystalReport.Load(Server.MapPath("~/CrFeesReceipt.rpt"));



        crystalReport.SetDataSource(ds.Tables["NurseryFeeCollection_Receipt"]);


        CrystalReportViewer1.ReportSource = crystalReport;

        // CrystalReportPartsViewer1.DisplayGroupTree = false;
    }

    protected void btnShowFees_Click(object sender, EventArgs e)
    {



        //fromdate = Request.Form["txtFromDate"];
        //todate = Request.Form["txtToDate"];
        BindReport();


    }
}