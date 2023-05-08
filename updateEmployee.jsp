<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

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
Statement pstmt=null;
String query=null;
ResultSet rs= null;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	input{
	border:none;
	background:silver;
	heigth:50px;
	font-size:16px;
	padding:15px;
	width:60%;
	border:20%;
	}
	h2,h1{
	left-margin:20%;
	}
	hr{
	width:100%;
	}
</style>
</head>
<body>
<%
	int empId=Integer.parseInt(request.getParameter("empId"));
try
{
	
	connect=DriverManager.getConnection(DB_URL,USER,PASS);
	query="select *from Employee where empID="+empId;
	pstmt=connect.createStatement();
	query="select *from Employee where empID="+empId;	
	rs=pstmt.executeQuery(query);
	while(rs.next())	
	{	
%>
<div class="container">
<form action="updateEmployeeAction.jsp" method="post">
<input type="hidden" name="empId" value="<%=empId%>">
<h2>Name</h2>
<input type="text" name="empName" value="<%=rs.getString(2)%>">
<hr>
<h2>Age</h2>
<input type="number" value="<%=rs.getInt(3)%>" name="empAge">
<hr>
<h2>Department</h2>
<input type="text" value="<%=rs.getString(5)%>" name="empDepartment">
<hr>
<h2>Salary</h2>
<input type="number" value="<%=rs.getInt(6)%>" name="empSalary">
<hr>
<h2>Phone No.</h2>
<input type="tel" value="<%=rs.getString(7)%>" name="empPhNo" size="10">
<hr>
<h2>Email</h2>
<input type="text" value="<%=rs.getString(9)%>" name="empEmail" >
<br>
<button type="submit" class="submit" style="width:20%">Save</button>
</form>	
</div>
<%
	}
}
catch(Exception e)
{
	System.out.println(e);
}
%>
<a href="deleteEmployee.jsp"><button type="button" id="submit" class="btn btn-success">Back</button></a>
</body>
</html>
