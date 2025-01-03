package wish;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class WishController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String url = request.getRequestURL().toString();
		String contextPath = request.getContextPath();
		WishDAO dao = new WishDAO();
		
		if(url.indexOf("insert.do") != -1) {
			WishDTO dto = new WishDTO();
			
			String userID = request.getParameter("userID");
			int productNum = Integer.parseInt(request.getParameter("productNum"));
			
			dto.setUserID(userID);
			dto.setProductNum(productNum);
			dao.insert(dto);
			
		}
		else if(url.indexOf("delete.do") != -1) {
			int wishNum = Integer.parseInt(request.getParameter("wishNum"));
			dao.delete(wishNum);
			
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
