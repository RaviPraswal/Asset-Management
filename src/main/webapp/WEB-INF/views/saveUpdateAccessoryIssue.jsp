<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AccessoryIssue</title>
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
.model-header {
	padding: 5px;
	text-align: center;
}

.model-footer {
	padding: 5px;
	text-align: right;
}
.error {
	color: #ff0000;
}
.formerror, #s1, #s2,#s, #Emp {
	color: red;
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
					<h3>Accessory Issue</h3>
				</div>
				<hr>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="container">
						<form:form onsubmit="return validForm()"
							action="save_update_accessory_issue" method="post"
							modelAttribute="accessoryIssues">

							<div class="row mb-3">
								<c:if test="${ accessoryIssues!=null}">
									<label for="id" class="col-md-3 col-form-label"
										style="display: none;">Id :</label>
									<div class="col-md-9">
										<input type="hidden" class="form-control form-control-sm"
											readOnly name="id" id="id" value="${accessoryIssues.id} ">
									</div>
								</c:if>
							</div>
							<div class="row mb-2">
								<label for="accessory" class="col-md-3 col-form-label">Accessory<span
									class="text-danger">*</span></label>
								<div class="col-md-9" id="accessory">
									<form:select class=" form-select form-select-sm"
										path="accessory.id" >
										<option selected disabled value="">Select Accessory</option>
										<c:forEach items="${loadAccessory}" var="loadAccessoryObj">
											<c:if test="${loadAccessoryObj!=null}">
												<form:option value="${loadAccessoryObj.id }"
													label="${loadAccessoryObj.name}"></form:option>
											</c:if>
										</c:forEach>
									</form:select>
									<span id="s"></span><b><span class="formerror"> </span></b>
								</div>
							</div>
							<div class="row mb-2">
								<label for="issuedToEmployee" class="col-md-3">Issue
									To(Employee)<span class="text-danger">*</span>
								</label>
								<div class="col-md-9" id="emp" style="display: inline-flex;">
									<input type="radio" name="type" value="employee"
										style="margin-top: 10px; margin-left: -20px;" >
									<form:select class="form-select  form-select-sm"
										path="issuedToEmployee.employeeId" id="issuedToEmployee"
										style="margin-left: 10px;"
										disabled="${true}">
										<option selected disabled value="">Select Employee</option>
										<c:forEach items="${loadEmployee}" var="loadEmployeeObj">
											<c:if test="${loadEmployeeObj!=null}">
												<form:option value="${loadEmployeeObj.employeeId}"
													label="${loadEmployeeObj.firstName}"></form:option>
											</c:if>
										</c:forEach>
									</form:select>
									<span id="Emp"></span><b><span class="formerror"> </span></b>
								</div>
							</div>
							<div class="row mb-1">
								<label for="issuedToNonEmployee" class="col-md-3">Issue
									To(Non-Employee)<span class="text-danger">*</span>
								</label>
								<div class="col-md-9" id="nonEmp" style="display: inline-flex;" >
									<input type="radio" name="type" value="employee"
										style="margin-top: 10px; margin-left: -20px;">
									<input type="text" class="form-control form-control-sm"
										oninput="validNonEmployee()"
										placeholder="Non employee atleast 3 char" id="issuedToNonEmployee"
										name="issuedToNonEmployee"
										value="${accessoryIssues.issuedToNonEmployee}"
										style="margin-left: 10px;" disabled="true">
								</div>
								<span id="s1" class="text-center"></span><b><span class="formerror"> </span></b>
							</div>
							<div class="row mb-2">
								<label for="issueDate" class="col-md-3 col-form-label">Issue
									Date<span class="text-danger">*</span>
								</label>
								<div class="col-md-9" id="date">
									<input type="date" class="form-control form-control-sm"
										value="${accessoryIssues.issueDate}" name="issueDate"
										id="issueDate">
									<form:errors path="issueDate" cssClass="error" />
									<span id="s"></span><b><span class="formerror"> </span></b>
								</div>

								<label for="issueQuantity" class="col-md-3 col-form-label">Issue
									Qty<span class="text-danger">*</span>
								</label>
								<div class="col-md-9" style="margin-top: 10px;" id="issueQty">
									<input type="text" class="form-control form-control-sm"
										placeholder="0" oninput="validIssueQty()" name="issueQuantity"
										id="issueQuantity" value="${accessoryIssues.issueQuantity}">
									<form:errors path="issueQuantity" cssClass="error" />
									<span id="s2"></span><b><span class="formerror"> </span></b>
								</div>
							</div>
							<div class="row mb-1">
								<label for="remark" class="col-md-3 col-form-label">Remark
									Purpose :</label>
								<div class="col-md-9">
									<textarea rows="5" class="form-control form-control-sm"
										placeholder="remark..." name="remark" id="remark"></textarea>

								</div>
							</div>
							<hr>
							<!-- Modal footer -->
							<div class="model-footer">
								<a href="../admin/accessory_issues_view"
									class="btn btn-secondary " style="font-size: 1vw;">Close</a>

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
	document.getElementsByTagName('input')[1].addEventListener('click',function() {
		document.getElementById('issuedToEmployee').removeAttribute('disabled', false);
		document.getElementById('issuedToNonEmployee').setAttribute('disabled', true);
	});
	document.getElementsByTagName('input')[2].addEventListener('click',function() {
		document.getElementById('issuedToNonEmployee').removeAttribute('disabled', false);
		document.getElementById('issuedToEmployee').setAttribute('disabled', true);
	});
	</script>
	<script>
	//---validation javascript code---------------name
	function validNonEmployee(){ 
	  let name = document.forms['accessoryIssues']["issuedToNonEmployee"].value;
	if (name.search(/[0-9]/)>=0){
	  document.getElementById("s1").innerHTML="dont use numbers value";  
	}else if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
	    document.getElementById("s1").innerHTML="don't use symbolic character";
	}
	else{
	    document.getElementById("s1").innerHTML="";
	}
	}
	function validIssueQty(){
		let issueQty = document.forms['accessoryIssues']["issueQuantity"].value;
		if (issueQty.search(/[A-Z]/)>=0){
		  document.getElementById("s2").innerHTML="*dont use String";  
		}else if (issueQty.search(/[a-z]/)>=0){
		  document.getElementById("s2").innerHTML="*dont use String";  
		}
		else if(issueQty.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
		    document.getElementById("s2").innerHTML="*don't use symbolic character";
		}
		else{
		    document.getElementById("s2").innerHTML="";
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
		let accssorY = document.forms['accessoryIssues']["accessory.id"].value;
		if (accssorY.length == 0){
		    seterr("accessory", "*This field cannot be empty!");
		    return false;
		}
		let nonemp = document.forms['accessoryIssues']["issuedToNonEmployee"].value;
		if (nonemp.length == 0){
		    seterr("nonEmp", "*This cannot be empty!");
		    return false;
		}
		 if (nonemp.length>2){
		    seterr("nonEmp", "*Name should have char between 2-10");
		    return false;
		}
		if (nonemp.length>10){
		    seterr("nonEmp", "* name too long,Name should have char between 2-10");
		    return false;
		}
		if (nonemp.search(/[0-9]/)>=0){
		 	seterr("nonEmp", "*please enter string type name not enter number");
			 return false;
		}
		if(nonemp.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
		 	seterr("nonEmp", "*name is not symbol");
			 return false;
		}
		let idate = document.forms['accessoryIssues']["issueDate"].value;
		if (idate.length == 0){
		    seterr("date", "*This date cannot be empty!");
		    return false;
		}
		let issueQty = document.forms['accessoryIssues']["issueQuantity"].value;
		 if (issueQty.length == 0){
		     seterr("issueQty", "*issueQuantity cannot be empty!");
		     return false;
		 }
		 if (issueQty.length<1){
		     seterr("issueQty", "*issueQuantity enter atleast 1");
		     return false;
		 }
		 if (issueQty.search(/[A-Z]/)>=0){
		 	 seterr("issueQty", "*please enter numeric value not enter String");
		 	 return false;
		 }
		 if(issueQty.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
		 	 seterr("issueQty", "*issueQuantity is not symbol");
		 	 return false;
		 }
		 else{
				return true;
			}	
			}
	</script>
</body>
</html>