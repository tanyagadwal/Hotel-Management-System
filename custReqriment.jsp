<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="addEmployeeStyles.css" type="text/css">
</head>
<body>
<form  action="addCustomer.jsp" method="post">

 		<h1> HERE YOU CAN ADD CUSTOMER</h1><br><br>
        <label>Check In Date:</label><br><br>
        <input type="text" id="checkin" name="checkin"><br><br>
       
        <input type="submit" value="submit" name="submit" id="submit">
		
</form>

<a href="Customer.jsp"><button type="button" id="submit">Back</button></a>

<%    %>
</body>
</html>