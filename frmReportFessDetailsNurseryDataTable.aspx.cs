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


public partial class frmReportFessDetailsNurseryDataTable : System.Web.UI.Page
{

    static DBConnection Connection = new DBConnection();
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string GetData()
    {

        string sql;
        //if (drclass != "All")
        //{

        sql = "  Select  [FeeBookNo], [ReceiptDate], [StudentName], [MonthT],[Class], [Section], [TotalAmount], [TutionFee], [SdfFee], [TermFee], [MiscFee], [LateFee], [DupFee], [TotalReceived], [TransactionType] from NurseryFeeCollection_2122 ";// where[Class] = '" + drclass + "' and ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";
           // sql = " SELECT * FROM  patientregistration  where reg_date between  '" + fromdate + "' and  '" + todate + "' and patcategory='" + category + "'  order by receiptno";

        //}
        //else
        //{
        //    sql = "  Select* from NurseryFeeCollection_2122 where ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";

        //          }
     
        DataSet ds = new DataSet();

        SqlConnection conn = new SqlConnection(Connection.ConString);
       
         SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "fees_data");
        int i;

       

        string _data = "";
        if (ds.Tables["fees_data"].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables["fees_data"]);
        }
        else
        {
            _data = "Failure";
        }
        return _data;


    }

   
  
}




