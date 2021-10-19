


using System;

using System.Collections.Generic;

using System.Data.SqlClient;
using System.Data;

using System.Web.Services;
using Newtonsoft.Json;
using System.Web.UI;
using System.Web;
using System.Web.UI.WebControls;

public partial class FeesCollectionGridWiseAdmissinNo : System.Web.UI.Page
{
    static   string receiptno;
    static string drClass, fromdate, todate, sql, trans_type;

    static DBConnection Connection = new DBConnection();
   
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_PreInit(object sender, EventArgs e)
    {


        
        trans_type = Request.Form["drTransaction"];
      

    }

    [WebMethod]
    public static string GetData()
    {

        string sql;
        sql = "SELECT  distinct [Class] FROM NurTab ";
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
        sql = "SELECT distinct[section] FROM StudentMaster where [Class] ='" + class_name + "' ";
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
            return _data;
        }

        return _data;


    }

    [WebMethod]
    public static string GetStudentData(string class_name, string section_name)
    {

        string sql;
        sql = "SELECT * FROM StudentMaster where [Class] ='" + class_name + "' and [Section]='" + section_name + "' ";
        // sql = "SELECT * FROM TehsilMaster   ";
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "StudentDetail");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables["StudentDetail"].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables["StudentDetail"]);
        }

        da.Dispose();
        ds.Dispose();
        conn.Close();
        return _data;


    }

    [WebMethod]
    public static string GetStudentDetails( string admission_no)
    {

        string sql;
        sql = "SELECT * FROM StudentMaster where   AdmissionNo= '" + admission_no + "' ";
        // sql = "SELECT * FROM TehsilMaster   ";
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "StudentDetail");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables["StudentDetail"].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables["StudentDetail"]);
        }

        else {

            _data = "false";
        }
        da.Dispose();
        ds.Dispose();
        conn.Close();
        return _data;


    }


    public class Fees
    {
        public string BookNo { get; set; }
        public string FeesDate { get; set; }
        public string StudentName { get; set; }
        public string AdmissionNo { get; set; }
        public string ClassName { get; set; }
        public string Section { get; set; }
        public string Amount { get; set; }
        public string Month { get; set; }
        public string TutionFees { get; set; }
        public string StdFees { get; set; }
        public string TermFees { get; set; }
        public string CompFees { get; set; }
        public string SportFees { get; set; }
        public string MiscFees { get; set; }
        public string LateFees { get; set; }
        public string CautionFees { get; set; }
      
        public string ReReg_Fees { get; set; }

        public string DuplicateFees { get; set; }
        public string TransactionType { get; set; }
        public string Remarks { get; set; }
    }



    [WebMethod]
    public static void get_next_receiptno(string Trans_Type)
    {

        
       

        string sql;

        try
        {
            sql = "SELECT isnull(max(cast(ReceiptNo as bigint)),0) + 1 FROM NurseryFeeCollection_2122  where TransactionType='" + Trans_Type + "'";




            DataSet ds = new DataSet();
            SqlConnection conn = new SqlConnection(Connection.ConString);
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);



            da.Fill(ds, "NurseryFeeCollection_2122");


            if (ds.Tables["NurseryFeeCollection_2122"].Rows.Count > 0)
            {

                receiptno = ds.Tables["NurseryFeeCollection_2122"].Rows[0][0].ToString();

                Int32 regno;
                regno = Int32.Parse(receiptno.ToString());


                receiptno = String.Format("{0:00000}", regno);
                Global.ReceiptNo_Global = receiptno;
                Global.TransType_Global = Trans_Type;

                Page page = (Page)HttpContext.Current.Handler;
           
               
                TextBox TxtReceiptNo = (TextBox)page.FindControl("TxtReceiptNo");
                TxtReceiptNo.Text = receiptno;


            }
        }
        catch (Exception ex)
        {


        }

    }






    [WebMethod]
    public static string SaveFeesDetails(string feesdata)
    {
        var serializeData = JsonConvert.DeserializeObject<List<Fees>>(feesdata);

        string sql, sql_month ;
        int amount = 0;
        string monthT = "";
        string return_result = "false";
        SqlTransaction sqltrans = null;
       SqlConnection conn = new SqlConnection(Connection.ConString);
          //using (SqlConnection conn = new SqlConnection(Connection.ConString))
     
                if (conn.State == ConnectionState.Closed)
                {

                    conn.ConnectionString = Connection.ConString;
                    conn.Open();
                }

                sqltrans = conn.BeginTransaction(IsolationLevel.ReadCommitted);


                try
                {

                        int i = 0;
                        var fee_month1 = serializeData[0];
                        get_next_receiptno(fee_month1.TransactionType);

                foreach (var fee in serializeData)

                    {

                        sql = "insert into NurseryFeeCollection_2122(ReceiptNo,FeeBookNo, ReceiptDate, StudentName, MonthT, Class, Section, TotalAmount, TutionFee, SdfFee, TermFee, MiscFee, LateFee, DupFee,CautionMoney,ReRegFee, TotalReceived, TransactionType, Remarks, AdmissionNo, Session, Balance) values (@ReceiptNo,@FeeBookNo, @Date, @StudentName, @MonthT, @Class, @Section, @TotalAmount, @TutionFee, @SdfFee, @TermFee, @MiscFee, @LateFee, @DupFee, @CautionMoney, @ReRegMoney, @TotalReceived, @TransactionType, @Remarks, @AdmissionNo, @Session, @Balance)";

                        SqlCommand cmd = new SqlCommand(sql, conn, sqltrans);
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@ReceiptNo", receiptno);
                        cmd.Parameters.AddWithValue("@FeeBookNo", fee.BookNo);
                        cmd.Parameters.AddWithValue("@Date", fee.FeesDate);
                        cmd.Parameters.AddWithValue("@StudentName", fee.StudentName);
                        cmd.Parameters.AddWithValue("@MonthT", fee.Month);
                        cmd.Parameters.AddWithValue("@Class", fee.ClassName);
                        cmd.Parameters.AddWithValue("@Section", fee.Section);
                        cmd.Parameters.AddWithValue("@TotalAmount", fee.Amount);
                        cmd.Parameters.AddWithValue("@TutionFee", fee.TutionFees);
                        cmd.Parameters.AddWithValue("@SdfFee", fee.StdFees);
                        cmd.Parameters.AddWithValue("@TermFee", fee.TermFees);
                        cmd.Parameters.AddWithValue("@MiscFee", fee.MiscFees);
                        cmd.Parameters.AddWithValue("@LateFee", fee.LateFees);
                        cmd.Parameters.AddWithValue("@DupFee", fee.DuplicateFees);

                        if (String.IsNullOrEmpty(fee.CautionFees))
                        {
                            cmd.Parameters.AddWithValue("@CautionMoney", 0);
                        }
                        else {
                            cmd.Parameters.AddWithValue("@CautionMoney", fee.CautionFees);
                        }


                        if (String.IsNullOrEmpty(fee.ReReg_Fees))
                        {
                            cmd.Parameters.AddWithValue("@ReRegMoney", 0);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@ReRegMoney", fee.ReReg_Fees);
                        }


                        cmd.Parameters.AddWithValue("@TotalReceived", fee.Amount);
                        cmd.Parameters.AddWithValue("@TransactionType", fee.TransactionType);
                        if (i == 0)
                        {
                            cmd.Parameters.AddWithValue("@Remarks", fee.Remarks);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@Remarks", "");
                        }


                        cmd.Parameters.AddWithValue("@AdmissionNo", fee.AdmissionNo);
                        cmd.Parameters.AddWithValue("@Session", 2021);
                        cmd.Parameters.AddWithValue("@Balance", 0);

                        monthT = monthT + fee.Month + ",";
                        amount = amount + Int32.Parse(fee.Amount);
                        cmd.CommandTimeout = 3000;

                        cmd.ExecuteNonQuery();
                       // cmd.Dispose();
                        i++;

                    }



                var fee_month = serializeData[0];


                        sql_month = "insert into NurseryFeeCollection_Receipt(ReceiptNo,FeeBookNo, ReceiptDate, StudentName, MonthT, Class, Section,  TotalReceived, TransactionType, AdmissionNo, Session) values (@ReceiptNo,@FeeBookNo, @ReceiptDate, @StudentName, @MonthT, @Class, @Section, @TotalReceived, @TransactionType, @AdmissionNo, @Session)";
                        SqlCommand cmd_month = new SqlCommand(sql_month, conn, sqltrans);
                        cmd_month.CommandType = CommandType.Text;

                        cmd_month.Parameters.AddWithValue("@ReceiptNo", receiptno);
                        cmd_month.Parameters.AddWithValue("@FeeBookNo", fee_month.BookNo);
                        cmd_month.Parameters.AddWithValue("@ReceiptDate", fee_month.FeesDate);
                        cmd_month.Parameters.AddWithValue("@StudentName", fee_month.StudentName);
                        cmd_month.Parameters.AddWithValue("@MonthT", monthT);
                        cmd_month.Parameters.AddWithValue("@Class", fee_month.ClassName);
                        cmd_month.Parameters.AddWithValue("@Section", fee_month.Section);
                        cmd_month.Parameters.AddWithValue("@TotalReceived", amount);
                        cmd_month.Parameters.AddWithValue("@TransactionType", fee_month.TransactionType);
                        cmd_month.Parameters.AddWithValue("@AdmissionNo", fee_month.AdmissionNo);
                        cmd_month.Parameters.AddWithValue("@Session", 2021);

                        cmd_month.ExecuteNonQuery();
                        cmd_month.Dispose();

                       sqltrans.Commit();
                       return_result = "true";

                }
                catch (Exception ex)
                {
                        sqltrans.Rollback();
                        return_result = "false";
                        throw ex;
           
                }
                finally
                {
                    conn.Close();
                }
    
        return return_result;
    }
















    [WebMethod]
    public static string GetFeeDetails( string Admission_No, string class_name)
    {

        string sql;
       

        sql = "  SELECT Fee.* , isNull(coll.TotalReceived, 0) TotalReceived , IsNull(TransactionType,'') TransactionType, isNull( FORMAT (ReceiptDate, 'dd-MMM-yyyy') ,'') ReceiptDate , isNull (Remarks,'')  Remarks ,SM.Category  FROM[SchoolDB].[dbo].[FeeStructure] ";
        sql += "       Fee  left join ";
        sql += " (select * from   [NurseryFeeCollection_2122] coll   inner join StudentMaster SM on  Fee.AdmissionNo=Sm.AdmissionNo  where    AdmissionNo= '" + Admission_No + "') coll on Fee.Class=coll.Class and  Fee.MonthT=coll.MonthT   where Fee.[Class]= '" + class_name + "'   order by seq_Month";





        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "FeeDetails");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables["FeeDetails"].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables["FeeDetails"]);
        }
        da.Dispose();
        ds.Dispose();
        conn.Close();
        return _data;


    }

   

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        //string drStudentName, drClass, drSection, drAdmissionNo, sql;
        //drStudentName = Request.Form["drStudentName"];
        //drClass = Request.Form["drClass"];
        //drSection = Request.Form["drSection"];
        //drStudentName = Request.Form["drStudentName"];
        //drAdmissionNo = Request.Form["drAdmissionNo"];
        //try
        //{
        //    SqlConnection conn = new SqlConnection(Connection.ConString);
        //    conn.Open();


        //    sql = "insert into NurseryFeeCollection_2122(FeeBookNo, Date, StudentName, Month, Class, Section, TotalAmount, TutionFee, SdfFee, TermFee, MiscFee, LateFee, DupFee, TotalReceived, TransactionType, Remarks, AdmissionNo, Session, Balance) values (@FeeBookNo, @Date, @StudentName, @Month, @Class, @Section, @TotalAmount, @TutionFee, @SdfFee, @TermFee, @MiscFee, @LateFee, @DupFee, @TotalReceived, @TransactionType, @Remarks, @AdmissionNo, @Session, @Balance)";
        //    SqlCommand cmd = new SqlCommand(sql, conn);
        //    cmd.CommandType = CommandType.Text;
        //    cmd.Parameters.AddWithValue("@FeeBookNo", txtFeeBook.Text.Trim());
        //    cmd.Parameters.AddWithValue("@Date", txtDate.Text.Trim());
        //    cmd.Parameters.AddWithValue("@StudentName", drStudentName);
        //    cmd.Parameters.AddWithValue("@Month", drMonth.SelectedItem.Value);
        //    cmd.Parameters.AddWithValue("@Class", drClass);
        //    cmd.Parameters.AddWithValue("@Section", drSection);
        //    cmd.Parameters.AddWithValue("@TotalAmount", txtTotalAmount.Text.Trim());
        //    cmd.Parameters.AddWithValue("@TutionFee", txtTutionFee.Text.Trim());
        //    cmd.Parameters.AddWithValue("@SdfFee", txtStdFee.Text.Trim());
        //    cmd.Parameters.AddWithValue("@TermFee", txtTermFee.Text.Trim());
        //    cmd.Parameters.AddWithValue("@MiscFee", txtMiscFee.Text.Trim());
        //    cmd.Parameters.AddWithValue("@LateFee", txtLateFee.Text.Trim());
        //    cmd.Parameters.AddWithValue("@DupFee", txtDupFee.Text.Trim());
        //    cmd.Parameters.AddWithValue("@TotalReceived", txtReceiveAmount.Text.Trim());
        //    cmd.Parameters.AddWithValue("@TransactionType", drTrans.SelectedItem.Value);
        //    cmd.Parameters.AddWithValue("@Remarks", "-");
        //    cmd.Parameters.AddWithValue("@AdmissionNo", drAdmissionNo);
        //    cmd.Parameters.AddWithValue("@Session", 2021);
        //    cmd.Parameters.AddWithValue("@Balance", txtBalance.Text.Trim());
        //    cmd.ExecuteNonQuery();
        //    cmd.Dispose();
        //    conn.Close();
        //    string script = "window.onload = function() { SucessMessage(); };";

        //    ClientScript.RegisterStartupScript(this.GetType(), "SucessMessage", script, true);
        //    //    Response.Write("<script>alert('Saved Successfully');</script>");
        //    //BindGrid();
        //    //clear();
        //    // Session["Save"] = "Success";
        //    /// btnsave.Enabled = false;
        //    /// 
        //}
        //catch (Exception ex)
        //{
        //    //sqltrans.Rollback();
        //    throw ex;
        //}
        //finally
        //{

        //}


    }








}
