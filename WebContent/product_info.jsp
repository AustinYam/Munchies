<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList, org.elluck91.munchies.Product" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if (request.getAttribute("productList") != null) {
	ArrayList<Product> itemsArray = (ArrayList<Product>) request.getAttribute("productList");

	Product temp;
 	for (int i=0; i < itemsArray.size(); i++) {
 		temp = itemsArray.get(i);
 		
 		out.println(temp.toString());
 	}
}
else {
	out.println("no data in array");
}	
%>

<c: forEach items = ${productList} var = "product">
	<tr>
		<td><c:out value = "${product.name}"/></td>
		<td>><c:out value = "${product.uniqueName}"/></td>
		<td>><c:out value = "${product.price}"/></td>
		<td>><c:out value = "${product.description}"/></td>
		<td><img src = "${product.imgUrl}"></td>
	</tr>
</c: forEach>

</body>
</html>