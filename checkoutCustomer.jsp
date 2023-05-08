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
ResultSet rs1= null;
ResultSet rs2= null;
ResultSet rs3= null;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>Checkout Customer</title>
<style>
body{
background:url("Images/back2.jpg")
background-size: 50%;
background-position: -80px 0px;   
   
}
table{
    background-color: #D6EEEE;
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
<link rel="stylesheet" href="background.css">
</head>
<body>
	
	<div>
	<form action="checkoutCustomer.jsp" method="post">
	<label>Customer Id:</label>
	<select name="custID" >			
		<% 
		try{
			connect=DriverManager.getConnection(DB_URL,USER,PASS);
			pstmt=connect.createStatement();
			String query="select custID from custRoom";
     		rs=pstmt.executeQuery(query);
			while(rs.next()){
		%>
		 <option value="<%=rs.getInt(1)%>"><%=rs.getInt(1)%></option>
		
		<%
			}			
		}
		  catch(Exception ex){out.print(ex);}
				
		%>
		</select><br><br>
		<input type="submit">	
	</form>
	</div>
	
	<% String output=request.getParameter("custID");
	;//to get the customer ID
	if(output!=null)
	{
    int roomId=0,depo=0,roomPrice=0,pendingPrice=0,TotalBill=0,days=0;
    String roomType=null;
    Date bookDt=null,checkOutDt=null,checkInDt=null;
	int custId=Integer.parseInt(output);
	
	
	%>
	
		<table class="table table1">
		  <thead class="thead-dark">
		<tr>	
		<th>ID</th>
		<th>Name</th>
		<th>Age</th>
		<th>Phone No</th>
		<th>Aadhar No</th>
		<th>Country</th>		
		</tr>
		</thead>
		<% 
		try{
			connect=DriverManager.getConnection(DB_URL,USER,PASS);
			pstmt=connect.createStatement();
			String query="select *from Customer where custID="+custId;
     		rs1=pstmt.executeQuery(query);
     		while(rs1.next()){
     		%>
     		<tr>
     		<td><%=rs1.getInt(1)%></td>
     		<td><%=rs1.getString(2)%></td>
     		<td><%=rs1.getInt(3) %></td>
     		<td><%=rs1.getString(4) %></td>
     		<td><%=rs1.getString(5) %></td>
     		<td><%=rs1.getString(6)%></td>  	    		
     		</tr>
     		
     		
<% 		
}		     		
}catch(Exception e){out.print(e);}
		
%></table>

<% 
		try{
			connect=DriverManager.getConnection(DB_URL,USER,PASS);
			pstmt=connect.createStatement();
			String query="select roomID,deposite,bookingDt,checkInDt,checkOutDt from custRoom where custID="+custId;
			rs2=pstmt.executeQuery(query);
			while(rs2.next()){
				roomId=rs2.getInt(1);
				depo=rs2.getInt(2);
				bookDt=rs2.getDate(3);	
				checkInDt=rs2.getDate(4);
				checkOutDt=rs2.getDate(5);
				
			}
			pstmt=connect.createStatement();
			query="select roomPrice from Room where roomID="+roomId;
			rs3=pstmt.executeQuery(query);
			while(rs3.next()){
				roomPrice=rs3.getInt(1);							
			}
			pendingPrice=roomPrice-depo;
			
			
			ps=connect.prepareStatement("SELECT DATEDIFF(?, ?)");
			ps.setDate(1,checkOutDt);
			ps.setDate(2,checkInDt);
			rs2=ps.executeQuery();
			while(rs2.next()){
				days=rs2.getInt(1);
			}
			days=days+1;
			TotalBill=(days*roomPrice)-depo;
		}catch(Exception e){
			out.print(e);
		}
%>
		<table class="table table1">
		  <thead class="thead-dark">
		<tr>	
		<th>Room ID</th>
		<th>CheckIN Date</th>
		<th>CheckOUT Date</th>
		<th>Booking Date</th>
		<th>Deposite</th>
		<th>Room Price </th>
		</tr>
		</thead>
		<tr>
		<td><%=roomId%></td>
     	<td><%=checkInDt %></td>
     	<td><%=checkOutDt%></td>
     	<td><%=bookDt%></td>
     	<td><%=depo%></td>  		
     	<td><%=roomPrice%></td>  		
		</tr>
		</table>
<% 

	

	
%>

<h3>Amenities used by the Customer:</h3>
<table class="table table1">
  <thead class="thead-dark">
<tr>	
		<th>Amenity Name</th>
		<th>Amenity Price</th>
		<th>Used Date</th>
		</tr>
</thead>
<%
try{
	connect=DriverManager.getConnection(DB_URL,USER,PASS);
	pstmt=connect.createStatement();
	String query="select * from CustAmenity left outer join Amenities on Amenities.amenityID=CustAmenity.amenityID";
	rs=pstmt.executeQuery(query);
	while(rs.next()){
		if(rs.getInt(2)==custId){
%>
<tr>
<td><%= rs.getString(6) %></td>
<%TotalBill+=rs.getInt(7); %>
<td><%= rs.getInt(7) %></td>
<td><%= rs.getDate(4) %>

</tr>
<% 
		}
	}
}catch(Exception e){
	out.print(e);
}

%>
</table>
<table>
<tr>
<th>Pending Room Price</th>
<td><%= (days*roomPrice)-depo%> </td>
</tr>
<tr>
<th>Total BILL</th>
<td><%=TotalBill %> </td>
</tr>
</table>

<form action="checkOut.jsp">
<a href="checkOut.jsp?custId=<%=custId%>"><button type="button" class="btn btn-success">Checkout</button></a>
</form>
<% 
	}
%>
<a href="Customer.jsp"><button type="button" id="submit">Back</button></a>
</body>
</html>
