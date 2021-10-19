<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmStudentFeesCard.aspx.cs" Inherits="FrmStudentFeesCard" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
   
    
   

 




     
 
    <link rel="stylesheet" href="css/form.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css " />
     
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <%--<script type="text/javascript" src="https://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"> </script>--%>

    
    <script src="DataTables/datatables.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
         
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>

<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.flash.min.js"></script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>

<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>

<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.print.min.js"></script>    



    <script type="text/javascript">
        $(document).ready(function () {
           
            var str_checked_month;
            $("#nav-placeholder").load("nav1.html");

            var flag = false;
          

            $('#but_showhide').click(function () {

                checked_arr = [];
                unchecked_arr = [];

                $.each($('input[type="checkbox"]:checked'), function (key, value) {
                    checked_arr.push(this.value);
                });

                // Read all unchecked checkboxes
                $.each($('input[type="checkbox"]:not(:checked)'), function (key, value) {
                    unchecked_arr.push(this.value);
                });
                //alert("ok");
               // alert(checked_arr);
               
                // Hide the checked columns
                //datatableVariable.columns([1, 2]).visible(false);

                //// Show the unchecked columns
                //datatableVariable.columns([5, 6]).visible(true);

              
            });



            $("#EditModal").on("hidden.bs.modal", function () {

                if (flag == true)
                { location.reload(); }

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
                    //  alert(_data);

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


            $('#PrintReceipt').on('click', function (evt) {
                evt.stopPropagation();
                // alert("print Button Click");

                window.location.href = 'FrmPrintFeesReceipt.aspx';
            });
           
            $("#drClass").change(function (e) {

              
                $("#drSection option").remove();
                

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
                        $("#drSection").append($('<option/>').attr("value", "All").text("All"));

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
     
          
      
            

            
         
            


            $("#btnShowFees").click(function (e) {
                
                if ($.fn.DataTable.isDataTable("#datatable")) {
                    $("#datatable").DataTable().clear().draw();
                    $("#datatable").dataTable().fnDestroy();
                    //   $("#dataTable").empty();
                }

                var checked_arr = [];
                var checked_arr_no = [];
                var unchecked_arr_no = [];
                var unchecked_arr = [];

                $.each($('input[type="checkbox"]:checked'), function (key, value) {
                    if (this.value == "April")
                    {
                        checked_arr_no.push('4,5');
                    } 
                    if (this.value == "July")
                    {
                        checked_arr_no.push('6,7');
                    }
                    if (this.value == "August")
                    {
                        checked_arr_no.push('8,9');
                    }
                    if (this.value == "September")
                    {
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

                  //  alert(checked_arr_no);
                    checked_arr.push(this.value);
                });

                // Read all unchecked checkboxes
                $.each($('input[type="checkbox"]:not(:checked)'), function (key, value) {

                    if (this.value == "April") {
                        unchecked_arr_no.push('4,5');
                    }
                    if (this.value == "July") {
                        unchecked_arr_no.push('6,7');
                    }
                    if (this.value == "August") {
                        unchecked_arr_no.push('8,9');
                    }
                    if (this.value == "September") {
                        unchecked_arr_no.push('10,11');
                    }

                    if (this.value == "October") {
                        unchecked_arr_no.push('12,13');
                    }
                    if (this.value == "November") {
                        unchecked_arr_no.push('14,15');
                    }
                    if (this.value == "December") {
                        unchecked_arr_no.push('16,17');
                    }
                    if (this.value == "January") {
                        unchecked_arr_no.push('18,19');
                    }
                    if (this.value == "[February-March]") {
                        unchecked_arr_no.push('20,21');
                    }
                    if (this.value == "[Caution-Money]") {
                        unchecked_arr_no.push('22,23');
                    }
                    if (this.value == "[Re_REG-FEE]") {
                        unchecked_arr_no.push('24,25');
                    }
                    
                    unchecked_arr.push(this.value);
                });
                //alert("ok");
               // alert(checked_arr);
                if (checked_arr.length == 0) {
                    alert("Select Month Name From Check Box  To Dsipaly....")
                    return false;
                }

                $.ajax({
                    url: 'FrmStudentFeesCard.aspx/GetData',
                    method: 'post',
                    dataType: 'json',
                    data: '{"class_name":"' + $("#drClass").val() + '" ,"section_name":"' + $("#drSection").val() + '","paid_status":"' + $("#drTransaction").val() + '" ,"month_name_check":"' + checked_arr + '","month_name_uncheck":"' + unchecked_arr + '"}',
                    contentType: 'application/json;charset=utf-8',
                    success: function (_data)
                    {
                        _data = JSON.parse(_data.d);
                      
                        var datatableVariable = $('#datatable').dataTable({
                            paging: true,
                            sort: true,
                            pageLength: 100,
                            searching: true,
                            data: _data,
                            dom: 'Bfrtip',
                            buttons: [
                                {
                                    extend: 'copy',
                                    className: 'btn btn btn-warning rounded-0',
                                    text: '<i class="fa fa-copy"></i> Copy'
                                },
                                {
                                    extend: 'csv',
                                    className: 'btn btn-info  rounded-0',
                                    text: '<i class="fa fa-csv-o"></i> CSV'
                                },
                                {
                                    extend: 'excel', exportOptions: {
                                        columns: ':visible'
                                    },
                                    className: 'btn  btn-success rounded-0',
                                    text: '<i class="fa fa-excel-o"></i> Excel'
                                },
                                {
                                    extend: 'pdf', exportOptions: {
                                        columns: ':visible'
                                    },
                                    className: 'btn btn-danger rounded-0',
                                    text: '<i class="fa fa-file-pdf-o"></i> Pdf',
                                    orientation: 'landscape',
                                    pageSize: 'LEGAL',
                                    messageTop: 'The information in this Table is copyright to Phoenix Software Solution, Jabalpur.'
                                },
                                {
                                    extend: 'print', exportOptions: {
                                        columns: ':visible'
                                    },
                                    className: 'btn btn-primary rounded-0',
                                    text: '<i class="fa fa-print"></i> Print'
                                    
                                },

                            ],
                            "columnDefs":
                                [
                                      {
                                          "width": "5%",
                                          "targets": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                                      },
                                      {
                                          "className": "text-center custom-middle-align",
                                          "targets": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                                      },
                                ],
                            "language":
                            {
                                "processing": "<div class='overlay custom-loader-background'><i class='fa fa-cog fa-spin custom-loader-color'></i></div>"
                            },

                            columns: [
                                             { "data": "AdmissionNo" },
                                             { "data": "Class" },
                                             { "data": "Section" },
                                             { "data": "StudentName" },
                                             { "data": "April" },
                                             { "data": "April_Date" },
                                             { "data": "July" },
                                             { "data": "July_Date" },
                                             { "data": "August" },
                                             { "data": "August_Date" },
                                             { "data": "September" },
                                             { "data": "September_Date" },
                                             { "data": "October" },
                                             { "data": "October_Date" },
                                             { "data": "November" },
                                             { "data": "November_Date" },
                                             { "data": "December" },
                                             { "data": "December_Date" },
                                             { "data": "January" },
                                             { "data": "January_Date" },
                                             { "data": "February-March" },
                                             { "data": "February_March_Date" },
                                             { "data": "Caution-Money" },
                                             { "data": "Caution_Money_Date" },
                                             { "data": "Re_Reg-Fee" },
                                             { "data": "Re_Reg_Date" },
                                             { "data": "CollectedAmount" }


                            ]
                        });
                       
                       

                        // Hide & show columns
                        $('#but_showhide1').click(function () {
                           
                            // checked_arr = [];
                            // unchecked_arr = [];
                           
                            //$.each($('input[type="checkbox"]:checked'), function (key, value) {
                            //    checked_arr.push(this.value);
                            //});

                            //// Read all unchecked checkboxes
                            //$.each($('input[type="checkbox"]:not(:checked)'), function (key, value) {
                            //    unchecked_arr.push(this.value);
                            //});
                            ////alert("ok");
                            
                            var datatableVariable = $('#datatable').DataTable();
                            // Hide the checked columns
                            //datatableVariable.columns([1, 2]).visible(false);

                            //// Show the unchecked columns
                            //datatableVariable.columns([5, 6]).visible(true);

                            datatableVariable.columns(checked_arr_no).visible(true);

                            // Show the unchecked columns
                            datatableVariable.columns(unchecked_arr_no).visible(false);
                        });

                    }, error: function (response) {
                        alert(response.responseText);
                    }
                });
             
                //$('#but_showhide1').click();
             
            });
 
            $('body').on('click', '[id*=btnPrint]', function () {

              
               
                //alert("Section Name:");

                var data = $(this).parents('tr').find('td');
                var admission_no = data.eq(0).html();
                var receipt_no = data.eq(1).html();
                var student_name = data.eq(3).html();
               
                
                 var class_name = data.eq(2).html();
                 var section_name = data.eq(3).html();
                 var trans_type = data.eq(7).html();
                //alert("Class Name:" + class_name);
                // alert("Section Name:" + trans_type);
               
               

                 window.location.href = 'FrmPrintFeesReceipt.aspx?Trans_Type=' + trans_type + '&Receipt_No=' + receipt_no;

               
              
              
               
                //$.ajax({
                //    type: "POST",
                //    url: "frmFeesTransaction/PrintReceipt",
                //    contentType: "application/json; charset=utf-8",
                //    data: '{"receipt_no":"' + receipt_no + '"}',

                //    dataType: "json",
                //    success: function (_data) {
                //        _data = JSON.parse(_data.d);
                //        //  alert(_data);





                //    },
                //    failure: function (response) {
                //        alert("Fail");
                //    },
                //    error: function (response) {
                //        alert(response.responseText);
                //    }

                //});


            });

            $('body').on('click', '[id*=btnEdit]', function () {



                //var data = $(this).parents('tr').find('td');
                //var admission_no = data.eq(0).html();
                //var student_name = data.eq(1).html();
                //var father_name = data.eq(4).html();
                //var mobileno = data.eq(5).html();

                //var class_name = data.eq(2).html();
                //var section_name = data.eq(3).html();
                //alert("Class Name:" + class_name);
                //alert("Section Name:" + section_name);

                //$.ajax({
                //    url: 'FeesCollection.aspx/GetAllSection',
                //    type: 'post',
                //    contentType: 'application/json;charset=utf-8',
                //    dataType: 'json',
                //    data: "{}",
                //    success: function (_data) {
                //        _data = JSON.parse(_data.d);

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


                //$('[id*=txtAdmissionNo]').val(admission_no);
                //$('[id*=txtStudentName]').val(student_name);
                //$('[id*=txtFatherName]').val(father_name);
                //$('[id*=txtMobileNo]').val(mobileno);
                //$('[id*=drClass_edit]').val(class_name);
                //$('[id*=drSection_edit]').val(section_name);

                $('FeesModal').modal("show");


            });

       

        });
   
        
        </script>




    </head>
<body>

    <div id="nav-placeholder">

     </div>
    <form id="form2" runat="server">

          
                <div class="container-fluid">

                      <div class="row justify-content-center">

                        <div class="col-md-12">

                            <div class="card card-primary">
                                <div class="card-header bg-danger text-center text-white">
                                    <h3 class="card-title">Report Student Fees Collection (Katanga)</h3>
                                    <asp:Image ID="imgBarcode" runat="server" Visible="false" ImageAlign="Right" />

                                </div>
                                <div class="card-body">
                                    <div class="alert alert-danger" id="message_box" style="display: none">
                                    </div>

                                      <div class="row">
                                        <div class="col-lg-3 col-md-3 col-sm-3  col-12">
                                            <div class="form-group">
                                              <label for="Section">Class Name</label> 
                                               <div class="select-option">
                                                    <select id="drClass" name="drClass" class="form-control  " ForeColor="#6666FF">

                                            
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                       
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-12">
                                <div class="form-group">
                                    <label for="Section">Section Name</label>
                                    <div class="select-option">

                                         <select id="drSection"  name="drSection"  class="form-control  " ForeColor="#0066FF" >

                                          
                        
                                        </select>
                                    </div>
                                </div>
                            </div>

                                        

                                       <div class="col-lg-3 col-md-3 col-sm-3 col-12">
                                            <div class="form-group">
                                               <label for="Section">Paid Status</label>
                                                <div class="select-option">


                                                       <asp:DropDownList ID="drTransaction" runat="server" class="form-control " ForeColor="#6666FF">
                                                            <asp:ListItem>All</asp:ListItem>
                                                            <asp:ListItem>UnPaid</asp:ListItem>
                                                            <asp:ListItem>Paid</asp:ListItem>
                                                           
                                                        </asp:DropDownList>

                                                   
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-12">
                                            
                                           
                                              <input type='button' id="btnShowFees" value="Show Fees Details" Class="btn btn-primary" />
                                        </div> 

                                    </div>
                                         
                              
                                </div>
                            </div>
                        </div>
                    </div>
                      <div style="width: 100%; border: 1px solid black; padding: 0px;">


                          <div >  
                      <span>   </span>   
      <input type="button"  class="btn btn-success btn-rounded" id="but_showhide1" value='Show/Hide'/><span>  </span>
      <label class="label " >Month Name </label>
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
           

     

                   <style>
  /*.table.dataTable  {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: 12px;
}*/
  table.dataTable tr.dtrg-level-0 td {
  font-size: 1.1em;
}
  table.dataTable td {
        font-family: Verdana, Geneva, Tahoma, sans-serif;
       font-size: 12px;
}
   table.dataTable th {
        font-family: Verdana, Geneva, Tahoma, sans-serif ;
       font-size: 12px;
       color:red;
}
</style>
       <table class="table table-striped table-bordered table-hover" id="datatable" cellspacing="0" align="center"   > 
                
            <thead>
                <tr>
                    <th style="color:red;" class="auto-style2">Admission No</th> 
                    <th class="auto-style2">Class</th> 
                    <th class="auto-style2">Section</th> 
                    <th class="auto-style2">Student-Name</th>
                    <th class="auto-style2">April</th>
                    <th class="auto-style2">Date</th>  
                    <th class="auto-style2">July</th>  
                    <th class="auto-style2">Date</th>  
                    <th class="auto-style2">August</th>
                    <th class="auto-style2">Date</th>  
                    <th class="auto-style2">September</th>
                    <th class="auto-style2">Date</th>  
                    <th class="auto-style2">October</th>
                    <th class="auto-style2">Date</th>     
                    <th class="auto-style2">November</th>
                    <th class="auto-style2">Date</th>                 
                    <th class="auto-style2">December</th>
                    <th class="auto-style2">Date</th>     
                    <th class="auto-style2">January</th>
                    <th class="auto-style2">Date</th> 
                    <th class="auto-style2">Februry-March</th>
                    <th class="auto-style2">Date</th>  
                    <th class="auto-style2">Caution-Money</th>
                    <th class="auto-style2">Date</th>  
                    <th class="auto-style2">Re.Reg-Fees</th>
                    <th class="auto-style2">Date</th> 
                    <th class="auto-style2">Total-Amount</th>
                </tr>
            </thead>
     
        </table>
           </div>
               
                </div>

          

    </form>


   
    
  
</body>
</html>
