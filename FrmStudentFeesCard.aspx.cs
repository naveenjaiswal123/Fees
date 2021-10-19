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

public partial class FrmStudentFeesCard : System.Web.UI.Page
{

    static DBConnection Connection = new DBConnection();
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
  
    public static string GetData(string class_name , string section_name , string paid_status  , string month_name_check , string month_name_uncheck)
    {


        string[] monthnamecheck = month_name_check.Split(',');
        string[] monthnameuncheck = month_name_uncheck.Split(',');
        int i;


        string Month_cond_check = ""; ;
        string Month_cond_check_paid = ""; ;
        string Month_cond_uncheck = ""; ;


        for (i = 0; i < monthnamecheck.Length; i++)
        {
            if (i == monthnamecheck.Length - 1)
            {
                Month_cond_check += monthnamecheck[i] + "= '0' ";
                Month_cond_check_paid += monthnamecheck[i] + "> '0' ";
            }
            else
            {

                Month_cond_check += monthnamecheck[i] + "= '0' or ";
                Month_cond_check_paid += monthnamecheck[i] + "> '0'  and  ";
            }
        }



        for (i = 0; i < monthnameuncheck.Length; i++)
        {
            if (i == monthnameuncheck.Length - 1)
            {
                Month_cond_uncheck += monthnameuncheck[i] + "> '0' ";
            }
            else
            {

                Month_cond_uncheck += monthnameuncheck[i] + "> '0' or ";
            }
        }



        string sql ="";
        string _data = "";

        SqlConnection conn = new SqlConnection(Connection.ConString);
        try
        {

           
            if (conn.State == ConnectionState.Closed)
            {

                conn.ConnectionString = Connection.ConString;
                conn.Open();
            }

            sql = "delete from FeesCard";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.Text;

            cmd.CommandTimeout = 3000;
            cmd.ExecuteNonQuery();
            cmd.Dispose();




            sql = "Insert into FeesCard ([AdmissionNo], [Class], [Section], [StudentName],[Category], [April], [April_Date], [July],  [July_Date], [August], [August_Date], [September],  [September_Date], [October],[October_Date], [November],[November_Date], [December], [December_Date], [January],[January_Date], [February-March], [February_March_Date],[Caution-Money], [Caution_Money_Date],[Re_Reg-Fee] ,[Re_Reg_Date],[CollectedAmount]  )";
            sql += "   Select R1.AdmissionNo ,R1.Class ,R1.Section ,R1.StudentName ,R1.Category,R1.April ,R2.April_Date ,R1.July ,R2.July_Date , R1.August , R2.August_Date  , R1.September , R2.September_Date , R1.October ,R2.October_Date , R1.November ,R2.November_Date ,R1.December ,R2.December_Date ,R1.January , R2.January_Date , R1.[February-March] , R2.February_March_Date,R1.Caution_Money,R2.Caution_Money_Date,R1.Re_Reg_Fee,R2.Re_Reg_Date, R1.CollectedAmount  from ";
            sql += "  (SELECT[AdmissionNo], isNull([Class],'') Class,[Section] ,[StudentName],[Category], isNull([April],'0') April,   isNull([July],'0') July,   IsNull([August],'0') August, IsNull([September],'0')September,   IsNull([October],'0') October,IsNull([November],'0') November,IsNull([December],'0') December, isNull([January],'0') January,isnull([February-March],'0')[February-March] ,isnull([Caution-Money],'0')[Caution_Money] ,isnull([Re_REG-FEE],'0')[Re_REG_FEE] ,(isNull([April],0) + isNull([July],0) +   IsNull([August],0) + IsNull([September],0) + IsNull([October],0) +  IsNull([November],0) +  IsNull([December],0) + isNull([January],0) + isnull([February-March],0) ) [CollectedAmount] from ";
            sql += "  (Select M.AdmissionNo, MonthT , M.Class, M.Section , M.StudentName , Category,TotalReceived from [dbo].[NurseryFeeCollection_2122] N right join[dbo].[StudentMaster]  M on N.AdmissionNo = M.AdmissionNo) tab1 PIVOT(SUM(TotalReceived)       FOR[MonthT] IN([April], [July], [August], [September], [October], [November] , [December], [January], [February-March],[Caution-Money],[Re_Reg-Fee])  ) AS P1) R1 ";
            sql += "  inner join ";
            sql += "  (SELECT [AdmissionNo], [Class],[Section] ,[StudentName],[Category], isNull([April],'UnPaid') April_Date,   isNull([July],'UnPaid') July_Date,   IsNull([August],'UnPaid') August_Date, IsNull([September],'UnPaid')September_Date,   IsNull([October],'UnPaid') October_Date,IsNull([November],'UnPaid') November_Date,IsNull([December],'UnPaid') December_Date, isNull([January],'UnPaid') January_Date,isnull([February-March],'UnPaid')[February_March_Date]  ,isnull([Caution-Money],'UnPaid')[Caution_Money_Date] ,isnull([Re_REG-FEE],'UnPaid')[Re_REG_Date]   from ";
            sql += "  (select M.AdmissionNo, MonthT , M.Class, M.Section , M.StudentName ,M.Category, isNull( FORMAT (ReceiptDate, 'dd-MM-yyyy') ,'') ReceiptDate from [dbo].[NurseryFeeCollection_2122] N right join[dbo].[StudentMaster]  M on N.AdmissionNo = M.AdmissionNo) tab1 ";
            sql += "  PIVOT ";
            sql += "  ( ";
            sql += "  max(Receiptdate) ";
            sql += "       FOR[MonthT] IN([April], [July], [August], [September], [October], [November] , [December], [January], [February-March],[Caution-Money],[Re_Reg-Fee]) ";
            sql += "  ) AS P2 ) R2 ";



            if (section_name != "All")
            {
                sql += "  on R1.AdmissionNo=R2.AdmissionNo   where R1.class='" + class_name + "'   and  R1.Section='" + section_name + "'   ";
            }

            else
            {
                sql += "  on R1.AdmissionNo=R2.AdmissionNo   where R1.class='" + class_name + "'     ";
            }



            SqlCommand cmd1 = new SqlCommand(sql, conn);
            cmd1.CommandType = CommandType.Text;

            cmd1.CommandTimeout = 3000;
            cmd1.ExecuteNonQuery();
            cmd1.Dispose();



            string sql11, sql12, sql13,sql14;
            sql11 = "Update feesCard set [April_Date] ='BPL',[July_Date]='BPL' ,[August_Date]='BPL' ,[September_Date]='BPL', [October_Date]='BPL',[November_Date]='BPL', [December_Date]='BPL' ,[January_Date]='BPL' ,[February_March_Date]='BPL'  where Category='BPL' ";
            //sql12 = "Update feesCard set [April_Date] ='T.C',[July_Date]='T.C',[August_Date]='T.C' ,[September_Date]='T.C', [October_Date]='T.C',[November_Date]='T.C', [December_Date]='T.C' ,[January_Date]='T.C' ,[February_March_Date]='T.C'  where Category='T.C' ";
            sql13 = "Update feesCard set [April_Date] ='T.W',[July_Date]='T.W',[August_Date]='T.W' ,[September_Date]='T.W', [October_Date]='T.W',[November_Date]='T.W', [December_Date]='T.W' ,[January_Date]='T.W' ,[February_March_Date]='T.W'  where Category='T.W' ";
          //  sql14 = "Update feesCard set [April_Date] ='Exempted',[July_Date]='Exempted', [August_Date]='Exempted' ,[September_Date]='Exempted', [October_Date]='Exempted',[November_Date]='Exempted', [December_Date]='Exempted' ,[January_Date]='Exempted' ,[February_March_Date]='Exempted'  where Category='Exempted' ";



            SqlCommand cmd11 = new SqlCommand(sql11, conn);
            cmd11.CommandType = CommandType.Text;

            cmd11.CommandTimeout = 3000;
            cmd11.ExecuteNonQuery();
            cmd11.Dispose();


            SqlCommand cmd12 = new SqlCommand("Exec Sp_Update_TC", conn);
            cmd12.CommandType = CommandType.Text;

            cmd12.CommandTimeout = 3000;
            cmd12.ExecuteNonQuery();
            cmd12.Dispose();

            SqlCommand cmd13 = new SqlCommand(sql13, conn);
            cmd13.CommandType = CommandType.Text;

            cmd13.CommandTimeout = 3000;
            cmd13.ExecuteNonQuery();
            cmd13.Dispose();


            SqlCommand cmd14 = new SqlCommand("Exec Sp_Update_Exempted", conn);
            cmd14.CommandType = CommandType.Text;

            cmd14.CommandTimeout = 3000;
            cmd14.ExecuteNonQuery();
            cmd14.Dispose();





            if (paid_status == "UnPaid")
            {

                sql = "select * from feesCard  where " + Month_cond_check + " ";



            }
            else if (paid_status == "Paid")
            {
                sql = "select * from feesCard  where  " + Month_cond_check_paid + " ";
            }
            else if (paid_status == "All")
            {
                sql = "select * from feesCard  ";
            }







            DataSet ds = new DataSet();



            SqlDataAdapter da = new SqlDataAdapter(sql, conn);

            da.Fill(ds, "FeesCard");




          
            if (ds.Tables["FeesCard"].Rows.Count > 0)
            {
                _data = JsonConvert.SerializeObject(ds.Tables["FeesCard"]);
            }
            else
            {
                _data = "Failure";
            }
        }
        catch (Exception ex)
        {


            return "false";
            throw ex;

        }
        finally
        {
            conn.Close();

          
        }

        return _data;

    }
     

}