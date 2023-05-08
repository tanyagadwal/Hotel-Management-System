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
PreparedStatement pstmt= null;
ResultSet rs= null;
String query=null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="background.css">
<style type="text/css">
h1{
margin-left:600px;
}
#start{
background-color:#FFEEB3 ;}
table{
    background-color:#FFEEB3 ;
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
select{
margin-left:350px;}
input{
margin-left:400px;
}
button{
margin-left:400px;
}
</style>
</head>
<body >
 

<h1 style="margin-left:200px;">Display Employee</h1>

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
   </tr>
    </thead>

  <%
  String dept=request.getParameter("department"); 
  String sortopt=request.getParameter("sort");
  try {
	    
		connect=DriverManager.getConnection(DB_URL,USER,PASS);
		if(sortopt==null){
			query="select * from Employee where empDepartment=?";
		}
		else{
			query="select * from Employee where empDepartment=?"+"order by empName";
		}		
		pstmt=connect.prepareStatement(query);
		pstmt.setString(1,dept);					
		rs=pstmt.executeQuery();	
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
		
		</tr>
		
  <% 
  }connect.close();}
  catch(Exception ex){out.print(ex);}
  %>
  
  </table>
  
  </div><!-- end of the main-->
<form action="displayEmployee.jsp" method="post">
<button type="submit" class="btn btn-success" id="submit">Back</button>
</form>


</body>
</html>