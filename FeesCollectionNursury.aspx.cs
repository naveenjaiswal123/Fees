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
public partial class FeesCollectionNursury : System.Web.UI.Page
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
        sql = "SELECT  distinct [Class] FROM NurTab ";
        // sql = "SELECT * FROM TehsilMaster   ";
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "ClassName");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables[0].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables[0]);
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
        if (ds.Tables[0].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables[0]);
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
        if (ds.Tables[0].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables[0]);
        }
        return _data;


    }


    [WebMethod]
    public static string GetFeeDetails(string month_name, string class_name)
    {

        string sql;
        sql = "SELECT * FROM FeeStructure where [MonthT] ='" + month_name + "'  and [Class]= '" + class_name + "' ";
        // sql = "SELECT * FROM TehsilMaster   ";
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "FeeDetails");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables[0].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables[0]);
        }
        return _data;


    }






    protected void btnLogin_Click(object sender, EventArgs e)
    {


        conn.Open();

        //SqlCommand cmd = new SqlCommand("insert into NurseryFeeCollection_2122(FeeBookNo, Date, StudentName, Month, Class, Section, TotalAmount, TutionFee, SdfFee, TermFee, MiscFee, LateFee, DupFee, TotalReceived, TransactionType, Remarks, AdmissionNo, Session, Balance) values (@FeeBookNo, @Date, @StudentName, @Month, @Class, @Section, @TotalAmount, @TutionFee, @SdfFee, @TermFee, @MiscFee, @LateFee, @DupFee, @TotalReceived, @TransactionType, @Remarks, @AdmissionNo, @Session, @Balance)", conn);
        //cmd.CommandType = CommandType.Text;
        //cmd.Parameters.AddWithValue("@FeeBookNo", txtFeeBook.Text.Trim());
        //cmd.Parameters.AddWithValue("@Date", txtDate.Text.Trim());
        //cmd.Parameters.AddWithValue("@StudentName", drStudentName.SelectedItem.Value);
        //cmd.Parameters.AddWithValue("@Month", drMonth.SelectedItem.Value);
        //cmd.Parameters.AddWithValue("@Class", drClass.SelectedItem.Value);
        //cmd.Parameters.AddWithValue("@Section", drSection.SelectedItem.Value);
        //cmd.Parameters.AddWithValue("@TotalAmount", txtTotalAmount.Text.Trim());
        //cmd.Parameters.AddWithValue("@TutionFee", txtTutionFee.Text.Trim());
        //cmd.Parameters.AddWithValue("@SdfFee", txtStdFee.Text.Trim());
        //cmd.Parameters.AddWithValue("@TermFee", txtTermFee.Text.Trim());
        //cmd.Parameters.AddWithValue("@MiscFee", txtMiscFee.Text.Trim());
        //cmd.Parameters.AddWithValue("@LateFee", txtLateFee.Text.Trim());
        //cmd.Parameters.AddWithValue("@DupFee", txtDupFee.Text.Trim());
        //cmd.Parameters.AddWithValue("@TotalReceived", txtReceiveAmount.Text.Trim());
        //cmd.Parameters.AddWithValue("@TransactionType", drTrans.SelectedItem.Value);
        //cmd.Parameters.AddWithValue("@Remarks", "-");
        //cmd.Parameters.AddWithValue("@AdmissionNo", drAdmissionNo.SelectedItem.Value);
        //cmd.Parameters.AddWithValue("@Session", '-');
        //cmd.Parameters.AddWithValue("@Balance", txtBalance.Text.Trim());
        //cmd.ExecuteNonQuery();
        //cmd.Dispose();
        //conn.Close();
        //Response.Write("<script>alert('Saved Successfully');</script>");
        ////BindGrid();
        ////clear();
        //// Session["Save"] = "Success";
        /// btnsave.Enabled = false;


    }

    protected void btnShow_Click(object sender, EventArgs e)
    {

    }

    protected void Reset_Click(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Write("<script>alert('Saved Successfully');</script>");
    }
}
