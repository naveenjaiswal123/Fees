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

public partial class _Default : System.Web.UI.Page
{
    /*
     protected void Page_Load(object sender, EventArgs e)
     {


     }
     protected void btnLogin_Click(object sender, EventArgs e)
     {
         string sql;

         try
         {

             DBConnection Connection = new DBConnection();
             SqlConnection con = new SqlConnection(Connection.ConString);
             con.Open();
             SqlCommand cmd = new SqlCommand("Select * from [User] where UserName='" + txtUserName.Text + "' and Password ='" + txtPassword.Text + "'", con);
             SqlDataAdapter da = new SqlDataAdapter(cmd);
             DataTable dt = new DataTable();
             da.Fill(dt);
             if (dt.Rows.Count > 0)
             {
                 String ses;

                 Session["UserName"] = txtUserName.Text;
                 ses = txtUserName.Text;
                 Response.Write(Session["UserName"]);
                 //Response.Write("<script>alert('OK' + ses )</script>");
                 Response.Redirect("Default2.aspx");
                 // Response.Write("<script>alert('OK')</script>");
             }
             else
             {
                 Response.Write("<script>alert('Please enter valid Username and Password')</script>");
             }
         }

         catch (Exception ex)
         {
             Response.Write("<script>alert('Error Occured' + ex.Message )</script>");

         }
     }

     */




    // gmod Gmod = new gmod();
    static DBConnection Connection = new DBConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql;
        sql = "select getdate() from User";
        try
        {

            DataSet ds2 = new DataSet();
            SqlConnection conn = new SqlConnection(Connection.ConString);
            SqlDataAdapter da2 = new SqlDataAdapter(sql, conn);

            da2.Fill(ds2, "serverdate");



            if (ds2.Tables[0].Rows.Count > 0)
            {

               // Gmod.SessionYear = String.Format("{0:yyyy}", ds2.Tables[0].Rows[0][0]);

            }
        }
        catch (Exception ex)
        {

        }

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string sql;

        try
        {
            sql = "SELECT *  FROM [User] where  UserNAme='" + txtUserName.Text + "' and  cast(Password as varchar(50)) ='" + txtPassword.Text + "'  ";


            DataSet ds1 = new DataSet();
            SqlConnection conn = new SqlConnection(Connection.ConString);
            SqlDataAdapter da1 = new SqlDataAdapter(sql, conn);

            da1.Fill(ds1, "username");


            if (ds1.Tables[0].Rows.Count > 0)
            {



                Response.Redirect("FeesCollection.aspx");

            }
        }
        catch (Exception ex)
        {


        }
    }

    [WebMethod]
    public static string login(string username, string password)
    {
        string sql, _data;
        try
        {

            
            sql = "SELECT *  FROM [User] where UserName='" + username + "' and  Password  ='" + password + "'  ";


            DataSet ds1 = new DataSet();
            SqlConnection conn = new SqlConnection(Connection.ConString);
            SqlDataAdapter da1 = new SqlDataAdapter(sql, conn);

            da1.Fill(ds1, "username");


            if (ds1.Tables["username"].Rows.Count > 0)
            {



                _data = "true";

            }
            else
            {
                _data = "false";
            }


            return _data;
        }
        catch (Exception ex)
        {
            return ex.Message;

        }
       

    }

}



