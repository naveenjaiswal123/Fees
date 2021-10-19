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


public partial class AdmissionMaster : System.Web.UI.Page
{

    static DBConnection Connection = new DBConnection();
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {

        SqlCommand cmd = new SqlCommand("insert into AdmissionDetails(AdmissionNo, StudentName, Class, Section, FormFees, AdmissionFees, ReceiptNo, ReceiptDate, Session, UserName) values ( @AdmissionNo, @StudentName, @Class, @Section, @FormFees, @AdmissionFees, @ReceiptNo, @ReceiptDate, @Session, @UserName)", con);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@AdmissionNo", txtAdmissionNo.Text.Trim());
        cmd.Parameters.AddWithValue("@StudentName", txtStudentName.Text.Trim());
        cmd.Parameters.AddWithValue("@Class", drClass.SelectedItem.Value);
        cmd.Parameters.AddWithValue("@Section", '-');
        cmd.Parameters.AddWithValue("@FormFees", txtFormFees.Text.Trim());
        cmd.Parameters.AddWithValue("@AdmissionFees", txtAdmissionFees.Text.Trim());
        cmd.Parameters.AddWithValue("@ReceiptNo", txtReceiptNo.Text.Trim());
        cmd.Parameters.AddWithValue("@ReceiptDate", txtReceiptDate.Text.Trim());
        cmd.Parameters.AddWithValue("@UserName", Session["UserName"]);
        cmd.Parameters.AddWithValue("@Session", '-');
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        con.Close();
        Response.Write("<script>alert('Saved Successfully');</script>");
        txtAdmissionNo.Text = "";
        txtStudentName.Text = "";
        txtFormFees.Text = "";
        txtAdmissionFees.Text = "";
        txtReceiptNo.Text = "";
        txtAdmissionNo.Focus();
       // BindGrid();

    }



    protected void btnGetData_Click(object sender, EventArgs e)
    {

    }
}