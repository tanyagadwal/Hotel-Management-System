import java.io.IOException; 
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**

 * Servlet implementation class addCustomer
 */

@WebServlet("/addCustomer")
public class addCustomer extends HttpServlet {
	static final String JDBC_DRIVER="com.mysql.cj.jdbc.Driver";
	static final String DB_URL="jdbc:mysql://127.0.01:3306/DBMSProject?autoReconnect=true&useSSL=false";
	static final String USER="root";
	static final String PASS="Mysql@123";
	private static final long serialVersionUID = 1L;
	Connection connect=null;
	PreparedStatement pstmt=null;
	Statement ps=null;
	ResultSet rs=null;
	ResultSet rs1=null;
	String query=null; 
	Date date=null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addCustomer() {
        super();
       // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	/**	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String custName=request.getParameter("name");
		int custAge = Integer.parseInt(request.getParameter("age"));
		String custPhNo=request.getParameter("phNo");		
		String custAadhar=request.getParameter("aadharNo");
		String custCountry=request.getParameter("country");		
		int roomid = Integer.parseInt(request.getParameter("roomno"));		
		String checkIn=request.getParameter("checkIn");		
		String checkOut=request.getParameter("checkOut");		
		int deposit = Integer.parseInt(request.getParameter("deposit"));
		
		
		try {

			Class.forName(JDBC_DRIVER);
			connect=DriverManager.getConnection(DB_URL, USER, PASS);	
			
			ps= connect.createStatement();
			String sql = "SELECT CURRENT_TIMESTAMP";
			rs1 = ps.executeQuery(sql);
			while (rs1.next()) {
				date = rs1.getDate(1);			
			}
			
     		query="insert into Customer(custName,custAge,custPhNo,custAadharNo,custCountry) values(?,?,?,?,?)";
			pstmt=connect.prepareStatement(query);					
			pstmt.setString(1,custName);
			pstmt.setInt(2,custAge); 
			pstmt.setString(3,custPhNo); 
			pstmt.setString(4,custAadhar); 
			pstmt.setString(5,custCountry); 
			int i=pstmt.executeUpdate();
			if(i>0) {
				System.out.println("You are Successful!!!");
			}
			else {
				System.out.println("Unsuccessful!!!");
			}		
		    query="select custID from Customer where custName=?";
		    pstmt=connect.prepareStatement(query);
		    pstmt.setString(1,custName);
		    rs=pstmt.executeQuery();
		    
		    int custID=0;
		    while(rs.next())
		    {
		    	 custID=rs.getInt(1);
		    }
		    		    
		    if(custID!=0) {
		    String query="insert into custRoom(custID,roomID,checkInDt,checkOutDt,deposite,bookingDt) values(?,?,?,?,?,?)";			
			pstmt=connect.prepareStatement(query);
			pstmt.setInt(1,custID);
			pstmt.setInt(2,roomid);
			pstmt.setString(3,checkIn); 
			pstmt.setString(4,checkOut); 
			pstmt.setInt(5,deposit); 	
			pstmt.setDate(6, date);
			int j=pstmt.executeUpdate();			
			if(j>0) {

				System.out.println("You are Successful!!!");

			}

			else {

				System.out.println("Unsuccessful!!!");

			}
			response.sendRedirect("displayCustomer.jsp");  
		    }

		}

		catch(Exception e) {

			System.out.println(e);

		}

       

	}



}