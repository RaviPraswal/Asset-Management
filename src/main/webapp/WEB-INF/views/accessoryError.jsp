<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>error</title>
<link
	href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css"
	rel="styleshet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<style>
.model-header {
	padding: 5px;
	text-align: center;
	color: red;
}

.model-footer {
	padding: 5px;
	text-align: right;
}
</style>
</head>
<body>
	<div class="modal fade" id="deleteAccessory">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="model-header">
					<h1>Error!</h1>

				</div>
				<hr>
				<div class="modal-body">
					<h2 class="far fa-times-circle"
						style="margin-left: 40%; color: red; font-size: 5vw;"></h2>
					<h3 class="text-center">${existId}</h3>
				</div>
				<hr>

				<div class="model-footer">
					<a href="../admin/accessory_view" class="btn btn-secondary"
									style="font-size: 1vw;"> Close</a>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#deleteAccessory").modal('show');
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("body").click(function (){
				window.location.href="../admin/accessory_view";
			});
			
		});
	</script>

</body>
</html>