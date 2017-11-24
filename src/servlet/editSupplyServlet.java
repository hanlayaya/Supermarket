package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.SupplyService;

import model.Employee;
import model.Supply;

public class editSupplyServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public editSupplyServlet() {
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
			SupplyService supplyservice = new SupplyService();
			Supply supply = new Supply();
			supply.setId(Integer.valueOf(request.getParameter("id")));
			supply.setName(request.getParameter("name"));
			supply.setTel(request.getParameter("tel"));
			supply.setPerson(request.getParameter("coname"));
			supplyservice.editSupply(supply);
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
