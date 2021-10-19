<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <div class="container-fluid">

              
    
        <div class="row">
            <div class="col-sm-6">
              
                  
                    
                        <div class="panel panel-primary">
                            
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

                  
               
            </div>
             

        </div>
    </div>
                    
                         
                 
               
                      

                      
                   
    </div>
    </form>
</body>
</html>
