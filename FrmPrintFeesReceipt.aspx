<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmPrintFeesReceipt.aspx.cs" Inherits="FrmPrintFeesReceipt" %>



<%@ Register TagPrefix="CR" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>





<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

 
   


  

<!--<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->
    
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/Style.css" />
   
    <script>

       
        $(document).ready(function () {

            $("#btnPrint").click();


            $('#btnHome').click(function () {
           
                window.history.back();
                //window.location.href = 'FrmPrintFeesReceipt.aspx';
            });
        });
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <button type="button" class="btn btn-success small " id="btnPrint"  onclick="Print()"> <i class="glyphicon glyphicon-print" style="font-size:20px"></i>  Print</button>
            <button type="button" class="btn btn-primary small " id="btnHome"  onclick="GoHome()"> <i class="glyphicon glyphicon-home" style="font-size:20px"></i>  Back</button>
              
        </div>
        <br />
    <div id="dvReport" >
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" ToolPanelView="None" PageZoomFactor="85" HasCrystalLogo="False" HasDrilldownTabs="False" HasDrillUpButton="False" HasExportButton="False" HasGotoPageButton="False" />
    </div>
    <br />
    
    <script type="text/javascript">
        function Print() {
            var dvReport = document.getElementById("dvReport");
            var frame1 = dvReport.getElementsByTagName("iframe")[0];
            if (navigator.appName.indexOf("Internet Explorer") != -1 || navigator.appVersion.indexOf("Trident") != -1) {
                frame1.name = frame1.id;
                window.frames[frame1.id].focus();
                window.frames[frame1.id].print();
            }
            else {
                var frameDoc = frame1.contentWindow ? frame1.contentWindow : frame1.contentDocument.document ? frame1.contentDocument.document : frame1.contentDocument;
                frameDoc.print();
            }
        }


     
    </script>
       
    </form>
</body>
</html>


