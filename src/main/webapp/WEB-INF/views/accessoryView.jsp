<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Accessory</title>
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

input[type="file"] {
	z-index: -1;
	position: absolute;
	opacity: 0;
}
</style>
</head>
<body>
	<jsp:include page="navigation.jsp">
		<jsp:param value="accessory" name="selectedNav" />
	</jsp:include>
	<div style="overflow-x: auto; width: 100%; font-size: 1vw;"
		class="container">
		<h2
			style="text-align: center; color: #4075DC; text-shadow: 2px 2px 4px #000000; margin-top: 20px; font-size: 35px;">
			Accessory</h2>
		<!--  add assets code -->
		<a href="open_accessory_view" class="btn btn-primary"
			style="margin-left: 5px; font-size: 1.3vw; color: white">Create
			New</a> <span style="font-size: 1.3vw;">&nbsp;| &nbsp;</span>
		<form:form action="importExcel" method="POST"
			enctype="multipart/form-data" style="display:inline;">
			<input type="file" id="file" name="excelFile" multiple="multiple">
			<label for="file"
				style="margin-left: 5px; font-size: 1.3vw; color: green;">Import
				to Excel</label>
			<button type="submit" style="font-size: 1.3vw; color: green"
				class="fa fa-plus"></button>
		</form:form>
		<!-- <a href="importExcel"style="margin-left: 5px; font-size: 1.3vw; color: #4075DC; margin-top: -30px;">Import to Excel</a> -->
		<a href="exportExcel"
			style="margin-right: 5px; float: right; font-size: 1.3vw; color: green;"
			class="fas fa-file-excel"> Export to Excel</a>
		<hr>
		<table id="example" class="table ">
			<thead>
				<tr>
					<th>#</th>
					<th>Sku Number</th>
					<th>Name</th>
					<th>Purchase date</th>
					<th>Unit Cost</th>
					<th>Purchase Qty</th>
					<th>Bill Document</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${accessoryList}" var="accessoryObj">
					<c:if test="${accessoryObj != null}">
						<tr>
							<td>${accessoryObj.id}</td>
							<td>${accessoryObj.skuNumber}</td>
							<td>${accessoryObj.name}</td>
							<td>${accessoryObj.purchaseDate}</td>
							<td>${accessoryObj.cost}</td>
							<td>${accessoryObj.purchaseQuantity}</td>
							<td><c:if test="${accessoryObj.billFileId!=null}">
									<a href="bill_download/${accessoryObj.billFileId}"><i
										class="fas fa-arrow-circle-down"
										style="margin-left: 30px; color: blue; font-size: 1vw;"></i></a>
								</c:if>
								<c:if test="${accessoryObj.billFileId==null}">
								<i class="fa fa-times" aria-hidden="true" style="margin-left: 30px; font-size: 1vw;"></i>
								</c:if>
								</td>
							<td style="display: inline-flex; font-size: 0.9vw;"><a
								href='open_update_accessory_form?accessoryId=${accessoryObj.id}'
								class="btn btn-secondary fa fa-edit"
								style="margin-left: 5px; font-size: 0.9vw;">Edit</a>
								<button type="button" class="btn btn-danger fa fa-trash"
									data-bs-toggle="modal" data-bs-target="#deleteAccessory"
									style="margin-left: 5px; font-size: 0.9vw;"
									onclick="showModal(${accessoryObj.id})">Delete</button></td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!--  add assets code -->
	<!-- <a href="open_accessory_view" class="btn btn-primary" 
		style="margin: 50px; margin-left: 45%; font-size: 1vw;">Create
		New</a> -->


	<!-- delete asset code start here  -->
	<!-- Modal -->
	<div class="modal fade" id="deleteAccessory">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="model-header">
					<h4 class="modal-title">Delete Accessory</h4>
				</div>
				<hr>
				<div class="modal-body">
					<h2 class="fa fa-exclamation-triangle"
						style="margin-left: 40%; color: #EDD73B; font-size: 4vw;"></h2>
					<h5 class="text-center">Are You Sure Delete this Accessory..</h5>
					<p class="text-center">Can't be undo</p>
				</div>
				<hr>
				<form:form action="delete_accessory" id="delete-data">
					<div class="row mb-3 ml-2">
						<label for="id" class="col-md-3 col-form-label"
							style="display: none;">Id : </label>
						<div class="col-md-8">
							<input type="hidden" class="form-control form-control-sm"
								name="id">
						</div>

						<div class="model-footer">
							<button type="button" class="btn btn-secondary fa fa-times "
								data-bs-dismiss="modal" style="font-size: 1vw;">No</button>
							<button type="submit" class="btn btn-primary fa fa-check"
								style="font-size: 1vw;">Yes</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<!-- JavaScript -->
	<!--  delete code here -->
	<script>
		function showModal(accessoryId){	
			document.getElementById("delete-data").id.value=accessoryId;
			$("#deleteAccessory").modal("show");

			}
	</script>

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