<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FeesCollection.aspx.cs" Inherits="FeesCollection" %>

<!DOCTYPE html>

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
    <%-- <script src="DataTables/datatables.min.js"></script>--%>
     <script>
       
         function SucessMessage() {
           

             $("#message_box").fadeIn(100);
             $("#message_box").text("Fees Received Sucessfully");
            

         }


        $(document).ready(function () {
          
            var student_array = [];
            $("#StudentRecord").hide();
            $("#nav-placeholder").load("nav.html");

           //Get_Data();


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

            $("#txtTotalAmount").change(function (e) {

            });

            $("#txtTutionFee").change(function (e) {
                if (isNaN($("#txtTutionFee").val())) {
                    alert("Incorrect Tution  Data");
                    $("#txtTutionFee").focus();
                }
                else
                {
                    calculate_fees();
                }
            });
            $("#txtStdFee").change(function (e) {

                if (isNaN($("#txtStdFee").val())) {
                    alert("Incorrect Std  Fee Data");
                    $("#txtStdFee").focus();
                }
                else {
                    calculate_fees();
                }

            });
            $("#txtTermFee").change(function (e) {

                if (isNaN($("#txtTermFee").val()))  {
                    alert("Incorrect Term Fee Data");
                    $("#txtTermFee").focus();
                }
                else {
                    calculate_fees();
                }

            });
            $("#txtMiscFee").change(function (e) {
                if (isNaN($("#txtMiscFee").val())) {
                    alert("Incorrect Misc Fee  Data");
                    $("#txtMiscFee").focus();
                }
                else {
                    calculate_fees();
                }

            });
            $("#txtLateFee").change(function (e) {
                if (isNaN($("#txtLateFee").val())) {
                    alert("Incorrect Late Fee  Data");
                    $("#txtLateFee").focus();
                }
                else {
                    calculate_fees();
                }

            });
            $("#txtDupFee").change(function (e) {
                if (isNaN($("#txtDupFee").val())) {
                    alert("Incorrect Dup Fee Data");
                    $("#txtDupFee").focus();

                }
                else {
                    calculate_fees();
                }

            });

            function calculate_fees() {
                var amt=0 , balance=0;
                amt=  parseInt( $("#txtTutionFee").val()) +  parseInt($("#txtStdFee").val()) +  parseInt($("#txtTermFee").val()) + parseInt($("#txtMiscFee").val()) + parseInt($("#txtLateFee").val()) + parseInt($("#txtDupFee").val());
                
                $("#txtReceiveAmount").val(amt);

                balance = parseInt($("#txtTotalAmount").val()) - amt;
                $("#txtBalance").val(balance);
                
              
                
            }

            $("#drAdmissionNo").change(function (e) {
      
                $.ajax({
                    type: "POST",
                    url: "FeesCollection.aspx/GetStudentDetails",
                    contentType: "application/json; charset=utf-8",
                    data: '{"section_name":"' + $("#drSection").val() + '","class_name":"' + $("#drClass").val() + '","admission_no":"' + $(this).val() + '"}',

                    dataType: "json",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                        //  alert(_data);

                      
                      
                        student_array = _data.FatherName;
                        for (var i = 0; i < _data.length; i++) {
                            //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                            $("#txtFatherName").val(_data[0].FatherName);
                            $("#txtMobile").val(_data[0].MobileNo);
                            $("#drStudentName").val(_data[0].StudentName);
                        }


                    },
                    failure: function (response) {
                        alert("Fail");
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }

                });
            });

            $("#drClass").change(function (e) {

                $("#drAdmissionNo option").remove();
                $("#drStudentName option").remove();
                $("#drMonth").selectedIndex = 0;
                $("#drSection option").remove();
                $("#txtFatherName").val("");
                $("#txtMobile").val("");
                $("#txtBalance").val("0");
                $("#txtFeeBook").val("");
                $("#txtDate").val("");

                $.ajax({
                    type: "POST",
                    url: "FeesCollection.aspx/GetSection",
                    contentType: "application/json; charset=utf-8",
                    //data: '{distt_name: "' + $(this).val() + '" }',
                    data: '{"class_name":"' + $("#drClass").val() + '"}',
                    dataType: "json",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                         // alert(_data);

                        //$("#drAdmissionNo option").remove();
                        //$("#drStudentName option").remove();
                        //$("#drSection option").remove();
                        //$("#drAdmissionNo").append($('<option/>').attr("value", "Select Admission No").text("Select Admission No"));
                        //$("#drStudentName").append($('<option/>').attr("value", "Select Student Name").text("Select Student Name"));
                        $("#drSection").append($('<option/>').attr("value", "Select Section").text("Select Section"));
                      
                        for (var i = 0; i < _data.length; i++) {
                            //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                            $("#drSection").append($('<option/>').attr("value", _data[i].section).text(_data[i].section));
                        }
                       
                    },
                    failure: function (response) {
                        alert("Fail");
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }

                });
            });

            $("#drSection").change(function (e) {

                $("#drAdmissionNo option").remove();
                $("#drStudentName option").remove();
                $("#txtFatherName").val("");
                $("#txtMobile").val("");
                $.ajax({
                    type: "POST",
                    url: "FeesCollection.aspx/GetStudentData",
                    contentType: "application/json; charset=utf-8",
                    //data: '{distt_name: "' + $(this).val() + '" }',
                    data: '{"section_name":"' + $(this).val() + '","class_name":"' + $("#drClass").val() + '"}',
                    dataType: "json",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                        //  alert(_data);

                        $("#drAdmissionNo option").remove();
                        $("#drStudentName option").remove();
                        //  alert(_data.length);

                        //$("#txtFatherName").val(_data[0].FatherName) ;
                        //$("#txtMobile").val( _data[0].MobileNo) ;
                        $("#drAdmissionNo").append($('<option/>').attr("value", "Select Admission No").text("Select Admission No"));
                        $("#drStudentName").append($('<option/>').attr("value", "Select Student Name").text("Select Student Name"));
                        student_array = _data.FatherName;
                        for (var i = 0; i < _data.length; i++) {
                            //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                            $("#drAdmissionNo").append($('<option/>').attr("value", _data[i].AdmissionNo).text(_data[i].AdmissionNo));
                            $("#drStudentName").append($('<option/>').attr("value", _data[i].StudentName).text(_data[i].StudentName));
                        }
                        //$("#drAdmissionNo").selectedIndex = 0;
                        //$("#drStudentName").selectedIndex = 0;

                    },
                    failure: function (response) {
                        alert("Fail");
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }

                });
            });


            $("#drMonth").change(function (e) {
                     
                $("#txtTotalAmount").val(0);
                $("#txtTutionFee").val(0);
                $("#txtStdFee").val(0);
                $("#txtTermFee").val(0);
                $("#txtMiscFee").val(0);
                $("#txtLateFee").val(0);
                $("#txtDupFee").val(0);
                $("#txtReceiveAmount").val(0);

                $.ajax({
                    type: "POST",
                    url: "FeesCollection.aspx/GetFeeDetails",
                    contentType: "application/json; charset=utf-8",
                    data: '{"month_name":"' + $(this).val() + '","class_name":"' + $("#drClass").val() + '"}',

                    dataType: "json",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                        //  alert(_data);


                        
                        
                        if (_data.length > 0) {

                            $("#txtTotalAmount").val(_data[0].TotatAmount);
                            $("#txtTutionFee").val(_data[0].TutionFee);
                            $("#txtStdFee").val(_data[0].SdfFee);
                            $("#txtTermFee").val(_data[0].TermFee);
                            $("#txtMiscFee").val(_data[0].MiscFee);
                            $("#txtLateFee").val(_data[0].LateFee);
                            $("#txtDupFee").val(_data[0].DupFee);
                        }
                        

                        calculate_fees();
                    },
                    failure: function (response) {
                        alert("Fail");
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }

                });
            });
          



        
            

            $("#btnShow").click(function (e) {
                
                $("#StudentRecord").show();
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
                else if (($("#drTrans").val() == "Select Transaction Type")) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select Fees Transaction Type");
                    $("#drTrans").focus();
                    return false;

                }

                else if (($("#drMonth").val() == "Select Fee Month")) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select Fee Month");
                    $("#drMonth").focus();
                    return false;

                }
                else if (($("#txtFeeBook").val() == "")) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select Fee Book no.");
                    $("#txtFeeBook").focus();
                    return false;

                }
                else if (($("#txtDate").val() == "")) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select Fee Book Date");
                    $("#txtDate").focus();
                    return false;

                }

                else if ((parseInt($("#txtReceiveAmount").val()) ==0)) {
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

                                        <select id="drClass" name="drClass" class="form-control  " ForeColor="#6666FF">

                                            
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="Section">Section Name</label>
                                    <div class="select-option">

                                         <select id="drSection"  name="drSection"  class="form-control  " ForeColor="#0066FF" >

                                          
                        
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                           <div class="row">
                           
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="AdmissionNo">Admission No <span class="required">*</span></label>
                                    <div class="select-option">
                                        <select id="drAdmissionNo"  name="drAdmissionNo"  class="form-control">
                                         </select>   
                                                                      
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
                                           <select id="drStudentName" name="drStudentName"  class="form-control  ">
                                           </select>
                                            
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
                        <asp:ListItem>Card Swipe</asp:ListItem>
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
     <script src="DateCalender/jquery.js"></script>
    <script src="DateCalender/jquery.datetimepicker.full.js"></script>
    
  <script>


      $('#txtDate').datetimepicker({
            step: 5 ,
            
            format:'d/M/Y',
                      
          
      

      });
     
    </script>
                 
</html>


