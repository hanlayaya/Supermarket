package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.sql.*;

import jdbc.JDBCuntl;

public class zhuceServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public zhuceServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 response.setHeader("prama", "no-cache");
	     response.setHeader("cache-control", "no-cache"); 
	     response.setCharacterEncoding("utf-8");
	     PrintWriter out = response.getWriter();
	     Connection conn = null;
	     PreparedStatement pstmt = null;
	     ResultSet rs = null;
	     int exit = 0;
	     try {
	    	 System.out.println(request.getParameter("type"));
		     conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		     pstmt = conn.prepareStatement("select * from user");
		     rs = pstmt.executeQuery();
		     while(rs.next()){
		    	 if(rs.getString("username").equals(request.getParameter("username"))){
		    		 exit = 1;
		    	 }
		     }
		     if(exit == 0){
		    	 String sql = "insert into user(username,password,type) values(?,?,?)";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, request.getParameter("username"));
				 pstmt.setString(2, request.getParameter("password"));
				 pstmt.setInt(3, Integer.valueOf(request.getParameter("type")));
				 pstmt.executeUpdate();
				 out.println("注册成功");
		     }else{
		    	 out.println("用户名已存在");
		     }
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
			out.flush(); 
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
