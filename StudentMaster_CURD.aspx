<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StudentMaster_CURD.aspx.cs" Inherits="StudentMaster_CURD" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
   
    
   

 

     
 
   <link rel="stylesheet" href="css/form.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <%--    <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>  --%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>



    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
   <%-- <link rel="stylesheet" href="css/Style.css" />--%>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#nav-placeholder").load("nav1.html");

            var flag = false;
        
            $('#fees_month').hide();

          //  $('#fees_month').show();

            $('#drCategory_edit').change(function (e) {
              

                if (($("#drCategory_edit").val() == "Exempted")) {


                    $('#fees_month').show();

                }
                else {
                    $('#fees_month').hide();
                }
             
            });

            $("#EditModal").on("hidden.bs.modal", function () {

                if (flag == true)
                {
                    location.reload();
                }

            });

            $("#AddModal").on("hidden.bs.modal", function () {

                if (flag == true)
                { location.reload(); }

            });

            $.ajax({
                url: 'FeesCollection.aspx/GetData',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{}",
                success: function (_data) {
                    _data = JSON.parse(_data.d);
                     // alert(_data);

                    $("#drClass option").remove();
                    $("#drClass").append($('<option/>').attr("value", "Select Class").text("Select Class"));
                    for (var i = 0; i < _data.length; i++) {
                        //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                        $("#drClass").append($('<option/>').attr("value", _data[i].Class).text(_data[i].Class));

                    }


                    $("#drClass_edit option").remove();
                    $("#drClass_edit").append($('<option/>').attr("value", "Select Class").text("Select Class"));
                    for (var i = 0; i < _data.length; i++) {
                        //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                        $("#drClass_edit").append($('<option/>').attr("value", _data[i].Class).text(_data[i].Class));

                    }

                  

                

                },
                failure: function (response) {
                    alert("Fail");
                },
                error: function (response) {
                    alert(response.responseText);
                }
    
            });

            $.ajax({
                url: 'FeesCollection.aspx/GetAllSection',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{}",
                success: function (_data) {
                    _data = JSON.parse(_data.d);
                    //  alert(_data);

                   


                   
                   
                
                        $("#drSection_edit").append($('<option/>').attr("value", "Select Section").text("Select Section"));

                        for (var i = 0; i < _data.length; i++) {
                            //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                            $("#drSection_edit").append($('<option/>').attr("value", _data[i].section).text(_data[i].section));
                        }

                    },



                    ////  alert(_data.length);
                    //for (var i = 0; i < _data.length; i++) {
                    //    //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                    //    $("#drClass").append($('<option/>').attr("value", _data[i].Class).text(_data[i].Class));

                    //}



                failure: function (response) {
                    alert("Fail");
                },
                error: function (response) {
                    alert(response.responseText);
                }

            });
            //$.ajax({
            //    url: 'StudentMaster_CURD.aspx/GetSection',
            //    type: 'post',
            //    contentType: 'application/json;charset=utf-8',
            //    dataType: 'json',
            //    data: '{"class_name":"' + $("#drClass").val() + '"}',
            //    success: function (_data) {
            //        _data = JSON.parse(_data.d);
            //        // alert(_data);

            //        $("#drSection_edit").append($('<option/>').attr("value", "Select Section").text("Select Section"));

            //        for (var i = 0; i < _data.length; i++) {
            //            //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
            //            $("#drSection_edit").append($('<option/>').attr("value", _data[i].section).text(_data[i].section));
            //        }

            //    },
            //    failure: function (response) {
            //        alert("Fail");
            //    },
            //    error: function (response) {
            //        alert(response.responseText);
            //    }

            //});
     
          
            $("#drClass").change(function (e) {

              
                $("#drSection option").remove();
           
                $.ajax({
                    type: "POST",
                    url: "StudentMaster_CURD.aspx/GetSection",
                    contentType: "application/json; charset=utf-8",
                    //data: '{distt_name: "' + $(this).val() + '" }',
                    data: '{"class_name":"' + $("#drClass").val() + '"}',
                    dataType: "json",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                        // alert(_data);

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
            

            
            $("#drClass_edit").change(function (e) {


                $("#drSection_edit option").remove();

                $.ajax({
                    type: "POST",
                    url: "StudentMaster_CURD.aspx/GetSection",
                    contentType: "application/json; charset=utf-8",
                    //data: '{distt_name: "' + $(this).val() + '" }',
                    data: '{"class_name":"' + $("#drClass_edit").val() + '"}',
                    dataType: "json",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                      
                        $("#drSection_edit").append($('<option/>').attr("value", "Select Section").text("Select Section"));

                        for (var i = 0; i < _data.length; i++) {
                            //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                            $("#drSection_edit").append($('<option/>').attr("value", _data[i].section).text(_data[i].section));
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

            $.ajax({
                url: 'StudentMaster_CURD.aspx/GetData',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                success: function (data) {

                    data = JSON.parse(data.d);
                    $('#datatable').dataTable({
                        paging: true,
                        sort: true,
                        pageLength: 15,
                        searching: true,
                        data: data,
                        columns: [
                                         { "data": "AdmissionNo"},
                                         { "data": "StudentName"},
                                         { "data": "Class"},
                                         { "data": "Section"},
                                         { "data": "FatherName"},
                                         { "data": "MobileNo"},
                                         { "data": "Category"},
                                         
                                         {
                                            "data": null,
                                            "defaultContent": '<input type="button" id="btnEdit" class="btn btn-primary" value="Edit"> <span class="glyphicon glyphicon-pencil"></span></button>'
                                         }
                                        
                                     
                                ]
                    });
                }, error: function (response) {
                    alert(response.responseText);
                }
            });
 
            $('body').on('click', '[id*=btnEdit]', function () {

             

                var data = $(this).parents('tr').find('td');
                var admission_no = data.eq(0).html();
                var student_name = data.eq(1).html();
                var father_name = data.eq(4).html();
                var mobileno = data.eq(5).html();
                var class_name = data.eq(2).html();
                 var section_name = data.eq(3).html();
                 var category_name = data.eq(6).html();
                //alert("Class Name:" + class_name);
                 //alert("category Name:" + category_name);

                $.ajax({
                    url: 'FeesCollection.aspx/GetAllSection',
                    type: 'post',
                    contentType: 'application/json;charset=utf-8',
                    dataType: 'json',
                    data: "{}",
                    success: function (_data) {
                        _data = JSON.parse(_data.d);
                       
                        $("#drSection_edit").append($('<option/>').attr("value", "Select Section").text("Select Section"));

                        for (var i = 0; i < _data.length; i++) {
                            //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                            $("#drSection_edit").append($('<option/>').attr("value", _data[i].section).text(_data[i].section));
                        }

                    },

                  
                    failure: function (response) {
                        alert("Fail");
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }

                });
               

                $('[id*=txtAdmissionNo]').val(admission_no);
                $('[id*=txtStudentName]').val(student_name);
                $('[id*=txtFatherName]').val(father_name);
                $('[id*=txtMobileNo]').val(mobileno);
                $('[id*=drClass_edit]').val(class_name);
                $('[id*=drSection]').val(section_name);
                $('[id*=drCategory_edit]').val(category_name);
                $('#EditModal').modal("show");


            });



            $('body').on('click', '[id*=btnAdd]', function () {
                var data = $(this).parents('tr').find('td');
                var admission_no = data.eq(0).html();
                var student_name = data.eq(1).html();
                var father_name = data.eq(4).html();
                var mobileno = data.eq(5).html();
                var class_name = data.eq(2).html();
                var section_name = data.eq(3).html();
                var category_name = data.eq(6).html();


                $('[id*=txtAdmissionNo]').val('');
                $('[id*=txtStudentName]').val('');
                $('[id*=txtFatherName]').val('');
                $('[id*=txtMobileNo]').val('');
                $('[id*=drCategory]').val('Select Category');
                //$('[id*=txtClassName]').val(class_name);
                //$('[id*=txtSectionName]').val(section_name);
                $('#btnAdd_Student').focus();
                $('#AddModal').modal("show");

                return false;
            });


            $("#btnAdd_Student").click(function (e) {
                var feesdetails = {};
                var feesdata;
            if (($("#txtAdmissionNo_Add").val().length < 3)) {
                //alert("ok");
                $("#message_box").fadeIn(100);
                $("#message_box").text("Enter Student Admission No...");
                $("#txtAdmissionNo_Add").focus();
                return false;

            } else if (($("#drClass").val() == "Select Class")) {
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

            }else if (($("#txtStudentName_Add").val().length < 3)) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Student Name Should be More than 3 Character");
                    $("#txtxStudentName_Add").focus();
                    return false;
                }
                else if (($("#txtFatherName_Add").val().length < 3)) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Father  Name is More than 3 Character");
                    $("#txtFatherName_Add").focus();
                    return false;

                }
                

                else if (($("#txtMobileNo_Add").val().length < 10)) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Mobile No is Should be 10  Number");
                    $("#txtMobileNo_Add").focus();
                    return false;

                }
                else if (($("#drCategory_add").val() == "Select Category")) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select Student Category");
                    $("#drCategory_add").focus();
                    return false;

                }
          
            var Students = new Array();

            var student = {};

            
           
            student.StudentName = $("#txtStudentName_Add").val();
            student.AdmissionNo = $("#txtAdmissionNo_Add").val();
            student.ClassName = $("#drClass").val();
            student.Section = $("#drSection").val();
            student.MobileNo = $("#txtMobileNo_Add").val();
            student.FatherName = $("#txtFatherName_Add").val();
            student.Category = $("#drCategory_add").val();

          

                // alert(fees.TransactionType);
                // alert(student);
            Students.push(student);
            studentdata = JSON.stringify(Students);

            $.ajax(
           {
               type: "POST",
               url: "StudentMaster_CURD.aspx/SaveStudentMaster",
               data: JSON.stringify({ 'studentdata': studentdata, }),
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {

            //       alert(result);


                   if (result.d == "true") {
                    //   alert(result.d);
                       $("#message_box").fadeIn(1000);
                       $("#message_box").text("Student Registration Sucessfully");
                       flag = true;


                      
                       $("#txtStudentName_Add").val("");
                       $("#drSection").val("");
                       $("#txtFatherName_Add").val("");
                       $("#txtMobileNo_Add").val("");
                       $("#txtAdmissionNo_Add").val("");
                       $("#drCategory_add").val("Select Category");
                     

                       SucessMessage();

                   } else if (result.d == "false") {
                       $("#message_box").fadeIn(1000);
                       $("#message_box").text("Registration No. is Already Exist.... ");
                       flag=false

                   }

                   else {
                       alert(result.d);
                       $("#message_box").fadeIn(300);
                       $("#message_box").text("Technical Error in  Saving Fees.....");
                   }
               }
           });

                // Refreshing Update Data


                return true;
            });

         
            $("#btnUpdateStudent").click(function (e) {
                var feesdetails = {};
                var feesdata;

                var checked_arr = [];
                var checked_arr_no = [];
                var unchecked_arr_no = [];
                var unchecked_arr = [];

                if (($("#txtAdmissionNo").val().length < 3)) {
                    //alert("ok");
                    $("#message_box_edit").fadeIn(100);
                    $("#message_box_edit").text("Enter Student Admission No...");
                    $("#txtAdmissionNo").focus();
                    return false;

                } else if (($("#drClass_edit").val() == "Select Class")) {
                    //alert("ok");
                    $("#message_box_edit").fadeIn(100);
                    $("#message_box_edit").text("Select Class Name");
                    $("#drClass_edit").focus();
                    return false;

                }
                else if (($("#drSection_edit").val() == "Select Section")) {
                    //alert("ok");
                    $("#message_box_edit").fadeIn(100);
                    $("#message_box_edit").text("Select Section Name");
                    $("#drSection_edit").focus();
                    return false;

                } else if (($("#txtStudentName").val().length < 3)) {
                    //alert("ok");
                    $("#message_box_edit").fadeIn(100);
                    $("#message_box_edit").text("Student Name Should be More than 3 Character");
                    $("#txtxStudentName").focus();
                    return false;
                }
                else if (($("#txtFatherName").val().length < 3)) {
                    //alert("ok");
                    $("#message_box_edit").fadeIn(100);
                    $("#message_box_edit").text("Father  Name is More than 3 Character");
                    $("#txtFatherName_Add").focus();
                    return false;

                }


                else if (($("#txtMobileNo").val().length < 10)) {
                    //alert("ok");
                    $("#message_box_edit").fadeIn(100);
                    $("#message_box_edit").text("Mobile No is Should be 10  Number");
                    $("#txtMobileNo_Add").focus();
                    return false;

                }
                else if (($("#drCategory_edit").val() == "Select Category")) {
                    //alert("ok");
                    $("#message_box_edit").fadeIn(100);
                    $("#message_box_edit").text("Select Student Category");
                    $("#drCategory_edit").focus();
                    return false;

                }


                $.each($('input[type="checkbox"]:checked'), function (key, value) {
                    if (this.value == "April") {
                        checked_arr_no.push('4,5');
                    }
                    if (this.value == "July") {
                        checked_arr_no.push('6,7');
                    }
                    if (this.value == "August") {
                        checked_arr_no.push('8,9');
                    }
                    if (this.value == "September") {
                        checked_arr_no.push('10,11');
                    }

                    if (this.value == "October") {
                        checked_arr_no.push('12,13');
                    }
                    if (this.value == "November") {
                        checked_arr_no.push('14,15');
                    }
                    if (this.value == "December") {
                        checked_arr_no.push('16,17');
                    }
                    if (this.value == "January") {
                        checked_arr_no.push('18,19');
                    }
                    if (this.value == "[February-March]") {
                        checked_arr_no.push('20,21');
                    }
                    if (this.value == "[Caution-Money]") {
                        checked_arr_no.push('22,23');
                    }
                    if (this.value == "[Re-Reg-Fee]") {
                        checked_arr_no.push('24,25');
                    }

                     
                    checked_arr.push(this.value);
                });



                var Students = new Array();

                var student = {};



                student.StudentName = $("#txtStudentName").val();
                student.AdmissionNo = $("#txtAdmissionNo").val();
                student.ClassName = $("#drClass_edit").val();
                student.Section =  $("#drSection_edit").val();
                student.MobileNo = $("#txtMobileNo").val();
                student.FatherName = $("#txtFatherName").val();
                student.Category = $("#drCategory_edit").val();
               

                // alert(fees.TransactionType);
               // alert(student);
                Students.push(student);
                studentdata = JSON.stringify(Students);
                checked_arr_data = JSON.stringify(checked_arr);

             
                $.ajax(
               {
                   type: "POST",
                   url: "StudentMaster_CURD.aspx/EditStudentMaster",
                   data: JSON.stringify({ 'studentdata': studentdata, 'month_name_check':checked_arr_data}),
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (result) {

                       //       alert(result);


                       if (result.d == "true") {
                           flag = true;
                           //   alert(result.d);
                           $("#message_box_edit").fadeIn(1000);
                           $("#message_box_edit").text("Student Information Edit Sucessfully");




                           $("#txtStudentName").val("");
                           $("#drSection_edit").val("");
                           $("#txtFatherName").val("");
                           $("#txtMobileNo").val("");
                           $("#txtAdmissionNo").val("");
                           $("#drCategory_edit").val("Select Category");

                           SucessMessage();

                       } else if (result.d == "false") {
                           $("#message_box_edit").fadeIn(1000);
                           $("#message_box_edit").text("Registration No. is Already Exist.... ");
                           flag = false;
                       }

                       else {
                           alert(result.d);
                           $("#message_box_edit").fadeIn(300);
                           $("#message_box_edit").text("Technical Error in  Saving Fees.....");
                       }
                   }
               });

///For Refreshing Form Data
          

        



                return true;
            });

        });
    </script>




</head>
<body>

    <%-- <div id="nav-placeholder">

     </div>--%>
    <form id="form2" runat="server">

           <section class="content">
                <div class="container-fluid py-3">

                    <div id="nav-placeholder">

                 </div>

                    <div style="width: 100%; border: 1px solid black; padding: 3px">

        <br/>
        <br/>
         <%--<a class="btn btn-success btn-md" href="#AddModal" data-toggle="modal"  data-target="#AddModal"><i class="fa fa-plus" aria-hidden="true"></i>Add Student </a>--%>
         <input type="button" id="btnAdd" class="btn btn-success" value="Add New Student" />
        <br/>
        <br/>
         <table id="datatable" class="table table-bordered  table-striped" >
            <thead>
                <tr>
                     <th>Admission No</th> 
                     <th>Student Name</th>
                     <th>Class</th>  
                     <th>Section</th>   
                     <th>Father Name</th>  
                     <th>Mobile No</th> 
                     <th>Category</th>   
                     <th>Edit</th>                
                    
                </tr>
            </thead>
     
        </table>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
        id="EditModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content modaledit">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h2 class="modal-title" id="myModalLabel">
                        Edit Student Master Data</h2>
                </div>
                <div class="modal-body">
                    <div class="panel-body">
                         <div class="alert alert-danger" id="message_box_edit" style="display: none">
                                    </div>
                        <table id="tbtUpdate" class="table">
                            <tr>
                                <td>
                                    Admission No
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAdmissionNo" runat="server" ReadOnly="true" ></asp:TextBox>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    Class Name
                                </td>
                                <td>
                                    <select id="drClass_edit" name="drClass_edit" class="form-control" ForeColor="#6666FF">

                                            
                                        </select>
                                    
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    Section Name
                                </td>
                                <td>
                                     <div class="select-option">

                                                     <select id="drSection_edit"  name="drSection"  class="form-control" ForeColor="#0066FF" >
                                        
                        
                                                    </select>
                                                </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Student Name
                                </td>
                                <td>
                                    <asp:TextBox ID="txtStudentName" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Father Name
                                </td>
                                <td>
                                     <asp:TextBox ID="txtFatherName" runat="server"></asp:TextBox>
                                     
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Mobile No
                                </td>
                                <td>
                                     <asp:TextBox ID="txtMobileNo" runat="server"></asp:TextBox>
                                     
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Student Category
                                </td>
                                <td>
                                     <div class="select-option">

                                                     <select id="drCategory_edit"  name="drCategory_edit"  class="form-control" ForeColor="#0066FF" >
                                                            <option value ="Select Category">Select Category</option>
                                                            <option value ="Gen">Gen</option>
                                                            <option value ="T.C">T.C</option>
                                                            <option value ="BPL">BPL</option>
                                                            <option value ="Exempted">Exempted</option>
                        
                                                    </select>
                                                </div>
                                </td>
                            </tr>

                            <tr>
                                <td align="center">
                                   <%-- <asp:Button ID="btnUpdateStudent" Text="Update" runat="server" class="btn btn-primary" />--%>
                                
                                <button type="button" class="btn btn-success"  id="btnUpdateStudent" ><span class="glyphicon glyphicon-save-file"></span> Update Data</button>
                                </td>
                               
                            </tr>
                        </table>
  <div id ="fees_month" >                                              
     
      <label class="label">Month Name </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='April'/> April </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='July'/> July </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='August'/> August </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='September'/> September </label> 
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='October'/> October </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='November'/> November  </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='December'/> December </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='January'/> January </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='[February-March]'/> Feb-March </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='[Caution-Money]'/> Caution Money </label>
      <label class="checkbox-inline"><input type="checkbox" name='hide_columns[]' value='[Re_REG-FEE]'/> ReReg-FEE </label>

 
            </div>  

                    </div>
                </div>
                <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>

         <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
        id="AddModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content modaledit">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h3 class="modal-title" id="myModalLabel1">
                        Student Master (Registration)</h3>
                </div>
                <div class="modal-body">
                    <div class="panel-body">
                        <div class="alert alert-danger" id="message_box" style="display: none">
                                    </div>
                        <table id="tbtUpdate_add" class="table">
                            <tr>
                                <td>
                                    Admission No
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAdmissionNo_Add" runat="server" class="form-control"></asp:TextBox>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    Class Name
                                </td>
                                <td>
                                    

                                        <select id="drClass" name="drClass" class="form-control" ForeColor="#6666FF">

                                            
                                        </select>
                                    
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    Section Name
                                </td>
                                <td>
                                   <div class="select-option">

                                                     <select id="drSection"  name="drSection"  class="form-control" ForeColor="#0066FF" >
                                        
                                                         

                                                    </select>
                                                </div>
                                   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Student Name
                                </td>
                                <td>
                                    <asp:TextBox ID="txtStudentName_Add" runat="server" class="form-control"></asp:TextBox>
                                     
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Father Name
                                </td>
                                <td>
                                     <asp:TextBox ID="txtFatherName_Add" runat="server" class="form-control"></asp:TextBox>
                                     
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Mobile No
                                </td>
                                <td>
                                     <asp:TextBox ID="txtMobileNo_Add" runat="server" class="form-control"></asp:TextBox>
                                     
                                </td>
                            </tr>

                           <tr>
                                <td>
                                    Student Category
                                </td>
                                <td>
                                   <div class="select-option">

                                                     <select id="drCategory_add"  name="drCategory_add"  class="form-control" ForeColor="#0066FF" >
                                                           <option value ="Select Category">Select Category</option>
                                                          <option value ="Gen">Gen</option>
                                                          <option value ="BPL">BPL</option>
                                                          <option value ="T.C">T.C</option>
                                                          <option value ="Exempted">Exempted</option>
                                                    </select>
                                                </div>
                                   
                                </td>
                            </tr>
                          

<%--                            <tr>
                                <td align="center">

                                    
                                   
                                </td>
                               
                            </tr>--%>
                        </table>

               


                    </div>
                </div>
                <div class="modal-footer">
                     <%--<asp:Button ID="btnAdd_Student" Text="Save Data" runat="server" class="btn btn-primary" />--%>
                     <button type="button" class="btn btn-success"  id="btnAdd_Student" ><span class="glyphicon glyphicon-save-file"></span> Save Data</button>
                   <%--<button type="button" ID="btnAdd_Student" Text="Save Data" runat="server" class="btn btn-primary" />--%>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Close</button>
                </div>
            </div>
        </div>
    </div>
</div>

</section>

    </form>
</body>
</html>