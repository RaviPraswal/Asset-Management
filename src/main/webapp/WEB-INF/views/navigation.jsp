<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
	<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Navigation</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!--bootstrap icon -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<style>
@import
	url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css")
	;

/* general */
* {
	box-sizing: border-box;
	margin: 0px auto;
	&:
	before
	,
	&
	:
	after
	{
	
    
	box-sizing
	:
	 
	border-box;
}

}
.new {
	background: radial-gradient(ellipse at center, #0674d5 1%, #1d2d7b 100%);
	height: auto;
	width: 100%;
	color: white;
}
.dropdownmenu {
 background: #497ADA;
 height:100px;
 min-width: 15px;
 
}
.dropdownmenu li a{
color: #fff;
}

.profile-menu { .dropdown-menu { right:0;
	left: unset;
}

.fa-fw {
	margin-right: 10px;
}

}
.toggle-change { &::after { border-top:0;
	border-bottom: .3em solid;
}
}
.dropdown:hover .dropdown-menu{
        display: block;
        background: #497ADA;
    }
    .dropdown-menu{
        margin-top: 0;
    }
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark new ">
		<div class="container-fluid ">
			<a class="navbar-brand" href="#"> AssetsManagement</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link"
						 href="/admin/"><span id="home"><b>Home</b></span></a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
						href="#"><span id="asset"><b> Assets</b></span> </a>
						<ul class="dropdown-menu dropdownmenu" style="font-size: 1.1vw;">
							<li><a class="dropdown-item" href="../admin/asset_view">Assets</a></li>
							<li><a class="dropdown-item" href="../admin/asset_assignment_view">Assets Assignment</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" role="button"
						id="dropdownmenulink" data-bs-toggle="dropdown" href="#"><span id="accessory"><b>
							Accessory </b></span></a>
						<ul class="dropdown-menu dropdownmenu" style="font-size: 1.1vw;">
							<li><a class="dropdown-item" href="../admin/accessory_view">Accessory</a></li>
							<li><a class="dropdown-item" href="../admin/accessory_issues_view">Accessory Issues</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						data-bs-toggle="dropdown"><span id="configuration"><b>Configuration</b></span></a>
						<ul class="dropdown-menu dropdownmenu" style="font-size: 1.1vw;">
							<li><a class="dropdown-item" href="../admin/asset_type_view">Assets Type</a></li>
							<li><a class="dropdown-item" href="../admin/accessory_type_view">Accessory Type</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link" href="#"><span id="help"><b>Help</b></span></a></li>
				</ul>
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0 profile-menu">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						data-bs-toggle="dropdown"> <span id="profile-menu"><b><i class="fas fa-user"></i></b></span>
					</a>
						<ul class="dropdown-menu dropdownmenu" style="font-size: 1.1vw;">
							<li><a class="dropdown-item" href="../admin/employee_view"><i
									class="fas fa-user-tie"></i> Employee</a></li>
							<li><a class="dropdown-item" href="../logout"><i
									class="fas fa-sign-out-alt fa-fw"></i> Log Out</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
	<!--Bootstrap js-->
<script>
$(document).ready(function(){
    $(".dropdown").hover(function(){
        var dropdownMenu = $(this).children(".dropdown-menu");
        if(dropdownMenu.is(":visible")){
            dropdownMenu.parent().toggleClass("open");
        }
    });
});     
</script>
<script>
var navId = "${param.selectedNav}";

var nav = document.getElementById(navId);

nav.style.color = 'white';


</script>
</body>
</html>