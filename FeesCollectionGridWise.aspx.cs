using System;
using System.Web.Security;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Data.Sql;
using System.Web.Services;
using Newtonsoft.Json;
public partial class FeesCollectionGridWise : System.Web.UI.Page
{
    static string receiptno;
    static string drClass, fromdate, todate, sql, trans_type;
    static DBConnection Connection = new DBConnection();
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {

        trans_type = drTrans.SelectedItem.Value;
    }


    protected void Page_PreInit(object sender, EventArgs e)
    {



        trans_type = drTrans.SelectedItem.Value;


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
        return _data;


    }

    [WebMethod]
    public static string GetStudentDetails(string section_name, string class_name, string admission_no)
    {

        string sql;
        sql = "SELECT * FROM StudentMaster where [Class] ='" + class_name + "' and [Section]='" + section_name + "'  and  AdmissionNo= '" + admission_no + "' ";
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
        public string DuplicateFees { get; set; }
        public string TransactionType { get; set; }
    }


    [WebMethod]
    public static void get_next_receiptno( string Trans_Type)
    {




        string sql;

        try
        {
            sql = "SELECT isnull(max(cast(ReceiptNo as bigint)),0) + 1 FROM NurseryFeeCollection_2122  where TransactionType='" + Trans_Type + "'";




            DataSet ds = new DataSet();
            SqlConnection conn = new SqlConnection(Connection.ConString);
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);



            da.Fill(ds, "nxtrec");


            if (ds.Tables[0].Rows.Count > 0)
            {

                receiptno = ds.Tables["nxtrec"].Rows[0][0].ToString();

                Int32 regno;
                regno = Int32.Parse(receiptno.ToString());


                receiptno = String.Format("{0:00000}", regno);


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
       
        string sql, sql_month;
        int amount = 0;
        string monthT = "";
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
            var fee_month1 = serializeData[0];
            get_next_receiptno(fee_month1.TransactionType);
                         foreach (var fee in serializeData)
                        {

                            sql = "insert into NurseryFeeCollection_2122(ReceiptNo,FeeBookNo, ReceiptDate, StudentName, MonthT, Class, Section, TotalAmount, TutionFee, SdfFee, TermFee, MiscFee, LateFee, DupFee, TotalReceived, TransactionType, Remarks, AdmissionNo, Session, Balance) values (@ReceiptNo,@FeeBookNo, @Date, @StudentName, @MonthT, @Class, @Section, @TotalAmount, @TutionFee, @SdfFee, @TermFee, @MiscFee, @LateFee, @DupFee, @TotalReceived, @TransactionType, @Remarks, @AdmissionNo, @Session, @Balance)";

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
                            cmd.Parameters.AddWithValue("@TutionFee", fee.TermFees);
                            cmd.Parameters.AddWithValue("@SdfFee", fee.StdFees);
                            cmd.Parameters.AddWithValue("@TermFee", fee.TermFees);
                            cmd.Parameters.AddWithValue("@MiscFee", fee.MiscFees);
                            cmd.Parameters.AddWithValue("@LateFee", fee.LateFees);
                            cmd.Parameters.AddWithValue("@DupFee", fee.DuplicateFees);
                            cmd.Parameters.AddWithValue("@TotalReceived", fee.Amount);
                            cmd.Parameters.AddWithValue("@TransactionType", fee.TransactionType);
                            cmd.Parameters.AddWithValue("@Remarks", "-");
                            cmd.Parameters.AddWithValue("@AdmissionNo", fee.AdmissionNo);
                            cmd.Parameters.AddWithValue("@Session", 2021);
                            cmd.Parameters.AddWithValue("@Balance", 0);

                             monthT = monthT + fee.Month + ",";
                             amount = amount + Int32.Parse(fee.Amount);
                            cmd.CommandTimeout = 3000;

                            cmd.ExecuteNonQuery();
                            cmd.Dispose();

                        }



            var fee_month = serializeData[0];

            sql_month = "insert into NurseryFeeCollection_Receipt(ReceiptNo,FeeBookNo, ReceiptDate, StudentName, MonthT, Class, Section,  TotalReceived, TransactionType, AdmissionNo, Session) values (@ReceiptNo,@FeeBookNo, @Date, @StudentName, @MonthT, @Class, @Section, @TotalReceived, @TransactionType, @AdmissionNo, @Session)";
            SqlCommand cmd_month = new SqlCommand(sql_month, conn, sqltrans);
            cmd_month.CommandType = CommandType.Text;

            cmd_month.Parameters.AddWithValue("@ReceiptNo", receiptno);
            cmd_month.Parameters.AddWithValue("@FeeBookNo", fee_month.BookNo);
            cmd_month.Parameters.AddWithValue("@Date", fee_month.FeesDate);
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
                  

        }
            catch (Exception ex)
            {
                sqltrans.Rollback();
                throw ex;
            }
            finally
            {
            conn.Close();
            }

        return "true";
        }

        

        



    


    




    [WebMethod]
    public static string GetFeeDetails(string month_name, string class_name, string Admission_No)
    {

        string sql;
        //  sql = "SELECT * FROM FeeStructure where  [Class]= '" + class_name + "' ";

        /****** Script for SelectTopNRows command from SSMS  ******/
        // sql = " SELECT Fee.* , coll.TotalReceived FROM[SchoolDB].[dbo].[FeeStructure] Fee left join[dbo].[NurseryFeeCollection_2122] coll on Fee.Class=coll.Class and    Fee.MonthT=coll.[MonthT]   where  Fee.[Class]= '" + class_name + "'  and AdmissionNo='"+ Admission_No + "' ";
        // sql = "SELECT * FROM TehsilMaster   ";


        sql = "  SELECT Fee.* , isNull(coll.TotalReceived, 0) TotalReceived FROM[SchoolDB].[dbo].[FeeStructure] ";
        sql += "       Fee left join ";
        sql += " (select* from   [NurseryFeeCollection_2122] coll where    AdmissionNo= '" + Admission_No + "') coll on Fee.Class=coll.Class and  Fee.MonthT=coll.MonthT   where Fee.[Class]= '" + class_name + "' ";



        //        SELECT Fee.*   , isNull(coll.TotalReceived, 0) , coll.TransactionType FROM[SchoolDB].[dbo].[FeeStructure]
        //    Fee left join


        //(select* from   [NurseryFeeCollection_2122] coll where AdmissionNo= 'K1A/20/18') coll on Fee.Class=coll.Class and  Fee.MonthT=coll.MonthT where Fee.[Class]= 'KGI'




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

    protected void btnShow_Click(object sender, EventArgs e)
    {

    }

    protected void Reset_Click(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }



    protected void btnPayment_Click(object sender, EventArgs e)
    {

    }
}
