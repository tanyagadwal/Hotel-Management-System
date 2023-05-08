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
Connection connect = null;
PreparedStatement ps=null;
Statement pstmt= null;
ResultSet rs= null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Amenity</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
body{
background-color:#96D4D4;
text-align:center;
}

</style>
</head>
<body>

<div>
<form action="custAmenity2.jsp" method="post">
<h3><label>Select Customer to get Amenity:</label></h3>
<select name="custID">
<% 
       try{
			connect=DriverManager.getConnection(DB_URL,USER,PASS);
			pstmt=connect.createStatement();
			String query="select distinct custID from custRoom";
     		rs=pstmt.executeQuery(query);
			while(rs.next()){
		%>
		 <option value="<%=rs.getInt(1)%>"><%=rs.getInt(1)%></option>
		
		<%
			}			
		}
		  catch(Exception ex){out.print(ex);}
				
		%>
		</select>
		<br><br>
		<h3><label>Select amenity</label></h3>
		<select name="custAmenity">
		<%
		try{
			connect=DriverManager.getConnection(DB_URL,USER,PASS);
			pstmt=connect.createStatement();
			String query="select amenityName from Amenities";
     		rs=pstmt.executeQuery(query);
			while(rs.next()){
		%>
		 <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
		
		<%
			}			
		}
		  catch(Exception ex){out.print(ex);}
				
		
		%>
		</select>		
		<br><br>
		<input type="checkbox"><label>Add Amenity</label>
		<br><br>
		<button type="submit" name="submitAinity" class="btn btn-success">Submit</button>
		
</form>
</div>
<a href="Customer.jsp"><button type="button" id="submit">Back</button></a>
</body>
</html>