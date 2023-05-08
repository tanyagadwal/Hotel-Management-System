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
Statement pstmt= null;
ResultSet rs= null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
table{
 background-color: rgba(0,0,0,0.2);}
</style>
</head>
<body >
<br>
<%
String msg=request.getParameter("msg");
if(msg=="valid"){
%>
<font color="red" size="5">Successfully updated</font>
<%}
if(msg=="invalid"){
%>
<font color="red" size="5">Some thing went wrong! try again!</font>
<%}%>

<h1 style="text-align:center">Employee Details</h1>

<div class="main">
  <table class="table">
   <thead class="thead-dark">
  <tr>
  <th>ID</th>
  <th>Name</th>
  <th>Age</th>
  <th>Gender</th>
  <th>Department</th>
  <th>Salary</th>
  <th>Phone No</th>
  <th>Aadhar No</th>
  <th>Email</th>
  <th>Edit</th>
  <th>Delete</th>
  </tr>
    </thead>
 <%
 try {
		connect=DriverManager.getConnection(DB_URL,USER,PASS);
		pstmt=connect.createStatement();
		String query="select *from Employee";
		rs=pstmt.executeQuery(query);	
		while(rs.next()){
 %>
		<tr>
		<td><%=rs.getInt(1)%></td>
		<td><%=rs.getString(2)%></td>
		<td><%=rs.getInt(3)%></td>
		<td><%=rs.getString(4)%></td>
		<td><%=rs.getString(5)%></td>
		<td><%=rs.getInt(6)%></td>
		<td><%=rs.getString(7)%></td>
		<td><%=rs.getString(8)%></td>
		<td><%=rs.getString(9)%></td>
		<td><a href="updateEmployee.jsp?empId=<%=rs.getString(1) %>"><button  type="button"  class="update">Edit</button></a></td>		
		<td><a href="delete.jsp?empId=<%=rs.getString(1) %>"><button  type="button"  class="delete">Delete</button></a></td>
		
		</tr>	
		
 <%
 }connect.close();}
 catch(Exception ex){out.print(ex);}
 %>
</table>
</div>
<a href="Employee.jsp"><button type="button" id="submit">Back</button></a>
</body>
</html>
