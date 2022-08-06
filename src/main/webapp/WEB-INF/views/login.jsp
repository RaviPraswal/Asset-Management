<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!--bootstrap icon -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
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
html {
	/*  background: radial-gradient(ellipse at center, #0264d6 1%, #1c2b5a 100%); */
	background-image: url('static/img/login.jpg');
	background-repeat: no-repeat;
	background-size: cover;
	height: calc(100vh);
	width: 100%;
}

body {
	color: #c5c5c5c;
	font: 87.5%/1.5em "Open Sans", sans-serif;
	margin: 0;
}

a {
	color: #fff;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

.small-text {
	color: #ddd;
}

.small-text:hover {
	color: #fff;
}

input {
	border: none;
	font-family: "Open Sans", Arial, sans-serif;
	font-size: 14px;
	line-height: 1.5em;
	padding: 0;
	-webkit-appearance: none;
}

p {
	line-height: 1.5em;
}

.clearfix {
	*zoom: 1; &: before , & : after {
    content : " ";
	display: table;
}

&
:after {
	clear: both;
}

}
.container {
	left: 50%;
	position: fixed;
	top: 50%;
	transform: translate(-50%, -50%);
}

/* Login */
#login form {
	width: 250px;
}

#login, .logo {
	display: inline-block;
	width: 40%;
}

#login {
	border-right: 1px solid #fff;
	padding: 0px 22px;
	width: 59%;
}

.logo {
	color: #fff;
	font-size: 40px;
	line-height: 120px;
}

#login form span.bi {
	background-color: #fff;
	border-radius: 3px 0px 0px 3px;
	color: #000;
	display: block;
	float: left;
	height: 50px;
	font-size: 24px;
	line-height: 50px;
	text-align: center;
	width: 50px;
}

#login form input {
	height: 50px;
}

fieldset {
	padding: 0;
	border: 0;
	margin: 0;
}

#login form input[type="text"], input[type="password"] {
	background-color: #fff;
	border-radius: 0px 3px 3px 0px;
	color: #000;
	margin-bottom: 1em;
	padding: 0 16px;
	width: 200px;
}

#login form input[type="submit"] {
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	background-color: #000000;
	color: #eee;
	font-weight: bold;
	/* margin-bottom: 2em; */
	text-transform: uppercase;
	padding: 3px 10px;
	height: 30px;
}

#login form input[type="submit"]:hover {
	background-color: #0264d6;
	color: #fff;
}

#login>p {
	text-align: center;
}

#login>p span {
	padding-left: 5px;
}

.middle {
	display: flex;
	width: 600px;
}

.fw-semibold {
	font-weight: 600;
}
</style>
</head>
<body>
	<!--login box-->

	<div class="container">
		<h2 style="color: #fff; margin-bottom: 50px;" class="text-center">SignIn</h2>
		<!-- <center> -->
		<div class="middle">
			<div id="login">


				<form:form action="login" method="post" role="form">
					<fieldset class="clearfix">

						<p>
							<span class="bi bi-person-fill"></span><input type="text"
								Placeholder="Username" name="username" required>
						</p>

						<p>
							<span class="bi bi-lock-fill"></span><input type="password"
								Placeholder="Password" name="password" required>
						</p>

						<div>
							<span
								style="width: 100%; text-align: center; display: inline-block;"><input
								type="submit" value="LogIn"></span>
						</div>

					</fieldset>
					<div class="clearfix"></div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form:form>

				<div class="clearfix"></div>

			</div>
			<!-- end login -->
			<div class="logo">
				<!-- <img alt="adjectiLogo" src="images/logo-white.png" width="80px" height="80px"> -->

				<h3 class="h3 fw-semibold opacity-75">
					<!--       TYPED JS       -->
					<span id="typed"></span>
				</h3>
				<div class="clearfix"></div>
			</div>

		</div>
		<!-- </center> -->
	</div>

	<!--Bootstrap js-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

	<script src="https://cdn.jsdelivr.net/npm/typed.js@2.0.12"></script>
	<script type="text/javascript">
		var typed = new Typed("#typed", {
			strings : [ "Adjecti Solutions Pvt.Ltd." ],
			typeSpeed : 110,
			startDelay : 500,
			loop : true,
			loopCount : Infinity,
			backDelay : 1000
		});
	</script>
</body>
</html>