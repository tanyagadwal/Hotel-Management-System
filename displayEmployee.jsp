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
ResultSet rs1= null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="background.css">
<style>
 
h1{
margin-left:500px;
}
#start{
background-color:#FFEEB3;}
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
<div>
 <h1 id="title">Employee Information</h1>
   
  <div id="start">
    <form action="displayEmployee2.jsp" method="post">
        
        <select class="form-select form-select-sm" aria-label=".form-select-sm example" name="department" >
            <option value="Housekeeping">Housekeeping</option>
            <option value="Room-Service">Room Service</option>
            <option value="Waiter/Waitress">Waiter/Waitress</option>
            <option value="Manager">Manager</option>
            <option value="Accountant">Accountant</option>
            <option value="Chef">Chef</option>
        </select>
        <label>Search particular Department</label>

        
        <input class="form-check-input checking" type="checkbox" name="sort" value="sort" id="flexCheckDefault">
        <label id="sort">Sort</label>
        <br><br>
        <button type="submit"  class="btn btn-success" name="submit">Submit</button>
    </form>
    
</div>

<hr class="horizonatal">
  <h3>Display of all employees</h3>
    

        <table class="table table1">
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
		
		</tr>
		
  <% 
  }connect.close();}
  catch(Exception ex){out.print(ex);}
  %>
  
  </table>

  
   <hr class="horizonatal">
<h3>Display the no of employee according to department:</h3>

        <table class="table2">
            <tr>
                <th>Department</th>
                <th>Count</th>
            </tr>
<%
try {
    
	connect=DriverManager.getConnection(DB_URL,USER,PASS);
	pstmt=connect.createStatement();
	String query="select empDepartment, count(*) from Employee group by empDepartment";
	pstmt=connect.prepareStatement(query);
	rs1=pstmt.executeQuery(query);	
	while(rs1.next()){
		%>
		<tr>
		<td style="width:50%;"><%=rs1.getString(1)%></td>
		<td style="width:50%;"><%=rs1.getInt(2)%></td>
		</tr>
		<% 
}		
}catch(Exception e){
	out.print(e);
}

%>
</table>
  


 </div>
 <a href="Employee.jsp"><button type="button" id="submit" class="btn btn-success">Back</button></a>
 
  </body>

</html>