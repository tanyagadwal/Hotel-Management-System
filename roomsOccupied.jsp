<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
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
Statement pstmt= null;
ResultSet rs= null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display Room Details</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="background.css">
<style>
 
h1{
margin-left:500px;
}
#start{
background-color:#FFEEB3;}
table{
    background-color:#FA9884;
    width:100%;
    font-size: 18px;
    border-radius: 10px;
    margin-top:50px;
    margin-bottom:25px;
    margin-left:0px;
 }
 table,th,td{
	border:1.5px solid;
	width:10px;
	border-collapse:collapse;
}
th, td {
    padding: 8px;
    border-bottom: 1px solid #0a0909;
}
tr:hover{
	background-color:rgba(0,0,0,0.2);
}
</style>
</head>
<body >
<br>
<h1 >Room Details</h1>

  <table style="width:100%">
  <tr>
  <th>Room ID</th>
  <th>Customer ID</th>
  <th>checkIn Date</th>
  <th>checkOut Date</th>
  <th>Deposite</th>
  <th>Booking Date</th>
  </tr>
 <%
 try {
		connect=DriverManager.getConnection(DB_URL,USER,PASS);
		pstmt=connect.createStatement();
		String query="select *from custRoom";
		rs=pstmt.executeQuery(query);	
		while(rs.next()){
 %>
		<tr>
		<td><%=rs.getInt(2)%></td>
		<td><%=rs.getInt(1)%></td>
		<td><%=rs.getDate(3)%></td>
		<td><%=rs.getDate(4)%></td>
		<td><%=rs.getInt(5)%></td>
		<td><%=rs.getDate(6) %></td>
		</tr>	
		
 <%
 }connect.close();}
 catch(Exception ex){out.print(ex);}
 %>
</table>
 <a href="Room.jsp"><button type="button" id="submit" class="btn btn-success">Back</button></a>
</body>
</html>