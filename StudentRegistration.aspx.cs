

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

public partial class Default4 : System.Web.UI.Page
{
    static DBConnection Connection = new DBConnection();
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {


        con = new SqlConnection(Connection.ConString);

        if (IsPostBack == false)
        {
            BindGrid();

        }




    }


    public void BindGrid()
    {

        try
        {
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter("select * from StudentMaster order by SrNo", con);
            sda.Fill(dt);
           // GridView1.DataSource = dt;
           // GridView1.DataBind();
        }
        catch { }

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
       // GridView1.PageIndex = e.NewPageIndex;
        //BindGrid();
    }


    public Boolean Validate()
    {

        if (txtAdmissionNo.Text == "")
        {
            Response.Write("<script>alert('Please Enter Admission No.');</script>");
            txtAdmissionNo.Focus();
            return false;
        }

        if (txtStudentName.Text == "")
        {
            Response.Write("<script>alert('Please Enter Student Name');</script>");
            txtStudentName.Focus();
            return false;
        }

        if (txtFatherName.Text == "")
        {
            Response.Write("<script>alert('Please Enter Father Name');</script>");
            txtFatherName.Focus();
            return false;
        }

        if (txtMobile.Text == "")
        {
            Response.Write("<script>alert('Please Enter Mobile No.');</script>");
            txtMobile.Focus();
            return false;
        }
        return true;
    }


    [WebMethod]
    public static string GetData()
    {

        string sql;
      
       
            sql = " select AdmissionNo, StudentName, FatherName, MobileNo, School, Class, Section  from StudentMaster ";
       
        
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(Connection.ConString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);

        da.Fill(ds, "studenta_data");
        int i;

        //  List<DistricData> tehsil = new List<DistricData>();

        string _data = "";
        if (ds.Tables[0].Rows.Count > 0)
        {
            _data = JsonConvert.SerializeObject(ds.Tables[0]);
        }
        else
        {
            _data = "Failure";
        }
        return _data;


    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (Validate())
        {
            if (Session["Save"] != "Success")
            {

                SqlConnection conn = new SqlConnection(Connection.ConString);





                conn.Open();


                SqlCommand cmd = new SqlCommand("insert into StudentMaster(AdmissionNo, StudentName, FatherName, MobileNo, School, Class, Section) values (@AdmissionNo, @StudentName, @FatherName, @MobileNo, @School, @Class, @Section)", conn);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@AdmissionNo", txtAdmissionNo.Text.Trim());
                cmd.Parameters.AddWithValue("@StudentName", txtStudentName.Text.Trim());
                cmd.Parameters.AddWithValue("@FatherName", txtFatherName.Text.Trim());
                cmd.Parameters.AddWithValue("@MobileNo", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@School", drSchool.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@Class", drClass.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@Section", '-');
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                conn.Close();
                Response.Write("<script>alert('Saved Successfully');</script>");
                txtAdmissionNo.Text = "";
                txtStudentName.Text = "";
                txtFatherName.Text = "";
                txtMobile.Text = "";
                txtAdmissionNo.Focus();
                // BindGrid();
                Session["Save"] = "Success";
                // btnsave.Enabled = false;
            }
            else
            {
                Response.Write("<script>alert('Data is Already Saved');</script>");
            }

        }
    }

    protected void Reset_Click(object sender, EventArgs e)
    {

    }
}