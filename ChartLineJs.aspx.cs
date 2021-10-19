using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

using System.Web.Services;
using Newtonsoft.Json;

public partial class ChartLineJs : System.Web.UI.Page
{
    static string server_date;

    static DBConnection Connection = new DBConnection();
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string GetLineChartData()
    {
       
        string sql;
        sql = "select * from (select top 15 ReceiptDate, count(*) as Totaltrans  from  NurseryFeeCollection_2122   group by ReceiptDate order by ReceiptDate desc )t order by t.ReceiptDate asc";
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Mycon"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "Chart");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables["Chart"].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables["Chart"]);
        }
        return _data;


    }
    [WebMethod]
    public static string GetAmountChartData()
    {

        string sql;
        sql = "select * from (select top 15 ReceiptDate,sum(TotalReceived) as TotalAmount  from  NurseryFeeCollection_2122   group by ReceiptDate order by ReceiptDate desc )t order by t.ReceiptDate asc";
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Mycon"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "Chart");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables["Chart"].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables["Chart"]);
        }
        return _data;


    }

    [WebMethod]
    public static string GetChartData()
    {

        string sql;
         sql = "select * from (select top 15 purchase_no, count(*) as totalPurchase  from  bill_table   where session='2122'  group by purchase_no order by purchase_no desc )t order by t.purchase_no asc";




        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Mycon"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "Chart");
        int i;

      
        string _data = "";
        if (ds.Tables[0].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables[0]);
        }
        return _data;


    }

    [WebMethod]
    public static string GetTotalAmount()
    {

        string sql;
        sql = "select * from (select top 15 purchase_no, count(*) as totalPurchase  from  bill_table   where session='2122'  group by purchase_no order by purchase_no desc )t order by t.purchase_no asc";

        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Mycon"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "Chart");
        int i;

       

        string _data = "";
        if (ds.Tables[0].Rows.Count > 0)
        {
            _data = ds.Tables[0].Rows[0][0].ToString();
        }
        return _data;


    }

    [WebMethod]
    public static string GetTotalData()
    {


        return null;

    }


    [WebMethod]
    public static string GetServerDate()
    {


        string sql;
        sql = "select getdate() from usertab";
        try
        {

            DataSet ds2 = new DataSet();
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Mycon"].ToString());
            SqlDataAdapter da2 = new SqlDataAdapter(sql, conn);

            da2.Fill(ds2, "serverdate");



            if (ds2.Tables[0].Rows.Count > 0)
            {

                server_date = String.Format("{0:dd/MMM/yyyy}", ds2.Tables[0].Rows[0][0]);

            }
        }
        catch (Exception ex)
        {

        }
        return server_date;
    }



   
   
    
   
}