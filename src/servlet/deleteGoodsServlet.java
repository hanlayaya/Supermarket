package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.GoodsService;

public class deleteGoodsServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public deleteGoodsServlet() {
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
			GoodsService goodsservice = new GoodsService();
			goodsservice.deleteGoods(id);
		}catch(Exception e){
			PrintWriter out = response.getWriter();
			out.println("Fail");
			out.flush();
		}
	}

	
	public void init() throws ServletException {
		// Put your code here
	}

}
