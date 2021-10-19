<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModalDialog.aspx.cs" Inherits="ModalDialog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

 
   


     
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/Style.css" />

     <!-- Datatable JS -->
    <%-- <script src="DataTables/datatables.min.js"></script>--%>
     
    <script>
        $(document).ready(function () {
           
            $("#myModal").modal("show");
           
        });
            
     </script>
</head>
<body>

     <div id="nav-placeholder">

    </div>
    <form id="form1" runat="server">
      <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-confirm">
		<div class="modal-content modaledit">
			<div class="modal-header justify-content-center">
				<div class="icon-box">
					<i class="material-icons">&#xE876;</i>
				</div>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body text-center">
				<h4>Great! <span id='my' class="badge badge-primary">Primary</span></h4>	
				<p>Your account has been created successfully.</p>
				<button class="btn btn-success" data-dismiss="modal"><span>Start Exploring</span> <i class="material-icons">&#xE5C8;</i></button>
			    <button type="button" class="btn btn-warning" id="PrintReceipt"  data-dismiss="modal"><i class="glyphicon glyphicon-print" style="font-size:20px"></i>  Print</button>
			
             <button type="button" class="btn btn-success"  ID="btnAdd_Student" ><span class="glyphicon glyphicon-save-file"></span> Save Data</button>
                   <%--<button type="button" ID="btnAdd_Student" Text="Save Data" runat="server" class="btn btn-primary" />--%>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Close</button>
    
            </div>
		</div>
	</div>
</div>     
    </form>

    
</body>


     
    
    <script>


      $('#txtDate').datetimepicker({
            step: 5 ,
            
            format:'d/M/Y',
                      
          
      
          
      });
     
  </script>
</html>
