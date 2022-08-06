<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>VIEW PAGE</title>
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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.ModelContent {
	background-color: white;
	margin: 5px;
	padding: 10px;
	align-content: flex-end;
	font-size: 1.2vw;
}

.model-header {
	padding: 5px;
	text-align: center;
}

.model-footer {
	padding: 5px;
	text-align: right;
}
</style>
</head>
<body>
	<jsp:include page="navigation.jsp">
		<jsp:param value="profile-menu" name="selectedNav" />
	</jsp:include>
	<div style="overflow-x: auto; width: 100%; font-size: 1.2vw;"
		class="container">
		<h2
			style="text-align: center; color: #4075DC; text-shadow: 2px 2px 4px #000000; margin-top: 50px; font-size: 35px;">
			Employee Detail</h2>
		<!--  add assets code -->
		<a href="open_employee" class="btn btn-primary"
			style="margin-left: 5px; float:left;margin-top:-30px; font-size: 0.9vw;">Create
			New</a>
		<hr>
		<table id="example" class="table ">
			<thead>
				<tr>
					<th>Id</th>
					<th>Email</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<!-- loop over and print our customers -->
				<c:forEach var="empObj" items="${employeeList}">
					<c:if test="${empObj!= null}">

						<tr>
							<td>${empObj.employeeId}</td>
							<td>${empObj.email}</td>
							<td>${empObj.firstName}</td>
							<td>${empObj.lastName}</td>
							<td style="display: inline-flex; font-size: 0.9vw;"><a
								href='editEmployee?empId=${empObj.employeeId}'
								class="btn btn-secondary fa fa-edit"
								style="margin-left: 5px; font-size: 0.9vw;">Edit</a>
								<button type="button" class="btn btn-danger fa fa-trash"
									data-bs-toggle="modal" data-bs-target="#deleteEmployee"
									onclick="showDeleteModel(${empObj.employeeId})"
									style="margin-left: 5px; font-size: 0.9vw;">Delete</button></td>

						</tr>
					</c:if>
				</c:forEach>
			</tbody>

		</table>
	</div>




	<!-- delete asset code start here  -->
	<!-- Modal -->
	<div class="modal fade" id="deleteEmployee">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Delete Assets</h4>
				</div>
				<div class="modal-body">Are you sure delete this Employee..</div>
				<form action="delete_employee_by_Id" id="delete-data">
					<div class="row mb-3 ml-2">
						<label for="id" class="col-md-3 col-form-label"
							style="display: none;">Id : </label>
						<div class="col-md-8">
							<input type="hidden" class="form-control form-control-sm"
								name="id">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-dark"
								data-bs-dismiss="modal">No</button>
							<button type="submit" class="btn btn-primary">Yes</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- JavaScript -->
	<script>
		function showDeleteModel(empId){			
			document.getElementById("delete-data").id.value=empId;
			alert(id)
			$("#deleteEmployee").modal("show");

			}
		
</script>
	<!-- end delete employee code here -->

	<!-- table scripting code -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#example').DataTable();
		});
	</script>

	<script>
		var save="${param.saved}"
		if(save=="savedSuccessfully"){
			swal("Saved","saved successfully..","success");
		}
</script>



</body>

</html>