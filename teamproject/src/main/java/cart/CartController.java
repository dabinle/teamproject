package cart;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import product.ProductDTO;

public class CartController  extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI();
		String path = request.getContextPath();
		CartDAO dao = new CartDAO();
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("userID");
		String productName = (String) session.getAttribute("productName");
		String productImage = (String) session.getAttribute("productImage");
		
		if (url.indexOf("insert.do") != -1) {
			if (userID == null) {
				response.sendRedirect(path + "/member/login.jsp");
			} else {
				CartDTO dto = new CartDTO();
				dto.setUserID(userID);
				dto.setProductNum(Integer.parseInt(request.getParameter("productNum")));
				dto.setCartAmount(Integer.parseInt(request.getParameter("cartAmount")));
				dao.insert_cart(dto);
				response.sendRedirect(path + "/cart_servlet/list.do");
			}
		} else if (url.indexOf("list.do") != -1) {
			int sum_money = dao.sum_money(userID);
			int fee = sum_money >= 30000 ? 0 : 3000;
			int sum = sum_money + fee;
			Map<String, Object> map = new HashMap<>();
			map.put("sum_money", sum_money);
			map.put("fee", fee);
			map.put("sum", sum);
			request.setAttribute("map", map);
			List<CartDTO> items = dao.list_cart(userID);
			request.setAttribute("list", items);
			String page = "/cart/cart_list.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (url.indexOf("delete.do") != -1) {
			dao.delete_cart(Integer.parseInt(request.getParameter("cartNum")));
			response.sendRedirect(path + "/cart_servlet/list.do");
		} else if (url.indexOf("delete_all.do") != -1) {
			dao.clear_cart(userID);
			response.sendRedirect(path + "/cart_servlet/list.do");
		} else if (url.indexOf("update.do") != -1) {
			String[] productNum = request.getParameterValues("productNum");
			String[] cartAmount = request.getParameterValues("cartAmount");
			String[] cartNum = request.getParameterValues("cartNum");
			for (int i=0; i<productNum.length; i++) {
				CartDTO dto = new CartDTO();
				dto.setUserID(userID);
				dto.setCartNum(Integer.parseInt(cartNum[i]));
				dto.setCartAmount(Integer.parseInt(cartAmount[i]));
				dao.update_cart(dto);
			}
			response.sendRedirect(path + "/cart_servlet/list.do");
		} 
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}