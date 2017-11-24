package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Employee;
import model.Goods;
import service.EmployeeService;
import service.GoodsService;

import com.google.gson.Gson;

public class getEmployeeServlet extends HttpServlet {

	public getEmployeeServlet() {
		super();
	}
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = Integer.valueOf(request.getParameter("page"));
	    List<Employee> list = new ArrayList<Employee>();
		EmployeeService employeeservice = new EmployeeService();
		try {
			list = employeeservice.getEmployee(page);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		Gson gson = new Gson();
		String result = gson.toJson(list);
		response.setContentType("application/json;charset=utf-8");
		response.setHeader("pragma", "no-cache");
		response.setHeader("cache-control", "no-cache");
		
		PrintWriter out = response.getWriter();
		out.println(result);
		out.flush();
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Employee> list = new ArrayList<Employee>();
		int querypage = Integer.valueOf(request.getParameter("querypage"));
		String query = new String(request.getParameter("query"));
		EmployeeService employeeservice = new EmployeeService();
        try {
			list = employeeservice.queryEmployee(query,querypage);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
        Gson gson = new Gson();
		String result = gson.toJson(list);
		response.setContentType("application/json;charset=utf-8");
		response.setHeader("pragma", "no-cache");
		response.setHeader("cache-control", "no-cache");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.flush();
		
	}
	public void init() throws ServletException {
		// Put your code here
	}

}
