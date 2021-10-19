<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DashBoard.aspx.cs" Inherits="DashBoard2" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    

    <title>Little World School Fees Management Dashboard</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

    <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" />
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css "/>
  

     <link rel="stylesheet" href="css/form.css" />
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

   <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"  />
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Custom styles for this template -->
  <%--  <link href="css/simple-sidebar.css" rel="stylesheet" />--%>

    <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.min.css" rel="stylesheet" />

     <link rel="stylesheet" href="css/adminlte.min.css"/> 

     <link rel="stylesheet" type="text/css" href="DateCalender/jquery.datetimepicker.min.css" />



    <script src="DateCalender/jquery.js"></script>
    <script src="DateCalender/jquery.datetimepicker.full.js"></script>


    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>  
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" crossorigin="anonymous"></script>
  
     <!-- Datatable JS -->
  

     <script type="text/javascript">
    
         function fetchdata1() {



             $.ajax({
                 type: "POST",
                 url: "ChartLineJs.aspx/GetLineChartData",
                 datatype: "JSON",
                 contentType: "application/json; charset=utf-8",

                 success: function (_data) {
                     var player = [];
                     var score = [];
                     const months = [
                                        "Jan", "Feb",
                                        "Mar", "Apr", "May",
                                        "Jun", "Jul", "Aug",
                                        "Sep", "Oct",
                                        "Nov", "Dec"
                     ];
                     _data = JSON.parse(_data.d);

                     for (var i = 0; i < _data.length; i++) {
                         const d = new Date(_data[i].ReceiptDate);
                         const year = d.getFullYear(); // 2019
                         const date = d.getDate(); // 23
                         const monthIndex = d.getMonth();
                         //const monthName = months[monthIndex];
                         //    player.push("Date " + _data[i].reg_date);

                         player.push("" + date + "/" + months[monthIndex]);
                         score.push(_data[i].Totaltrans);

                     }
                     //  alert(player);
                     var chartdata = {
                         labels: player,
                         datasets: [
                           {
                               label: 'Transactions',
                               fill: false,
                               lineTension: 0.1,
                               backgroundColor: "rgba(59, 89, 152, 0.75)",
                               borderColor: "rgba(59, 89, 152, 1)",
                               pointHoverBackgroundColor: "rgba(59, 89, 152, 1)",
                               pointHoverBorderColor: "rgba(59, 89, 152, 1)",
                               data: score
                           },
                            {
                                label: 'Label Fees',
                                fill: false,
                                lineTension: 0.1,
                                backgroundColor: "rgba(59, 89, 152, 0.75)",
                                borderColor: "rgba(59, 89, 152, 1)",
                                pointHoverBackgroundColor: "rgba(59, 89, 152, 1)",
                                pointHoverBorderColor: "rgba(59, 89, 152, 1)",
                                data: score
                            }
                         ]
                     };
                     var ctx = $("#myLineChart");

                     var LineGraph = new Chart(ctx, {
                         type: 'line',
                         data: chartdata
                     });
                 },
                 error: function (_data) {
                     //console.log(_data);
                 },
                 complete: function (_data) {
                     setTimeout(fetchdata1, 2000);
                 }
             });
         }
          

         function fetchdata2() {
             $.ajax({
                 type: "POST",
                 url: "ChartLineJs.aspx/GetAmountChartData",
                 datatype: "JSON",
                 contentType: "application/json; charset=utf-8",

                 success: function (_data) {
                     var player = [];
                     var score = [];
                     const months = [
                                    "Jan", "Feb",
                                    "Mar", "Apr", "May",
                                    "Jun", "Jul", "Aug",
                                    "Sep", "Oct",
                                    "Nov", "Dec"
                     ];
                     _data = JSON.parse(_data.d);

                     for (var i = 0; i < _data.length; i++) {
                         const d = new Date(_data[i].ReceiptDate);
                         const year = d.getFullYear(); // 2019
                         const date = d.getDate(); // 23
                         const monthIndex = d.getMonth();
                         //const monthName = months[monthIndex];
                         //    player.push("Date " + _data[i].reg_date);

                         player.push("" + date + "/" + months[monthIndex]);
                         // player.push("" + date + "/" + (monthIndex + 1));
                         score.push(_data[i].TotalAmount);

                     }
                     //  alert(player);
                     var chartdata = {
                         labels: player,
                         datasets: [
                           {
                               label: ' Received Amount',
                               fill: false,
                               lineTension: 0.1,
                               backgroundColor: "rgba(59, 89, 152, 0.75)",
                               borderColor: "rgba(59, 89, 152, 1)",
                               pointHoverBackgroundColor: "rgba(59, 89, 152, 1)",
                               pointHoverBorderColor: "rgba(59, 89, 152, 1)",
                               data: score
                           },
                            {
                                label: 'Receipt Date',
                                fill: false,
                                lineTension: 0.1,
                                backgroundColor: "rgba(59, 89, 152, 0.75)",
                                borderColor: "rgba(59, 89, 152, 1)",
                                pointHoverBackgroundColor: "rgba(59, 89, 152, 1)",
                                pointHoverBorderColor: "rgba(59, 89, 152, 1)",
                                data: score
                            }
                         ]
                     };
                     var ctx = $("#myAmountLineChart");

                     var LineGraph = new Chart(ctx, {
                         type: 'line',
                         data: chartdata
                     });
                 },
                 error: function (_data) {
                     //console.log(_data);
                 },
                 complete: function (_data) {
                     setTimeout(fetchdata2, 2000);
                 }
             });
         }


         function fetchdata3() {

             $.ajax({
                 type: "POST",
                 url: "ChartLineJs.aspx/GetAmountChartData",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {

                     // alert(result.d);

                     $("#TotalAmount").text(result.d);




                 }, error: function (error) {

                 },
                 complete: function (_data) {
                     setTimeout(fetchdata3, 5000);
                 }
             });
         }
         function fetchdata4() {
             $.ajax({
                 type: "POST",
                 url: "ChartLineJs.aspx/",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {

                     //     alert(result.d);

                     $("#CashReceipt").text(result.d);




                 }, error: function (error) {

                 },
                 complete: function (_data) {
                     setTimeout(fetchdata4, 5000);
                 }
             });
         }

         function fetchdata5() {
             $.ajax({
                 type: "POST",
                 url: "ChartLineJs.aspx/",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {

                     //      alert(result.d);




                 }, error: function (error) {

                 },
                 complete: function (_data) {
                     setTimeout(fetchdata5, 5000);
                 }
             });
         }

                 function fetchdata6() {
                 $.ajax({
                     type: "POST",
                     url: "ChartLineJs.aspx/",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (result) {

                         //   alert("Discharge Data" +result.d);

                        




                     }, error: function (error) {

                     },
                     complete: function (_data) {
                         setTimeout(fetchdata6, 5000);
                     }
                 });

            
         }
    

         $(document).ready(function () {
             $("#nav-placeholder").load("nav.html");
      
             setTimeout(fetchdata1, 5000);
             setTimeout(fetchdata2, 5000);
             setTimeout(fetchdata4, 5000);

             setTimeout(fetchdata5, 5000);
             setTimeout(fetchdata6, 5000);
            
         });

                

    
         </script>




    

</head>


<body>

    <div id="nav-placeholder">

    </div>
     <section class="content">
        <!-- Begin Page Content -->
        <div class="container-fluid">


        
      <h1 class="h3 mb-2 text-gray-800">School Fees </h1>
        <div class="row">
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-info">
              <div class="inner">
                <h3 id="TotalPurchase"></h3>

                <p>Cash Fees Collection</p>
                  
              </div>
              <div class="icon">
                <i class="ion ion-bag"></i>
              </div>

              <a href="" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-success">
              <div class="inner">
                <h3 id=""><sup style="font-size: 20px"></sup></h3>

                <p>Card Swipe(Today)</p>
              </div>
              <div class="icon">
                <i class="ion ion-stats-bars"></i>
              </div>
              <a href="" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-warning">
              <div class="inner">
                <h3 id="TotalFees">0</h3>

                <p>Total fees (Today)</p>
              </div>
              <div class="icon">
                <i class="ion ion-person-add"></i>
              </div>
              <a href="" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-danger">
              <div class="inner">
                <h3 id="">&nbsp;</h3>

                <p>On line Fees</p>
              </div>
              <div class="icon">
                <i class="ion ion-pie-graph"></i>
              </div>
              <a href="" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
        </div>

          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">Charts</h1>
         
          <!-- Content Row -->
                 <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        </div>
                                    <div class="card-body">
                                        <canvas id="myLineChart" width="100%" height="50%">

                                        </canvas>

                                   
                  
                

                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        </div>
                                    <div class="card-body"><canvas id="myAmountLineChart" width="100%" height="50%"></canvas></div>
                                </div>
                            </div>
                        </div>

                 <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        </div>
                                    <div class="card-body">
                                        <canvas id="" width="100%" height="50%">

                                        </canvas>
                                                      
                  
                

                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                    </div>
                                    <div class="card-body"><canvas id="myAdmitLineChart1" width="100%" height="50%"></canvas></div>
                                </div>
                            </div>
                        </div>

        </div>
        <!-- /.container-fluid -->
     </section>
    
     <script src="js/sb-admin-2.min.js"></script>

  
    <script type="text/javascript" src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
     <script src="scripts/Chart.js" type="text/javascript"></script>

</body>
    </html>







