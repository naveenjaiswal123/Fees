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
public partial class StudentMaster_CURD : System.Web.UI.Page
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

        sql = "  Select [AdmissionNo],[StudentName],[Class], [Section] ,[FatherName],[MobileNo],[Category] from  StudentMaster  order by  [Class] ,Section ";// where[Class] = '" + drclass + "' and ReceiptDate between '" + fromdate + "' and  '" + todate + "' ";
             
       

        DataSet ds = new DataSet();

        SqlConnection conn = new SqlConnection(Connection.ConString);

        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "StudentMaster");
        int i;



        string data = "";
        if (ds.Tables["StudentMaster"].Rows.Count > 0)
        {
            data = JsonConvert.SerializeObject(ds.Tables["StudentMaster"]);
        }
        else
        {
            data = "Failure";
        }
        return data;


    }

    public class Student
    {
        public string SrNo { get; set; }
        public string AdmissionNo { get; set; }
        public string StudentName { get; set; }
        public string FatherName { get; set; }
        public string MobileNo { get; set; }
        public string ClassName { get; set; }
        public string Section { get; set; }
        public string Category { get; set; }
        
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


    [WebMethod]
    public static string SaveStudentMaster(string studentdata )
    {
        var serializeData = JsonConvert.DeserializeObject<List<Student>>(studentdata);
        string sql , sql_search;

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


        

            foreach (var student in serializeData)
            {


          
              
                sql = "insert into StudentMaster( AdmissionNo, StudentName, FatherName, Class, Section,MobileNo,Category) values (@AdmissionNo, @StudentName, @FatherName, @Class, @Section,@MobileNo,@Category  )";

                SqlCommand cmd = new SqlCommand(sql, conn, sqltrans);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@AdmissionNo", student.AdmissionNo);
                cmd.Parameters.AddWithValue("@StudentName", student.StudentName);
                cmd.Parameters.AddWithValue("@FatherName", student.FatherName);
                cmd.Parameters.AddWithValue("@Class", student.ClassName);
                cmd.Parameters.AddWithValue("@Section", student.Section);
                cmd.Parameters.AddWithValue("@MobileNo", student.MobileNo);
                cmd.Parameters.AddWithValue("@Category", student.Category);


                cmd.CommandTimeout = 3000;
                cmd.ExecuteNonQuery();
                cmd.Dispose();

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
    public static string EditStudentMaster(string studentdata, string month_name_check)
    {
        var serializeData = JsonConvert.DeserializeObject<List<Student>>(studentdata);
        string sql, sql_search;

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




            foreach (var student in serializeData)
            {

                string[] monthnamecheck = month_name_check.Split(',');

                sql = " Update StudentMaster set StudentName=@StudentName, FatherName= @FatherName, Class=@Class, Section= @Section,MobileNo=@MobileNo ,Category=@Category  where  AdmissionNo=@AdmissionNo";

                SqlCommand cmd = new SqlCommand(sql, conn, sqltrans);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@AdmissionNo", student.AdmissionNo);
                cmd.Parameters.AddWithValue("@StudentName", student.StudentName);
                cmd.Parameters.AddWithValue("@FatherName", student.FatherName);
                cmd.Parameters.AddWithValue("@Class", student.ClassName);
                cmd.Parameters.AddWithValue("@Section", student.Section);
                cmd.Parameters.AddWithValue("@MobileNo", student.MobileNo);
                cmd.Parameters.AddWithValue("@Category", student.Category);


                cmd.CommandTimeout = 3000;
                cmd.ExecuteNonQuery();
                cmd.Dispose();

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