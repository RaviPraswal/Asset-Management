<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link href="/static/css/home.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!--bootstrap icon -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">

</head>

<body class="anti-flash-white linear-gradient-body"
	style="background-image: url('/static/img/login.jpg'); background-repeat: no-repeat; background-size: cover; color: white;">
	<jsp:include page="navigation.jsp">
		<jsp:param value="home" name="selectedNav" />
	</jsp:include>
	<!-- HERO SECTION -->
	<div
		class="container-fluid position-relative overflow-hidden mb-4 mb-sm-0"
		style="min-height: 95vh;">

		<div class="container mt-xl-5 mt-lg-5 ">
			<div
				class="row pt-xl-5 pt-lg-5 d-sm-flex flex-column-reverse flex-lg-row text-center text-md-start">
				<div class="col-xl-6 col-lg-7 pt-xl-5 mt-xl-5 mt-lg-5">
					<h3 class="h3 fw-semibold opacity-75">
						<!--       TYPED JS       -->
						<span id="typed"></span>
					</h3>

					<h1 class="h1 fw-bold ">Add Assets & Accessory easily</h1>

					<!-- <a href="#" class="btn medium-candy-apple-red text-white fs-5">Get started</a> -->
				</div>
				<div class="col-xl-6 col-lg-5 mt-lg-5 position-relative">
					<div class="flip-container">
						<div class="flipper">
							<div clas="front">
								<img src="/static/img/74.png">

							</div>
							<div class="back">
								<img src="/static/img/pngegg.png">
							</div>

						</div>
					</div>
					<!-- <img src="images/74.png" alt="laptop" class="img-fluid scale-up" > -->
				</div>
			</div>
		</div>
	</div>

	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js">
		
	</script>
	<script src="https://cdn.jsdelivr.net/npm/typed.js@2.0.12"></script>
	<script type="text/javascript">
		var typed = new Typed("#typed", {
			strings : [ "Welcome to Assets Management" ],
			typeSpeed : 110,
			startDelay : 500,
			loop : true,
			loopCount : Infinity,
			backDelay : 1000
		});
	</script>
	<%@ include file="footer.jsp"%>
</body>
</html>
