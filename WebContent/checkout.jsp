<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<link rel = "icon" href = "./img/MunchiesLogo.jpg">
	<title>Munchies</title>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Hind:400,700" rel="stylesheet">

	<!-- Bootstrap -->
	<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />

	<!-- Slick -->
	<link type="text/css" rel="stylesheet" href="css/slick.css" />
	<link type="text/css" rel="stylesheet" href="css/slick-theme.css" />

	<!-- nouislider -->
	<link type="text/css" rel="stylesheet" href="css/nouislider.min.css" />

	<!-- Font Awesome Icon -->
	<link rel="stylesheet" href="css/font-awesome.min.css">

	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="css/style.css" />

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

</head>

<body>
	<!-- HEADER -->
	<header>
		<!-- header -->
		<div id="header">
			<div class="container">
				<div class="pull-left">
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="index.jsp">
							<img src="./img/MunchiesLogoCrop.jpg" alt="">
						</a>
					</div>
					<!-- /Logo -->

					<!-- Search -->
					<div class="header-search">
						<form>
							<input class="input search-input" type="text" placeholder="Enter your keyword">
							<select class="input search-categories">
								<option value="0">All Categories</option>
								<option value="1">Beverages</option>
								<option value="1">Baking</option>
								<option value="1">Breakfast & Cereal</option>
								<option value="1">Frozen Food</option>
								<option value="1">Grains & Pasta</option>
								<option value="1">Produce</option>
							</select>
							<button class="search-btn"><i class="fa fa-search"></i></button>
						</form>
					</div>
					<!-- /Search -->
				</div>
				<div class="pull-right">
					<ul class="header-btns">
						<!-- Account -->
						<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
								<strong class="text-uppercase">My Account<i class="fa fa-caret-down"></i></strong>
							</div>
							<% 
								String username = (String) session.getAttribute("userid");
								if (username == null){
							%>
							<a href="./login.jsp" class="text-uppercase">Login</a> / <a href="./register.jsp" class="text-uppercase">Join</a>
							<ul class="custom-menu">
								<li><a href="#"><i class="fa fa-user-o"></i> My Account</a></li>
								<li><a href="./checkout.jsp"><i class="fa fa-check"></i> Checkout</a></li>
								<li><a href="./login.jsp"><i class="fa fa-unlock-alt"></i> Login</a></li>
								<li><a href="./register.jsp"><i class="fa fa-user-plus"></i> Create An Account</a></li>
							</ul>
							<%
								}else {
							%>
							<a>Hi, <%= request.getSession().getAttribute("userid")%></a>
							<a href = "LogoutAPI">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Logout</a>
								
							<ul class="custom-menu">
								<li><a href="#"><i class="fa fa-user-o"></i> My Account</a></li>
								<li><a href="./checkout.jsp"><i class="fa fa-check"></i> Checkout</a></li>
								<li><a href="./TransactionAPI?username=${userid}"><i class="fa fa-book"></i> History</a></li>
							</ul>
							<% }%>
						</li>
						<!-- /Account -->	

						<!-- Cart -->
						<li class="header-cart dropdown default-dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-shopping-cart"></i>
									<%
										if (request.getSession().getAttribute("cart") == null){
									%>
									<span class="qty">0</span>
									<% 
										}else {
									%>
									<span class="qty"><%= request.getSession().getAttribute("quantity")%></span>
									<%} %>
								</div>
								<strong class="text-uppercase">My Cart:</strong>
								<br>
								<%
									if (request.getSession().getAttribute("cart") == null){
								%>
								<span>$0.00</span>
									<%
									}else {
									%>
									<span>$ <%= request.getSession().getAttribute("total")%></span>
									<%}%>
							</a>
							<div class="custom-menu">
								<div id="shopping-cart">
									<div class="shopping-cart-list">
										<div class="product product-widget">
											<div class="product-thumb">
												<img src="./img/thumb-product01.jpg" alt="">
											</div>
											<div class="product-body">
												<h3 class="product-price"># <span class="qty">#</span></h3>
												<h2 class="product-name"><a href="#">Product Name Goes Here</a></h2>
											</div>
											<button class="cancel-btn"><i class="fa fa-trash"></i></button>
										</div>
										<div class="product product-widget">
											<div class="product-thumb">
												<img src="./img/thumb-product01.jpg" alt="">
											</div>
											<div class="product-body">
												<h3 class="product-price">#<span class="qty">#</span></h3>
												<h2 class="product-name"><a href="#">Product Name Goes Here</a></h2>
											</div>
											<button class="cancel-btn"><i class="fa fa-trash"></i></button>
										</div>
									</div>
									<div class="shopping-cart-btns">
										<button class="main-btn">View Cart</button>
										<button class="primary-btn" href = "checkout.jsp">Checkout <i class="fa fa-arrow-circle-right"></i></button>
									</div>
								</div>
							</div>
						</li>
						<!-- /Cart -->

						<!-- Mobile nav toggle-->
						<li class="nav-toggle">
							<button class="nav-toggle-btn main-btn icon-btn"><i class="fa fa-bars"></i></button>
						</li>
						<!-- / Mobile nav toggle -->
					</ul>
				</div>
			</div>
			<!-- header -->
		</div>
		<!-- container -->
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<div id="navigation">
		<!-- container -->
		<div class="container">
			<div id="responsive-nav">
				<!-- category nav -->
				<div class="category-nav show-on-click">
					<div class="category-nav">
						<span class="category-header">Categories <i class="fa fa-list"></i></span>
						<ul class="category-list">			
								<li class="dropdown side-dropdown">
									<a class="dropdown-toggle" href = "./CategoryAPI?category=beverages">Beverages<i class="fa fa-angle-right"></i></a>
								</li>
								<li class="dropdown side-dropdown">
									<a class="dropdown-toggle" href = "./CategoryAPI?category=baking">Baking<i class="fa fa-angle-right"></i></a>
								</li>
							
								<li class="dropdown side-dropdown">
									<a class="dropdown-toggle" href = "./CategoryAPI?category=breakfast">Breakfast & Cereal<i class="fa fa-angle-right"></i></a>
								</li>
							
								<li class="dropdown side-dropdown">
									<a class="dropdown-toggle" href = "./CategoryAPI?category=frozenfood">Frozen Foods<i class="fa fa-angle-right"></i></a>
								</li>
							
								<li class="dropdown side-dropdown">
									<a class="dropdown-toggle" href = "./CategoryAPI?category=grain&pasta">Grains & Pasta<i class="fa fa-angle-right"></i></a>
								</li>
							
								<li class="dropdown side-dropdown">
									<a class="dropdown-toggle" href = "./CategoryAPI?category=produce">Produce<i class="fa fa-angle-right"></i></a>
								</li>
							</form>
						</ul>
					</div>
				</div>
				<!-- /category nav -->

				<!-- menu nav -->
				<div class="menu-nav">
					<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
					<ul class="menu-list">
						<li><a href="./index.jsp">Home</a></li>
						<li><a href="#">Shop</a></li>
					</ul>
				</div>
				<!-- menu nav -->
			</div>
		</div>
		<!-- /container -->
	</div>
	<!-- /NAVIGATION -->


	<!-- BREADCRUMB -->
	<div id="breadcrumb">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="#">Home</a></li>
				<li class="active">Checkout</li>
			</ul>
		</div>
	</div>
	<!-- /BREADCRUMB -->

	<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<form id="checkout-form" class="clearfix" action = "CheckoutAPI" method = "post" onSubmit = "return checkforblank()">
					<div class="col-md-6">
						<div class="billing-details">
						<% 
								if (username == null){
							%>
							<p>Already a customer ? <a href="./login.jsp">Login</a></p>
								<% }%>
							<div class="section-title">
								<h3 class="title">Billing Details</h3>
							</div>
							<div class="form-group">
								<input id = "name" class="input" type="text" name="name" placeholder="Name">
							</div>
							<div class="form-group">
								<input id = "email" class="input" type="email" name="email" placeholder="Email">
							</div>
							<div class="form-group">
								<input id = "address" class="input" type="text" name="address" placeholder="Address">
							</div>
							<div class="form-group">
								<input id = "city" class="input" type="text" name="city" placeholder="City">
							</div>
							<div class="form-group">
								<input id = "state" class="input" type="text" name="state" placeholder="State">
							</div>
							<div class="form-group">
								<input id = "country" class="input" type="text" name="country" placeholder="Country">
							</div>
							<div class="form-group">
								<input id = "zipcode" class="input" type="text" name="zip-code" placeholder="ZIP Code">
							</div>
							<div class="form-group">
								<input id = "tel" class="input" type="tel" name="tel" placeholder="Telephone">
							</div>
							<div class="form-group">
								<div class="input-checkbox">
									<input type="checkbox" id="register">
									<label class="font-weak" for="register">Create Account?</label>
									<div class="caption">
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt.
											<p>
												<input class="input" type="password" name="password" placeholder="Enter Your Password">
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-6">
						<div class="shiping-methods">
							<div class="section-title">
								<h4 class="title">Shiping Methods</h4>
							</div>
							<div class="input-checkbox">
								<input type="radio" name="shipping" id="shipping-1" checked>
								<label for="shipping-1">Free Shiping -  $0.00</label>
								<div class="caption">
									<p>Guaranteed within 3-5 business days
										<p>
								</div>
							</div>
							<div class="input-checkbox">
								<input type="radio" name="shipping" id="shipping-2">
								<label for="shipping-2">Standard - $4.00</label>
								<div class="caption">
									<p>Guaranteed within 1-2 business days
										<p>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="order-summary clearfix">
							<div class="section-title">
								<h3 class="title">Order Review</h3>
							</div>
							<table class="shopping-cart-table table">
								<thead>
									<tr>
										<th>Product</th>
										<th></th>
										<th class="text-center">Price</th>
										<th class="text-center">Quantity</th>
										<th class="text-center">Total</th>
										<th class="text-right"></th>
									</tr>
								</thead>
								<tbody>
									<%
										if(session.getAttribute("cart") != null) {
									%>
									<c:forEach items="${list}" var="item">
										<tr>
											<td class="thumb"><img src="${item.img}" alt=""></td>
											<td class="details">
												<a href="#">${item.name}</a>
												<ul>
													<li><span>${item.description}</span></li>
													
												</ul>
											</td>
											<td class="price text-center"><strong>${item.price}</strong><br></td>
											<td class="qty text-center"><input class="input" type="number">${item.quantity}</td>
											<td class="total text-center"><strong class="primary-color">${item.price*item.quantity}</strong></td>
											<td class="text-right"><button class="main-btn icon-btn"><i class="fa fa-close"></i></button></td>
										</tr>
										</tbody>
									</c:forEach>
										<tfoot>
											<tr>
												<th class="empty" colspan="3"></th>
												<th>SUBTOTAL</th>
												<th colspan="2" class="sub-total">$ <%= request.getSession().getAttribute("total")%></th>
											</tr>
											<tr>
												<th class="empty" colspan="3"></th>
												<th>SHIPING</th>
												<td colspan="2">Free Shipping</td>
											</tr>
											<tr>
												<th class="empty" colspan="3"></th>
												<th>TOTAL</th>
												<th colspan="2" class="total">$ <%= request.getSession().getAttribute("total")%></th>
											</tr>
										</tfoot>
									<%
										}else{
									%>
									<tr>
										<h2>Empty Cart</h2>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<th class="empty" colspan="3"></th>
										<th>SUBTOTAL</th>
										<th colspan="2" class="sub-total">$0.00</th>
									</tr>
									<tr>
										<th class="empty" colspan="3"></th>
										<th>SHIPING</th>
										<td colspan="2">Free Shipping</td>
									</tr>
									<tr>
										<th class="empty" colspan="3"></th>
										<th>TOTAL</th>
										<th colspan="2" class="total">$0.00</th>
									</tr>
								</tfoot>
								<%}%>
							</table>
							<div class="pull-right">
								<button class="primary-btn">Checkout</button>
							</div>
						</div>

					</div>
				</form>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /section -->

	<!-- FOOTER -->
	<footer id="footer" class="section section-grey">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!-- footer widget -->
				<div class="col-md-3 col-sm-6 col-xs-6">
					<div class="footer">
						<!-- footer logo -->
						<div class="footer-logo">
							<a class="logo" href="#">
		            <img src="./img/MunchiesLogo.jpg" alt="">
		          </a>
						</div>
						<!-- /footer logo -->
					</div>
				</div>
				<!-- /footer widget -->

				<!-- footer widget -->
				<% 
					if (username == null){
				%>
				<div class="col-md-3 col-sm-6 col-xs-6">
					<div class="footer">
						<h3 class="footer-header">My Account</h3>
						<ul class="list-links">
							<li><a href="./login.jsp">Login</a></li>
							<li><a href="./register.jsp">Register</a></li>
						</ul>
					</div>
				</div>
				<%} else {%>
				<div class="col-md-3 col-sm-6 col-xs-6">
					<div class="footer">
						<h3 class="footer-header">My Account</h3>
						<ul class="list-links">
							<li><a href="#">My Account</a></li>
							<li><a href="./checkout.jsp">Checkout</a></li>
							<li><a href="./TransactionAPI?username=${userid}">History</a></li>
						</ul>
					</div>
				</div>
				<%}%>
				<!-- /footer widget -->

				<div class="clearfix visible-sm visible-xs"></div>

				<!-- footer widget -->
				<div class="col-md-3 col-sm-6 col-xs-6">
					<div class="footer">
						<h3 class="footer-header">Customer Service</h3>
						<ul class="list-links">
							<li><a href="#">About Us</a></li>
							<li><a href="#">FAQ</a></li>
						</ul>
					</div>
				</div>
				<!-- /footer widget -->
			</div>
			<!-- /row -->
			<hr>
			<!-- row -->
			<div class="row">
				<div class="col-md-8 col-md-offset-2 text-center">
					<!-- footer copyright -->
					<div class="footer-copyright">
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</div>
					<!-- /footer copyright -->
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</footer>
	<!-- /FOOTER -->
	
	<script type = "text/javascript">
		
	</script>
	
	
	<script type = "text/javascript">
	
	function checkforblank(){
		
		var errormessage = "";
	if(document.getElementById('name').value == ""){
			errormessage += "Name is required \n";
		}
		if(document.getElementById('email').value == "" || document.getElementById('email').value.includes("@")){
			errormessage += "Valid email is required \n";
		}
		if(document.getElementById('address').value == ""){
			errormessage += "Address is required \n";
		}
		if(document.getElementById('city').value == ""){
			errormessage += "City is required \n";
		}
		if(document.getElementById('state').value == ""){
			errormessage += "state is required \n";
		}
		if(document.getElementById('country').value == ""){
			errormessage += "Country is required \n";
		}
		if(document.getElementById('zipcode').value == ""){
			errormessage += "Zip Code is required \n";
		}
		if(document.getElementById('tel').value == ""){
			errormessage += "Telephone number is required \n";
		}
		if(errormessage != ""){
			alert(errormessage);
			return false;
		}
	
			
	}
	</script>

	<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>

</body>

</html>
