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

import com.google.gson.Gson;

import model.Goods;
import service.GoodsService;

public class queryGoodsServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public queryGoodsServlet() {
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
		
		List<Goods> list = new ArrayList<Goods>();
		int querypage = Integer.valueOf(request.getParameter("querypage"));
		String query = new String(request.getParameter("query").getBytes("ISO-8859-1"),"utf-8");
        GoodsService goodsservice = new GoodsService();
        try {
			list = goodsservice.queryGoods(query,querypage);
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
		if(list.size() == 0){
			out.println("false");
		}else{
			out.println(result);
		}
		out.flush();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
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
