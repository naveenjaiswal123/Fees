using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System;
using System.Web.Services;
using Newtonsoft.Json;




public partial class Default10 : System.Web.UI.Page
{
    static DBConnection Connection = new DBConnection();
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql;
        sql = "select getdate() from [user]";
        try
        {

            DataSet ds2 = new DataSet();
            SqlConnection conn = new SqlConnection(Connection.ConString);
            SqlDataAdapter da2 = new SqlDataAdapter(sql, conn);

            da2.Fill(ds2, "serverdate");



            if (ds2.Tables["serverdate"].Rows.Count > 0)
            {

               // Gmod.SessionYear = String.Format("{0:yyyy}", ds2.Tables[0].Rows[0][0]);

            }
        }
        catch (Exception ex)
        {

        }

    }
    public   string btnLogin(string username, string email, string password, string role)
    {
        string sql;
        try
        {
            
            SqlConnection con = new SqlConnection(Connection.ConString);

            string sqlsavestr;





            sqlsavestr = "Insert into [User](UserName, Password,email  ) values ('" + username + "' ,'" + password + "' ,'" + email + "') ";





            SqlCommand cmd = new SqlCommand(sqlsavestr, con);

           
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            return "success";
        }

        catch (Exception ex)
        {
            return "error";
        }

    }

    [WebMethod]
    public static string login(string username, string email , string password, string role)
    {


        string sql, _data;

        try
        {
            sql = "SELECT *  FROM [User] where  UserName='" + username + "' and  email ='" + email + "'  ";


            DataSet ds1 = new DataSet();
            SqlConnection conn = new SqlConnection(Connection.ConString);
            SqlDataAdapter da1 = new SqlDataAdapter(sql, conn);

            da1.Fill(ds1, "username");


            if (ds1.Tables[0].Rows.Count > 0)
            {
                _data = "user_exist";

            }
            else
            {

                string sqlsavestr;
                conn.Open();
               
                sqlsavestr = "Insert into [User](UserName, Password,email  ) values ('" + username + "' , '" + password + "' ,'" + email + "') ";
                SqlCommand cmd = new SqlCommand(sqlsavestr, conn);
                      
                cmd.ExecuteNonQuery();
                conn.Close();
                _data= "success";
            }

                                 
        }
        catch (Exception ex)
        {
            _data= "Error Occured :"+ex.Message ;
            return _data;
        }
        _data = JsonConvert.SerializeObject(_data);
        return _data;

    }



}

