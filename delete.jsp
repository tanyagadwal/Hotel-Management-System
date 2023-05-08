<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
PreparedStatement pstmt=null;
String query=null;

int empId=Integer.parseInt(request.getParameter("empId"));
try
{
	connect=DriverManager.getConnection(DB_URL,USER,PASS);
	query="delete from Employee where empID="+empId;
	pstmt=connect.prepareStatement(query);
	pstmt.executeUpdate();
	pstmt.close();
	connect.close();
	response.sendRedirect("deleteEmployee.jsp?msg=deleted");
}
catch(Exception e)
{
	response.sendRedirect("deleteEmployee.jsp?msg=invalid");
}

%>
