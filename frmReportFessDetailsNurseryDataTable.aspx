<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmReportFessDetailsNurseryDataTable.aspx.cs" Inherits="frmReportFessDetailsNurseryDataTable" %>


<html>
    <head>
        <title>Nursery Fees Collection Report</title>
        <link rel="stylesheet" href="css/form.css" />
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"  />
          <!-- Datatable CSS -->
        <link href='DataTables/datatables.min.css' rel='stylesheet' type='text/css'>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

  
     <link rel="stylesheet" type="text/css" href="DateCalender/jquery.datetimepicker.min.css" />



    <script src="DateCalender/jquery.js"></script>
    <script src="DateCalender/jquery.datetimepicker.full.js"></script>


    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>  
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

   
        <link href="css/fontawesome-all.min.css" rel="stylesheet" />

      
            


       
        <!-- Datatable JS -->
      

          <script src="scripts/jquery.dataTables.min.js"></script>  
         <script src="scripts/dataTables.bootstrap4.min.js"></script>  
        

            <script>
            $(document).ready(function () {

                $("#nav-placeholder").load("nav.html");
                $("#message_box").fadeOut();
             //   Get_Data();

                $("#btnShowFees").click(function (e) {

                    var fromdate = new Date($("#txtFromDate").val());
                    var todate = new Date($("#txtToDate").val());
                    /*
                    if (($("#drClass").val() == "Select Class")) {
                        //alert("ok");
                        $("#message_box").fadeIn(100);
                        $("#message_box").text("Select Class of Student");
                        $("#drClass").focus();
                        return false;

                    }
                    else if (($("#txtFromDate").val() == "")) {
                        //alert("ok");
                        $("#message_box").fadeIn(100);
                        $("#message_box").text("Select From Date");
                        $("#txtFromDate").focus();
                        return false;

                    }
                    else if (($("#txtToDate").val() == "")) {
                        //alert("ok");
                        $("#message_box").fadeIn(100);
                        $("#message_box").text("Select To Date");
                        $("#txtToDate").focus();
                        return false;

                    }
                    else if (fromdate > todate) {
                        //alert("ok");
                        $("#message_box").fadeIn(100);
                        $("#message_box").text("Date Range is Incorrect");
                        $("#drTrans").focus();
                        return false;

                    }
                    */
                    Get_Data();
                    return false;
                });


                $.ajax({
                    url: 'ReportNurseryFeesCollection.aspx/GetData',
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


                //// Datapicker 
                //$("#fromdate").datepicker({
                    
                //dateFormat: 'dd/M/yy',  
                //changeMonth: true,  
                //changeYear: true,  
                //yearRange: '1950:2100'
                //});
            
                //$("#todate").datepicker({
                //    dateFormat: 'dd/M/yy',
                //    changeMonth: true,
                //    changeYear: true,
                //    yearRange: '1950:2100'
                //});
       

            function Get_Data() {
                //var table = $('#dataTable').DataTable();
                //table.destroy();
                //    alert("inside Data");
                /*
                if ($.fn.DataTable.isDataTable("#dataTable")) {
                    $("#dataTable").DataTable().clear().draw();
                    $("#dataTable").dataTable().fnDestroy();
                 //   $("#dataTable").empty();
                }
                */
                

                $.ajax({
                    url: 'frmReportFessDetailsNurseryDataTable.aspx/GetData',
                    type: 'post',
                    contentType: 'application/json;charset=utf-8',
                    dataType: 'json',
                   // data: '{"fromdate":"' + $("#txtFromDate").val() + '" ,"todate":"' + $("#txtToDate").val() + '" ,"class":"' + $("#drClass").val() + '" }',

                    beforeSend: function () {
                        // Show image container
                        $("#loader").show();
                    },
                    success: function (_data) {

                        if (_data.d == "Failure") {
                            $("#loader").hide();
                        }
                        _data = JSON.parse(_data.d);
                       
                        
                   
                        $('#dataTable').append('<caption style="caption-side: bottom">A fictional company\'s staff table.</caption>');

                        $('#dataTable').DataTable({
                            data: _data,
                             columns: [
                                                                       
                                         { "data": "FeeBookNo"},
                                         { "data": "ReceiptDate"},
                                         { "data": "StudentName"},
                                         { "data": "Class" },
                                         { "data": "MonthT" },
                                         { "data": "TotalAmount" },
                                         { "data": "SdfFee" },
                                         { "data": "TermFee" },
                                         { "data": "MiscFee" },
                                         { "data": "LateFee" },
                                         { "data": "DupFee" },
                                         { "data": "TotalReceived" },
                                         { "data": "TransactionType" },
                            ]

                        });

                    },
                    complete: function (data) {
                        // Hide image container
                        $("#loader").hide();
                    },
                    failure: function (response) {
                        alert("Some Error has Occured"+"Fail");
                    },
                    error: function (response) {
                        alert("Some Error has Occured"+response.responseText);
                    }

                });

            }
            // DataTable
          

            // Search button
            $('#btnShowFees').click(function () {

                var fromdate = new Date($("#fromdate").val());
                var todate =new Date( $("#todate").val());

                if (($("#fromdate").val()==""))
                {
                  
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select From Date is Blank");
                    $("#fromdate").focus();
                    return false;
                }
                else if (($("#search_todate").val()==""))
                {
                  
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Select To Date is Blank..");
                    $("#todate").focus();
                        return false;
                    }
                else if (fromdate>todate){
                   
                    $("#message_box").fadeIn(100);
                    $("#message_box").text("Date Range is Incorrect");
                    return false;
                       

                }
               
               
               
                $("#message_box").fadeOut();

                Get_Data();
            });
           
        });
        </script>


    </head>
    <body >
          
   <div id="nav-placeholder">

    </div>
    <form id="form1" runat="server">

         <section class="content">
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
                             
                                <div class="text-center" id='loader' style='display: none;'>
                                     <img src='loading.gif' width='62px' height='62px' >
 
                                </div>

                                       <div class="row">
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-12">
                                            <div class="form-group">
                                              
                                                <div class="select-option">

                                                    <select id="drClass" name="drClass" class="form-control  " ForeColor="#6666FF">

                                            
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-12">
                                            <div class="form-group">
                                           

                                                <asp:TextBox ID="txtFromDate"  runat="server" class="form-control  "
                                                    placeholder="From Date dd/MM/yyyy " />

                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-12">
                                            <div class="form-group">
                                           

                                                <asp:TextBox ID="txtToDate" runat="server" class="form-control  "
                                                    placeholder="To Date dd/MM/yyyy " />

                                          </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-12">
                                            
                                            <asp:Button ID="btnShowFees" Text="Show Fees Details" runat="server" Class="btn btn-primary"    />
                                        </div> 

                                    </div>
                     <div class="table-responsive">
             

                        <!-- Table -->
             <table id="dataTable" class="table table-bordered table-striped dt-responsive nowrap">  
                 <thead>  
                     <tr>  
                    <th>Fees Book No</th> 
                    <th>Receipt Date</th>  
                    <th>Student Name</th>  
                    <th>Class</th>  
                    <th>Month</th> 
                    <th>Total Amount</th>  
                    <th>SDF Fee</th>  
                    <th>Term Fee</th>
                   <th>Misc Fee</th> 
                    <th>Late Fee</th>  
                    <th>Dup. Fees</th>  
                    <th>Total Received</th>  
                    <th>Transaction Type</th>  
                </tr>  
            </thead> 
            <tbody></tbody> 
        </table>  
        </div>
         </div>
         </div>
        
        <!-- Script -->
     </div>
  

     </div>
    <!-- /#page-content-wrapper end -->

  </div> 
          </section>
    
   </form>

    

    
     
    




    </body>

</html>
