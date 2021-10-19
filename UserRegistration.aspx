<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserRegistration.aspx.cs" Inherits="Default10" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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


        $.get("nav.html", function (data) {
            $("#nav-placeholder").replaceWith(data);
        });




      

            /*
            $("#ddlDist").change(function (e) {
                alert('ok');
            });

            */
          

    </script>
        <script type="text/javascript">
         $(document).ready(function () {
             $("#message_box").fadeOut();

          $("#btnLogin").click(function (e)
           {
              // alert("ok");
             //  alert('len is' + $("#txtUserName").val().length);
               
               if (($("#txtUserName").val().length < 4))
               {
                 
                   $("#uname_msg").fadeIn(100);
                   $("#uname_msg").text("The username must be more than 4 and less than 30 characters long");
                   return false;
               }
               if (($("#txtPassword").val().length < 0)) 
               {

                   $("password_check").show();
                   $("#password_check").text("The password is required and can\'t be empty");
                   return false;
               }
               if ($("#txtPassword").val()!=$("#txtPassword").val())
               {

                   $("password_check").show();
                   $("#password_check").text("The password is required and can\'t be empty");
                   return false;
               }

               if (($("#txtUserName").val() != "") && ($("#txtEmail").val() != ""))
             
                   $.ajax({
                       type: "POST",
                       url: "UserRegistration.aspx/login",
                       contentType: "application/json; charset=utf-8",
                       data: '{"username":"' + $("#txtUserName").val() + '","email":"' + $("#txtEmail").val() + '" ,"password":"' + $("#txtPassword").val() + '","role":"' + $("#ddlRole").val() + '"}',
                       dataType: "json",
                       success: function (result)
                       {

                           alert("Result of User Checking in Service " + result.d);
                           var result = result.d;
                           if (result.localeCompare("user_exist"))
                           {
                             //  alert(result);

                               alert("You are in true sectuion");
                               $("#message_box").fadeIn(100);
                               $("#message_box").text("User is Already Registered with Email .");
                               $("#message_box").fadeOut(10000);
                              // window.location.href = 'Default3.aspx';


                           }
                           else if (result.d=="success")
                           {
                               alert(result );
                               $("#message_box").fadeIn(100);
                               $("#message_box").text("User Account Created Successfully .");
                               $("#message_box").fadeOut(10000);
                           }
                           else
                           {
                               alert(result);
                               $("#message_box").fadeIn(300);
                               $("#message_box").text("Error in Creating User Account, Please try again.");
                           }
                       },
                       error: function (error) {
                           alert(result.d);

                       }
                   });
           });
          
         });
     </script>
    <style type="text/css">
            body{
                  width: 100%;
                  background: url(image/slider-image1.jpg) ;
                  background-position: center center;
                  background-repeat: no-repeat;
                  background-attachment: fixed;
                  background-size: cover;
                }
          </style>
</head>


    <body >     
     <form id="form2" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
              
                    <section class="login first grey">
                    
                        <div class="panel panel-primary">
                            <div class="panel-heading ">
                                User Registration Form
                            </div>
                            <div class="panel-body">
                                <center> <h5 style="font-family: Noto Sans;">Login to </h5><h4 style="font-family: Noto Sans;">Online Registration System</h4></center>

                                     <div class="alert alert-danger" id="message_box" style="display: none" >
                            
    
                                        </div>
                                <br>
                               
                                    <div class="form-group">
                                        <label>Enter Your User Name:</label>
                                        <input class = "form-control item" type = "text" name = "username" maxlength = "15" minlength = "4" pattern = "^[a-zA-Z0-9_.-]*$" id = "txtUserName" placeholder = "Username" required>

                                        <div class="alert alert-danger" id="uname_msg" style="display: none" >
                            
    
                                      </div>

                                     
                                        

                                    </div>

                                 <div class="form-group">
                                        <label>Enter Your Email Id:</label>
									         <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                         placeholder="Enter User Email" required />
                                       <h5 id="email_check"></h5>
                                    </div>


                                    <div class="form-group">
                                        <label class="fw">
                                            Enter Your Password:
										          
                                        </label>
                                        <asp:TextBox ID="txtPassword" runat="server" class="form-control"
                                            placeholder="Enter Password.. " TextMode="Password" required />

                                        <h5 id="password_check"></h5>
                                    </div>
                                
                                    <div class="form-group">
                                        <label class="fw">
                                          Re Enter Your Password:
										          
                                        </label>
                                        <asp:TextBox ID="txtRePassword" runat="server" class="form-control"
                                            placeholder="Enter Password.. " TextMode="Password" required />
                                          <h5 id="repassword_check"></h5>

                                    </div>

                                <div class="form-group">
                                    <label for="gender">User Role</label>
                                    <div class="select-option">

                                        <asp:DropDownList ID="ddlRole" runat="server" class="form-control form-control-lg">
                                            <asp:ListItem>Administrator</asp:ListItem>
                                            <asp:ListItem>Operator</asp:ListItem>
                                            <asp:ListItem>Consultant</asp:ListItem>
                                         </asp:DropDownList>
                                    </div>
                                </div>

                                    <div class="form-group text-right">
                                       
                                        <button type="button" class="btn btn-primary btn-block" ID="btnLogin" >Sign UP</button>
                                        

                                    </div>
                                    
                                    <%--<div class="form-group text-center" id="error_occured">
                                        <span class="text-muted">User Name or Password  is Incorrect</span>
                                    </div>--%>
                               
                            </div>
                        </div>

                    </section>
               
            </div>
             <div class="col-sm-4">
              </div>
        </div>
    </div>
          </form>
</body>




</html>

 