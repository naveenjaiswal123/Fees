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

public partial class frmFeesTransaction : System.Web.UI.Page
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

        sql = "  Select [AdmissionNo],[ReceiptNo],[ReceiptDate],  [StudentName],[Class], [Section] ,[TotalReceived],[TransactionType]  from NurseryFeeCollection_Receipt  order by  [ReceiptNo] ,[ReceiptDate] ";// where[Class] = '" + drclass + "' and ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";



        DataSet ds = new DataSet();

        SqlConnection conn = new SqlConnection(Connection.ConString);

        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "FeesCollection");
        int i;



        string data = "";
        if (ds.Tables["FeesCollection"].Rows.Count > 0)
        {
            data = JsonConvert.SerializeObject(ds.Tables["FeesCollection"]);
        }
        else
        {
            data = "Failure";
        }
        return data;


    }


    public class FeesReceipt
    {
        public string SrNo { get; set; }
        public string AdmissionNo { get; set; }
        public string ReceiptDate { get; set; }
        public string StudentName { get; set; }
        public string FatherName { get; set; }
        public string ClassName { get; set; }
        public string Section { get; set; }
        public string ReceiptNo { get; set; }

    }

    [WebMethod]
    public static string EditFeesTransaction(string receiptdata)
    {
        var serializeData = JsonConvert.DeserializeObject<List<FeesReceipt>>(receiptdata);
        string sql, sql_receipt, sql_search;

        SqlTransaction sqltrans = null;
        SqlConnection conn = new SqlConnection(Connection.ConString);

        if (conn.State == ConnectionState.Closed)
        {

            conn.ConnectionString = Connection.ConString;
            conn.Open();
        }

        sqltrans = conn.BeginTransaction();


        try
        {




            foreach (var receipt in serializeData)
            {



                sql = " Update NurseryFeesCollection_2122 set ReceiptDate=@ReceiptDate  where  AdmissionNo=@AdmissionNo and ReceiptNo=@ReceiptNo";

                SqlCommand cmd = new SqlCommand(sql, conn, sqltrans);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@AdmissionNo", receipt.AdmissionNo);
                  cmd.Parameters.AddWithValue("@ReceiptNo", receipt.ReceiptNo);
                cmd.Parameters.AddWithValue("@ReceiptDate", receipt.ReceiptDate);


                cmd.CommandTimeout = 3000;
                cmd.ExecuteNonQuery();
                cmd.Dispose();


                sql_receipt = " Update NurseryFeesCollection_Receipt set ReceiptDate=@ReceiptDate  where  AdmissionNo=@AdmissionNo and ReceiptNo=@ReceiptNo";

                SqlCommand cmd_receipt = new SqlCommand(sql_receipt, conn, sqltrans);
                cmd_receipt.CommandType = CommandType.Text;
                cmd_receipt.Parameters.AddWithValue("@AdmissionNo", receipt.AdmissionNo);
                cmd_receipt.Parameters.AddWithValue("@ReceiptNo", receipt.ReceiptNo);
                cmd_receipt.Parameters.AddWithValue("@ReceiptDate", receipt.ReceiptDate);


                cmd_receipt.CommandTimeout = 3000;
                cmd_receipt.ExecuteNonQuery();
                cmd_receipt.Dispose();
            }

            sqltrans.Commit();


        }
        catch (Exception ex)
        {
            sqltrans.Rollback();

            return "false";
            throw ex;

        }
        finally
        {
            conn.Close();
        }

        return "true";
    }



}