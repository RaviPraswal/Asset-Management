<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Accessory Type</title>
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
.ModelContent {
	background-color: white;
	margin: 10px;
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
	text-align: left;
	   margin-left: 20rem;
}
</style>
</head>
<body>
	<jsp:include page="navigation.jsp">
		<jsp:param value="configuration" name="selectedNav" />
	</jsp:include>
	<div style="width: 100%; font-size: 1.2vw;" class="container">
		<h2
			style="text-align: center; color: #4075DC; text-shadow: 2px 2px 4px #000000; margin-top: 20px; font-size: 35px;">
			Accessory Type</h2>
		<hr>
		<table id="example" class="table ">
			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Parent Type</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="accessoryTypeList"
					value='${requestScope["accessoryTypeList"]}' />
				<c:if test="${accessoryTypeList != null}">
					<c:forEach items="${accessoryTypeList}" var="accessoryTypeobj">
						<tr>
							<td>${accessoryTypeobj.id}</td>
							<td>${accessoryTypeobj.typeName}</td>
							<td>${accessoryTypeobj.parentType}</td>

							<td style="display: inline-flex; font-size: 0.9vw;"><a
								href='open_update_form?accessoryTypeId=${accessoryTypeobj.id}'
								class="btn btn-secondary fa fa-edit"
								style="margin-left: 5px; font-size: 0.9vw;">Edit</a>
								<button type="button" class="btn btn-danger fa fa-trash"
									data-bs-toggle="modal" data-bs-target="#deleteAccessoryType"
									onclick="showDeleteModel(${accessoryTypeobj.id})"
									style="margin-left: 5px; font-size: 1vw;">Delete</button></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
	
	<a href='save_update_view' class="btn btn-primary"
		style="margin: 50px; margin-left: 45%; font-size: 1vw;">Create New</a>

	
	<!-- delete accessory code start here  -->
	<!-- Modal -->
	<div class="modal fade" id="deleteAccessoryType">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="model-header">
					<h4>Delete Accessory Type</h4>
				</div>
				<hr>
				<div class="modal-body">
					<h2 class="fa fa-exclamation-triangle"
						style="margin-left: 40%; color: #EDD73B; font-size: 4vw;"></h2>
					<h5 class="text-center">Are You Sure Delete this Accessory type..</h5>
					<p class="text-center">Can't be undo</p>
				</div>
				<hr>
				<form:form action="delete_accessory_type" id="delete-data">
					<div class="row mb-3">
						<label for="id" class="col-md-3 col-form-label "
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
				</form:form>
			</div>
		</div>
	</div>
	<!-- JavaScript -->

	<script>
	var accessoryTypeId="${accessoryTypeobj.id}";
		function showDeleteModel(accessoryTypeId){			
			document.getElementById("delete-data").id.value=accessoryTypeId;
			$("#deleteAccessorys").modal("show");

			}
		
</script>

	<!-- end delete accessory code here -->

	<!-- table scripting code -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#example').DataTable();
		});
		
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