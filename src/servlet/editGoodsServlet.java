package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Goods;
import service.GoodsService;

public class editGoodsServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public editGoodsServlet() {
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
		GoodsService goodsservice = new GoodsService();
		Goods goods = new Goods();
		goods.setId(Integer.valueOf(request.getParameter("id")));
		goods.setName(request.getParameter("name"));
		goods.setPrice(Float.parseFloat(request.getParameter("price")));
		goods.setMeasurement(request.getParameter("measurement"));
		goods.setType(request.getParameter("type"));
		goods.setStock(Integer.parseInt(request.getParameter("stock")));
		if(request.getParameter("year") != null){
			Date date = Date.valueOf(request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day"));
			goods.setDate(date);
			try {
				goodsservice.editGoodsWithDate(goods);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else{
			try {
				goodsservice.editGoodsWithOutDate(goods);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
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
