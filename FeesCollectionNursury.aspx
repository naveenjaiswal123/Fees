<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FeesCollectionNursury.aspx.cs" Inherits="FeesCollectionNursury" %>

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
  <%--  <link href="css/simple-sidebar.css" rel="stylesheet" />--%>

     <link rel="stylesheet" type="text/css" href="DateCalender/jquery.datetimepicker.min.css" />



    <script src="DateCalender/jquery.js"></script>
    <script src="DateCalender/jquery.datetimepicker.full.js"></script>


    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>  
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

     <!-- Datatable JS -->
  <script >
      $(document).ready(function () {

          var student_array = [];
          $("#StudentRecord").hide();
          $("#nav-placeholder").load("nav.html");




          $.ajax({
              url: 'FeesCollection.aspx/GetData',
              type: 'post',
              contentType: 'application/json;charset=utf-8',
              dataType: 'json',
              data: "{}",
              success: function (_data) {
                  _data = JSON.parse(_data.d);
                  //  alert(_data);


                  //  alert(_data.length);
                  for (var i = 0; i < _data.length; i++) {
                      //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                      $("#drClass").append($('<option/>').attr("value", _data[i].Class).text(_data[i].Class));

                  }



              },
              failure: function (response) {
                  alert("Fail");
              },
              error: function (response) {
                  alert(response.responseText);
              }

          });


          $("#btnShow").click(function (e) {

             // $("#StudentRecord").show();
          });

          $("#btnLogin").click(function (e) {

              if (($("#drClass").val() == "Select Class")) {
                  //alert("ok");
                  $("#message_box").fadeIn(100);
                  $("#message_box").text("Select Class of Student");
                  $("#drClass").focus();
                  return false;

              }
              else if (($("#drSection").val() == "Select Section")) {
                  //alert("ok");
                  $("#message_box").fadeIn(100);
                  $("#message_box").text("Select Section of Class Student");
                  $("#drSection").focus();
                  return false;

              }

              else if (($("#drAdmissionNo").val() == "Select Admission No")) {
                  //alert("ok");
                  $("#message_box").fadeIn(100);
                  $("#message_box").text("Select Admission No of Student");
                  $("#drAdmissionNo").focus();
                  return false;

              }
              else if (($("#drMonth").val() == "Select Fee Month")) {
                  //alert("ok");
                  $("#message_box").fadeIn(100);
                  $("#message_box").text("Select Fee Month");
                  $("#drMonth").focus();
                  return false;

              }

              else if ((parseInt($("#txtReceiveAmount").val()) == 0)) {
                  //alert("ok");
                  $("#message_box").fadeIn(100);
                  $("#message_box").text("Receive Amount Cnnot Be Zero ");
                  $("#txtReceiveAmount").focus();
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
                                    <h3 class="card-title">Student Fees Collection (Katanga)</h3>
                                    <asp:Image ID="imgBarcode" runat="server" Visible="false" ImageAlign="Right" />

                                </div>
                                <div class="card-body">
                                    <div class="alert alert-danger" id="message_box" style="display: none">
                                    </div>

                                     
              
             <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="Department">Class Name</label>
                                    <div class="select-option">

                                        <asp:DropDownList ID="drClass" runat="server" class="form-control  " ForeColor="#6666FF">

                                            <asp:ListItem>Select Class</asp:ListItem>
                       
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="Department">Section Name</label>
                                    <div class="select-option">

                                        <asp:DropDownList ID="drSection" runat="server" class="form-control  " ForeColor="#0066FF" >

                                           
                        
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                           <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="AdmissionNo">Admission No <span class="required">*</span></label>
                                    <div class="select-option">
                                        <asp:DropDownList ID="drAdmissionNo" runat="server" class="form-control  " ForeColor="#CC0000">
                                            <asp:ListItem>Select Admission No</asp:ListItem>
                       
                                        </asp:DropDownList>
                                    </div>
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
                                       <asp:DropDownList ID="drStudentName" runat="server" class="form-control  ">
                                            <asp:ListItem>Select Student Name</asp:ListItem>
                                           </asp:DropDownList>
                                            
                                  </div>
                                </div>   
                           


                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="email">Father Name <span class="required">*</span></label>

                                    <asp:TextBox ID="txtFatherName" runat="server" class="form-control  "
                                        placeholder="Enter Father   Name "  />

                                </div>
                            </div>
                        </div>

                 

                    


                  

                 

                                     <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="FormFees">"Fees Month <span class="required">*</span></label>
                                    <asp:DropDownList ID="drMonth" runat="server" class="form-control  ">
                                            <asp:ListItem>Select Fee Month</asp:ListItem>
                         <asp:ListItem>April</asp:ListItem>
                        <asp:ListItem>July</asp:ListItem>
                        <asp:ListItem>August</asp:ListItem>
                        <asp:ListItem>September</asp:ListItem>
                        <asp:ListItem>October</asp:ListItem>
                        <asp:ListItem>November</asp:ListItem>
                        <asp:ListItem>December</asp:ListItem>
                        <asp:ListItem>January</asp:ListItem>
                        <asp:ListItem>February</asp:ListItem>
                        <asp:ListItem>March</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                         
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                <label for="AdmissionFees">Transaction Type <span class="required">*</span></label>

                                      <asp:DropDownList ID="drTrans" runat="server" class="form-control  ">
                                            <asp:ListItem>Select Transaction Type</asp:ListItem>
                         <asp:ListItem>On Line</asp:ListItem>
                        <asp:ListItem>Card Swapi</asp:ListItem>
                        <asp:ListItem>Cash</asp:ListItem>
                        
                                        </asp:DropDownList>

                                </div>
                            </div>
                        </div>


                          <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="FormFees">Book Fees No <span class="required">*</span></label>
                                    <asp:TextBox ID="txtFeeBook" runat="server" class="form-control  "
                                        placeholder="Book Fees No " />
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                <label for="AdmissionFees">Receipt Date <span class="required">*</span></label>

                                   <asp:TextBox ID="txtDate" runat="server" class="form-control  "
                                        placeholder="Receipt Date " />

                                </div>
                            </div>
                        </div>

                           <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="FormFees">Total Amount  <span class="required">*</span></label>
                                    <asp:TextBox ID="txtTotalAmount" runat="server" class="form-control  "
                                        placeholder="Total Amount " />
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                <label for="AdmissionFees">Tution Fees <span class="required">*</span></label>

                                   <asp:TextBox ID="txtTutionFee" runat="server" class="form-control  "
                                        placeholder="Tution Fees " />

                                </div>
                            </div>
                        </div>

                           <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="FormFees">"STD Fees <span class="required">*</span></label>
                                    <asp:TextBox ID="txtStdFee" runat="server" class="form-control  "
                                        placeholder="STD Fees " />
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                <label for="AdmissionFees">Term Fees <span class="required">*</span></label>

                                   <asp:TextBox ID="txtTermFee" runat="server" class="form-control  "
                                        placeholder="Term Fees " />

                                </div>
                            </div>
                        </div>
                           
                            <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="FormFees">"Misc Fees <span class="required">*</span></label>
                                    <asp:TextBox ID="txtMiscFee" runat="server" class="form-control  "
                                        placeholder="Misc Fees " />
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                <label for="AdmissionFees">Late Fees <span class="required">*</span></label>

                                   <asp:TextBox ID="txtLateFee" runat="server" class="form-control  "
                                        placeholder="Late Fees " />

                                </div>
                            </div>
                        </div>

                              <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="FormFees">"Duplicate Fees <span class="required">*</span></label>
                                    <asp:TextBox ID="txtDupFee" runat="server" class="form-control  "
                                        placeholder="Duplicate Fees " />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-3 col-12">
                                <div class="form-group">
                                <label for="AdmissionFees">Received Amount <span class="required">*</span></label>

                                   <asp:TextBox ID="txtReceiveAmount" runat="server" class="form-control  "
                                        placeholder="Receive Amount " />

                                </div>
                            </div>

                                   <div class="col-lg-3 col-md-3 col-sm-3 col-12">
                                <div class="form-group">
                                <label for="AdmissionFees">Balance Amount <span class="required">*</span></label>

                                   <asp:TextBox ID="txtBalance" runat="server" class="form-control  "
                                        placeholder="Balance Amount " />

                                </div>
                            </div>
                        </div>



                        <div class="form-group text-center">
                            <asp:Button ID="btnLogin" Text="Save" runat="server" Class="btn btn-primary" OnClick="btnLogin_Click"   />
                             <asp:Button ID="btnShow" Text="Show" runat="server" Class="btn btn-success" OnClick="btnShow_Click"  />
                            <asp:Button ID="Reset" Text="Reset" runat="server" Class="btn btn-warning" OnClick="Reset_Click"  />


                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />


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



