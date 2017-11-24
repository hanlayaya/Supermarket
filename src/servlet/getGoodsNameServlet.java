package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import jdbc.JDBCuntl;
import model.Supply;

public class getGoodsNameServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public getGoodsNameServlet() {
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
			Connection conn;
			try {
				conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
				String sql;
				if(Integer.valueOf(request.getParameter("type")) == 1){
					sql = "select g_id,g_name from goods;";
					PreparedStatement pstmt;
					pstmt = (PreparedStatement)conn.prepareStatement(sql);
					ResultSet rs = pstmt.executeQuery();
			        List<String> list = new ArrayList<String>();
					while(rs.next()){
						String str = "";
						str += rs.getInt(1);
						str += ",";
						str += rs.getString(2);		
						list.add(str);
					}
					rs.close();
					pstmt.close();
					conn.close();
					
					Gson gson = new Gson();
					String result = gson.toJson(list);
					response.setContentType("application/json;charset=utf-8");
					PrintWriter out = response.getWriter();
					out.println(result);
					out.flush();
				}else if(Integer.valueOf(request.getParameter("type")) == 11111){
					sql = "select g_price from goods where g_id=" + Integer.valueOf(request.getParameter("id"));
					PreparedStatement pstmt;
					pstmt = (PreparedStatement)conn.prepareStatement(sql);
					ResultSet rs = pstmt.executeQuery();
					PrintWriter out = response.getWriter();
					rs.next();
					//System.out.println(rs.getFloat(1));
					out.println(rs.getFloat(1));
					
					rs.close();
					pstmt.close();
					conn.close();
					out.flush();
				}
	
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
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
