
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json;
using System.Web.UI;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class SaveToken : System.Web.UI.Page
{
    static DBConnection Connection = new DBConnection();
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string Save_Token(string  token)
    { 
     string sql;
        try
        {
            
            SqlConnection con = new SqlConnection(Connection.ConString);

            string sqlsavestr;





               sqlsavestr = "Insert into [User_Token](live_fcm_device  ) values ('" + token + "' ) ";





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



}