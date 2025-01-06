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

public class CartController extends HttpServlet{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI();
		String path = request.getContextPath();
		HttpSession session = request.getSession();

		CartDAO dao = new CartDAO();
		System.out.println("cart 시작: " + url);
		if(url.indexOf("list.do")!=-1) {
			String userID = (String)session.getAttribute("userID");
			List<CartDTO> list = dao.listCart(userID);
			request.setAttribute("list", list);
			int sum = dao.sumMoney(userID);
			int fee = sum >= 50000 ? 0 : 3000;
			int total = sum + fee;
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sum", sum);
			map.put("fee", fee);
			map.put("total", total);
			request.setAttribute("map", map);
			RequestDispatcher rd = request.getRequestDispatcher("/cart/cart_list.jsp");
			rd.forward(request, response);
		}
		else if (url.indexOf("insert.do")!=-1) {  
			String userID = (String)session.getAttribute("userID");
			System.out.println("id"+userID);
			int productNum = Integer.parseInt(request.getParameter("productNum"));
			System.out.println("pn"+productNum);
			int cartAmount = Integer.parseInt(request.getParameter("cartAmount"));
			System.out.println("cm"+cartAmount);
			CartDTO dto = new CartDTO();
			dto.setUserID(userID);
			dto.setProductNum(productNum);
			dto.setCartAmount(cartAmount);
			dao.insertCart(dto);
			response.sendRedirect("/teamproject/cart_servlet/list.do");
		}
		
		else if (url.indexOf("delete_all.do")!=-1) {
			String userID = (String)session.getAttribute("userID");
			dao.deleteAll(userID);
			response.sendRedirect("/teamproject/cart_servlet/list.do");
		}
		
		else if (url.indexOf("delete_selected.do")!=-1) {
			int cartNum = Integer.parseInt(request.getParameter("cartNum"));
			dao.deleteSelected(cartNum);
			response.sendRedirect("/teamproject/cart_servlet/list.do");
		}
		
		else if (url.indexOf("update.do")!=-1) {
			int cartNum = Integer.parseInt(request.getParameter("cartNum"));
			int cartAmount = Integer.parseInt(request.getParameter("cartAmount"));
			CartDTO dto = new CartDTO();
			dto.setCartAmount(cartAmount);
			dto.setCartNum(cartNum);
			dao.updateCart(dto);
			response.sendRedirect("/teamproject/cart_servlet/list.do");
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}
}
