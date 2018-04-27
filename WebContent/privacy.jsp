<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList, org.elluck91.munchies.Product" %>

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
							<form action = "ProductSearchAPI">
								<input class="input" type="text" name = "product_name" placeholder="Enter your keyword">
								<button class="search-btn" type = "submit"><i class="fa fa-search"></i></button>
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
									<!--add quanitity iterator-->
									<c:set var = "quantity" value = "0"/>
									<c:forEach items = "${cart.getProductList()}" var = "record">
										<c:set var = "quantity" value = "${quantity+record.getProduct_quantity()}"/>
									</c:forEach>
									<span class="qty"><c:out value = "${quantity}"/></span>
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
									<c:set var = "total" value = "0.00"/>
									<c:forEach items = "${cart.getProductList()}" var = "record">
										<c:set var = "total" value = "${total + record.getProduct_price()*record.getProduct_quantity()}"/>
									</c:forEach>
									<span>$<c:out value = "${total}"/></span>
									<%}%>
							</a>
							<div class="custom-menu">
								<div id="shopping-cart">
									<div class="shopping-cart-list">
										<%
											if (request.getSession().getAttribute("cart") != null){
										%>
										<c:forEach items = "${cart.getProductList()}" var = "product">
											<div class="product product-widget">
												<div class="product-thumb">
													<img src= "${product.getProduct_img()}" alt="nope">
												</div>
												<div class="product-body">
													<h3 class="product-price"><a href="./ProductAPI?product_id=${product.getProduct_id()}"><c:out value = "${product.getProduct_uniquename()}"/></a></h2>
													<h3 class="product-name">price: $<span class="qty"><c:out value = "${product.getProduct_price()}"/></span></h3>
													<h3 class="product-name">qty: <span class="qty"><c:out value = "${product.getProduct_quantity()}"/></span></h3>
												</div>
												<form action="CartAPI" method = "post">
													<input type="hidden" value="delete" name="action">
													<input type="hidden" value="${product.getProduct_id() }" name="product_id">
													<input name="username" type="hidden" value="${userid}">
													<input name="page" type="hidden" value="privacy">
													<button class="cancel-btn" type = "submit"><i class="fa fa-trash"></i></button>
												</form>
											</div>
										</c:forEach>
										<%}else{%>
										<div class="product product-widget">
											<div class="product-thumb">
												<img src="./img/thumb-product01.jpg" alt="">
											</div>
											<div class="product-body">
												<h3 class="product-price"><span class="qty"></span></h3>
												<h2 class="product-name"><a href="#">Cart is Empty</a></h2>
											</div>
											<button class="cancel-btn"><i class="fa fa-trash"></i></button>
										</div>
										<%}%>
									</div>
									<div class="shopping-cart-btns">
										<a href = "./checkout.jsp" button class="primary-btn" >Checkout <i class="fa fa-arrow-circle-right"></i></a>
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
						</ul>
					</div>
				</div>
				<!-- /category nav -->

				<!-- menu nav -->
				<div class="menu-nav">
					<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
					<ul class="menu-list">
						<li><a href="./index.jsp">Home</a></li>
					</ul>
				</div>
				<!-- menu nav -->
			</div>
		</div>
		<!-- /container -->
	</div>
	<!-- /NAVIGATION -->


	<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!-- ASIDE -->
				
				<!-- /ASIDE -->

				<!-- MAIN -->
				<div id="main" class="col-md-9">
					<!-- store top filter -->
					<div class="store-filter clearfix">
						<div class="pull-left">
						</div>
						<div class="pull-right">
						</div>
					</div>
					<!-- /store top filter -->

					<!-- STORE -->
								<div class="col-md-12">
						<div class="order-summary clearfix">
							<div class="section-title">
								<h3 class="title">Privacy Page</h3>
								<p>At Munchies, we want you to know how we collect, use, share, and protect information about you. By interacting with Munchies through our stores, websites, mobile applications, products, and services, you consent to the use of information that is collected or submitted as described in this privacy policy. We may change or add to this privacy policy, so we encourage you to review it periodically.

What information is collected?
Third-party automated collection and interest-based advertising
How is your information used?
How is your information shared?
What choices do you have?
California residents?
How do you access and update your personal information?
How is your personal information protected?
Children’s personal information
How do you contact Munchies?
Types of information we collect may include:

Name
Mailing address
E-mail address
Phone (or mobile) number
Date of birth or age
Driver’s license number
Credit/debit card number
Purchase/return/exchange information
Registry or list information
Your mobile device information (e.g., device model, operating system version, device date and time, unique device identifiers, mobile network information)
How you use our sites and mobile applications, search terms, pages you visit on our mobile applications and application performance, as discussed further below
Geo-location and in-store location
Social media information (e.g., ID, profile picture, gender, age range, friends’ IDs)
If you choose not to provide information, we may not be able to provide you with requested products, services or information.

automated information collection
We may connect information collected automatically with information we already have about you in order to identify you as a Munchies guest. If we are able to identify you as a Munchies guest we may, for example, link your activity on our website to your activity in a Munchies store or on one of our mobile applications. This allows us to provide you with a personalized experience regardless of how you interact with us – online, in store, mobile, etc.

In order to provide the best guest experience possible, we also use automated information collection technologies for reporting and analysis purposes. We examine metrics such as how you are shopping on our website, in our stores, and on our mobile applications, the performance of our marketing efforts, and your response to those marketing efforts.

Munchies Automated Collection

We and our service providers use cookies, web beacons, and other technologies to receive and store certain types of information whenever you interact with us or third-parties that use our services through your computer or mobile device. This information, which includes, but is not limited to: the pages you visit on our site or mobile application, ads you click on, which web address you came from, the type of browser/device/hardware you are using, purchase information and checkout process, search terms, and IP-based geographic location, helps us recognize you, customize your website experience and make our marketing messages more relevant. This includes Munchies content presented on another website or mobile application, for example, Munchies Weekly Ad. These technologies also enable us to provide features such as storage of items in your cart between visits. In addition to other technologies, we use Flash cookies to prevent fraud or other harmful activities.

cross-context and cross-device identification, advertising, personalization, and advertising attribution
Cross-Context

We merge data collected from our own websites, such as www.Munchies.com and www.weeklyad.Munchies.com , and our mobile apps, such as our Munchies and Cartwheel apps. Data collected includes cookie IDs, device Advertising IDs (such as Apple’s Identifier for Advertising and Google’s Advertising ID); transactions and browsing history; your interaction with our online and mobile advertisements, including advertisements we serve within our emails and advertisements that we serve on behalf of third parties through the Munchies Media Network; information about ads we serve, such as which ad was served, your interactions with the ads, and the URLs where the ads are served from marketing partners such as Google DoubleClick for Publishers and Google DoubleClick Campaign Manager ; the email address we have on file for you; any Registry information you have provided us; demographic and other information regarding your likely commercial interests from third parties; and in-store transaction data. This combination of data enables us to see users’ and Guests’ web activity on Munchies websites, app activity on Munchies apps, and interactions with our online and mobile advertisements and advertisements that we serve on behalf of third parties through the Munchies Media Network, to create a single set of information from all of the various contexts with which we or our partners interact with you, and to understand how well Munchies’s advertisements and advertisements that Munchies serves for third parties through the Munchies Media Network perform in terms of translating to transactions online, in app, and in Munchies’s stores and the stores of our third-party advertisers. It also helps us improve our users’ and Guests’ experience by delivering more personalized advertising, including email advertising, social media advertising, and paid search advertising, and helps us create more personalized online and in-app experiences. We share information on the performance of advertisements Munchies serves for third parties with our advertising partners in aggregate form

Cross-Device

We may also link your various devices so that content you see on one device can result in relevant advertising on another device. We do this using both deterministic and statistical methods. The deterministic means of linking devices and browsers uses data such as a consumer logging into a single account on multiple devices. The statistical means using data about your devices or browsers that help identify devices, such as partial or full IP address and browser version. We use this data to help us determine if two or more devices are linked to a single consumer or household. We can then use this linkage to serve interest-based advertising (IBA) and other content to you across your devices and to allow us to perform analytics and measurement of the performance of advertising campaigns. This allows us to deliver more relevant and consistent advertising to you (for example, if you purchase a product on our website using your desktop, we’re able to avoid showing you an advertisement on the same product on your tablet. Instead, we may show you an ad on your tablet for complimentary products to the one you just purchased on our website). We also measure the performance of such ads and deliver information on advertising performance to our advertising partners in aggregate form.

Your Choices

To opt-out of the vendors we use for cross-device linking, go to the Digital Advertising Alliance’s Choices page at www.aboutads.info/choices and perform a global opt-out on each browser and device that you would like to be opted out on. Opting out in this manner means that the browser on the device from which you opt-out will no longer receive information collected on devices linked to it, that devices linked to it will not receive information collected from the opted-out device, and that the vendor will not transfer information collected from the opted-out device to a third party. Please note that this will not opt you out of cross-device linking or advertising across linked devices based solely on your visits to Munchies websites or apps, or your interaction with advertisements for Munchies delivered by Munchies

The opt-out tool described above is Cookie-based. Therefore, the opt-out will only function if your browser is set to accept third-party cookies, and it may not function where cookies are automatically disabled or removed. If you delete cookies, change your browser settings, switch browsers or computers, or use another operating system, you will need to opt-out again.

Third-Party Automated Collection and Interest-Based Advertising

Munchies participates in interest-based advertising (IBA), also known as Online Behavioral Advertising. We use third-party advertising companies to display ads tailored to your individual interests based on how you browse and shop online, as well as to provide advertising-related services such as ad delivery, reporting, attribution, analytics, and market research. Munchies adheres to the Digital Advertising Alliance (DAA) self-regulatory principles for IBA.

We allow third-party companies to collect certain information when you visit our websites or use our mobile applications. This information is used to serve ads for Munchies products or services or for the products or services of other companies when you visit this website or other websites. These companies use non-personally-identifiable information (e.g., click stream information, browser type, time and date, subject of advertisements clicked or scrolled over, hardware/software information, cookie and session ID) and personally identifiable information (e.g., static IP address) during your visits to this and other websites in order to provide advertisements about goods and services likely to be of greater interest to you or advertising-related services, such as ad delivery, reporting, attribution, analytics, and market research. These parties typically use a cookie, web beacon or other similar tracking technologies to collect this information.

our do not track policy
Some browsers have a ”do not track” feature that lets you tell websites that you do not want to have your online activities tracked. At this time, we do not respond to browser ”do not track” signals, but we do provide you the option to opt out of interest-based advertising. To learn more about IBA or to opt-out of this type of advertising, visit the Network Advertising Initiative website and the Digital Advertising Alliance website. Options you select are browser- and device-specific.

mobile location information
If you use a mobile device, your device may share location information (when you enable location services) with our websites, mobile applications, services, or our service providers. We use this information to improve our services, and provide you more relevant and personalized advertisements, services, and promotions. For example, precise geo-location can be used to identify your device’s latitude and longitude or your device’s location capabilities (e.g., GPS or Wi-Fi) to help you find nearby Munchies stores. Or, in-store location through the use of your phone’s blue tooth signal, LED light chip technologies or other technologies will permit Munchies to find nearby products for you, get you real-time deals, auto-sort your shopping list and more. To manage how you share your device’s location settings, go to the Choices section of this privacy policy.

user experience information
In order to improve guest online and mobile shopping experiences, help with fraud identification, and assist our guest relations representatives in resolving issues guests may experience in completing online purchases, we use tools to monitor certain user experience information; including login information, IP address, data regarding pages visited and ads clicked, specific actions taken on pages visited (e.g., information entered during checkout process), browser and device information.

Munchiesed TV Ads
We may display Munchiesed ads to you through your cable or satellite TV provider. These ads are sent to groups of people who share traits such as likely commercial interests and demographics. For example, we may Munchies TV ads to guests who have expressed an interest in shopping for groceries, cosmetics, clothing, etc. The ads may also be based on personal information you have provided your cable or satellite TV provider. We do not share any of your personal information, including your shopping history, with your cable or satellite TV provider. See your cable or satellite TV provider’s privacy policy for additional information about Munchiesed TV Ads, including how you can opt-out of receiving such ads.

social media
Munchies engages with guests on multiple social media platforms (e.g., Facebook, Twitter, and Pinterest). If you contact us on one of our social media platforms, request guest service via social media, or otherwise direct us to communicate with you via social media, we may contact you via direct message or use other social media tools to interact with you. In these instances, your interactions with us are governed by this privacy policy as well as the privacy policy of the social media platform you use.

Social Media Widgets

Our sites and mobile applications include social media features, such as the Facebook Like button, Google Plus, Pinterest, and Twitter widgets. These features may collect information about you such as your IP address and which page you’re visiting on our site. They may set a cookie or employ other tracking technologies to accomplish this. Social media features and widgets may be hosted by a third party. Your interactions with those features are governed by the privacy policies of the companies that provide them.

Social Media Ads

We may display Munchiesed ads to you through social media platforms. These ads are sent to groups of people who share traits such as likely commercial interests and demographics. For example, we may Munchies guests who have expressed an interest in shopping for groceries, cosmetics, clothing, etc. See the policies of each social media platform for additional information about these types of ads.

information from other sources
We collect data that is publicly available. For example, information you submit in a public forum (e.g., a blog, chat room, or social network) can be read, collected or used by us and others, and could be used to personalize your experience. You are responsible for the information you choose to submit in these instances.

We also obtain information provided by third parties. For instance, we obtain demographic and other information from companies that can enhance our existing guest information to improve the accuracy and add to the information we have about our guests (e.g., adding address information).

This improves our ability to contact you and increases the relevance of our marketing by providing better product recommendations or special offers that may interest you.

store cameras
We use cameras in and around our stores for security purposes and for operational purposes such as measuring traffic patterns and tracking in-stock levels. Cameras in some stores may use biometrics, including facial recognition to assist with theft, fraud prevention and security.

how is your information used?
How is your information used?
Examples of how we use the information we collect include:

product & service fulfillment
Fulfill and manage purchases, orders, payments, and returns/exchanges
Respond to requests for information about our products and services in our stores, on our websites or mobile applications, or to otherwise serve you
Connect with you regarding guest service via our contact center, guest service desk, or on social media or internet chat platforms
Provide services such as Gift Registry or a shopping list
Manage subscription services, including order management, billing, improving reorder experiences, communicate with you about your subscription, and offer other products and services that may be of interest to you
Fulfill benefits associated with use of our services, such as delivery of Welcome kits, to award and redeem points through our loyalty programs, etc.
Administer sweepstakes and contests
Conduct a transaction where we collect information required by law (for example, pseudoephedrine or age-restricted purchases)
Allow you to, using our mobile applications: find a store nearest to your location via Store Finder, show you a map of the store (if available), sign up for coupons, search for products and check availability, check prices, provide product ratings and reviews, track your orders, scan a UPC barcode or QR code, use voice recognition to add to your list, update information, etc.
our purposes (including but not limited to marketing)
Deliver coupons, mobile coupons, newsletters, in-store receipt messages, e-mails, mobile messages, and social media notifications
Provide interactive features of the website or mobile applications, such as product reviews or Weekly Ad, send marketing communications and other information regarding products, services and promotions
Administer promotions, surveys, and focus groups
internal operations
Improve the effectiveness of our website, stores, mobile experience, products, services, and marketing efforts
Conduct research and analysis, including focus groups and surveys
Perform other business activities as needed, or as described elsewhere in this policy
prevention of fraud & other harm
Prevent fraudulent transactions, monitor against theft and otherwise protect our guests and our business (e.g., product recalls)
legal compliance
For example, assist law enforcement and respond to legal/regulatory inquiries
how is your information shared?
Munchies subsidiaries & affiliates
We share the information we collect within Munchies Corporation, which includes all Munchies subsidiaries and affiliates. Munchies Corporation may use this information to offer you products and services that may be of interest to you.

Munchies Corporation owns and operates Munchies stores, websites, mobile applications, and issues the Munchies Debit Card. Munchies Corporation subsidiaries and affiliates include, but are not limited to: Retail Activation Services LLC (Consensus Corporation) and Dermstore LLC.

card-issuing bank
We may share the information we collect with our banking partner, TD Bank USA N.A., which issues the Munchies MasterCard and Munchies Credit Card.

service providers
We may share the information we collect with companies that provide support services to us (such as printers, e-mail providers, mobile marketing services, analytics providers, web hosting providers, call center/chat providers, sweepstakes vendors, payment processors, coupon delivery vendors, data enhancement services, fraud prevention providers or shipping services providers, including product vendors) or that help us market our products and services. These companies may need information about you in order to perform their functions.

registries and shopping lists
If you create a gift registry or shopping list, your information will be accessible on our website, mobile or social applications, on partner registries, and on kiosks in stores. If you purchase an item from a registry or shopping list, information such as your billing name and address will be made available to the owner(s).

legal requirements
We may disclose information we collect when we believe disclosure is appropriate to comply with the law; to enforce or apply applicable terms and conditions and other agreements; to facilitate the financing, securitization, insuring, sale, assignment, bankruptcy, or disposal of all or part of our business or assets; or to protect the rights property or safety of our company, our guests or others.

elsewhere at your direction
At your direction or request, or when you otherwise consent, we may share your information.

sharing with other companies (for their marketing purposes)
We may share your personal information with other companies, or organizations which are not part of Munchies. These companies and organizations may use the information we share to provide special offers and opportunities to you. To opt-out of our sharing of your personal information with such companies and organizations, go to the Choices section of this privacy policy.

sharing non-identifiable or aggregate information with third parties
We may share non-identifiable or aggregate information with third parties for lawful purposes.

business transfers
In connection with the sale or transfer of some or all of our business assets, we may transfer the corresponding information regarding our guests. We also may retain a copy of that guest information.

what choices do you have?
postal mail
If you do not wish to receive catalogs, coupons, and other promotional postal mail, email guest.relations@Munchies.com with your first and last name and complete mailing address or call 800-440-0680 to opt-out.

telephone
If you do not wish to receive promotional telephone calls, email guest.relations@Munchies.com with your first and last name and telephone number or call 800-440-0680 to opt-out.

e-mail
If you do not wish to receive promotional e-mails from us, email guest.relations@Munchies.com or call 800-440-0680 to opt-out. You also have the ability to unsubscribe from promotional e-mails via the unsubscribe link included in each promotional e-mail. You may continue to receive program-specific marketing emails through a program such as, but not limited to, A Bullseye View, or Munchies Photo. You can unsubscribe from program-specific emails via the unsubscribe link located at the bottom of those program-specific emails.

This opt-out does not apply to operational emails (e.g., surveys, product reviews).

mobile
Text Messages

We may send text messages you have consented to receive.

You can cancel text messages at any time by texting "STOP". After you send "STOP", we may send you an additional text message to confirm that you have been unsubscribed. You will no longer receive text messages from that short code, but you may receive text messages if you are subscribed to other text lists.

If at any time you have questions about the text messages, text "HELP". After you send "HELP" we will respond with instructions on how to use our service as well as how to unsubscribe.

Message and data rates may apply.

Push Notifications

You may at any time opt-out from further allowing Munchies to send you push notifications by adjusting the permissions in your mobile device.

Geo-location and in-store location

You may prevent your mobile device from sharing your precise geo- location data by adjusting the permissions on your mobile device or within the relevant app.

Uninstall a Munchies Mobile Application

You can stop all further collection of information by a Munchies mobile application by uninstalling the Munchies mobile application. You may use the standard uninstall process available as part of your mobile device or via the mobile application marketplace or network.

Note: If you uninstall the mobile application from your device, the Munchies unique identifier associated with your device will continue to be stored. If you re-install the application on the same device, Munchies will be able to re-associate this identifier to your previous transactions and activities.

sharing with other companies (for their marketing purposes)
If you do not wish us to share the personal information we have collected with other unaffiliated companies (for their marketing purposes), email this request to guest.relations@Munchies.com with your first and last name and complete mailing address or call 800-440-0680 to opt out.

cookies, tracking & interest-based advertising
The help function of your browser should contain instructions on how to set your computer to accept all cookies, to notify you when a cookie is issued or to not receive cookies at any time. If you set your device to not receive cookies at any time, certain personalized services cannot be provided to you, and accordingly, you may not be able to take full advantage of all of our features (i.e. you will be able to browse the site, but will not be able to make a purchase).

Interest-based advertising

To opt-out of our interest-based advertising for Munchies’s goods and services or those of another party, online and in third-party mobile applications, visit Digital Advertising Alliance’s Choices page at http://optout.aboutads.info and perform a global opt-out.

Other Web Site Analytics Services

Analytics services such as Site Catalyst by Adobe Analytics and Google Analytics provide services that analyze information regarding visits to our websites and mobile applications. They use cookies, web beacons, and other tracking mechanisms to collect this information.

To learn about Adobe Analytics privacy practices or to opt-out of cookies set to facilitate reporting, click here.
To learn more about Google’s privacy practices, click here. To access and use the Google Analytics Opt-out Browser Add-on, click here.
California residents?
california residents
If you are a California resident and have an established business relationship with us, you can request a notice disclosing the categories of personal information we have shared with third parties, for the third parties’ direct marketing purposes, during the preceding calendar year. To request a notice, please submit your request to Munchies Corporation, Attn: California Shine the Light Inquiry, P.O. Box 9350 Minneapolis, MN 55440. Please allow 30 days for a response.

If you are a California resident under 18 years old and a registered user, you can request that we remove content or information that you have posted to our website or other online services. Note that fulfilment of the request may not ensure complete or comprehensive removal (e.g., if the content or information has been reposted by another user). To request removal of content or information, please email guest.relations@Munchies.com or call 800-440-0680.

how do you access & update your personal information?
In order to keep your personal information accurate and complete, you can access or update some of it in the following ways:

If you have created a Munchies.com account, you can log in to review and update your account information, including contact, billing, and shipping information.
Email guest.relations@Munchies.com or call 800-440-0680 with your current contact information and the personal information you would like to access. We will provide you the personal information requested if reasonably available, or will describe the types of personal information we typically collect.
how is your personal information protected?
security methods
We maintain administrative, technical, and physical safeguards to protect your personal information. When we collect or transmit sensitive information such as a credit or debit card number, we use industry standard methods to protect that information. However, no e-commerce solution, website, mobile application, database or system is completely secure or “hacker proof.” You are also responsible for taking reasonable steps to protect your personal information against unauthorized disclosure or misuse.

children’s personal information
We recognize the particular importance of protecting privacy where children are involved. We do not knowingly collect personal information online from children under the age of 13. If a child under the age of 13 has provided us with personal information online, we ask that a parent or guardian email guest.relations@Munchies.com or call 800-440-0680.

how do you contact Munchies?
mail
Munchies Stores

Munchies Executive Offices

PO Box 9350

Minneapolis, MN 55440

phone
800-440-0680

email
guest.relations@Munchies.com

Munchies privacy policy scope
This privacy policy applies to all current or former guest personal information, except for information collected by or provided in connection with:

A Munchies Debit Card. See the Munchies Debit Card Privacy Policy.
A Munchies MasterCard or a Munchies Credit Card. See the Munchies Credit Card Privacy Policy. Note, contact information you provide on a Munchies Credit Card application is provided to both TD Bank USA N.A. and to Munchies and its affiliates.
Use of Munchies’s Wireless Service. See the Munchies Wireless Service Privacy Policy.
Completing an application for employment with Munchies.
Our website may offer links to other sites. If you visit one of these sites, you may want to review the privacy policy on that site. In addition, you may have visited our website through a link or a banner advertisement on another site. In such cases, the site you linked from may collect information from people who click on the banner or link. You may want to refer to the privacy policies on those sites to see how they collect and use this information.

last update: 08/01/2017
Under What Information Is Collected section – clarified collection, use, and management of location Information in the Mobile Location Information paragraph and updated the use of Social Media Widgets paragraph.
Under How is Your Information Used section – added information about subscription services.
Under Choice section – clarified how to manage location information under the Geo-Location and In-Store Location paragraph.
Under Store Cameras section – added information about the use of cameras for biometrics to assist with theft, fraud prevention and security</p>
							</div>
							<div class="pull-right">
							<!--	<button class="primary-btn">Checkout</button>-->
							</div>
						</div>
					</div>
					<!-- /STORE -->

					<!-- store bottom filter -->
					<div class="store-filter clearfix">
						<div class="pull-left">

						</div>
						<div class="pull-right">
							
						</div>
					</div>
					<!-- /store bottom filter -->
				</div>
				<!-- /MAIN -->
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
							<li><a href="./aboutus.jsp">About Us</a></li>
							<li><a href="./privacy.jsp">Privacy</a></li>
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
						Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" Munchies="_blank">Colorlib</a>
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

	<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>

</body>

</html>