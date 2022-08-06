<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Assets</title>
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

.formerror, #s1, #idemail, #s2, #s, #p, #w {
	color: red;
}
input[type="file"] { 
  z-index: -1;
  position: absolute;
  opacity: 0;
}

input:focus label {
  outline: 2px solid;
}
</style>
</head>
<body>
	<!-- edit asset code here start -->

	<div class="modal fade" id="editAssets"
		style="width: 100%; font-size: 1vw; font-weight: bold;">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="model-header">
					<h3 class=" modal-title">Assets</h3>
				</div>
				<hr>
				<!-- Modal body -->
				<div class="modal-body">
					<form:form onsubmit="return validForm()"
						action="save_update_asset?${_csrf.parameterName}=${_csrf.token}"
						method="POST" modelAttribute="asset" enctype="multipart/form-data">
						<c:if test="${asset!=null }">
							<div class="row mb-2">
								<label for="id" class="col-md-2 col-form-label"
									style="display: none;">Id :</label>
								<div class="col-md-10">
									<input type="hidden" class="form-control form-control-sm"
										value="${asset.id}" name="id" id="id" readonly>
								</div>
							</div>
						</c:if>
						<div class="row mb-2">

							<form:label path="skuNumber" for="skuNumber"
								class="col-md-2 col-form-label">Sku
								Number <span class="text-danger">*</span>
							</form:label>
							<div class="col-md-4" id="snumber">
								<form:input type="text" class="form-control form-control-sm"
									placeholder="skuNumber" value="${asset.skuNumber}"
									path="skuNumber" name="skuNumber" id="skuNumber" />
								<form:errors path="skuNumber" cssClass="error" />
								<span id="s"></span><b><span class="formerror"></span></b>

							</div>

							<label for="purchaseDate" class="col-md-2 col-form-label">Purchase
								Date <span class="text-danger">*</span>
							</label>
							<div class="col-md-4" id="purchase">
								<input type="date" class="form-control form-control-sm"
									value="${asset.purchaseDate}" name="purchaseDate"
									id="purchaseDate">
								<form:errors path="purchaseDate" cssClass="error" />
								<span id="p"></span><b><span class="formerror"> </span></b>
							</div>
						</div>
						<div class="row mb-2">
							<label for="name" class="col-md-2 col-form-label">Name <span
								class="text-danger">*</span></label>
							<div class="col-md-4" id="name">
								<input type="text" class="form-control form-control-sm"
									oninput="validname()" placeholder="Name" value="${asset.name}"
									id="name" name="name">
								<form:errors path="name" cssClass="error" />
								<span id="s1"></span><b><span class="formerror"> </span></b>
							</div>
							<label for="waranty" class="col-md-2 col-form-label">Warranty
								Date <span class="text-danger">*</span>
							</label>
							<div class="col-md-4" id="wDate">
								<input type="date" class="form-control form-control-sm"
									value="${asset.waranty}" name="waranty" id="waranty">
								<form:errors path="waranty" cssClass="error" />
								<span id="w"></span><span class="formerror"> </span>
							</div>
						</div>
						<div class="row mb-2">
							<label for="description" class="col-md-2 col-form-label">Description
								:</label>
							<div class="col-md-4">
								<textarea class="form-control form-control-sm"
									placeholder="description" name="description" id="description"></textarea>
							</div>

							<label for="cost" class="col-md-2 col-form-label">Cost <span
								class="text-danger">*</span></label>
							<div class="col-md-4" id="Cost">
								<input type="text" class="form-control form-control-sm"
									oninput="validCost()" placeholder="0" value="${asset.cost}"
									id="cost" name="cost" />
								<form:errors path="cost" cssClass="error" />
								<span id="s2"></span><b><span class="formerror"> </span></b>
							</div>
						</div>
						<div class="row mb-2">
							<label for="vendor" class="col-md-2 col-form-label">Vender
								<span class="text-danger">*</span>
							</label>
							<div class="col-md-4" id="Vender">
								<input type="text" class="form-control form-control-sm"
									oninput="validVender()" placeholder="vender"
									value="${asset.vendor}" id="vendor" name="vendor">
								<form:errors path="vendor" cssClass="error" />
								<span id="s1"></span><b><span class="formerror"> </span></b>
							</div>


							<label for="billNo" class="col-md-2 col-form-label">Bill
								Number <span class="text-danger">*</span>
							</label>
							<div class="col-md-4" id="bnumber">
								<input type="text" class="form-control form-control-sm"
									placeholder="bill number" value="${asset.billNo}" name="billNo"
									id="billNo">
								<form:errors path="billNo" cssClass="error" />
								<span id="s"></span><b><span class="formerror"> </span></b>
							</div>
						</div>
						<div class="row mb-2">
							<label for="model" class="col-md-2 col-form-label">Model
								<span class="text-danger">*</span>
							</label>
							<div class="col-md-4" id="Modal">
								<input type="text" class="form-control form-control-sm"
									placeholder="model" value="${asset.model}" name="model"
									id="model">
								<form:errors path="model" cssClass="error" />
								<span id="s"></span><b><span class="formerror"> </span></b>
							</div>
							<label for="assetType" class="col-md-2 col-form-label">Assets
								Type <span class="text-danger">*</span>
							</label>
							<div class="col-md-4" id="assetType">
								<form:select class="form-select  form-select-sm"
									path="assetType.id" name="at">
									<option selected disabled value="">select type</option>
									<c:forEach items="${assetTypeList}" var="assetTypeListObj">
										<c:if test="${assetTypeListObj!=null}">
											<form:option value="${assetTypeListObj.id}"
												label="${assetTypeListObj.typeName}"></form:option>
										</c:if>
									</c:forEach>
								</form:select>
								<span id="s"></span><b><span class="formerror"> </span></b>
							</div>
						</div>

						<div class="row mb-2">
							<label for="parentAsset" class="col-md-2 col-form-label">Parent
								Asset: </label>
							<div class="col-md-4">
								<form:select class="form-select  form-select-sm"
									path="parentAsset">
									<option value="${asset.parentAsset}">${asset.parentAsset}</option>
									<c:forEach items="${parentAssetList}" var="parentAsset">
										<c:if test="${parentAsset!=null}">
											<form:option value="${parentAsset}" label="${parentAsset}"></form:option>
										</c:if>
									</c:forEach>
								</form:select>
								<form:errors path="parentAsset" cssClass="error" />
							</div>
							<form:label class="col-md-2 col-form-label" path="file">Bill
								Document <span class="text-danger">*</span>
							</form:label>
							<div class="col-md-4" id="billdoc" style="display: inline-flex;">
								<!-- Bill document: -->
								<!-- <input type="file"class="form-control form-control-sm" name="file" id="file" > -->
								<%-- Previous Bill=${billFileName} --%>
								<input type="file" id="file" name="file" multiple /> <label
									for="file" style="border: 1px solid black;">Upload file</label>
								<div id="file-upload-filename" style="margin-left: 10px;">${billFileName}</div>
								<span id="s"></span><b><span class="formerror"> </span></b>
							</div>
						</div>
						<hr>
						<!-- Modal footer -->
						<div class="model-footer">
							<a href="../admin/asset_view" class="btn btn-secondary "
								style="font-size: 1vw;">Close</a>
							<button type="submit" class="btn btn-primary"
								style="font-size: 1vw;">save</button>
						</div>
					</form:form>

				</div>
			</div>
		</div>
	</div>
	<!--  here end code of edit asset-->
	<script>
	var input = document.getElementById( 'file' );
	var infoArea = document.getElementById( 'file-upload-filename' );
	input.addEventListener( 'change', showFileName );
	function showFileName( event ) {	  
	  // the change event gives us the input it occurred in 
	  var input = event.srcElement;
	  
	  // the input has an array of files in the `files` property, each one has a name that you can use. We're just using the name here.
	  var fileName = input.files[0].name;
	  
	  // use fileName however fits your app best, i.e. add it into a div
	  infoArea.textContent =  fileName;
	}
</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#editAssets").modal('show');
		});
	</script>
	<script>
//---validation javascript code---------------name
function validname(){ 
  let name = document.forms['asset']["name"].value;
if (name.search(/[0-9]/)>=0){
  document.getElementById("s1").innerHTML="dont use numbers value";  
}else if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
    document.getElementById("s1").innerHTML="don't use symbolic character";
}
else{
    document.getElementById("s1").innerHTML="";
}
}
function validCost(){ 
	  let cost = document.forms['asset']["cost"].value;
	if (cost.search(/[A-Z]/)>=0){
	  document.getElementById("s2").innerHTML="dont use String";  
	}else if (cost.search(/[a-z]/)>=0){
	  document.getElementById("s2").innerHTML="dont use String";  
	}
	else if(cost.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
	    document.getElementById("s2").innerHTML="don't use symbolic character";
	}
	else{
	    document.getElementById("s2").innerHTML="";
	}
	}
	function validVender(){
		let vender = document.forms['asset']["vendor"].value;
		if (name.search(/[0-9]/)>=0){
			  document.getElementById("s1").innerHTML="dont use numbers value";  
			}else if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
			    document.getElementById("s1").innerHTML="don't use symbolic character";
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
let snumber = document.forms['asset']["skuNumber"].value;
if (snumber.length == 0){
    seterr("snumber", "* Sku number cannot be empty!");
    return false;
}
let  date = document.forms['asset']["purchaseDate"].value;
if (date.length == 0){
    seterr("purchase", "* purchase date cannot be empty!");
    return false;
}
let name = document.forms['asset']["name"].value;
if (name.length == 0){
    seterr("name", "** name cannot be empty!");
    return false;
}
 if (name.length<2){
    seterr("name", "*Name should have char between 2-10");
    return false;
}
if (name.length>10){
    seterr("name", "* name too long **Name should have char between 2-10");
    return false;
}
if (name.search(/[0-9]/)>=0){
 	seterr("name", "*please enter string type name not enter number");
	 return false;
}
if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
 	seterr("name", "*name is not symbol");
	 return false;
}
 let wdate = document.forms['asset']["waranty"].value;
 if (wdate.length == 0){
     seterr("wDate", "* warranty date cannot be empty!");
     return false;
 }
 let cost = document.forms['asset']["cost"].value;
 if (cost.length == 0){
     seterr("Cost", "* cost cannot be empty!");
     return false;
 }
 if (cost.length<2){
     seterr("Cost", "*cost enter atleast 2 digit");
     return false;
 }
 if (cost.search(/[A-Z]/)>=0){
 	 seterr("Cost", "*please enter numeric value not enter String");
 	 return false;
 }
 if(cost.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
 	 seterr("Cost", "*cost is not symbol");
 	 return false;
 }
 let vender = document.forms['asset']["vendor"].value;
 if (vender.length == 0){
	    seterr("Vender", "*This field cannot be empty!");
	    return false;
}
if (vender.length<2){
    seterr("Vender", "*vender should have too short");
    return false;
}
if(vender.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
	 seterr("Vender", "*vendor is not symbol only use hyphen - ");
	 return false;
}
let billNumber = document.forms['asset']["billNo"].value;
if (billNumber.length == 0){
	seterr("bnumber", "* billNumber cannot be empty!");
	return false;
}
if (billNumber.length<3){
	seterr("bnumber", "*billNumber should have too short");
	return false;
}
if(billNumber.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
	seterr("bnumber", "*billNumber is not use symbol");
	return false;
}
let modal = document.forms['asset']["model"].value;
if (modal.length == 0){
	seterr("Modal", "* Modal cannot be empty!");
	return false;
}
if (modal.length<3){
	seterr("Modal", "*Modal should have atleast 3 character");
	return false;
}
let asset = document.forms['asset']["assetType.id"].value;
if (asset.length == 0){
	seterr("assetType", "* assetType cannot be empty!");
	return false;
}
let bdoc = document.forms['asset']["file"].value;
if (bdoc.length == 0){
	seterr("billdoc", "* bill document cannot be empty!");
	return false;
}
else{
	return true;
}	
}
  </script>
</body>
</html>