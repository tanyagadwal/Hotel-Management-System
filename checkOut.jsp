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
PreparedStatement pstmt=null;
String query=null;


int customerID=Integer.parseInt(request.getParameter("custId"));

try
{
	connect=DriverManager.getConnection(DB_URL,USER,PASS);
	query="delete from custRoom where custID="+customerID;
	pstmt=connect.prepareStatement(query);
	pstmt.executeUpdate();
	
	query="SET FOREIGN_KEY_CHECKS=OFF";
	pstmt=connect.prepareStatement(query);
	pstmt.executeUpdate();
	
	query="delete from Customer where custID="+customerID;
	pstmt=connect.prepareStatement(query);
	pstmt.executeUpdate();
	
	query="SET FOREIGN_KEY_CHECKS=ON";
	pstmt=connect.prepareStatement(query);
	pstmt.executeUpdate();
	
	response.sendRedirect("displayCustomer.jsp"); 
}
catch(Exception e)
{
	out.print(e);
}

	

%>