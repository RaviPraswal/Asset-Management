<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Assets</title>
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
	margin-left: 90%;
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
		<jsp:param value="asset" name="selectedNav" />
	</jsp:include>
	<div style="overflow-x: auto; width: 100%; font-size: 0.9vw;"
		class="container-fluid">
		<h2
			style="text-align: center; color: #4075DC; text-shadow: 2px 2px 4px #000000; margin-top: 20px; font-size: 35px;">
			Assets</h2>
		<!--  add assets code -->
		<a href="open_asset_view" class="btn btn-primary
		"
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
					<th>Description</th>
					<th>Model</th>
					<th>Purchase date</th>
					<th>Warranty date</th>
					<th>Cost</th>
					<th>Vender</th>
					<th>Bill Number</th>
					<th>Bill document</th>

					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${assetList}" var="assetObj">
					<c:if test="${assetObj != null}">
						<tr>
							<td>${assetObj.id}</td>
							<td>${assetObj.skuNumber}</td>
							<td>${assetObj.name}</td>
							<td>${assetObj.description}</td>
							<td>${assetObj.model}</td>
							<td>${assetObj.purchaseDate}</td>
							<td>${assetObj.waranty}</td>
							<td>${assetObj.cost}</td>
							<td>${assetObj.vendor}</td>
							<td>${assetObj.billNo}</td>
							<td><c:if test="${assetObj.billFileId!=null}">
									<a href="bill_download/${assetObj.billFileId}"><i
										class="fas fa-arrow-circle-down"
										style="margin-left: 30px; color: blue; font-size: 1vw;"></i></a>
								</c:if>
								<c:if test="${assetObj.billFileId==null}">
								<i class="fa fa-times" aria-hidden="true" style="margin-left: 30px; font-size: 1vw;"></i>
								</c:if>
								</td>

							<td style="display: inline-flex; font-size: 0.9vw;"><a
								href='open_update_form?assetId=${assetObj.id}'
								class="btn btn-secondary fa fa-edit"
								style="margin-left: 5px; font-size: 0.9vw;"> Edit</a>
								<button type="button" class="btn btn-danger fa fa-trash"
									data-bs-toggle="modal" data-bs-target="#deleteAsset"
									style="margin-left: 5px; font-size: 0.9vw;"
									onclick="showModal(${assetObj.id})">Delete</button></td>
						</tr>
					</c:if>
				</c:forEach>

			</tbody>

		</table>
	</div>



	<!-- delete asset code start here  -->
	<!-- Modal -->
	<div class="modal fade" id="deleteAsset">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="model-header">
					<h4>Delete Assets</h4>
				</div>

				<hr>
				<div class="modal-body fa-solid fa-circle-question">
					<h2 class="fa fa-exclamation-triangle"
						style="margin-left: 40%; color: #EDD73B; font-size: 4vw;"></h2>
					<h5 class="text-center">Are You Sure Delete this Asset..</h5>
					<p class="text-center">Can't be undo</p>
				</div>

				<form action="delete_asset" id="delete-data">
					<div class="row mb-3 ml-2">
						<label for="id" class="col-md-3 col-form-label"
							style="display: none;">Id : </label>
						<div class="col-md-8" style="display: none;">
							<input class="form-control form-control-sm" name="id">
						</div>
						<div class="model-footer">
							<button type="button" class="btn btn-secondary fa fa-times "
								data-bs-dismiss="modal" style="font-size: 1vw;">No</button>
							<button type="submit" class="btn btn-primary fa fa-check"
								style="font-size: 1vw;">Yes</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>


	<!-- JavaScript -->
	<script>
	var aid="${assetObj.id}"
		function showModal(aid){			
			document.getElementById("delete-data").id.value=aid;
			$("#deleteAsset").modal("show");

			}
</script>
	<!-- end delete asset code here -->

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