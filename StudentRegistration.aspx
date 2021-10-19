<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StudentRegistration.aspx.cs" Inherits="Default4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

 
   


    <link rel="stylesheet" href="css/form.css" />
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

   <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"  />
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Custom styles for this template -->
    <link href="css/simple-sidebar.css" rel="stylesheet" />

     <link rel="stylesheet" type="text/css" href="DateCalender/jquery.datetimepicker.min.css" />



    <script src="DateCalender/jquery.js"></script>
    <script src="DateCalender/jquery.datetimepicker.full.js"></script>


    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>  
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

     <!-- Datatable JS -->
    <%-- <script src="DataTables/datatables.min.js"></script>--%>
     <script>
       
        


        $(document).ready(function () {
          

            $("#StudentRecord").hide();
            $("#nav-placeholder").load("nav.html");

            Get_Data();


            function Get_Data() {

             
                if ($.fn.DataTable.isDataTable("#dataTable")) {
                    $("#dataTable").DataTable().clear().draw();
                    $("#dataTable").dataTable().fnDestroy();
                    //   $("#dataTable").empty();
                }

                $.ajax({
                    url: 'StudentRegistration.aspx/GetData',
                    type: 'post',
                    contentType: 'application/json;charset=utf-8',
                    dataType: 'json',

                    beforeSend: function () {
                        // Show image container
                        $("#loader").show();
                    },
                    success: function (_data) {
                        if (_data.d == "Failure") {
                            $("#loader").hide();
                        }

                        _data = JSON.parse(_data.d);
                        // alert(_data);
                        $('#dataTable').append('<caption style="caption-side: bottom"> staff table.</caption>');

                        $('#dataTable').DataTable({
                            data: _data,
                            dom: 'Bfrtip',
                            

                            
                            columns: [{ "data": "AdmissionNo" },
                                      { "data": "StudentName" },
                                      { "data": "FatherName" },
                                      { "data": "MobileNo" },
                                      { "data": "School" },
                                      { "data": "Class" },
                                      { "data": "Section" },
                            ]

                        });

                    },
                    complete: function (data) {
                        // Hide image container
                        $("#loader").hide();
                    },
                    failure: function (response) {
                        alert("Fail");
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }

                });

            }
            

            $("#btnShow").click(function (e) {
                
                $("#StudentRecord").show();
            });

            $("#btnLogin").click(function (e) {
                

                if (($("#txtStudentName").val().length < 3)) {
                    //alert("ok");
                     $("#message_box").fadeIn(100);
                     $("#message_box").text("Student Name Should be More than 3 Character");
                    alert("Student Name is More than 3 Character");
                    $("#txtxStudentName").focus();
                    return false;
                }
                else if (($("#txtFatherName").val().length < 3)) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                   $("#message_box").text("Father  Name is More than 3 Character");
                    $("#txtFatherName").focus();
                    return false;

                }

                else if (($("#txtMobile").val().length < 10)) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Mobile No is Should be 10  Number");
                    $("#txtMobile").focus();
                    return false;

                }
                else if (($("#drSchool").val()=="Select School")) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select School Name");
                    $("#drSchool").focus();
                    return false;

                }
                else if (($("#drClass").val() == "Select Class")) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select Class Name");
                    $("#drClass").focus();
                    return false;

                }
                else if (($("#drSection").val() == "Select Section")) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select Section Name");
                    $("#drSection").focus();
                    return false;

                }
                return true;
            });



            


        });
    </script>

</head>
<body>
    <div id="nav-placeholder">

    </div>
   
    
    <form runat="server">
          
          
           <section class="content">
                <div class="container-fluid">

                    <div class="row justify-content-center">

                        <div class="col-md-10">

                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Student Registration</h3>
                                    <asp:Image ID="imgBarcode" runat="server" Visible="false" ImageAlign="Right" />

                                </div>
                                <div class="card-body">
                                    <div class="alert alert-danger" id="message_box" style="display: none">
                                    </div>

                                     
              
           
                    
                           <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="AdmissionNo">Admission No <span class="required">*</span></label>
                                    <asp:TextBox ID="txtAdmissionNo" runat="server" class="form-control  "
                                        placeholder="Admission  No " />
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                <label for="Admission Date">Admission Date <span class="required">*</span></label>

                                    <asp:TextBox ID="txtAdmissionDate" runat="server" class="form-control  "
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
                                    <label for="pincode"> Mobile No</label>
                                    <asp:TextBox ID="txtMobile" runat="server" class="form-control  "
                                        placeholder="Enter Father Mobile No." required />
                                </div>
                            </div>

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


                        </div>

                        <div class="row">
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

                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="Department">Section Name</label>
                                    <div class="select-option">

                                        <asp:DropDownList ID="drSection" runat="server" class="form-control  ">

                                            <asp:ListItem>Select Section</asp:ListItem>
                        <asp:ListItem>A</asp:ListItem>
                        <asp:ListItem>B</asp:ListItem>
                                            <asp:ListItem>C</asp:ListItem>
                                            <asp:ListItem>D</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>

                 
                        <div class="form-group text-center">
                            <asp:Button ID="btnLogin" Text="Save" runat="server" Class="btn btn-primary" OnClick="btnLogin_Click"   />
                             <asp:Button ID="btnShow" Text="Show" runat="server" Class="btn btn-success"  />
                            <asp:Button ID="Reset" Text="Reset" runat="server" Class="btn btn-warning" OnClick="Reset_Click"  />


                        </div>
                      
                             
                               
      
              <div class="table-responsive" id="StudentRecord">
             

            <!-- Table -->

 
            <table id="dataTable" class="table table-bordered table-striped dt-responsive ">  
            <thead>  
                <tr>  
                      <th>Admission No</th>  
                    <th>Student Name</th>  
                    <th>Father</th>  
                    <th>Mobile No</th> 
                    <th>School Name</th>  
                    <th>Class</th>  
                     <th>Section</th>  
                    
                    
                </tr>  
            </thead> 
            <tbody></tbody> 
        </table>  
        </div>                     
                       
                      
                            </div>
                                
                            </div>
                            
                            </div>
                        
                            </div>
                    </div>






               </section>

   </form>
   
   
</body>
    <script src="js/jquery.js"></script>
<script src="scripts/bootstrap/bootstrap.min.js"></script>

    <script src="jquery-ui-1.12.1/jquery-ui.js"></script>  
         <script src="scripts/jquery.dataTables.min.js"></script>
  
                 
</html>
