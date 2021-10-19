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

public partial class FrmFeesTransactionNew : System.Web.UI.Page
{

    static DBConnection Connection = new DBConnection();
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {

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
        public string  PaymentMode { get; set; }
        public string  Remarks { get; set; }

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


            int i =0;

            foreach (var receipt in serializeData)
            {



                sql = " Update NurseryFeeCollection_2122 set ReceiptDate=@ReceiptDate  , Remarks= @Remarks where  AdmissionNo=@AdmissionNo and ReceiptNo=@ReceiptNo  and TransactionType=@PaymentMode";

                SqlCommand cmd = new SqlCommand(sql, conn, sqltrans);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@AdmissionNo", receipt.AdmissionNo);
                cmd.Parameters.AddWithValue("@ReceiptNo", receipt.ReceiptNo);
                cmd.Parameters.AddWithValue("@ReceiptDate", receipt.ReceiptDate);
                cmd.Parameters.AddWithValue("@PaymentMode", receipt.PaymentMode);

                if (i == 0)
                {
                    cmd.Parameters.AddWithValue("@Remarks", receipt.Remarks);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Remarks", "");
                }

                


                cmd.CommandTimeout = 3000;
                cmd.ExecuteNonQuery();
                cmd.Dispose();




                if (i == 0)
                {
                    sql_receipt = " Update NurseryFeeCollection_Receipt set ReceiptDate=@ReceiptDate , Remarks= @Remarks  where  AdmissionNo=@AdmissionNo and ReceiptNo=@ReceiptNo and  TransactionType=@PaymentMode";

                    SqlCommand cmd_receipt = new SqlCommand(sql_receipt, conn, sqltrans);
                    cmd_receipt.CommandType = CommandType.Text;
                    cmd_receipt.Parameters.AddWithValue("@AdmissionNo", receipt.AdmissionNo);
                    cmd_receipt.Parameters.AddWithValue("@ReceiptNo", receipt.ReceiptNo);
                    cmd_receipt.Parameters.AddWithValue("@ReceiptDate", receipt.ReceiptDate);
                    cmd_receipt.Parameters.AddWithValue("@PaymentMode", receipt.PaymentMode);

                    cmd_receipt.CommandTimeout = 3000;
                    cmd_receipt.ExecuteNonQuery();
                    cmd_receipt.Dispose();
                }
                i++;
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


    [WebMethod]
    public static string CancelFeesTransaction(string receiptdata)
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



                sql = " delete from  NurseryFeeCollection_2122   where  AdmissionNo=@AdmissionNo and ReceiptNo=@ReceiptNo  and TransactionType=@PaymentMode";

                SqlCommand cmd = new SqlCommand(sql, conn, sqltrans);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@AdmissionNo", receipt.AdmissionNo);
                cmd.Parameters.AddWithValue("@ReceiptNo", receipt.ReceiptNo);
                cmd.Parameters.AddWithValue("@ReceiptDate", receipt.ReceiptDate);
                cmd.Parameters.AddWithValue("@PaymentMode", receipt.PaymentMode);


                cmd.CommandTimeout = 3000;
                cmd.ExecuteNonQuery();
                cmd.Dispose();


                sql_receipt = " delete from  NurseryFeeCollection_Receipt   where  AdmissionNo=@AdmissionNo and ReceiptNo=@ReceiptNo and  TransactionType=@PaymentMode";

                SqlCommand cmd_receipt = new SqlCommand(sql_receipt, conn, sqltrans);
                cmd_receipt.CommandType = CommandType.Text;
                cmd_receipt.Parameters.AddWithValue("@AdmissionNo", receipt.AdmissionNo);
                cmd_receipt.Parameters.AddWithValue("@ReceiptNo", receipt.ReceiptNo);
                cmd_receipt.Parameters.AddWithValue("@ReceiptDate", receipt.ReceiptDate);
                cmd_receipt.Parameters.AddWithValue("@PaymentMode", receipt.PaymentMode);

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


    [WebMethod]
    public static string GetData()
    {

        string sql;
        //if (drclass != "All")
        //{
        
     sql = "  Select [AdmissionNo],[ReceiptNo],  FORMAT(ReceiptDate, 'dd-MMM-yyyy') as [ReceiptDate],  [StudentName],[Class], [Section] ,[MonthT],[TotalReceived],[TransactionType]  from NurseryFeeCollection_Receipt  order by    Cast([ReceiptDate] as date) , cast([ReceiptNo]  as integer)  desc ";// where[Class] = '" + drclass + "' and ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";



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

    [WebMethod]
    public static string  GetDataReceiptNo(string receiptno ,string paymentmode)
    {

        string sql;
        //if (drclass != "All")
        //{
        sql = "    Select R.[AdmissionNo],R.[ReceiptNo],  FORMAT(R.ReceiptDate, 'dd-MMM-yyyy') as [ReceiptDate],  R.[StudentName],R.[Class], R.[Section] ,R.[MonthT],R.[TotalReceived],R.[TransactionType],C.[Remarks] from NurseryFeeCollection_Receipt R inner join[dbo].[NurseryFeeCollection_2122]C on (R.ReceiptNo =C.Receiptno  and R.TransactionType =C.TransactionType) where R.Receiptno='" + receiptno + "'  and R.TransactionType='"+ paymentmode + "' order by  [ReceiptNo] ,[ReceiptDate]  ";
       // sql = "  Select [AdmissionNo],[ReceiptNo],  FORMAT(ReceiptDate, 'dd-MMM-yyyy') as [ReceiptDate],  [StudentName],[Class], [Section] ,[MonthT],[TotalReceived],[TransactionType],[Remarks]  from NurseryFeeCollection_Receipt  where Receiptno='"+ receiptno + "'  order by  [ReceiptNo] ,[ReceiptDate] ";// where[Class] = '" + drclass + "' and ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";



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

}