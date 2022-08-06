<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>saveUpdate Accessory</title>
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

.formerror, #s1, #idemail, #s2, #s, #pq, #w {
	color: red;
}

.error {
	color: #ff0000;
}

/* input[type="file"] {
	z-index: -1;
	position: absolute;
	opacity: 0;
} */

/* input:focus label {
	outline: 2px solid;
} */
</style>
</head>
<body>
	<%@ include file="accessoryView.jsp"%>

	<!-- The Modal -->
	<div class=" modal fade" id="open_update_accessory_form"
		style="width: 100%; font-size: 1vw; font-weight: bold;">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="model-header">
					<h3>Accessory</h3>
				</div>
				<hr>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="container">
						<form:form onsubmit="return validForm()"
							action="save_update_accessory?${_csrf.parameterName}=${_csrf.token}"
							method="post" modelAttribute="accessory"
							enctype="multipart/form-data">
							<c:if test="${accessory!=null }">
								<div class="row mb-2">
									<label for="id" class="col-md-2 col-form-label"
										style="display: none;">Id :</label>
									<div class="col-md-10">
										<input type="hidden" class="form-control form-control-sm"
											id="id" name="id" placeholder="" value="${accessory.id}"
											readOnly>
									</div>
								</div>
							</c:if>
							<div class="row mb-2">
								<label for="skuNumber" class="col-md-2 col-form-label">SkuNumber<span
									class="text-danger">*</span>
								</label>
								<div class="col-md-4" id="snumber">
									<input type="text" class="form-control form-control-sm"
										placeholder="sku Number" name="skuNumber" id="skuNumber"
										value="${accessory.skuNumber}">
									<form:errors path="skuNumber" cssClass="error" />
									<span id="s"></span><span class="formerror"> </span>
								</div>
								<label for="cost" class="col-md-2 col-form-label">Unit
									Cost <span class="text-danger">*</span>
								</label>
								<div class="col-md-4" id="Cost">
									<input type="text" class="form-control form-control-sm"
										oninput="validCost()" placeholder="0.0" id="cost" name="cost"
										value="${accessory.cost}">
									<form:errors path="cost" cssClass="error" />
									<span id="s2"></span><b><span class="formerror"> </span></b>
								</div>

							</div>
							<div class="row mb-2">
								<label for="name" class="col-md-2 col-form-label">Name<span
									class="text-danger">*</span></label>
								<div class="col-md-4" id="name">
									<input type="text" class="form-control form-control-sm"
										oninput="validname()" placeholder="Name" id="name" name="name"
										value="${accessory.name}">
									<form:errors path="name" cssClass="error" />
									<span id="s1"></span><b><span class="formerror"> </span></b>
								</div>
								<label for="purchaseQuantity" class="col-md-2 col-form-label">
									PurchaseQty<span class="text-danger">*</span>
								</label>
								<div class="col-md-4" id="purQty">
									<input type="text" class="form-control form-control-sm"
										placeholder="0" name="purchaseQuantity" id="purchaseQuantity"
										value="${accessory.purchaseQuantity}"> <span id="s1"></span><b><span
										class="formerror"></span></b>
									<form:errors path="purchaseQuantity" cssClass="error" />
								</div>
							</div>
							<div class="row mb-2">
								<label for="model" class="col-md-2 col-form-label">Type<span
									class="text-danger">*</span>
								</label>
								<div class="col-md-4" id="type">
									<form:select class="form-select form-select-sm"
										path="accessoryType.id" required="${true}">
										<c:forEach items="${loadAccessoryTypes}"
											var="loadAccessoryTypesObj">
											<c:if test="${loadAccessoryTypesObj!=null}">
												<form:option value="${loadAccessoryTypesObj.id }"
													label="${loadAccessoryTypesObj.typeName}"></form:option>
											</c:if>
										</c:forEach>
									</form:select>
									<span id="w"></span><span class="formerror"> </span>
									<%-- <form:errors path="purchaseQuantity" cssClass="error" /> --%>
								</div>
								<label for="vender" class="col-md-2 col-form-label">Vender
									<span class="text-danger">*</span>
								</label>
								<div class="col-md-4" id="Vender">
									<input type="text" class="form-control form-control-sm"
										oninput="validVender()" placeholder="vender" id="vendor"
										name="vendor" value="${accessory.vendor}">
									<form:errors path="vendor" cssClass="error" />
									<span id="s1"></span><span class="formerror"> </span>
								</div>
							</div>
							<div class="row mb-2">
								<label for="billNumber" class="col-md-2 col-form-label">BillNo<span
									class="text-danger">*</span>
								</label>
								<div class="col-md-4" id="bnumber">
									<input type="text" class="form-control form-control-sm"
										placeholder="bill number" id="billNumber" name="billNumber"
										value="${accessory.billNumber }">
									<form:errors path="billNumber" cssClass="error" />
									<span id="s1"></span><span class="formerror"> </span>
								</div>
								
								
								
								<form:label class="col-md-2 col-form-label"
									path="file">Bill
									Document<span class="text-danger">*</span>
								</form:label>
								<div class="col-md-4">
								<form:input path="file" type="file"/>
									<%-- <input type="file" class="form-control form-control-sm"
										value="${accessory.file}" id="file" name="file" required>--%>
									Previous Bill=${billFileName}
									<form:errors path="file" cssClass="error" />
									<span id="s1"></span><span class="formerror"> </span>
								</div>
								
								
								
							</div>
							<div class="row mb-2">
								<label for="desc" class="col-md-2 col-form-label">Description</label>
								<div class="col-md-4">
									<textarea rows="4" class="form-control form-control-sm"
										placeholder="${accessory.description}" name="description"
										id="description"></textarea>
								</div>
								<label for="purdate" class="col-md-2 col-form-label">PurchaseDate<span
									class="text-danger">*</span>
								</label>
								<div class="col-md-4" id="purchasedate">
									<input type="date" class="form-control form-control-sm"
										value="${accessory.purchaseDate}" name="purchaseDate"
										id="purchaseDate"> <span id="s2"></span><span
										class="formerror"> </span>
									<form:errors path="purchaseDate" cssClass="error" />
								</div>
							</div>
							<hr>
							<!-- Modal footer -->
							<div class="model-footer">
								<a href="../admin/accessory_view" class="btn btn-secondary "
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

	<script>
	//var input = document.getElementById( 'file' );
	//var infoArea = document.getElementById( 'file-upload-filename' );
	//input.addEventListener( 'change', showFileName );
	/* function showFileName( event ) {	  
	  // the change event gives us the input it occurred in 
	  var input = event.srcElement;
	  
	  // the input has an array of files in the `files` property, each one has a name that you can use. We're just using the name here.
	  var fileName = input.files[0].name;
	  
	  // use fileName however fits your app best, i.e. add it into a div
	  infoArea.textContent =  fileName;
	} */
</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#open_update_accessory_form").modal('show');
		});
	</script>
	<script>
	function validCost(){ 
		  let cost = document.forms['accessory']["cost"].value;
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
//---validation javascript code---------------name
function validname(){ 
  let name = document.forms['accessory']["name"].value;
if (name.search(/[0-9]/)>=0){
  document.getElementById("s1").innerHTML="dont use numbers value";  
}else if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
    document.getElementById("s1").innerHTML="don't use symbolic character";
}
else{
    document.getElementById("s1").innerHTML="";
}
}
function validVender(){
	let vender = document.forms['accessory']["vendor"].value;
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
let snumber = document.forms['accessory']["skuNumber"].value;
if (snumber.length == 0){
    seterr("snumber", "* Sku number cannot be empty!");
    return false;
}
let cost = document.forms['accessory']["cost"].value;
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

let name = document.forms['accessory']["name"].value;
if (name.length == 0){
    seterr("name", "*name cannot be empty!");
    return false;
}
 if (name.length<2){
    seterr("name", "*Name should have char between 2-10");
    return false;
}
if (name.length>10){
    seterr("name", "* name too long,Name should have char between 2-10");
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
let pQuantity = document.forms['accessory']["purchaseQuantity"].value;
if (pQuantity.length == 0){
    seterr("purQty", "*purchaseQuantity cannot be empty!");
    return false;
}
if (pQuantity.search(/[A-Z]/)>=0){
   seterr("purQty", "*purchaseQuantity cannot entry String!");
   return false;
}
if (pQuantity.search(/[a-z]/)>=0){
    seterr("purQty", "*purchaseQuantity cannot entry String!");
    return false;
} 
let aType = document.forms['accessory']["accessoryType"].value;
if (aType.length == 0){
    seterr("type", "*This field cannot be empty!");
    return false;
}
let vender = document.forms['accessory']["vendor"].value;
if (vender.length == 0){
	seterr("Vender", "*this cannot be empty!");
	return false;
}
if (vender.length<2){
    seterr("Vender", "*vender should have atleast 3 character");
    return false;
}
if(vender.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
	 seterr("Vender", "*vendor is not symbol only use hyphen - ");
	 return false;
}
let bNumber = document.forms['accessory']["billNumber"].value;
if (bNumber.length == 0){
	seterr("bnumber", "* billNumber cannot be empty!");
	return false;
}
if (bNumber.length<3){
	seterr("bnumber", "*billNumber should have atleast 3 character");
	return false;
}
if(bNumber.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
	seterr("bnumber", "*billNumber is not use symbol");
	return false;
}
let pdate = document.forms['accessory']["purchaseDate"].value;
if (pdate.length == 0){
    seterr("purchasedate", "*This date cannot be empty!");
    return false;
}
else{
	return true;
}	
}
  </script>
</body>
</html>