<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AccessoryIssues</title>
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
<!------------------------ JavaScript ----------------------->
<script type="text/javascript">
	$(document).ready(function() {
		$('#example').DataTable();
	});
	
</script>
<script>
/*  delete javascript code here*/
function showModal(accessoryIssueId){			
	document.getElementById("delete-data").id.value=accessoryIssueId;
		$("#deleteAccessoryIssue").modal("show");
}
</script>
<!-----------------CSS code here  ----------- -->
<style>
.model-header {
	padding: 5px;
	text-align: center;
}

.model-footer {
	padding: 5px;
	text-align: right;
	    margin-right: -100%;
}
</style>
</head>
<body>
	<jsp:include page="navigation.jsp">
		<jsp:param value="accessory" name="selectedNav" />
	</jsp:include>
	<div style="overflow-x: auto; width: 100%; font-size: 0.9vw;"
		class="container">
		<h2
			style="text-align: center; color: #4075DC; text-shadow: 2px 2px 4px #000000; margin-top: 20px; font-size: 35px;">
			Accessory Issue</h2>
			<a href="pdf" class="btn btn-primary fa fa-file-pdf-o" style="float: right; margin-top: -30px;"> Generate Report</a>
		<hr>
		<table id="example" class="table ">
			<thead>
				<tr>
					<th>#</th>
					<th>Accessory</th>
					<th>Issue To(Employee)</th>
					<th>Issue To(Non-Employee)</th>
					<th>Issue Date</th>
					<th>Issue Qty</th>
					<th>Remark Purpose</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${accessoryIssuesList}" var="accessoryIssueObj">
					<c:if test="${accessoryIssueObj != null}">
						<tr>
							<td>${accessoryIssueObj.id}</td>
							<td>${accessoryIssueObj.accessory.name}</td>
							<td>${accessoryIssueObj.issuedToEmployee.firstName}</td>
							<td>${accessoryIssueObj.issuedToNonEmployee}</td>
							<td>${accessoryIssueObj.issueDate}</td>
							<td>${accessoryIssueObj.issueQuantity}</td>
							<td>${accessoryIssueObj.remark}</td>
							<td style="display: inline-flex; font-size: 0.9vw;"><a
								href='open_update_accessory_issue?accessoryIssueId=${accessoryIssueObj.id}'
								class="btn btn-secondary fa fa-edit"
								style="margin-left: 5px; font-size: 1vw;">Edit</a>
								<button type="button" class="btn btn-danger fa fa-trash"
									data-bs-toggle="modal" data-bs-target="#deleteAccessoryIssue"
									style="margin-left: 5px; font-size: 1vw;"
									onclick="showModal(${accessoryIssueObj.id})">Delete</button></td>

						</tr>
					</c:if>
				</c:forEach>
			</tbody>

		</table>
	</div>
	<!--  add accessoryIssue code -->
	<a href="open_accessory_issue" class="btn btn-primary" 
		style="margin: 50px; margin-left: 45%; font-size: 0.9vw;">Create
		New</a>

	<!-- delete accessory code start here  -->
	<!-- Modal -->
	<div class="modal fade" id="deleteAccessoryIssue">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="model-header">
					<h4>Delete AccessoryIssue</h4>
				</div>
				<hr>
				<div class="modal-body">
					<h2 class="fa fa-exclamation-triangle"
						style="margin-left: 40%; color: #EDD73B; font-size: 4vw;"></h2>
					<h5 class="text-center">Are You Sure Delete this Asset..</h5>
					<p class="text-center">Can't be undo</p>
				</div><hr>
				<form action="delete_accessory_issue" id="delete-data">
					<!-- Id:<input class="form-control form-control-sm" name="id"> -->
					<div class="row mb-3">
						<label for="name" class="col-md-3 col-form-label "
							style="font-weight: bold; font-size: 1.3vw; display: none;">Id :</label>
						<div class="col-md-9">
							<input type="hidden"class="form-control form-control-sm" name="id">
						</div>
					</div>
					
					<div class="model-footer">
						<button type="button" class="btn btn-secondary fa fa-times "
								data-bs-dismiss="modal" style="font-size: 1vw;"> No</button>
							<button type="submit" class="btn btn-primary fa fa-check"
								style="font-size: 1vw;"> Yes</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
	var save="${param.saved}";
	if(save=="save/update"){
		swal("Saved :)","Saved/Update successfully..","success");
		}
	var deleted="${param.deleted}";
	if(deleted=="delete"){
		swal("Delete","Deleted  successfully..","success");
		}
	var qty="${param.qty}";
	if(qty=="Qty"){
		swal("Sorry :(","This Accessory Quantity less than","error");
		}
	</script>
	<%@ include file="footer.jsp"%>
</body>
</html>