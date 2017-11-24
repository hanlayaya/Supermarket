package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Employee;

import service.EmployeeService;

public class addEmployeeServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public addEmployeeServlet() {
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
		try {
			EmployeeService employeeservice = new EmployeeService();
			Employee employee = new Employee();;
			employee.setAddress(request.getParameter("address"));
			employee.setAge(Integer.valueOf(request.getParameter("age")));
			employee.setBank(request.getParameter("bank"));
			employee.setIdcard(request.getParameter("idcard"));
			employee.setName(request.getParameter("name"));
			employee.setPassword(request.getParameter("password"));
			employee.setSalary(Integer.valueOf(request.getParameter("salary")));
			employee.setTel(request.getParameter("tel"));
			employee.setSex(request.getParameter("sex"));
			employeeservice.addEmployee(employee);
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
