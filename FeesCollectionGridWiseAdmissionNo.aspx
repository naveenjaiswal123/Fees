<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FeesCollectionGridWiseAdmissionNo.aspx.cs" Inherits="FeesCollectionGridWiseAdmissinNo" %>




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
  <link rel="stylesheet" type="text/css" href="DateCalender/jquery.datetimepicker.min.css" />
    <link rel="stylesheet" href="cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.min.css" />
<!--<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->
    
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>  
   
    <!-- Custom styles for this template -->
    <%--  <link href="css/simple-sidebar.css" rel="stylesheet" />--%>

     <link rel="stylesheet" type="text/css" href="DateCalender/jquery.datetimepicker.min.css" />



    <script src="DateCalender/jquery.js"></script>
    <script src="DateCalender/jquery.datetimepicker.full.js"></script>


    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>  
   

     <!-- Datatable JS -->
    <%-- <script src="DataTables/datatables.min.js"></script>--%>
     <script>
       
         function SucessMessage1() {
           
             
             $("#myModal").modal("show");
           
         }

         

         function totalFeesAmount() {

             var calculated_total_sum = 0;

             $("#productTable .form-control-fees").each(function () {
                 var get_textbox_value = $(this).val();


                 if ($.isNumeric(get_textbox_value)) {
                     calculated_total_sum += parseFloat(get_textbox_value);
                 }

             });
             $("#total_sum_value").val(calculated_total_sum);
         }



         function productDisplay(ctl) {

         
             _row = $(ctl).parents("tr");
             var cols = _row.children("td");


           //    alert($(cols[1]).text()).attr('disabled');
             //alert($('#FeesChecked' + $(cols[1]).text()).is(":checked"));

             if ($('#FeesChecked' + $(cols[1]).text()).is(":checked")) {

                // alert("inside Check true");
                 $("#txtFeesReceived" + $(cols[1]).text()).prop('disabled', false);
                 $("#txtFeesReceived" + $(cols[1]).text()).val($(cols[10]).text());

                 $("#btnPayment").prop('disabled', false);
                 $("#total_sum_value").prop('disabled', false);

                 totalFeesAmount();
             }
             else {
                 
                 $("#txtFeesReceived" + $(cols[1]).text()).prop('disabled', true);
                 $("#txtFeesReceived" + $(cols[1]).text()).val('');

               
                 totalFeesAmount();
                // alert("inside Check false");
             }
           



             if ($(cols[0]).text().localeCompare("Fees Paid")!=0)
             {
                
                
            //     alert("inside Check true");
                
               //$(cols[10]).prop("disabled", true);
               // $($(cols[10])).attr('disabled', 'disabled');
            
                //$("#txtFeesReceived" + $(cols[1]).text()).attr('disabled', 'disabled');
                // $("#txtFeesReceivedAugust").attr('disabled', 'disabled');
               
             }
             else
             {
                

              //   $("#txtFeesReceived" + $(cols[1]).text()).attr('enabled','enabled');

                // $(cols[0]).prop("disabled", true);
                // alert("inside Check false");
                
             }

            // alert("Check");
         }

         $(document).ready(function () {
            
             function SucessMessage() {


                // alert("Click event fire");
                // $("#btnShowMessage").click();

                 $("#myModal").modal("show");

                 //$("#message_box").fadeIn(100);
                 //$("#message_box").text("Fees Received Sucessfully");
             }
             
            
            var _msg;
            var student_array = [];
            $("#StudentRecord").hide();
            $("#nav-placeholder").load("nav.html");
            $("#message_box").fadeOut();
           //Get_Data();
           
         
            ///--------------For Calcullating Sum of Received Fees


            $("#productTable").on('input', '.form-control-fees', function () {
                var calculated_total_sum = 0;
                
                $("#productTable .form-control-fees").each(function () {
                    var get_textbox_value = $(this).val();

               
                    if ($.isNumeric(get_textbox_value)) {
                        calculated_total_sum += parseFloat(get_textbox_value);
                    }
                   
                });
                $("#total_sum_value").val(calculated_total_sum);
            });
            //--------



          

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

            $("#btnSearchAdmissionNo").click(function (e) {
               

                if ($("#txtAdmissionNo").val() == "")
                {
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Admission No. Cannot Be Blank");
                    $("#txtAdmissionNo").focus();
                    return false;

                }
            //  $("#message_box").fadeout(100);
                $("#txtClass").val("");
                $("#drSection").val("");
                $("#txtFatherName").val("");
               // $("#txtFeeBook").val("");
                $("#txtDate").val("");
                $("#drStudentName").val("");
                $('#productTable tbody').empty();
                $("#drTrans")[0].selectedIndex = 0;
                $("#drTrans").prop('selectedIndex', 0);

                $.ajax({
                    type: "POST",
                    url: "FeesCollectionGridWiseAdmissionNo.aspx/GetStudentDetails",
                    contentType: "application/json; charset=utf-8",
                    data: '{"admission_no":"' + $("#txtAdmissionNo").val() + '"}',
                    dataType: "json",
                    success: function (_data) {
                      

                       
                       

                        if (_data.d=="false") {
                            alert("Student Admission No Not Exist");
                            $("#success_box").hide();
                            $("#message_box").fadeIn(100);
                            $("#message_box").text("Student Admission No Not Exist");
                            return false;
                        }
                        _data = JSON.parse(_data.d);
                   //  alert(_data);
                       
                  
                       if (_data.length > 0) {

                       
                           $("#txtClass").val(_data[0].Class);
                           $("#drSection").val(_data[0].Section);
                           $("#txtFatherName").val(_data[0].FatherName);
                           $("#drStudentName").val(_data[0].StudentName);
                           $("#message_box").hide();
                           $("#success_box").fadeIn(100);
                           $("#success_box").text("Record Found Student Admission No. ");
                           
                           fees_details();
                           return false;
                       }
                       
                       
                        

                    },
                    failure: function (response) {
                        alert("Fail");
                    },
                    error: function (response) {
                       alert(response.responseText);
                        
                    }

                });
              
                return false;
            });

          

      


            function fees_details() {
              
                

                //$("#txtTotalAmount").val(0);
                //$("#txtTutionFee").val(0);
                //$("#txtStdFee").val(0);
                //$("#txtTermFee").val(0);
                //$("#txtMiscFee").val(0);
                //$("#txtLateFee").val(0);
                //$("#txtDupFee").val(0);
                $("#txtReceiveAmount").val(0);
             
                $.ajax({
                    type: "POST",
                    url: "FeesCollectionGridWiseAdmissionNo.aspx/GetFeeDetails",
                    contentType: "application/json; charset=utf-8",
                    data: '{"Admission_No":"' + $("#txtAdmissionNo").val() + '","class_name":"' + $("#txtClass").val() + '" }',
                    dataType: "json",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                        //  alert(_data);
                     


                        var link = "   <div class=\"form-check form-switch\">  <input class=\"form-check-input\" type=\"checkbox\" id=\"flexSwitchCheckChecked\"  disabled=\"disabled\"  class =\"cbCheck\" checked onchange=\" productDisplay(this);\">    <label class=\"form-check-label\" for=\"flexSwitchCheckChecked\"  >Fees Paid </label> </div>";
                        var link_paid = "  <div class=\"form-check form-switch\">   <input class=\"form-check-input\" type=\"checkbox\" id=\"flexSwitchCheckChecked\" class =\"cbCheck\"  onchange=\" productDisplay(this);\" >   <label class=\"form-check-label\" for=\"flexSwitchCheckChecked\">Fees UnPaid </label> </div> ";
                        var  txtbox=   "<div class=\"form-group\">  <input type =\"TextBox\" ID=\"txtFeesReceived\"  style=\"width:70%;\" class=\"form-control  \"      /> </div> ";
                                

                                    
                                       

                                

                        //var status="<a class=\"btn btn-danger delete\" onclick=\"return alert('Are You sure?')\">Delete</a>";

                        $('#productTable tbody').empty();

                       

                        $.each(_data, function (i, item) {

                            var link = "   <div class=\"form-check form-switch\">  <input class=\"form-check-input\" type=\"checkbox\" id=\"FeesChecked" + item.MonthT + " \"  disabled=\"disabled\"  class =\"cbCheck\" checked onchange=\" productDisplay(this);\">    <label class=\"form-check-label\" for=\"flexSwitchCheckChecked\"  >Fees Paid </label> </div>";
                            var link_paid = "  <div class=\"form-check form-switch\">   <input class=\"form-check-input\" type=\"checkbox\" id=\"FeesChecked" + item.MonthT + "\" class =\"cbCheck\"  onchange=\" productDisplay(this);\" >   <label class=\"form-check-label\" for=\"flexSwitchCheckChecked\">Fees UnPaid </label> </div> ";



                            if (item.TotalReceived > 0 ) {
                                var status = link;
                                var status_txtbox = item.TotalReceived;

                            }
                            else
                            {
                                var txtbox = "<div class=\"form-group\">  <input type =\"TextBox\" ID=\"txtFeesReceived" + item.MonthT + "\"   disabled=\"disabled\"    class=\"form-control-fees\" /> </div> ";


                                var status = link_paid;
                                var status_txtbox = txtbox;
                            }
                           
                            var rows = "<tr class='bg-warning'>"
                                                + "<td>" + status + "</td>"
                                                + "<td>" + item.MonthT + "</td>"
                                                + "<td>" + item.TutionFee + "</td>"
                                                + "<td>" + item.SdfFee + "</td>"
                                                + "<td>" + item.TermFee + "</td>"
                                                + "<td>" + item.ComputerFee + "</td>"
                                                + "<td>" + item.SportsFee + "</td>"
                                                + "<td>" + item.MiscFee + "</td>"
                                                + "<td>" + item.LateFee + "</td>"
                                                + "<td>" + item.DupFee + "</td>"
                                                + "<td>" + item.TotatAmount + "</td>"
                                                + "<td>" + status_txtbox + "</td>"
                                                + "<td style='color:red'>" + item.ReceiptDate + "</td>"   
                                                + "<td>" + item.TransactionType + "</td>"
                                                + "<td>" + item.Remarks + "</td>"
                                                + "</tr>";
                                                $('#productTable tbody').append(rows);
                        });
                     
                        },
                        error: function (data) { }
                    });
                check_Fees_full_paid();
            }
          
           
            function check_Fees_full_paid() {
                $("#btnPayment").prop('disabled', true);
            
               $("#total_sum_value").prop('disabled', true);

               $("#productTable .cbCheck").each(function () {
                    
                   if ($(this).is(":not(:checked)")) {
                       
                       // fees_paid_status = "false";
                        $("#btnPayment").prop('disabled', false);
                        $("#total_sum_value").prop('disabled', false);
                      
                    }
                });

            }


            $("#btnPayment").click(function (e) {
                var status = "true";
                if (!validate()) { return false;}


                    


                var feesdetails = {};
                var feesdata;
                $("#productTable .form-control-fees").each(function () {
                    var get_textbox_value = $(this).val();

                   
                    if( (!$.isNumeric(get_textbox_value)) && ($(this).is(":enabled") )) {
                        alert(" Enter Nummeric Value for Fees...");
                        $(this).focus();
                        status = "false";
                        return false;
                      }
                    
                });
                //   $("#total_sum_value").html(calculated_total_sum);
                if (status == "false") { return false; }

                var Fees = new Array();
                $("#productTable TBODY TR").each(function () {
                    var row = $(this);
                   // $(this).is(":enabled")
                    var fees = {};
                    if ((row.find('.form-control-fees').val() != "") && (row.find('.form-control-fees').is(":enabled"))) {
                        //          alert("inside");

                      
                     //   alert(row.find('.form-check-input').val());
                        fees.BookNo = "000";
                        fees.FeesDate = $("#txtDate").val();
                        fees.StudentName = $("#drStudentName").val();
                        fees.AdmissionNo = $("#txtAdmissionNo").val();
                        fees.TransactionType = $("#drTrans").val();
                        fees.ClassName = $("#txtClass").val();
                        fees.Section = $("#drSection").val();
                        fees.Amount = row.find('.form-control-fees').val();
                        fees.Month = row.find("TD").eq(1).html();
                        fees.TutionFees = row.find("TD").eq(2).html();
                        fees.StdFees = row.find("TD").eq(3).html();
                        fees.TermFees = row.find("TD").eq(4).html();
                        fees.CompFees = row.find("TD").eq(5).html();
                        fees.SportFees = row.find("TD").eq(6).html();
                        fees.MiscFees = row.find("TD").eq(7).html();
                        fees.LateFees = row.find("TD").eq(8).html();
                        fees.DuplicateFees = row.find("TD").eq(9).html();
                        fees.Remarks = $("#txtRemark").val();
                                             
                      
                    
                       
                       // alert(fees.Month);


                        if (fees.Month == 'Caution-Money') 
                        {
                           
                           
                            fees.CautionFees = fees.Amount;
                           

                        }else if (fees.Month == 'Re_REG-FEE')
                        {
                            fees.ReReg_Fees = fees.Amount;
                           
                        } 
                       // alert(fees.TransactionType);
                      //  alert(fees);
                       Fees.push(fees);
                    }
                });

                feesdata = JSON.stringify(Fees);
              //  alert(JSON.stringify(Fees));
              

              

                swal({
                    title: "Are you sure you want to Submit the Fees?",
                    text: "It will Process the Fees !",
                    icon: "warning",
                    buttons: true,
                    showCancelButton: true,
                    dangerMode: true
                        
                }). then(function (isConfirm) {
                    if (isConfirm.value === true){

                       
                        $.ajax(
                       {
                           type: "POST",
                           url: "FeesCollectionGridWiseAdmissionNo.aspx/SaveFeesDetails",
                           data: JSON.stringify({ 'feesdata': feesdata, }),
                           contentType: "application/json; charset=utf-8",
                           dataType: "json",
                           success: function (result) {
                               if (result.d == "true") {
                                   //alert(result.d);
                                   $("#message_box").fadeIn(1000);
                                   $("#message_box").text("Student Fees Paid Sucessfully");



                                   $('#productTable tbody').empty();
                                   $("#txtClass").val("");
                                   $("#drSection").val("");
                                   $("#txtFatherName").val("");
                                   // $("#txtMobile").val("");
                                   $("#drStudentName").val("");
                                   $("#txtRemark").val("");
                                   $("#total_sum_value").val(0);

                                   $("#drTrans")[0].selectedIndex = 0;
                                   $("#drTrans").prop('selectedIndex', 0);
                                   SucessMessage();

                               } else {
                                   //alert(result.d);
                                   $("#message_box").fadeIn(300);
                                   $("#message_box").text("Technical Error in  Saving Fees.....");
                               }
                           }
                       });

                    }
                    
                });

              
/*
                var txt;
                var r = confirm("Press OK button For Confirmation !");
                if (r == true) {
              
                    $.ajax(
                 {
                     type: "POST",
                     url: "FeesCollectionGridWiseAdmissionNo.aspx/SaveFeesDetails",
                     data: JSON.stringify({ 'feesdata': feesdata, }),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (result) {
                         if (result.d == "true") {
                             //alert(result.d);
                             $("#message_box").fadeIn(1000);
                             $("#message_box").text("Student Fees Paid Sucessfully");



                             $('#productTable tbody').empty();
                             $("#txtClass").val("");
                             $("#drSection").val("");
                             $("#txtFatherName").val("");
                             // $("#txtMobile").val("");
                             $("#drStudentName").val("");
                             $("#total_sum_value").val(0);

                             $("#drTrans")[0].selectedIndex = 0;
                             $("#drTrans").prop('selectedIndex', 0);
                             SucessMessage();

                         } else {
                             //alert(result.d);
                             $("#message_box").fadeIn(300);
                             $("#message_box").text("Technical Error in  Saving Fees.....");
                         }
                     }
                 });

                    
                } 


  */           


                return false;
            });
           




            $("#btnShow").click(function (e) {
                
                $("#StudentRecord").show();
            });

            $('#PrintReceipt').on('click', function (evt) {
                evt.stopPropagation();
               // alert("print Button Click");

                window.location.href = 'FrmPrintFeesReceipt.aspx';
            });
          
           

            $("#btnShowMessage").click(function (e) {

              
                $("#myModal").modal("show");
                return false;
            });


     



            function validate() {
               // alert(" validate inside validate")

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


                //else if (($("#txtFeeBook").val() == "")) {
                //    //alert("ok");
                //    $("#message_box").fadeIn(100);
                //    $("#message_box").text("Select Fee Book no.");
                //    $("#txtFeeBook").focus();
                //    return false;

                //}
                else if (($("#txtDate").val() == "")) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select Fee Book Date");
                    $("#txtDate").focus();
                    return false;

                } else if ( ($("#total_sum_value").val() == "")  || ($("#total_sum_value").val() == "0") ){
                    
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Please Select Fees Month...");

                    return false;
                }

                return true;
            }
         //   $("#myModal").modal("show");
        });
       
         
        //function productBuildTableRow() {
        //    if ($("#productTable tbody").length == 0) {
        //        $("#productTable").append("<tbody></tbody>");
        //    }
        //    var link="    <a class=\"btn btn-success edit\">Edit</a>" ;
        //    $("#productTable tbody").append("<tr>" +
        //        "<td>" + $("#txtTutionFee").val() + "</td>" +
        //        "<td>" + $("#txtStdFee").val() + "</td>" +
        //        "<td>" + $("#txtTermFee").val() + "</td>" +
        //         "<td>" + $("#txtMiscFee").val() + "</td>" +
        //        "<td>" + $("#txtLateFee").val() + "</td>" +
        //        "<td>" + $("#txtDupFee").val() + "</td>" +
        //         "<td>" + $("#txtDupFee").val() + "</td>" +
        //         "<td>" + $("#txtDupFee").val() + "</td>" +
        //          "<td>" +  link    + "</td>" +
        //         "</tr>");
           
                                
                       
           
           
        //}
       



     </script>

</head>
    
<body>
    <div id="nav-placeholder">

    </div>
      
    <form runat="server">
          
          
           <section class="content">
                <div class="container-fluid py-3">

                    <div class="row justify-content-center">

                        <div class="col-md-10">

                            <div class="card card-primary">
                                <div class="card-header  bg-danger text-white">
                                    <h3 class="card-title">Student Fees Collection (Katanga)</h3>
                                    <asp:Image ID="imgBarcode" runat="server" Visible="false" ImageAlign="Right" />

                                </div>
                                <div class="card-body">
                                    <div class="alert alert-danger" id="message_box" style="display: none">
                                    </div>
                                    <div class="alert alert-success" id="success_box" style="display: none">
                                    </div>

                                       <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                            <div class="form-group">
                                                <label for="AdmisionNo">Admision No</label>
                                                <asp:TextBox ID="txtAdmissionNo" runat="server" class="form-control  "
                                                    placeholder="Admission No"  Font-Bold="True" ForeColor="Red" />

                                            </div>
                                        </div>

                                        <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                            
                                                <label for="AdmissionFees"> </label>
                                           <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                              <asp:Button ID="btnSearchAdmissionNo" Text="Search Admission No" runat="server" Class="btn btn-primary" Width="256px"   />
                                          </div>    
                                                
                                            </div>
                                       
                                    </div>
              
                                       <div class="row">
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                            <div class="form-group">
                                                <label for="Department">Class Name</label>
                                               
                                                 <asp:TextBox id="txtClass" name="txtClass"  runat="server" class="form-control  "
                                                    placeholder="Class Name" ReadOnly="true" />
                                                   
                                                
                                            </div>
                                        </div>

                                        <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                            <div class="form-group">
                                                <label for="Section">Section Name</label>
                                                    <asp:TextBox id="drSection"  name="drSection"   runat="server" class="form-control  "
                                                    placeholder="Section Name" ReadOnly="true" />

                                                
                                            </div>
                                        </div>
                                    </div>
                    
                                    
                                    
                                       <div class="row">
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                            <div class="form-group">
                                   
                                            
                                        
                                                        <label for="first_name">Student Name <span class="required">*</span></label>
                                                           <asp:TextBox id="drStudentName" name="drStudentName"  runat="server" class="form-control  "
                                                        placeholder="Student Name" ReadOnly="true"/>

                                            
                                              </div>
                                            </div>   
                           


                                        <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                            <div class="form-group">
                                                <label for="email">Father Name <span class="required">*</span></label>

                                                <asp:TextBox ID="txtFatherName" runat="server" class="form-control  "
                                                    placeholder="Enter Father Name " ReadOnly="true" />

                                            </div>
                                        </div>
                                    </div>

                                   <div class="row">
                           
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                         <div class="form-group">
                                            <label for="AdmissionFees">Receipt Date <span class="required">*</span></label>

                                               <asp:TextBox ID="txtDate" runat="server" class="form-control  "
                                                    placeholder="Receipt Date " />

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
                        
                                                        <asp:ListItem>Adjustment</asp:ListItem>
                        
                                                    </asp:DropDownList>

                                            </div>
                                        </div>
                                    </div>

                                     

                                      <%-- <div class="row">
                           
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-6">
                                            <div class="form-group">
                                                <label for="FormFees">Total Amount  <span class="required">*</span></label>
                                                <asp:TextBox ID="txtTotalAmount" runat="server" class="form-control  "
                                                    placeholder="Total Amount " />
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-6">
                                            <div class="form-group">
                                            <label for="AdmissionFees">Tution Fees <span class="required">*</span></label>

                                               <asp:TextBox ID="txtTutionFee" runat="server" class="form-control  "
                                                    placeholder="Tution Fees " />

                                            </div>
                                        </div>
                      

                          
                           
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-6">
                                            <div class="form-group">
                                                <label for="FormFees">"STD Fees <span class="required">*</span></label>
                                                <asp:TextBox ID="txtStdFee" runat="server" class="form-control  "
                                                    placeholder="STD Fees " />
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-6">
                                            <div class="form-group">
                                            <label for="AdmissionFees">Term Fees <span class="required">*</span></label>

                                               <asp:TextBox ID="txtTermFee" runat="server" class="form-control  "
                                                    placeholder="Term Fees " />

                                            </div>
                                        </div>
                                    </div>
                           
                                       <div class="row">
                           
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-6">
                                            <div class="form-group">
                                                <label for="FormFees">"Misc Fees <span class="required">*</span></label>
                                                <asp:TextBox ID="txtMiscFee" runat="server" class="form-control  "
                                                    placeholder="Misc Fees " />
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-6">
                                            <div class="form-group">
                                            <label for="AdmissionFees">Late Fees <span class="required">*</span></label>

                                               <asp:TextBox ID="txtLateFee" runat="server" class="form-control  "
                                                    placeholder="Late Fees " />

                                            </div>
                                        </div>
                     

                          
                           
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-6">
                                            <div class="form-group">
                                                <label for="FormFees">"Duplicate Fees <span class="required">*</span></label>
                                                <asp:TextBox ID="txtDupFee" runat="server" class="form-control  "
                                                    placeholder="Duplicate Fees " />
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-6">
                                            <div class="form-group">
                                            <label for="AdmissionFees">Received Amount <span class="required">*</span></label>

                                               <asp:TextBox ID="txtReceiveAmount" runat="server" class="form-control  "
                                                    placeholder="Receive Amount " />

                                            </div>
                                        </div>
                                                  </div>

                                       <div class="row">
                                       <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                            <div class="form-group">
                                            <label for="AdmissionFees">Balance Amount <span class="required">**</span></label>

                                             <asp:TextBox ID="txtBalance" runat="server" class="form-control  "
                                            placeholder="Balance Amount " />

                                             </div>
                                        </div>
                                     <div class="form-group">
                                          <label for="AdmissionFees"> <span class="required"></span></label>
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                            <asp:Button ID="btnAdd" Text="Add Fees" runat="server" Class="btn btn-primary" Width="153px"  />
                                        </div>
                                </div>
                                    </div>
                        --%>
              
                       
                      
                            </div>
                                
                            </div>
                            
                            </div>
                        
                            </div>

                     <div class="row justify-content-center">
                         <div class="col-md-10">

                             <div class="card"> 
                            
                                <div class="card-body">
                                     <div class="row">
                                        
                                          <table class="table table-bordered" id="productTable" style=" width: 80%;" cellpadding="0" cellspacing="0" >
                <thead  class="bg-danger text-center text-white">
                    <tr>
                        <th scope="col">Paid/Unpaid</th>
                        <th scope="col">Month</th>
                        <th scope="col">Tution Fees</th>
                        <th scope="col">SDF Fees</th>
                        <th scope="col">Term Fees</th>
                        <th scope="col">Comp. Fees</th>
                        <th scope="col">Sport Fees</th>
                        <th scope="col">Misc Fees</th>
                        <th scope="col">Late Fees</th>
                        <th scope="col">Dup. Fees</th>
                         <th scope="col">Total Fees</th>
                        <th scope="col">Received</th>
                          <th scope="col">Fees Paid Date</th>
                         <th scope="col">Paid Mode</th>
                        <th scope="col">Remark</th>

                    </tr>
                </thead>
                <tbody>
            
               
           
                </tbody>
            </table>
                                      
                                   </div>
                                      <div class="row">



                                           <div class="col-lg-2 col-md-3 col-sm-3 col-12">
                                                    <asp:Button ID="btnPayment" Text="Continue And Pay" runat="server" Class="btn btn-success"  Font-Bold="True"  />
                                            </div>  
                                            <div class="col-lg-2 col-md-2 col-sm-2 col-12"> 
                                                <asp:TextBox ID="TxtReceiptNo" runat="server" class="form-control  "
                                                    placeholder="Receiptno" CssClass="alert-primary" Font-Bold="True" ReadOnly="true"  Visible ="false"  />
                                            </div>      
                                            <div class="col-lg-2 col-md-2 col-sm-2 col-12"> 
                                                <asp:TextBox ID="txtRemark" runat="server" class="form-control  "
                                                    placeholder="Enter Remark" CssClass="alert-primary"  ReadOnly="false"  Visible ="true"  />
                                            </div>     
                                            <div class="col-lg-2 col-md-2 col-sm-2 col-12 text-right" > 
                                               <span class="text-right  font-weight-bold">Total Amount</span>
                                        
                                            </div>                           
                                           <div class="col-lg-3 col-md-3 col-sm-3 col-12"> 
                                                <asp:TextBox ID="total_sum_value" runat="server" class="form-control  "
                                                    placeholder=" " CssClass="alert-primary" Font-Bold="True" />
                                            </div> 
                                                
                                         </div>
                                           
                            </div>
                        </div>
                    </div>
         
            </div>


   
 <!-- Modal -->
  <div id="myModal" class="modal fade">
	 <div class="modal-dialog modal-confirm">
		<div class="modal-content">
			<div class="modal-header justify-content-center">
				<div class="icon-box">
					<i class="material-icons">&#xE876;</i>
				</div>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	   </div>
	   <div class="modal-body text-center">
           <div id="ReceiptNo">
				<h4>Transction Receipt No. for Fees :<span id="receiptno" class="badge badge-primary"><script> $("#receiptno").text = $("#TxtReceiptNo").val()</script>Primary</span></h4>
               
             </div>  	
				<p>Fees Deposit successfully.</p>
				<button class="btn btn-success" data-dismiss="modal"><span>Continue Deposit</span> <i class="material-icons">&#xE5C8;</i></button>
                <button type="button" class="btn btn-warning" id="PrintReceipt"><i class="glyphicon glyphicon-print" style="font-size:20px"></i>  Print</button>
			
          
            
               
          
            </div>
		</div>
	</div>
</div>     
  
</div>

               </section>

   </form>
   
   
</body>
<%-- <script src="js/jquery.js"></script>
    <script src="jquery-ui-1.12.1/jquery-ui.js"></script>  
      <script src="scripts/jquery.dataTables.min.js"></script>--%>    <%-- <script src="DateCalender/jquery.js"></script> --%>
    <script src="DateCalender/jquery.datetimepicker.full.js"></script>
<%--  <script src="scripts/bootstrap/bootstrap.min.js"></script>--%>
    
  <script>


      $('#txtDate').datetimepicker({
            step: 5 ,
            
            format:'d/M/Y',
                      
          
      
          
      });
     
  </script>
                 
</html>


