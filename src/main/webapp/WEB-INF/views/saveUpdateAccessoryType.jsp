<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>EditAccessory Type</title>
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
.formerror, #s1{
	color: red;
}
.error {
	color: #ff0000;
}
</style>
</head>
<body>
	<!-- The Modal -->
	<div class="modal fade" id="edit-modal-content"
		style="width: 100%; font-size: 1vw; font-weight: bold;">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="model-header">
					<h3>Accessory Type</h3>
				</div>
				<hr>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="container">
						<form:form onsubmit="return validForm()" action="save_accessory_type" method="post"
							modelAttribute="accessoryType">

							<div class="row mb-3">
								<c:if test="${accessoryType!=null }">
									<label for="id" class="col-md-2 col-form-label" style="display: none;">Id :</label>
									<div class="col-md-9">
										<input type="hidden"class="form-control form-control-sm" readOnly name="id"
											id="id" value="${accessoryType.id} ">
									</div>
								</c:if>
								</div>
							<div class="row mb-3">
								<label for="typeName" class="col-md-2 col-form-label">Name
									<span class="text-danger">*</span> </label>
								<div class="col-md-9" id="accessoryTypeName">
									<input type="text" class="form-control form-control-sm"
									oninput="validName()" placeholder="Name"
										name="typeName" id="typeName"
										value="${accessoryType.typeName}">
									<form:errors path="typeName" cssClass="error" />
									<span id="s1"></span><b><span class="formerror"></span></b>
								</div>
							</div>
							<div class="row mb-3">
								<label for="parent_type" class="col-md-2 col-form-label">ParentType
								</label>
								<div class="col-md-9">
									<form:select class="form-select  form-select-sm"
										path="parentType">
										<option  value="${accessoryType.parentType}">${accessoryType.parentType}</option>
										<c:forEach items="${parentTypeList}" var="parentType">
											<c:if test="${parentType!=null}">
												<form:option value="${parentType}" label="${parentType}"></form:option>
											</c:if>
										</c:forEach>
									</form:select>
									<form:errors path="parentType" cssClass="error" />
								</div>
							</div>
							<hr>
							<!-- Modal footer -->
							<div class="model-footer">
								<a href="../admin/accessory_type_view" class="btn btn-secondary "
									style="font-size: 1vw;">Close</a>

								<button type="submit" class="btn btn-primary"
									style="font-size: 1vw;">save</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#edit-modal-content").modal('show');
		});
	</script>
	<script>
	//---validation javascript code---------------name
	function validName(){ 
	  let name = document.forms['accessoryType']["typeName"].value;
	if (name.search(/[0-9]/)>=0){
	  document.getElementById("s1").innerHTML="*dont use numbers value";  
	}else if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
	    document.getElementById("s1").innerHTML="*don't use symbolic character";
	}
	else{
	    document.getElementById("s1").innerHTML="";
	}
	}
	//-----------------
	function clearErr(){
	errors = document.getElementsByClassName('formerror');
	for(let item of errors)
	{
	    item.innerHTML = "";
	}
	} function seterr(id, error){
	element = document.getElementById(id);
	element.getElementsByClassName("formerror")[0].innerHTML = error;

	}
	function validForm(){
	clearErr();
	let name = document.forms['accessoryType']["typeName"].value;
	if (name.length == 0){
	    seterr("accessoryTypeName", "* name cannot be empty!");
	    return false;
	}if (name.length<2){
	    seterr("accessoryTypeName", "*Name should have char between 2-10");
	    return false;
	}
	if (name.length>10){
		    seterr("accessoryTypeName", "* name too long **Name should have char between 2-10");
		    return false;
		}
	if (name.search(/[0-9]/)>=0){
		 seterr("accessoryTypeName", "*please enter string type name not enter number");
		 return false;
	}
	if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
		 seterr("accessoryTypeName", "*name is not symbol");
		 return false;
	 } else{
			return true;
		 }	
	}
	  </script>
</body>
</html>