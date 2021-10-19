<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>


<html>
<head>
    <title>Little World school Fees Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="stylesheet" href="scripts/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="scripts/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="css/form.css">
    <link href="css/jquery-ui.css" rel="stylesheet" />
    <script src="scripts/jquery-1.11.3.min.js"></script>
    <script src="scripts/jquery-ui.js"></script>

     <script type="text/javascript">
         $(document).ready(function () {


           
             $("#message_box").fadeOut();
             alert("ok");
            
     
/*
             $.ajax({
                 type: "POST",
                 url: "http://localhost/SchoolFees/SaveToken.aspx/Save_Token",
                 contentType: "application/json; charset=utf-8",
                 data: '{"token": "123456"}',
                 dataType: "json",
                 success: function (result) {
                     if (result.d == "true") {
                         // alert(result.d);
                         $("#message_box").fadeIn(10000);
                         $("#message_box").text("Login Successful, Redireting to your profile page.");
                        

                     } else if (result.d == "false") {
                         //alert(result.d);
                         $("#message_box").fadeIn(300);
                         $("#message_box").text("Login failed, Please try again.");
                     }
                     else {
                         alert(result.d);
                         $("#message_box").fadeIn(300);
                         $("#message_box").text("Exception  occur :" & result.d);
                     }

                 }, error: function (error) {

                 }
             });

  */ 
             


             $("#btnLogin").click(function (e) {
                 //alert("ok");

                 if (($("#txtUserName").val().length == 0)) {
                     $("#message_box").fadeIn(10);
                     $("#message_box").text("User Name Cannot Be Blank");
                     $("#txtUserName").focus();
                     return false;
                 }

                 if ($("#txtPassword").val() == "")
                 {
                     $("#message_box").fadeIn(10);
                     $("#message_box").text("User Password Cannot Be Blank");
                     $("#txtPassword").focus();
                     return false;
                 }

                 if (($("#txtUserName").val() != "") && ($("#txtPassword").val() != ""))
                     $.ajax({
                         type: "POST", url: "Default.aspx/login",
                         contentType: "application/json; charset=utf-8",
                         data: '{"username":"' + $("#txtUserName").val() + '","password":"' + $("#txtPassword").val() + '"}',
                         dataType: "json",
                         success: function (result) {
                             if (result.d == "true") {
                                // alert(result.d);
                                 $("#message_box").fadeIn(10000);
                                 $("#message_box").text("Login Successful, Redireting to your profile page.");
                                 window.location.href = 'FeesCollectionGridWiseAdmissionNo.aspx';


                             } else if (result.d == "false")
                             {
                                 //alert(result.d);
                                 $("#message_box").fadeIn(300);
                                 $("#message_box").text("Login failed, Please try again.");
                             }
                             else  {
                                 alert(result.d);
                                 $("#message_box").fadeIn(300);
                                 $("#message_box").text("Exception  occur :" & result.d);
                             }

                         }, error: function (error) {

                         }
                     });
             });
         });
     </script>

    <style type="text/css">
            body{
                  width: 100%;
                  background: url(image/slider-image2.jpg) ;
                  background-position: center center;
                  background-repeat: no-repeat;
                  background-attachment: fixed;
                  background-size: cover;
                }
          </style>

</head>
<body >     
     <form id="form1" runat="server">
    <div class="container">
        <div class="row">
            
            <div class="col-sm-6">
              
                    <section class="login first grey">
                    
                        <div class="panel panel-primary">
                            <div class="panel-heading " >
                                User Login
                            </div>
                            <div class="panel-body">
                                <center> <h4 style="font-family: Noto Sans;">Online School Fees Management System</h4></center>

                                     <div class="alert alert-danger" id="message_box" style="display: none">
                            
    
                                     </div>
                                <br>
                               
                                    <div class="form-group">
                                        <label>Enter Your User Name:</label>
                                        <asp:TextBox ID="txtUserName" runat="server" class="form-control form-control-lg"
                                            placeholder="Enter User Name.. "  required />

                                    </div>
                                    <div class="form-group">
                                        <label class="fw">
                                            Enter Your Password:
										            <a href="javascript:void(0)" class="pull-right">Forgot Password?</a>
                                        </label>
                                        <asp:TextBox ID="txtPassword" runat="server" class="form-control form-control-lg"
                                            placeholder="Enter Password.. " TextMode="Password" required />
                                    </div>


                                <div class="form-group">
                                    <label for="gender">Shift</label>
                                    <div class="select-option">

                                        <asp:DropDownList ID="ddlCategory" runat="server" class="form-control form-control-lg">
                                            <asp:ListItem>Morning-A</asp:ListItem>
                                            <asp:ListItem>Afternoon-B</asp:ListItem>
                                            <asp:ListItem>Evening-C</asp:ListItem>
                                         </asp:DropDownList>
                                    </div>
                                </div>

                                    <div class="form-group text-right">
                                       
                                              <button type="button" class="btn btn-primary btn-block" ID="btnLogin" >Sign In</button>
                                       
                                           <!-- <button type="button" class="btn btn-primary btn-block" ID="btnLogin" >Sign In</button>
                                        click -->

                                    </div>
                                    <div class="form-group text-center">
                                        <span class="text-muted">Don't have an account?</span> <a href="UserRegistration.aspx">Register</a> Here..
                                    </div>
                                    <div class="form-group text-center" id="error_occured">
                                        <span class="text-muted">User Name or Password  is Incorrect</span>
                                    </div>
                               
                            </div>
                        </div>

                    </section>
               
            </div>
             

        </div>
    </div>
          </form>
   
</body>
<script src="js/jquery.js"></script>
<script src="scripts/bootstrap/bootstrap.min.js"></script>

</html>
