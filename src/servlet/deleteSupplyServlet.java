package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.GoodsService;
import service.SupplyService;

public class deleteSupplyServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public deleteSupplyServlet() {
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
		try {
			int id = Integer.valueOf(request.getParameter("id"));
			SupplyService supplyservice = new SupplyService();
			supplyservice.deleteSupply(id);
		}catch(Exception e){
			e.printStackTrace();
			PrintWriter out = response.getWriter();
			out.println("Fail");
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
