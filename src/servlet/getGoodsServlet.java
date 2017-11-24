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

import service.GoodsService;

import model.Goods;

public class getGoodsServlet extends HttpServlet {

	public getGoodsServlet() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	    int page = Integer.valueOf(request.getParameter("page"));
	    List<Goods> list = new ArrayList<Goods>();
		GoodsService goodsservice = new GoodsService();
		try {
			list = goodsservice.getGoods(page);
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

	public void init() throws ServletException {
		// Put your code here
	}

}
