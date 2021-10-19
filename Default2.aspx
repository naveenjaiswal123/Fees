<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>



    
<html xmlns="http://www.w3.org/1999/xhtml">
 <head runat="server">
    <title></title>

    
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
     <script type="text/javascript">
       

         $(document).ready(function () {

            
                 $("#nav-placeholder").load("nav.html");
            

            alert("ok");

            $("#btnLogin").click(function (e) {
                alert("ok");

                if (($("#txtStudentName").val().length < 3)) {

                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Student Name is More than 3 Character");
                    alert("ok");
                    $("#txtName").focus();
                    return false;
                }


            });



        });


     



    </script>
</head>
<body>

    <div id="nav-placeholder">

    </div>
   
           <section class="content">
                <div class="container-fluid">

                    <div class="row justify-content-center">

                        <div class="col-md-10">

                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Quick Example</h3>
                                    <asp:Image ID="imgBarcode" runat="server" Visible="false" ImageAlign="Right" />

                                </div>
                                <div class="card-body">
                                    <div class="alert alert-danger" id="message_box" style="display: none">
                                    </div>

                                    <form runat="server">

           
                    
                           <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="UHIDNo">Admission No <span class="required">*</span></label>
                                    <asp:TextBox ID="txtAdmissionNo" runat="server" class="form-control  "
                                        placeholder="Admission  No " />
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                   <label for="UHIDNo">  Admission Date <span class="required">*</span></label>

                                    <asp:TextBox ID="txtRegDate" runat="server" class="form-control  "
                                        placeholder="Date mm/MM/yyyy " />

                                </div>
                            </div>
                        </div>

                    
                      

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                   
                                            
                                        
                                            <label for="first_name">Student Name <span class="required">*</span></label>
                                            <asp:TextBox ID="txtStudentName" runat="server" CssClass="form-control"
                                                placeholder="Enter Studentnt Name " required />
                                  </div>
                                </div>   
                           


                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="email">Father Name <span class="required">*</span></label>

                                    <asp:TextBox ID="txtFatherName" runat="server" class="form-control  "
                                        placeholder="Enter Father   Name " required />

                                </div>
                            </div>
                        </div>

                 

                    


                  

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="Symtom">Symtom </label>
                                    <asp:TextBox ID="txtSymtom" runat="server" class="form-control  "
                                        placeholder="Enter Patient Symtom " required />
                                </div>
                            </div>




                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="pincode"> Mobile No</label>
                                    <asp:TextBox ID="txtMobile" runat="server" class="form-control  "
                                        placeholder="Enter Father Mobile No." required />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="Reffered">School Branch Name</label>
                                    <div class="select-option">
                                        <asp:DropDownList ID="drSchool" runat="server" class="form-control  ">
                                            <asp:ListItem>Select School</asp:ListItem>
                        <asp:ListItem>Little World Nursery School</asp:ListItem>
                        <asp:ListItem>Little World School Tilwara</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>





                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="Department">Class Name</label>
                                    <div class="select-option">

                                        <asp:DropDownList ID="drClass" runat="server" class="form-control  ">

                                            <asp:ListItem>Select Class</asp:ListItem>
                        <asp:ListItem>NUR</asp:ListItem>
                        <asp:ListItem>KGI</asp:ListItem>
                        <asp:ListItem>KGII</asp:ListItem>
                        <asp:ListItem>I</asp:ListItem>
                        <asp:ListItem>II</asp:ListItem>
                        <asp:ListItem>III</asp:ListItem>
                        <asp:ListItem>IV</asp:ListItem>
                        <asp:ListItem>V</asp:ListItem>
                        <asp:ListItem>VI</asp:ListItem>
                        <asp:ListItem>VII</asp:ListItem>
                        <asp:ListItem>VIII</asp:ListItem>
                        <asp:ListItem>IX</asp:ListItem>
                        <asp:ListItem>X</asp:ListItem>
                        <asp:ListItem>XI</asp:ListItem>
                        <asp:ListItem>XII</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>

                    
                        <div class="form-group text-center">
                            <asp:Button ID="btnLogin" Text="Save" runat="server" Class="btn btn-primary" OnClick="btnLogin_Click"   />
                             <asp:Button ID="btnPrint" Text="Print" runat="server" Class="btn btn-success"  />
                            <asp:Button ID="Reset" Text="Reset" runat="server" Class="btn btn-warning"  />


                        </div>
                    <div class="row">
                            <div class="  col-12">

                <asp:GridView ID="GridView1"  AllowPaging="True" PageSize="10" runat="server" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="1" Font-Bold="False" Width="99%" Font-Names="Arial Rounded MT Bold" Height="100%">
          <FooterStyle BackColor="White" ForeColor="#000066" />
          <HeaderStyle BackColor="#569f9f" Font-Bold="True" ForeColor="White" />
          <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
          <RowStyle ForeColor="#000066" />
          <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
          <SortedAscendingCellStyle BackColor="#F1F1F1" />
          <SortedAscendingHeaderStyle BackColor="#007DBB" />
          <SortedDescendingCellStyle BackColor="#CAC9C9" />
          <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
                  </div>
                        </div>
                    </form>
                                </div>
                                </div>
                            </div>
                        </div>
                    </div>
               </section>
</body>

    </html>

