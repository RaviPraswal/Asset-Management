
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Asset Assignment</title>
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
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.model-header {
	padding: 5px;
	text-align: center;
}

.model-footer {
	padding: 5px;
	text-align: right;
	    margin-left: 85px;
}
</style>
</head>
<body>
	<jsp:include page="navigation.jsp">
		<jsp:param value="asset" name="selectedNav" />
	</jsp:include>
	<div style="overflow-x: auto; width: 100%; font-size: 0.9vw;"
		class="container-fluid">
		<h2
			style="text-align: center; color: #4075DC; text-shadow: 2px 2px 4px #000000; margin-top: 20px; font-size: 35px;">
			Asset Assignment</h2>
			<a href="pdf" class="btn btn-danger fa fa-file-pdf-o" style="float: right; margin-top: -30px;"> Generate Report</a>
		<hr>
		<table id="example" class="table ">
			<thead>
				<tr>
					<th>#</th>
					<th>Asset</th>
					<th>Employee</th>
					<th>Issue Date</th>
					<th>Issue Condition</th>
					<th>Return date</th>
					<th>Return Condition</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${assetAssignmentList}"
					var="assetAssignmentListObj">
					<c:if test="${assetAssignmentListObj !=null}">
						<tr>
							<td>${assetAssignmentListObj.id}</td>
							<td>${assetAssignmentListObj.asset.name}</td>
							<td>${assetAssignmentListObj.employee.firstName}</td>
							<td>${assetAssignmentListObj.issueDate}</td>
							<td>${assetAssignmentListObj.issueCondition}</td>
							<td>${assetAssignmentListObj.returnDate}</td>
							<td>${assetAssignmentListObj.returnCondition}</td>
							<td>${assetAssignmentListObj.status}</td>
							<td style="display: inline-flex; font-size: 0.9vw;"><a
								href='open_update_asset_assignment_form?assetAssignmentId=${assetAssignmentListObj.id}'
								class="btn btn-secondary fa fa-edit"
								style="margin-left: 5px; font-size: 0.9vw;">Edit</a>
								<button type="button" class="btn btn-danger fa fa-trash"
									data-bs-toggle="modal" data-bs-target="#deleteAssetAssignment" onclick="showModal(${assetAssignmentListObj.id})"
									style="margin-left: 5px; font-size: 0.9vw;">Delete</button></td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!--  add assets code -->
	<a href="open_asset_assignemnt" class="btn btn-primary" 
		style="margin: 50px; margin-left: 45%; font-size: 0.9vw;">Create
		New</a>

	<!-- Modal -->
	<div class="modal fade" id="deleteAssetAssignment">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="model-header">
					<h4 class="modal-title">Delete Assets</h4>
				</div>
				<hr>
				<div class="modal-body fa-solid fa-circle-question">
					<h2 class="fa fa-exclamation-triangle"
						style="margin-left: 40%; color: #EDD73B; font-size: 4vw;"></h2>
					<h5 class="text-center">Are You Sure Delete this Asset..</h5>
					<p class="text-center">Can't be undo</p>
				</div>
				<hr>
				<form action="delete_asset_assignment" id="delete-data">
					<div class="row mb-3 ml-2">
						<label for="id" class="col-md-3 col-form-label" style="display: none;">Id : </label>
						<div class="col-md-8">
							<input type="hidden"class="form-control form-control-sm" name="id">
						</div>
						<div class="model-footer">
							<button type="button" class="btn btn-secondary fa fa-times "
								data-bs-dismiss="modal" style="font-size: 1vw;"> No</button>
							<button type="submit" class="btn btn-primary fa fa-check"
								style="font-size: 1vw;"> Yes</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#example').DataTable();
		});
	</script>
	<script>
		function showModal(assetAssignmentId){			
			document.getElementById("delete-data").id.value=assetAssignmentId;
			$("#deleteAssetAssignment").modal("show");

			}
</script>
<script>
	var save="${param.saved}";
	if(save=="save/update"){
		swal("Saved :)","Saved/Update successfully..","success");
		}
	var deleted="${param.deleted}";
	if(deleted=="delete"){
		swal("Delete","Deleted  successfully..","success");
		}
	</script>
	<%@ include file="footer.jsp"%>
</body>
</html>