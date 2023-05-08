<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>   
<%@page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
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
PreparedStatement pstmt=null;
String query=null;
%>

<%
int empId=Integer.parseInt(request.getParameter("empId"));
String empName=request.getParameter("empName");
int empAge=Integer.parseInt(request.getParameter("empAge"));
String empDepartment=request.getParameter("empDepartment");
int empSalary=Integer.parseInt(request.getParameter("empSalary"));
String empPhNo=request.getParameter("empPhNo");
String empEmail=request.getParameter("empEmail");
try{
	connect=DriverManager.getConnection(DB_URL,USER,PASS);
	pstmt=connect.prepareStatement("update Employee set empName=?,empAge=?,empDepartment=?,empSalary=?,empPhNo=?,empEmail=? where empId=?");
	pstmt.setString(1,empName);
	pstmt.setInt(2,empAge);
	pstmt.setString(3,empDepartment);
	pstmt.setInt(4,empSalary);
	pstmt.setString(5,empPhNo);
	pstmt.setString(6,empEmail);
	pstmt.setInt(7,empId);
	pstmt.executeUpdate();
	response.sendRedirect("deleteEmployee.jsp?msg=valid");
	

	
	
}catch(Exception e)
{
	response.sendRedirect("deleteEmployee.jsp?msg=Invalid");
}
%>
