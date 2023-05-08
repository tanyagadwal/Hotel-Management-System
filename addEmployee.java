

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addEmployee
 */
@WebServlet("/addEmployee")
public class addEmployee extends HttpServlet {
	static final String JDBC_DRIVER="com.mysql.cj.jdbc.Driver";
	static final String DB_URL="jdbc:mysql://127.0.01:3306/DBMSProject?autoReconnect=true&useSSL=false";
	static final String USER="root";
	static final String PASS="Mysql@123";
	private static final long serialVersionUID = 1L;
	Connection connect=null;
	PreparedStatement pstmt=null;
	String query=null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addEmployee() {
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		
		String empName=request.getParameter("name");
		int empAge = Integer.parseInt(request.getParameter("age"));
		String empGender=request.getParameter("gender");
		String empJob=request.getParameter("job");
		int empSalary =Integer.parseInt(request.getParameter("salary"));
		String empPhNo=request.getParameter("phNo");
		String empAadhar=request.getParameter("aadharNo");
		String empEmail=request.getParameter("email");
		
		
		try {
			Class.forName(JDBC_DRIVER);
			connect=DriverManager.getConnection(DB_URL, USER, PASS);
			query="insert into Employee(empName,empAge,empGender,empDepartment,empSalary,empPhNo,empAaddhar,empEmail) values(?,?,?,?,?,?,?,?)";
			pstmt=connect.prepareStatement(query);
		
			pstmt.setString(1,empName);
			pstmt.setInt(2,empAge); 
			pstmt.setString(3,empGender); 
			pstmt.setString(4,empJob); 
			pstmt.setInt(5,empSalary); 
			pstmt.setString(6,empPhNo); 
			pstmt.setString(7,empAadhar); 
			pstmt.setString(8,empEmail); 
			
			int i=pstmt.executeUpdate();
			
			if(i>0) {
				System.out.println("You are Successful!!!");
			}
			else {
				System.out.println("Unsuccessful!!!");
			}
			response.sendRedirect("displayEmployee.jsp"); 
		}
		catch(Exception e) {
			System.out.println(e);
		}

	}

}
