package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Employee;
import model.Goods;
import service.EmployeeService;
import service.GoodsService;

public class editEmployeeServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public editEmployeeServlet() {
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

	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try{
			EmployeeService employeeservice = new EmployeeService();
			Employee employee = new Employee();
			employee.setId(Integer.valueOf(request.getParameter("id")));
			employee.setName(request.getParameter("name"));
			employee.setAddress(request.getParameter("address"));
			employee.setAge(Integer.valueOf(request.getParameter("age")));
			employee.setIdcard(request.getParameter("idcard"));
			employee.setSalary(Integer.valueOf(request.getParameter("salary")));
			employee.setSex(request.getParameter("sex"));
			employee.setTel(request.getParameter("tel"));
			employee.setPassword(request.getParameter("password"));
			employee.setBank(request.getParameter("bank"));
			employeeservice.editEmployee(employee);
		}catch(Exception e){
			e.printStackTrace();
			out.println("Fail");
		}
		out.flush();
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
