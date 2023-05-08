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
PreparedStatement pstmt= null;
ResultSet rs= null;
ResultSet rs1= null;
ResultSet rs2= null;
Statement ps=null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Amenity adding</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
body{
background-color:#96D4D4;
text-align:center;
}

</style>
</head>
<body>
<%int custId=Integer.parseInt(request.getParameter("custID"));
  String amenityName=request.getParameter("custAmenity");
  int amenityId=0,roomId=0;
  Date date =null;
  String custName=null;
   
  


     try{
 		connect=DriverManager.getConnection(DB_URL,USER,PASS);	
 		//Try-catch for getting the aminity Id using the aminity Name
 		String query="select amenityID from Amenities where amenityName=?";
		pstmt=connect.prepareStatement(query);
		pstmt.setString(1,amenityName);					
		rs=pstmt.executeQuery();

		while(rs.next()){
	       amenityId=rs.getInt(1);
	}
		

		//try-catch for getting todays date
 		ps= connect.createStatement();
		String sql = "SELECT CURRENT_TIMESTAMP";
		rs1 = ps.executeQuery(sql);
		while (rs1.next()) {
			date = rs1.getDate(1);			
		}
 		 query="Insert into CustAmenity(custID,amenityID,usedDate)values(?,?,?)";
 		pstmt=connect.prepareStatement(query);
 		pstmt.setInt(1,custId);		
 		pstmt.setInt(2,amenityId);
 		pstmt.setDate(3, date);	
 		pstmt.executeUpdate();
 		
 		
 		//try catch to insert the data in custaminity table
 		query="select custName from Customer where custID=?";
 		pstmt=connect.prepareStatement(query);
 		pstmt.setInt(1,custId);					
 		rs=pstmt.executeQuery();

 		while(rs.next()){
 	        custName=rs.getString(1);
 	    }
 		
 		//try get the cusomers room ID
 		query="select roomID from custRoom where custID=?";
 		pstmt=connect.prepareStatement(query);
 		pstmt.setInt(1,custId);					
 		rs=pstmt.executeQuery();

 		while(rs.next()){
 	        roomId=rs.getInt(1);
 	    }
 	}
 	  catch(Exception ex){out.print(ex);}       
     
    
     
%>

<div>
<h2><%=amenityName %> added successfully to:</h2>
<h3><label> Customer ID:</label></h3><h4><%=custId %></h4>
<h3><label> Customer Name:</label></h3><h4><%=custName %></h4>
<h3><label> Room ID:</label></h3><h4><%=roomId %></h4>

</div>
<a href="Customer.jsp"><button type="button" id="submit">Back</button></a>
</body>
</html>