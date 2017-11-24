package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.SupplyService;

public class addPurchaseServlet extends HttpServlet {

	
	public addPurchaseServlet() {
		super();
	}

	
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		SupplyService  supplyservice = new SupplyService();
		try {
			supplyservice.addPurchase(Integer.valueOf(request.getParameter("g_id")), Integer.valueOf(request.getParameter("s_id")), Integer.valueOf(request.getParameter("addstock")));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	
	public void init() throws ServletException {
		// Put your code here
	}

}
