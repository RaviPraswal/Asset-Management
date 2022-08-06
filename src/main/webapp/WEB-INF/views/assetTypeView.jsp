<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Assets Type</title>
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
	text-align: right;
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
			Asset Type</h2>
		<!--  add assets code -->
		<a href='save_update_view' class="btn btn-primary"
			style="margin-top: -30px; margin-left:5px; float:left; font-size: 1vw;">Create
			New</a>
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
				<c:set var="assetTypeList" value='${requestScope["assetTypeList"]}' />
				<c:if test="${assetTypeList != null}">
					<c:forEach items="${assetTypeList}" var="assetTypeobj">
						<tr>
							<td>${assetTypeobj.id}</td>
							<td>${assetTypeobj.typeName}</td>
							<td>${assetTypeobj.parentType}</td>

							<td style="display: inline-flex; font-size: 0.9vw;"><a
								href='open_update_form?assetTypeId=${assetTypeobj.id}'
								class="btn btn-secondary fa fa-edit"
								style="margin-left: 5px; font-size: 0.9vw;">Edit</a>
								<button type="button" class="btn btn-danger fa fa-trash"
									data-bs-toggle="modal" data-bs-target="#deleteAssetType"
									onclick="showDeleteModel(${assetTypeobj.id})"
									style="margin-left: 5px; font-size: 1vw;">Delete</button></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>



	<!-- delete asset code start here  -->
	<!-- Modal -->
	<div class="modal fade" id="deleteAssetType" role="dialog"
		data-backdrop="false">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="model-header">
					<h4>Delete Assets</h4>

				</div>
				<hr>
				<div class="modal-body">
					<h2 class="fa fa-exclamation-triangle"
						style="margin-left: 40%; color: #EDD73B; font-size: 4vw;"></h2>
					<h5 class="text-center">Are You Sure Delete this Asset type..</h5>
					<p class="text-center">Can't be undo</p>
				</div>
				<hr>
				<form:form action="delete_asset_type" id="delete-data">
					<div class="row mb-3">
						<label for="name" class="col-md-3 col-form-label "
							style="font-weight: bold; margin-left: 20px; display: none;">Id
							:</label>
						<div class="col-md-8">
							<input type="hidden" class="form-control form-control-sm"
								name="id">
						</div>
					</div>

					<div class="model-footer">
						<button type="button" class="btn btn-secondary fa fa-times "
							data-bs-dismiss="modal" style="font-size: 1vw;">No</button>
						<button type="submit" class="btn btn-primary fa fa-check"
							style="font-size: 1vw;">Yes</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<!-- JavaScript -->

	<script>
	var assetTypeId="${assetTypeobj.id}";
		function showDeleteModel(assetTypeId){			
			document.getElementById("delete-data").id.value=assetTypeId;
			$("#deleteAssetType").modal("show");

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


	<!-- table scripting code -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#example').DataTable();
		});
		
	</script>
	<%@ include file="footer.jsp"%>
</body>

</html>