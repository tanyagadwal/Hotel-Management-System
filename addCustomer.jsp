<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<% 
String JDBC_DRIVER="com.mysql.cj.jdbc.Driver";
String DB_URL="jdbc:mysql://127.0.01:3306/DBMSProject?autoReconnect=true&useSSL=false";
String USER="root";
String PASS="Mysql@123";  

try {
Class.forName(JDBC_DRIVER);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connect=null;
PreparedStatement pstmt=null;

ResultSet rs= null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Customer Registration</title>
<link rel="stylesheet" href="addEmployeeStyles.css" type="text/css">

</head>
<body>
<form  action="addCustomer.jsp" method="post"  autocomplete="off">
 		<h1> HERE YOU CAN ADD CUSTOMER</h1><br>
        <label>Check In Date:</label><br>
        <input type="text" id="checkin" name="checkin">    
        <input type="submit" value="submit" name="submit" id="submit">		
</form>

 <%
String checkin=request.getParameter("checkin");
if(checkin!=null){%>
<div class="main">
    <div class="register">
      <h2>Add Customer</h2>
      <form id="register" action="addCustomer" method="post" autocomplete="off" >
       
        <label>Name:</label><br>
        <input type="text" name="name" id="name" placeholder="Enter name" required>
        <br><br>

        <label>Age:</label><br>
        <input type="number" name="age" id="name" placeholder="Enter age" required>
        <br><br>
        
		 <label>Phone No:</label><br>
        <input type="tel" name="phNo" id="name" placeholder="xxx-xxx-xxxx" required pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"><br><br>
        
		<label >Aadhar No:</label><br>
        <input type="tel" name="aadharNo" id="name" placeholder="xxxx-xxxx-xxxx"  required pattern="[0-9]{4}-[0-9]{4}-[0-9]{4}"><br><br>
        
        <label >Country:</label><br>
        <input type="text" name="country" id="name" placeholder="Enter country" required><br><br>
        
         
		<input type="hidden" id="checkIn" id="name" name="checkIn" value=<%= checkin %> required>
				
		<label >Enter checkout date:</label><br>		
		<input type="date" id="checkOut" name="checkOut" placeholder="Enter check out date" required><br><br>
		
		<label >Enter deposit:</label><br>
		<input type="number" id="deposit" name="deposit" placeholder="Enter deposit" ><br><br>		
		
		 
		
		
		
		<label>Room:</label><br><br>
		<select name="roomno">
				
		
		<% 
		try{
			Class.forName(JDBC_DRIVER);
			connect=DriverManager.getConnection(DB_URL,USER,PASS);
			String query="(select roomID from Room where roomID not in (select roomID from custRoom)) union (select roomID from custRoom where (checkOutDt)<?);";
			pstmt=connect.prepareStatement(query);
			pstmt.setString(1,checkin);
			rs=pstmt.executeQuery();
			while(rs.next()){
				out.print(rs.getInt("roomID"));
		%>
		 <option value="<%=rs.getInt("roomID")%>"><%=rs.getInt("roomID")%></option>
		
		<%
			}			
		}
		  catch(Exception ex){
			  out.print("not");
			  out.print(ex);}
				
		%>
		</select><br><br>
		
		
		<input type="submit" value="submit" name="submit" id="submit">
			
      </form>	

    </div><!--end register-->

  </div><!--end main-->
		<%} %>

<a href="Customer.jsp"><button type="button" id="submit">Back</button></a>
</body>
</html>