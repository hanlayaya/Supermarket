package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jdbc.JDBCuntl;


public final class loginServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public loginServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = new String(request.getParameter("user").getBytes("ISO-8859-1"),"utf-8");
		String password = request.getParameter("password");
		int type = Integer.valueOf(request.getParameter("peo"));
		int identity = 0;
		
		response.setHeader("prama", "no-cache");
	    response.setHeader("cache-control", "no-cache"); 
	    response.setCharacterEncoding("utf-8");
	    
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try{
	    	conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
	    	if(type == 1){
	    		String sql = "select password from manager where username='" + username + "';";
	    		pstmt = conn.prepareStatement(sql);
	 		    rs = pstmt.executeQuery();
	 		    while(rs.next()){
	 		    	if(rs.getString(1).equals(password)){
	 		    		identity = 1;
	 		    	}
	 		    }
	    	}
	    	if(type == 2){
	    		String sql = "select e_password from employee where e_name='" + username + "';";
	    		pstmt = conn.prepareStatement(sql);
	 		    rs = pstmt.executeQuery();
	 		    while(rs.next()){
	 		    	if(rs.getString(1).equals(password)){
	 		    		identity = 2;
	 		    	}
	 		    }
	    	}
	    }catch(Exception e){
	    	e.printStackTrace();
	    }finally{
	    	if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(identity == 0){
				
			} else if(identity == 1){
				request.getRequestDispatcher("manager.jsp").forward(request,response);
				request.getSession().setAttribute("isLogin", "true");
			}else if(identity == 2){
				request.getRequestDispatcher("general.jsp").forward(request,response);
				request.getSession().setAttribute("isLogin", "true");
			}
			System.out.println(identity);
	    }
	    
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
