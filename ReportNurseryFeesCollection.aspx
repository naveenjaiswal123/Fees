<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportNurseryFeesCollection.aspx.cs" Inherits="ReportNurseryFeesCollection" %>

<%@ Register TagPrefix="CR" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    

    <title>Fees Collection Report Nursery</title>
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
          //var class_name, section_name;
          //$("#drClass").val(class_name);
          //$("#drSection").val(section_name);
          var student_array = [];
         
          $("#nav-placeholder").load("nav.html");

          $("#btnShowFees").click(function (e) {

              var fromdate = new Date($("#txtFromDate").val());
              var todate = new Date($("#txtToDate").val());

              if (($("#txtFromDate").val() == "")) {
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
              
          });


          //$.ajax({
          //    url: 'ReportNurseryFeesCollection.aspx/GetData',
          //    type: 'post',
          //    contentType: 'application/json;charset=utf-8',
          //    dataType: 'json',
          //    data: "{}",
          //    success: function (_data) {
          //        _data = JSON.parse(_data.d);
          //        //  alert(_data);
          //        $("#drSection").append($('<option/>').attr("value", "All").text("All"));
          //        $("#drClass").append($('<option/>').attr("value", "All").text("All"));
          //        //  alert(_data.length);
          //        for (var i = 0; i < _data.length; i++) {
          //            //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
          //            $("#drClass").append($('<option/>').attr("value", _data[i].Class).text(_data[i].Class));

          //        }
              


          //    },
          //    failure: function (response) {
          //        alert("Fail");
          //    },
          //    error: function (response) {
          //        alert(response.responseText);
          //    }

          //});


          //$("#drClass").change(function (e) {

          //    //$("#drAdmissionNo option").remove();
          //    //$("#drStudentName option").remove();
          //    //$("#drMonth").selectedIndex = 0;
          //    $("#drSection option").remove();
             
          //    $.ajax({
          //        type: "POST",
          //        url: "ReportNurseryFeesCollection.aspx/GetSection",
          //        contentType: "application/json; charset=utf-8",
          //        //data: '{distt_name: "' + $(this).val() + '" }',
          //        data: '{"class_name":"' + $("#drClass").val() + '"}',
          //        dataType: "json",
          //        success: function (_data) {
          //            _data = JSON.parse(_data.d);
          //            // alert(_data);

                    
          //            $("#drSection option").remove();
          //             $("#drSection").append($('<option/>').attr("value", "All").text("All"));

          //            for (var i = 0; i < _data.length; i++) {
          //                //   options += '<option value="' + _data[i].Tehsil + '">' + _data[i].Tehsil + '</option>';
          //                $("#drSection").append($('<option/>').attr("value", _data[i].section).text(_data[i].section));
          //            }
          //            //class_name = $("#drClass").val();
          //            //section_name = $("#drSection").val();

          //        },
          //        failure: function (response) {
          //            alert("Fail");
          //        },
          //        error: function (response) {
          //            alert(response.responseText);
          //        }

          //    });
          //});

          


      });
  </script>


</head>


<body>

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

                                      <div class="row">
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-12">
                                            <div class="form-group">
                                              
                                               
                                                   <div class="select-option">


                                                       <asp:DropDownList ID="ddlClass" runat="server" class="form-control " ForeColor="#6666FF" AutoPostBack="True" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                                                            
                                                        </asp:DropDownList>

                                                   
                                                </div>
                                                
                                            </div>
                                        </div>

                                       
                                           <div class="col-lg-2 col-md-2 col-sm-2 col-12">
                                               <div class="form-group">
                                              
                                               <div class="select-option">


                                                       <asp:DropDownList ID="ddlSection" runat="server" class="form-control " ForeColor="#6666FF" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged">
                                                            
                                                        </asp:DropDownList>

                                                   
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-2 col-md-2 col-sm-2 col-12">
                                            <div class="form-group">
                                           

                                                <asp:TextBox ID="txtFromDate"  runat="server" class="form-control  "
                                                    placeholder="From Date dd/MM/yyyy " />

                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-12">
                                            <div class="form-group">
                                           

                                                <asp:TextBox ID="txtToDate" runat="server" class="form-control  "
                                                    placeholder="To Date dd/MM/yyyy " />

                                          </div>
                                        </div>

                                       <div class="col-lg-2 col-md-2 col-sm-2 col-12">
                                            <div class="form-group">
                                              
                                                <div class="select-option">


                                                       <asp:DropDownList ID="drTransaction" runat="server" class="form-control " ForeColor="#6666FF">
                                                            <asp:ListItem>All</asp:ListItem>
                                                            <asp:ListItem>Cash</asp:ListItem>
                                                            <asp:ListItem>On Line</asp:ListItem>
                                                            <asp:ListItem>Card Swipe</asp:ListItem>
                                                            <asp:ListItem>Adjustment</asp:ListItem>
                                                        </asp:DropDownList>

                                                   
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-12">
                                            
                                            <asp:Button ID="btnShowFees" Text="Show Fees Details" runat="server" Class="btn btn-primary" OnClick="btnShowFees_Click"   />
                                        </div> 

                                    </div>
                                         <div class="row">
                                                 <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
                                                Height="1000" Width="1240" BestFitPage="False" ToolPanelView="None" EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" HasToggleGroupTreeButton="False" OnInit="CrystalReportViewer1_Init"  />
                                         </div>
                              
                                </div>
                            </div>
                        </div>
                    </div>
             </section>
    </form>

    <script src="js/jquery.js"></script>
    <script src="scripts/bootstrap/bootstrap.min.js"></script>

    <script src="jquery-ui-1.12.1/jquery-ui.js"></script>  
         <script src="scripts/jquery.dataTables.min.js"></script>
     <script src="DateCalender/jquery.js"></script>
    <script src="DateCalender/jquery.datetimepicker.full.js"></script>
    
  <script>


      $('#txtToDate').datetimepicker({
            step: 5 ,
            
            format:'d/M/Y',
                      
          
      
          
      });

      $('#txtFromDate').datetimepicker({
          step: 5,

          format: 'd/M/Y',




      });
     
  </script>

</body>
    </html>