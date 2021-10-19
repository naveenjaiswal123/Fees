<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmFeesTransactionNew.aspx.cs" Inherits="FrmFeesTransactionNew" %>



<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
   
    
   

 

     
 
   <link rel="stylesheet" href="css/form.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css "/>


    <link rel="stylesheet" type="text/css" href="DateCalender/jquery.datetimepicker.min.css" />
    <link rel="stylesheet" type="text/css" href=" https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css" />


    <script src="DateCalender/jquery.js"></script>
    <script src="DateCalender/jquery.datetimepicker.full.js"></script>

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


            $("#btnUpdateStudent").on("hidden.bs.modal", function () {

                if (flag == true)
                { location.reload(); }

            });

            $("#btnCancelStudent").on("hidden.bs.modal", function () {

                if (flag == true)
                { location.reload(); }

            });

            function ValidateDate(dtValue)
            {
                var dtRegex = new RegExp(/bd{1,2}[/-]d{1,2}[/-]d{4}b/);
                alert(dtRegex.test(dtValue));
                return dtRegex.test(dtValue);
            }
            $("#btnUpdateStudent").click(function (e) {
                var feesdetails = {};
                var receiptdata;

                if (($("#txtReceiptDate").val().length < 3)) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Enter Correct ReceiptDate ...");
                    $("#txtReceiptDate").focus();
                    return false;
                }
               
               
            

                var FeesReceipt = new Array();

                var fees = {};



                 fees.StudentName = $("#txtStudentName").val();
                 fees.AdmissionNo = $("#txtAdmissionNo").val();
                 fees.FatherName = $("#txtFatherName").val();
                 fees.Receiptno = $("#txtReceiptNo").val();
                 fees.ReceiptDate = $("#txtReceiptDate").val();
                 fees.PaymentMode = $("#txtPaymentMode").val();
                 fees.Remarks = $("#txtRemarks").val();
                


                // alert(fees.TransactionType);
              
                 FeesReceipt.push(fees);
                receiptdata = JSON.stringify(FeesReceipt);
                var txt;
                var r = confirm("Are You Sure Press OK button For Confirmation !");
                if (r == true) {
                    $.ajax(
                   {
                       type: "POST",
                       url: "FrmFeesTransactionNew.aspx/EditFeesTransaction",
                       data: JSON.stringify({ 'receiptdata': receiptdata, }),
                       contentType: "application/json; charset=utf-8",
                       dataType: "json",
                       success: function (result) {

                           //       alert(result);


                           if (result.d == "true") {
                               flag = true;
                               //   alert(result.d);
                               $("#message_box").fadeIn(1000);
                               $("#message_box").text("Fess Receipt Date  Edit Sucessfully");





                               SucessMessage();

                           } else if (result.d == "false") {
                               $("#message_box").fadeIn(1000);
                               $("#message_box").text("Fees Receipt Date Cannot Be Modify.... ");
                               flag = false;
                           }

                           else {
                               alert(result.d);
                               $("#message_box").fadeIn(300);
                               $("#message_box").text("Technical Error in  Updating Fees.....");
                           }
                       }
                   });

                    ///For Refreshing Form Data
                    return true;
                }
            });



            $("#btnCancelStudent").click(function (e) {
                var feesdetails = {};
                var receiptdata;

                if (($("#txtReceiptDate").val().length < 3)) {
                    //alert("ok");
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Enter Correct ReceiptDate ...");
                    $("#txtReceiptDate").focus();
                    return false;
                }




                var FeesReceipt = new Array();

                var fees = {};



                fees.StudentName = $("#txtStudentName").val();
                fees.AdmissionNo = $("#txtAdmissionNo").val();
                fees.FatherName = $("#txtFatherName").val();
                fees.Receiptno =  $("#txtReceiptNo").val();
                fees.ReceiptDate = $("#txtReceiptDate").val();
                fees.PaymentMode = $("#txtPaymentMode").val();


                // alert(fees.TransactionType);

                FeesReceipt.push(fees);
                receiptdata = JSON.stringify(FeesReceipt);


                var txt;
                var r = confirm("Are You Sure Press OK button For Confirmation !");
                if (r == true) {


                    $.ajax(
                   {
                       type: "POST",
                       url: "FrmFeesTransactionNew.aspx/CancelFeesTransaction",
                       data: JSON.stringify({ 'receiptdata': receiptdata, }),
                       contentType: "application/json; charset=utf-8",
                       dataType: "json",
                       success: function (result) {

                           //       alert(result);


                           if (result.d == "true") {
                               flag = true;
                               //   alert(result.d);
                               $("#message_box").fadeIn(1000);
                               $("#message_box").text("Fess Transaction Cancel... Sucessfully");





                               SucessMessage();

                           } else if (result.d == "false") {
                               $("#message_box").fadeIn(1000);
                               $("#message_box").text("Fess Transaction Cancel Cannot Be Cancel.... ");
                               flag = false;
                           }

                           else {
                               alert(result.d);
                               $("#message_box").fadeIn(300);
                               $("#message_box").text("Technical Error in  Cancel Fees.....");
                           }
                       }
                   });

                    ///For Refreshing Form Data
                    
                    return true;
                }
            });


        

            //$.ajax({
            //    url: 'FeesCollection.aspx/GetAllSection',
            //    type: 'post',
            //    contentType: 'application/json;charset=utf-8',
            //    dataType: 'json',
            //    data: "{}",
            //    success: function (_data) {
            //        _data = JSON.parse(_data.d);
            //        //  alert(_data);

                   


                   
                   
                
            //            $("#drSection_edit").append($('<option/>').attr("value", "Select Section").text("Select Section"));

            //            for (var i = 0; i < _data.length; i++) {
            //                //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
            //                $("#drSection_edit").append($('<option/>').attr("value", _data[i].section).text(_data[i].section));
            //            }

            //        },



            //        ////  alert(_data.length);
            //        //for (var i = 0; i < _data.length; i++) {
            //        //    //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
            //        //    $("#drClass").append($('<option/>').attr("value", _data[i].Class).text(_data[i].Class));

            //        //}



            //    failure: function (response) {
            //        alert("Fail");
            //    },
            //    error: function (response) {
            //        alert(response.responseText);
            //    }

            //});
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
     
          
            $.ajax({
                url: 'FrmFeesTransactionNew.aspx/GetData',
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
                        "columnDefs": [
                                        {"width": "5%", "targets": 0},
                                        { "width": "5%", "targets": 1 },
                                        { "width": "10%", "targets": 2 },
                                        { "width": "10%", "targets": 3 },
                                        { "width": "10%", "targets": 4 },
                                        { "width": "4%", "targets": 5 },
                                        { "width": "5%", "targets": 6 },
                                        { "width": "10%", "targets": 7 },
                                        { "width": "5%", "targets": 8 },
                                        { "width": "12%", "targets": 9 },
                                         { "width": "12%", "targets": 10 },
                                        {"orderable": false, "targets": [0,1]} // Can't order
                                    ],
                                    //"paging": false, // no pagination
                                     "language": {
                                     "zeroRecords": "Sorry we no data for this substance",
                                    "infoFiltered": "",
                                    "infoEmpty": "",
                                    "processing": '<i class="fa fa-spinner fa-spin fa-2x fa-fw"></i>'
                                    },
                        columns: [
                                         { "data": "AdmissionNo" },
                                         { "data": "ReceiptNo" },
                                         { "data": "ReceiptDate" },
                                         { "data": "StudentName"},
                                         { "data": "Class" },
                                         { "data": "Section" },
                                         { "data": "TotalReceived" },
                                         { "data": "MonthT" },
                                         { "data": "TransactionType" },

                                        {
                                            "data": null,
                                            "defaultContent": '<button type="button" id="btnPrint" class="btn btn-danger btn-md"><span class="glyphicon glyphicon-print">Print</span></button>', "width": "5%"

                                        },
                                        {
                                            "data": null,
                                            "defaultContent": '<button type="button" id="btnEdit" class="btn btn-success btn-md"><span class="glyphicon glyphicon-edit">Edit</span></button>', "width": "5%"

                                        }


                        ]
                    });
                }, error: function (response) {
                    alert(response.responseText);
                }
            });

            $('body').on('click', '[id*=btnPrint]', function () {



                var data = $(this).parents('tr').find('td');
                var admission_no = data.eq(0).html();
                var receipt_no = data.eq(1).html();
                var student_name = data.eq(3).html();
                var month_name = data.eq(7).html();
                var class_name = data.eq(4).html();
                var section_name = data.eq(5).html();
                var received_amount = data.eq(6).html();
                var payment_mode = data.eq(8).html();
                var receipt_date = data.eq(2).html();


                //alert("Class Name:" + class_name);
                // alert("Section Name:" + trans_type);



                window.location.href = 'FrmPrintFeesReceipt.aspx?Trans_Type=' + payment_mode + '&Receipt_No=' + receipt_no + '&Admission_No=' + admission_no;





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

             

                var data = $(this).parents('tr').find('td');
                var admission_no = data.eq(0).html();
                var receipt_no = data.eq(1).html();
                var student_name = data.eq(3).html();
                var month_name = data.eq(7).html();
                var class_name = data.eq(4).html();
                var section_name = data.eq(5).html();
                var received_amount = data.eq(6).html();
                var payment_mode = data.eq(8).html();
                var receipt_date = data.eq(2).html();
                
                /// For dispalying data in combobox

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

               
                $.ajax({
                    url: 'FrmFeesTransactionNew.aspx/GetDataReceiptNo',
                    type: 'post',
                    contentType: 'application/json;charset=utf-8',
                    dataType: 'json',
                    data: '{"receiptno":"' + receipt_no + '","paymentmode":"' + payment_mode + '" }',
                    success: function (_data) {
                        _data = JSON.parse(_data.d);

                        
                    //   alert(_data);
                       
                  
                        if (_data.length > 0) {


                            $("#txtRemarks").val(_data[0].Remarks);
                         

                        }



                    },
                    failure: function (response) {
                        alert("Fail");
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }

                });
               

                $('[id*=txtReceiptNo]').val(receipt_no);
                $('[id*=txtAdmissionNo]').val(admission_no);
                $('[id*=txtStudentName]').val(student_name);
                $('[id*=txtReceivedAmount]').val(received_amount);
               
                $('[id*=txtClassName]').val(class_name);
                $('[id*=txtSectionName]').val(section_name);
                $('[id*=txtReceiptDate]').val(receipt_date);
                $('[id*=txtPaymentMode]').val(payment_mode);

                $('#FeesModal').modal("show");


            });



            $('body').on('click', '[id*=btnAdd]', function () {
                var data = $(this).parents('tr').find('td');
                var admission_no = data.eq(0).html();
                var receipt_no = data.eq(1).html();
                var student_name = data.eq(3).html();
                      
                var class_name = data.eq(4).html();
                var section_name = data.eq(5).html();
                var received_amount = data.eq(6).html();
                var payment_mode = data.eq(7).html();

                $('[id*=txtAdmissionNo]').val('');
                $('[id*=txtStudentName]').val('');
                $('[id*=txtFatherName]').val('');
                $('[id*=txtMobileNo]').val('');
                //$('[id*=txtClassName]').val(class_name);
                //$('[id*=txtSectionName]').val(section_name);
                $('#btnAdd_Student').focus();
                $('#AddModal').modal("show");

                return false;
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
         border: 1px solid black;
         word-wrap: break-word;
}

  
   table.dataTable th {
        font-family: Verdana, Geneva, Tahoma, sans-serif ;
       font-size: 12px;
       color:red;
}

   table {
table-layout: fixed;
width: 95%; 
}
</style>
     
                     <table id="datatable" class="table display table-striped  table table-bordered " cellspacing="0" width="95%">
            <thead>
                <tr>
                    <th>Admission No</th> 
                    <th>Receipt No</th> 
                    <th>Receipt Date</th> 
                    <th>Student Name</th>
                    <th>Class</th>  
                    <th>Section</th>   
                    <th>Received Amount</th> 
                     <th>Fees Months</th> 
                    <th>Payment Mode</th> 
                    <th>Print</th>    
                    <th>Edit</th>                
                    
                </tr>
            </thead>
     
        </table>
    </div>

                    <style>

                   
                    .modal-ku {
  width: 700px;
  margin: auto;
}
                         </style>
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
        id="FeesModal">
        <div class="modal-dialog modal-ku" role="document">
            <div class="modal-content modaledit">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h2 class="modal-title" id="myModalLabel">
                        Edit Student Fees Transaction</h2>
                </div>
                <div class="modal-body">
                    <div class="panel-body">
                         <div class="alert alert-danger" id="message_box" style="display: none">
                                    </div>
                        <table id="tbtUpdate" class="table">
                            
                             <tr>
                                <td>
                                    Receipt No
                                </td>
                                <td>
                                    <asp:TextBox ID="txtReceiptNo" runat="server" ReadOnly="true" ></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td  >
                                    Receipt Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txtReceiptDate" runat="server" class="text-danger " ></asp:TextBox> <span>*(dd/MMM/yyyy)</span>
                                   
                                </td>
                            </tr>
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
                                  
                                    <asp:TextBox ID="txtClassName" runat="server" ReadOnly="true" ></asp:TextBox>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    Section Name
                                </td>
                                <td>
                                      <asp:TextBox ID="txtSectionName" runat="server" ReadOnly="true" ></asp:TextBox>
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
                                    Received Amount
                                </td>
                                <td>
                                     <asp:TextBox ID="txtReceivedAmount" runat="server"  ReadOnly="true"></asp:TextBox>
                                     
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   Remarks
                                </td>
                                <td>
                                     <asp:TextBox ID="txtRemarks" runat="server"  class="text-success"></asp:TextBox>  <span>*(Enter Remarks  )</span>
                                     
                                </td>
                            </tr>
                            <tr>
                                <td >
                                   Payment Mode
                                </td>
                                <td>
                                     <asp:TextBox ID="txtPaymentMode" runat="server"  ReadOnly="true"></asp:TextBox>
                                     
                                </td>
                            </tr>


                            <tr >
                                <td >
                                   
                                
                                <button type="button" class="btn btn-success"  id="btnUpdateStudent" ><span class="glyphicon glyphicon-save-file"></span> Update Data</button>
                                   
                                </td>
                               <td>
                                <span>  <button type="button" class="btn btn-danger"  id="btnCancelStudent" ><span class="glyphicon glyphicon-remove"></span> Delete Transaction</button> </span>
                               </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>

      
</div>

</section>

    </form>
</body>

    <script src="DateCalender/jquery.datetimepicker.full.js"></script>
  <%--  <script src="scripts/bootstrap/bootstrap.min.js"></script>--%>
    
  <script>


      $('#txtReceiptDate').datetimepicker({
            step: 5 ,
            
            format:'d/M/Y',
                      
          
      
          
      });
     
  </script>
                 
</html>