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

public class EchartsServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public EchartsServlet() {
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
			int food = 0,wash = 0,oil = 0,life = 0,other = 0;
			conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
			String sql = "select * from goods";
			PreparedStatement pstmt;
			pstmt = (PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				if(rs.getString("g_type").equals("食品类")){
					food++;
				}else if(rs.getString("g_type").equals("洗护类")){
					wash++;
				}else if(rs.getString("g_type").equals("粮油类")){
					oil++;
				}else if(rs.getString("g_type").equals("生活用品类")){
					life++;
				}else{
					other++;
				}
			}
			List <Integer> list = new ArrayList<Integer>();
			list.add(food);
			list.add(wash);
			list.add(oil);
			list.add(life);
			list.add(other);
			Gson gson = new Gson();
			String result = gson.toJson(list);
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println(result);
			out.flush();
			rs.close();
			pstmt.close();
			conn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn;
		try {
			int DAY1 = 0,DAY2 = 0,DAY3 = 0,DAY4 = 0,DAY5 = 0,DAY6 = 0, DAY7 = 0;
			conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
			String sql = "select * from sales WHERE TO_DAYS(NOW()) - TO_DAYS(s_time) <= 1;";
			PreparedStatement pstmt;
			pstmt = (PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				DAY1 = DAY1 + rs.getInt("s_money");
			}
			rs = pstmt.executeQuery("select * from sales WHERE TO_DAYS(NOW()) - TO_DAYS(s_time) <= 2;");
			while(rs.next()){
				DAY2 = DAY2 + rs.getInt("s_money");
			}
			rs = pstmt.executeQuery("select * from sales WHERE TO_DAYS(NOW()) - TO_DAYS(s_time) <= 3;");
			while(rs.next()){
				DAY3 = DAY3 + rs.getInt("s_money");
			}
			rs = pstmt.executeQuery("select * from sales WHERE TO_DAYS(NOW()) - TO_DAYS(s_time) <= 4;");
			while(rs.next()){
				DAY4 = DAY4 + rs.getInt("s_money");
			}
			rs = pstmt.executeQuery("select * from sales WHERE TO_DAYS(NOW()) - TO_DAYS(s_time) <= 5;");
			while(rs.next()){
				DAY5 = DAY5 + rs.getInt("s_money");
			}
			rs = pstmt.executeQuery("select * from sales WHERE TO_DAYS(NOW()) - TO_DAYS(s_time) <= 6;");
			while(rs.next()){
				DAY6 = DAY6 + rs.getInt("s_money");
			}
			rs = pstmt.executeQuery("select * from sales WHERE TO_DAYS(NOW()) - TO_DAYS(s_time) <= 7;");
			while(rs.next()){
				DAY7 = DAY7 + rs.getInt("s_money");
			}
			List <Integer> list = new ArrayList<Integer>();
			list.add(DAY1);
			list.add(DAY2 - DAY1);
			list.add(DAY3 - DAY2);
			list.add(DAY4 - DAY3);
			list.add(DAY5 - DAY4);
			list.add(DAY6 - DAY5);
			list.add(DAY7 - DAY6);
			Gson gson = new Gson();
			String result = gson.toJson(list);
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println(result);
			out.flush();
			rs.close();
			pstmt.close();
			conn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	public void init() throws ServletException {
		// Put your code here
	}

}
