package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MyFilter implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest servletRequest = (HttpServletRequest) request;
		HttpServletResponse servletResponse = (HttpServletResponse) response;
		HttpSession session = servletRequest.getSession();
		String path = servletRequest.getRequestURI();
		String isLogin = (String) session.getAttribute("isLogin");
		if(path.indexOf("index") > -1 || path.indexOf("login") > -1) {
			   chain.doFilter(servletRequest, servletResponse);
			   return;
		}	 
		 if (isLogin == null || "".equals(isLogin)) {
			   // 跳转到登陆页面
			   servletResponse.sendRedirect("index.jsp");
		 } else {
			   // 已经登陆,继续此次请求
			   chain.doFilter(request, response);
		 }  
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
