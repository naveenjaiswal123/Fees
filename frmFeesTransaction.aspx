<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmFeesTransaction.aspx.cs" Inherits="frmFeesTransaction" %>

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
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#nav-placeholder").load("nav1.html");

            var flag = false;


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


                    $("#drClass_edit option").remove();
                    $("#drClass_edit").append($('<option/>').attr("value", "Select Class").text("Select Class"));
                    for (var i = 0; i < _data.length; i++) {
                        //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                        $("#drClass_edit").append($('<option/>').attr("value", _data[i].Class).text(_data[i].Class));

                    }

                  

                    ////  alert(_data.length);
                    //for (var i = 0; i < _data.length; i++) {
                    //    //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
                    //    $("#drClass").append($('<option/>').attr("value", _data[i].Class).text(_data[i].Class));

                    //}

                

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
                    url: "StudentMaster_CURD.aspx.aspx/GetSection",
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
                url: 'frmFeesTransaction.aspx/GetData',
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
                                         { "data": "AdmissionNo" },
                                         { "data": "ReceiptNo" },
                                         { "data": "ReceiptDate" },
                                         { "data": "StudentName" },
                                         { "data": "Class" },
                                         { "data": "Section" },
                                         { "data": "TotalReceived" },
                                         { "data": "TransactionType" },
                                         
                                        {
                                         "data": null,
                                        "defaultContent": '<button type="button" id="btnPrint" class="btn btn-danger"><span class="glyphicon glyphicon-print"> Print</span></button>'
                               
                                        },
                                        {
                                        "data": null,
                                        "defaultContent": '<button type="button" id="btnEdit" class="btn btn-success"><span class="glyphicon glyphicon-edit"> Edit</span></button>'
                               
                                        }         
                                     
                        ]
                    });
                }, error: function (response) {
                    alert(response.responseText);
                }
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




    <style type="text/css">
        .auto-style1 {
            width: 93px;
        }
    </style>




</head>
<body>

    <div id="nav-placeholder">

     </div>
    <form id="form2" runat="server">

           <section class="content" >
                <div class="container-fluid py-3">

                  

               <div style="width: 74%; border: 1px solid black; padding: 3px;">

                 <br/>
       
                     <table id="datatable" class="table table-bordered  table-striped" >
            <thead>
                <tr>
                    <th>Admission No</th> 
                    <th>Receipt No</th> 
                    <th>Receipt Date</th> 
                    <th>Student Name</th>
                    <th>Class</th>  
                    <th>Section</th>   
                    <th class="auto-style1">Received Amount</th> 
                    <th>Payment Mode</th> 
                    <th>Print</th>    
                    <th>Edit</th>                
                    
                </tr>
            </thead>
     
        </table>
           </div>
                      <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
        id="FeesModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content modaledit">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h3 class="modal-title" id="myModalLabel1">
                        Student Fees (Transaction)</h3>
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
