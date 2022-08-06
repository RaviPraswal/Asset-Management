<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>EditModalContent</title>
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
.model-header {
	padding: 5px;
	text-align: center;
}

.model-footer {
	padding: 5px;
	text-align: right;
}
#s1, #idemail, #s2 {
	color: red;
}
.formerror {
	color: red;
}
</style>
</head>
<body>

	<!-- The Modal -->
	<div class="modal fade" id="editEmployee"
		style="width: 100%; font-size: 1vw; font-weight: bold;">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="model-header">
					<h3>Employee</h3>
				</div>
				<hr>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="container">
						<form:form onsubmit="return validForm()" action="save_update_employee" modelAttribute="employee"
							method="POST">

							<div class="row mb-3">
								<c:if test="${employee!=null }">
									<label for="empId" class="col-md-3 col-form-label" style="display: none;">EmployeeId
										: </label>
									<div class="col-md-8">
										<input type="hidden" class="form-control form-control-sm" name="employeeId"
											readonly="readonly" id="employeeId"
											value="${employee.employeeId }">
									</div>
								</c:if>
							</div>
							<div class="row mb-3">
								<label for="email" class="col-md-3 col-form-label">Email
									<span class="text-danger">*</span></label>
								<div class="col-md-8" id="email" onchange="validEmail()">
									<input type="email" class="form-control form-control-sm" placeholder="Email"
										name="email" id="email" value="${employee.email}">
										<span id="idemail"></span><b><span class="formerror">
									</span></b>
									<span class="text-danger"> ${existEmail}</span>
									<form:errors path="email" cssClass="formerror" />
								</div>
							</div>
							<div class="row mb-3">
								<label for="purdate" class="col-md-3 col-form-label">First
									Name <span class="text-danger">*</span></label>
								<div class="col-md-8"id="name">
									<input type="text" class="form-control form-control-sm"oninput="validfirstname()" placeholder="first name"
										name="firstName" id="firstName" value="${employee.firstName}">
										<form:errors path="firstName" cssClass="formerror" />
									<span id="s1"></span><b><span class="formerror"> </span></b>
								</div>
							</div>
							<div class="row mb-3">
								<label for="name" class="col-md-3 col-form-label">Last
									Name <span class="text-danger">*</span></label>
								<div class="col-md-8" id="lname">
									<input type="text" class="form-control form-control-sm" oninput="validlastname()" placeholder="last Name"
										id="lastName" name="lastName" value="${employee.lastName}">
										<span id="s2"></span><b><span class="formerror"> </span></b>
									<form:errors path="lastName" cssClass="formerror" />
								</div>
							</div>
							<hr>
							<!-- Modal footer -->
							<div class="model-footer">
								<a href="../admin/employee_view" class="btn btn-secondary "
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
			$("#editEmployee").modal('show');
		});
	</script>
	<script>
//---validation javascript code---------------name
function validfirstname(){ 
  let name = document.forms['employee']["firstName"].value;
if (name.search(/[0-9]/)>=0){
  document.getElementById("s1").innerHTML="dont use numbers value";  
}else if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
    document.getElementById("s1").innerHTML="don't use symbolic character";
}
else{
    document.getElementById("s1").innerHTML="";
}
}
//-----------lastname
function validlastname(){
 
 let name = document.forms['employee']["lastName"].value;

if (name.search(/[0-9]/)>=0){
document.getElementById("s2").innerHTML="Please input string value";

}else if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
    document.getElementById("s2").innerHTML="don't use symbolic character";
}else{
 document.getElementById("s2").innerHTML="";
}
}
//--------------email
function validEmail(){
let email=document.forms["employee"]["email"].value;
if(email.indexOf("@")<=0){
    document.getElementById("idemail").innerHTML="**invalid input use '@'"

}if((email.charAt(email.length-4)!='.') && (email.charAt(email.length-3)!='.')){
    document.getElementById("idemail").innerHTML="**invalid input"
}
else{
	    document.getElementById("idemail").innerHTML=""
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
let email = document.forms['employee']["email"].value;
if(email.length ==0){
    seterr("email","**Email cannot blank")
    return false;
}
if (email.length>35){
    seterr("email", "**Email too long");
    return  false;
}
if(email.indexOf("@")<=0){
	seterr("email","**Email is not correct")
    	return false;
}

let name = document.forms['employee']["firstName"].value;
if (name.length == 0){
    seterr("name", "**first name cannot be empty!");
    return false;
}
 if (name.length<3){
    seterr("name", "*First Name should have char between 3-10");
    return false;
}
 if (name.search(/[0-9]/)>=0){
	 seterr("name", "*please enter right first name");
	 return false;
 }
 if(name.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
	 seterr("name", "*name is not symbol");
	 return false;
 }
 let lname = document.forms['employee']["lastName"].value;
 if (lname.length == 0){
     seterr("lname", "**Last name cannot be empty!");
     return false;
 }
  if (lname.length<4){
     seterr("lname", "*Last Name should have char between 4-15");
     return false;
 } 
  if (lname.search(/[0-9]/)>=0){
		 seterr("lname", "*please enter right last name");
		 return false;
	 }
	 if(lname.search(/[!\@\#\$\%\^\&\*\(\)\_\=\+]/)>=0){
		 seterr("lname", "*name is not symbol");
		 return false;
	 } else{
			return true;
		   } 

}
	</script>
</body>
</html>