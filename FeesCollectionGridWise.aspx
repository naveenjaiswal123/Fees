<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FeesCollectionGridWise.aspx.cs" Inherits="FeesCollectionGridWise" %>


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
             $("#drClass").selectedIndex = 0;

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
          
            var student_array = [];
            $("#StudentRecord").hide();
            $("#nav-placeholder").load("nav.html");
            $("#message_box").fadeOut();
           //Get_Data();
           

            ///--------------For Calcullating Sum f Received Fees


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



            $.ajax({
                url: 'FeesCollectionGridWise.aspx/GetData',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{}",
                success: function (_data) {
                    _data = JSON.parse(_data.d);
                    //  alert(_data);


                    //  alert(_data.length);
                    $("#drClass option").remove();
                    $("#drClass").append($('<option/>').attr("value", "Select Class").text("Select Class"));
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
                    url: "FeesCollectionGridWise.aspx/GetStudentDetails",
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

                $("#drMonth").change();
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
                $('#productTable tbody').empty();
                $.ajax({
                    type: "POST",
                    url: "FeesCollectionGridWise.aspx/GetSection",
                    contentType: "application/json; charset=utf-8",
                    //data: '{distt_name: "' + $(this).val() + '" }',
                    data: '{"class_name":"' + $("#drClass").val() + '"}',
                    dataType: "json",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                         // alert(_data);

                        $("#drAdmissionNo option").remove();
                        $("#drStudentName option").remove();
                        $("#drSection option").remove();
                        $("#drAdmissionNo").append($('<option/>').attr("value", "Select Admission No").text("Select Admission No"));
                        $("#drStudentName").append($('<option/>').attr("value", "Select Student Name").text("Select Student Name"));
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
                //$("#txtFatherName").val("");
                //$("#txtMobile").val("");
                $.ajax({
                    type: "POST",
                    url: "FeesCollectionGridWise.aspx/GetStudentData",
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

                        $("#txtFatherName").val(_data[0].FatherName) ;
                        $("#txtMobile").val( _data[0].MobileNo) ;
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
                    url: "FeesCollectionGridWise.aspx/GetFeeDetails",
                    contentType: "application/json; charset=utf-8",
                    data: '{"month_name":"' + $(this).val() + '","class_name":"' + $("#drClass").val() + '" ,"Admission_No":"' + $("#drAdmissionNo").val() + '"}',

                    dataType: "json",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                        //  alert(_data);
                     


                        var link = "   <div class=\"form-check form-switch\">  <input class=\"form-check-input\" type=\"checkbox\" id=\"flexSwitchCheckChecked\"  disabled=\"disabled\"  class =\"cbCheck\" checked onchange=\" productDisplay(this);\">    <label class=\"form-check-label\" for=\"flexSwitchCheckChecked\"  >Fees Paid </label> </div>";
                        var link_paid = "  <div class=\"form-check form-switch\">   <input class=\"form-check-input\" type=\"checkbox\" id=\"flexSwitchCheckChecked\" class =\"cbCheck\"  onchange=\" productDisplay(this);\" >   <label class=\"form-check-label\" for=\"flexSwitchCheckChecked\">Fees UnPaid </label> </div> ";
                        var  txtbox=   "<div class=\"form-group\">  <input type =\"TextBox\" ID=\"txtFeesReceived\"  class=\"form-control  \" /> </div> ";
                                

                                    
                                       

                                

                        //var status="<a class=\"btn btn-danger delete\" onclick=\"return alert('Are You sure?')\">Delete</a>";

                        $('#productTable tbody').empty();

                       

                        $.each(_data, function (i, item) {

                            var link = "   <div class=\"form-check form-switch\">  <input class=\"form-check-input\" type=\"checkbox\" id=\"FeesChecked" + item.MonthT + " \"  disabled=\"disabled\"  class =\"cbCheck\" checked onchange=\" productDisplay(this);\">    <label class=\"form-check-label\" for=\"flexSwitchCheckChecked\"  >Fees Paid </label> </div>";
                            var link_paid = "  <div class=\"form-check form-switch\">   <input class=\"form-check-input\" type=\"checkbox\" id=\"FeesChecked" + item.MonthT + "\" class =\"cbCheck\"  onchange=\" productDisplay(this);\" >   <label class=\"form-check-label\" for=\"flexSwitchCheckChecked\">Fees UnPaid </label> </div> ";



                            if (item.TotalReceived > 0 ) {
                                var status = link;
                                var status_txtbox = item.TotalReceived;

                            } else
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
                                                + "</tr>";
                                                $('#productTable tbody').append(rows);
                        });
                     
                        },
                        error: function (data) { }
                    });

                  
                        
            //            if (_data.length > 0) {

            //                $("#txtTotalAmount").val(_data[0].TotatAmount);
            //                $("#txtTutionFee").val(_data[0].TutionFee);
            //                $("#txtStdFee").val(_data[0].SdfFee);
            //                $("#txtTermFee").val(_data[0].TermFee);
            //                $("#txtMiscFee").val(_data[0].MiscFee);
            //                $("#txtLateFee").val(_data[0].LateFee);
            //                $("#txtDupFee").val(_data[0].DupFee);
            //            }
                        

            //            calculate_fees();
            //        },
            //        failure: function (response) {
            //            alert("Fail");
            //        },
            //        error: function (response) {
            //            alert(response.responseText);
            //        }

            //    });
            });
          
            //$("#btnAdd").click(function (e) {
            //    alert("")
            //    productBuildTableRow();
            //    return false;
            //});

           /////--Fees PAyment 
        


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
                        fees.BookNo = $("#txtFeeBook").val();
                        fees.FeesDate = $("#txtDate").val();
                        fees.StudentName = $("#drStudentName").val();
                        fees.AdmissionNo = $("#drAdmissionNo").val();
                        fees.ClassName = $("#drClass").val();
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

                       // alert(fees.Month);
                      //  alert(fees);
                       Fees.push(fees);
                    }
                });

                feesdata = JSON.stringify(Fees);
              //  alert(JSON.stringify(Fees));
              

                var txt;
                var r = confirm("Press OK button For Confirmation !");
                if (r == true) {

                    $.ajax(
                 {
                     type: "POST",
                     url: "FeesCollectionGridWise.aspx/SaveFeesDetails",
                     data: JSON.stringify({ 'feesdata': feesdata, }),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (result) {
                         if (result.d == "true") {
                             alert(result.d);
                             $("#message_box").fadeIn(1000);
                             $("#message_box").text("Student Fees Paid Sucessfully");

                             $("#drClass")[0].selectedIndex = 0;
                             $("#drClass").prop('selectedIndex', 0);
                             $("#drClass").change();

                         } else {
                             //alert(result.d);
                             $("#message_box").fadeIn(300);
                             $("#message_box").text("Technical Error in  Saving Fees.....");
                         }
                     }
                 });

                    
                } 


             


                return false;
            });
           




            $("#btnShow").click(function (e) {
                
                $("#StudentRecord").show();
            });




     



            function validate() {
                alert(" validate inside validate")

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

                } else if ($("#total_sum_value").val() == "") {
                    alert(" blank");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Nothing is Selected");

                    return false;
                }

                return true;
            }

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
                                        
                                          <table class="table table-bordered" id="productTable" >
                <thead  class="bg-danger text-center text-white">
                    <tr>
                        <th scope="col">Paid/Unpaid</th>
                        <th scope="col">Month</th>
                        <th scope="col">Tution Fees</th>
                        <th scope="col">STD Fees</th>
                        <th scope="col">Term Fees</th>
                        <th scope="col">Comp. Fees</th>
                        <th scope="col">Sport Fees</th>
                        <th scope="col">Misc Fees</th>
                        <th scope="col">Late Fees</th>
                        <th scope="col">Dup. Fees</th>
                         <th scope="col">Total Fees</th>
                        <th scope="col">Received</th>
                        

                    </tr>
                </thead>
                <tbody>
            
               
           
                </tbody>
            </table>
                                      
                                   </div>
                                      <div class="row">



                                           <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                                    <asp:Button ID="btnPayment" Text="Continue And Pay" runat="server" Class="btn btn-success"  OnClick="btnPayment_Click"  />
                                            </div>  
                                                 
                                          
                                          <div class="col-lg-3 col-md-3 col-sm-3 col-12 text-right" > 
                                               <span class="text-right  font-weight-bold">Total Amount</span>
                                        
                                            </div>                           
                                           <div class="col-lg-3 col-md-3 col-sm-3 col-12"> 
                                                <asp:TextBox ID="total_sum_value" runat="server" class="form-control  "
                                                    placeholder=" " />
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


