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


public partial class LoginPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {

            DBConnection Connection = new DBConnection();
            SqlConnection con = new SqlConnection(Connection.ConString);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select * from [User] where UserName='" + txtusername.Text + "' and Password ='" + txtpassword.Text + "'", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                String ses;

                Session["UserName"] = txtusername.Text;
                ses = txtusername.Text;
                Response.Write(Session["UserName"]);
                //Response.Write("<script>alert('OK' + ses )</script>");
                Response.Redirect("MDI.aspx");
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


}