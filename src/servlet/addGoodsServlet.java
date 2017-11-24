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


public class addGoodsServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public addGoodsServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		GoodsService goodsservice = new GoodsService();
		Goods goods = new Goods();
		goods.setName(request.getParameter("name"));
		goods.setPrice(Float.parseFloat(request.getParameter("price")));
		goods.setMeasurement(request.getParameter("measurement"));
		goods.setType(request.getParameter("type"));
		goods.setStock(Integer.parseInt(request.getParameter("stock")));
		if(request.getParameter("year") != null){
			Date date = Date.valueOf(request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day"));
			goods.setDate(date);
			try {
				goodsservice.addGoodsWithDate(goods);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else{
			try {
				goodsservice.addGoodsWithOutDate(goods);
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
