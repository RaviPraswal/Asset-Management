<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Accessory</title>
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

.error {
	color: #ff0000;
}
.formerror{
color: red;
}
</style>
</head>
<body>
	<!-- The Modal -->
	<div class="modal fade" id="open_update_asset_assignment_form"
		style="width: 100%; font-size: 1vw; font-weight: bold;">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="model-header">
					<h3>Asset Assignment</h3>
				</div>
				<hr>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="container">
						<form:form onsubmit="return validForm()" action="save_update_asset_assignment" method="post"
							modelAttribute="assetAssignment">
							<div class="row">
								<div class="col-md-6">
									<c:if test="${assetAssignment!=null}">
										<div class="row mb-1">
											<label for="id" class="col-md-4 col-form-label"
												style="display: none;">Id :</label>
											<div class="col-md-8">
												<input type="hidden" class="form-control form-control-sm"
													value="${assetAssignment.id}" id="id" name="id" readOnly>
											</div>
										</div>
									</c:if>
									<div class="row mb-1">
										<label for="asset" class="col-md-4 col-form-label">Asset
											<span class="text-danger">*</span></label>
										<div class="col-md-8" id="Asset">
											<form:select class="  form-select form-select-sm"
												path="asset.id">
												<option selected disabled value="" >Select Asset</option>
												<c:forEach items="${loadAsset}" var="loadAssetObj">
													<c:if test="${loadAssetObj!=null}">
														<form:option value="${loadAssetObj.id}"
															label="${loadAssetObj.name}" />
													</c:if>
												</c:forEach>
											</form:select>
											<form:errors path="${loadAssetObj.name}" cssClass="error" />
											<span class="formerror"></span>
										</div>
									</div>
									<div class="row mb-1">
										<label for="employee" class="col-md-4 col-form-label">Employee
											<span class="text-danger">*</span></label>
										<div class="col-md-8" id="Emp">
											<form:select class="form-select  form-select-sm"
												path="employee.employeeId">
												<option selected disabled value="" >Select Employee</option>
												<c:forEach items="${loadEmployee}" var="loadEmployeeObj">
													<c:if test="${loadEmployeeObj!=null}">
														<form:option value="${loadEmployeeObj.employeeId}"
															label="${loadEmployeeObj.firstName}"></form:option>
													</c:if>
												</c:forEach>
											</form:select>
											<form:errors path="${loadEmployeeObj.firstName}"
												cssClass="error" />
												<span class="formerror"></span>
										</div>
									</div>
									<div class="row mb-1">
										<label for="issueDate" class="col-md-4 col-form-label">Issue
											Date <span class="text-danger">*</span></label>
										<div class="col-md-8" id="issuedate">
											<input type="date" class="form-control form-control-sm"
												value="${assetAssignment.issueDate}" id="issueDate"
												name="issueDate">
											<form:errors path="issueDate" cssClass="error" />
											<span class="formerror"></span>
										</div>
									</div>
									<div class="row mb-1">
										<label for="issueCondition" class="col-md-4 col-form-label">IssueCondition<span class="text-danger">*</span></label>
										<div class="col-md-8" id="issueCon">
											<select class="form-select  form-select-sm"
												name="issueCondition" id="issueCondition">
												<option value="${assetAssignment.issueCondition}">
													${assetAssignment.issueCondition}</option>
												<option value="Good">Good</option>
												<option value="Damage">Damage</option>
											</select>
											<form:errors path="issueCondition" cssClass="error" />
											<span class="formerror"></span>
										</div>
									</div>
									<div class="row mb-1">
										<label for="issueRemark" class="col-md-4 col-form-label">Issue
											Remark :</label>
										<div class="col-md-8">
											<textarea rows="4" class="form-control form-control-sm"
												placeholder="${assetAssignment.issueRemark}"
												name="issueRemark" id="issueRemark"></textarea>
										</div>
									</div>
								</div>
								<div class="col-md-6">														
									<div class="row mb-1">
										<label for="returnDate" class="col-md-4 col-form-label">Return
											Date :</label>
										<div class="col-md-8">
											<input type="date" class="form-control form-control-sm"
												value="${assetAssignment.returnDate}" id="returnDate"
												name="returnDate">
										</div>
									</div>
									<div class="row mb-1">
										<label for="returnCondition" class="col-md-4 col-form-label">ReturnCondition</label>
										<div class="col-md-8">
											<select class="form-select  form-select-sm"
												name="returnCondition" id="returnCondition">
												<option selected disabled
													value="${assetAssignment.returnCondition}">
													${assetAssignment.returnCondition}</option>
												<option value="Good">Good</option>
												<option value="Damage">Damage</option>
											</select>
										</div>
									</div>
									<div class="row mb-1">
										<label for="reruntRemark" class="col-md-4 col-form-label">Return
											Remark:</label>
										<div class="col-md-8">
											<textarea class="form-control form-control-sm" rows="4"
												placeholder="${assetAssignment.reruntRemark}"
												name="reruntRemark" id="reruntRemark"></textarea>
										</div>
									</div>
								</div>
							</div>
							<hr>

							<div class="model-footer">
								<a href="../admin/asset_assignment_view"
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
			$("#open_update_asset_assignment_form").modal('show');
		});
	</script>
	<script type="text/javascript">
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
		let asset = document.forms['assetAssignment']["asset.id"].value;
		if (asset.length == 0){
			seterr("Asset", "* This field cannot be empty!");
			return false;
		}
		let employee = document.forms['assetAssignment']["employee.employeeId"].value;
		if (employee.length == 0){
			seterr("Emp", "* This field cannot be empty!");
			return false;
		}
		let idate = document.forms['assetAssignment']["issueDate"].value;
		if (idate.length == 0){
		    seterr("issuedate", "*issue date cannot be empty!");
		    return false;
		}
		let icon = document.forms['assetAssignment']["issueCondition"].value;
		if (icon.length == 0){
		    seterr("issueCon", "*issue condition cannot be empty!");
		    return false;
		}
		else{
			return true;
		}
	}
	</script>
</body>
</html>