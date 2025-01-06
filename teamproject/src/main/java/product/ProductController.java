package product;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ProductController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI();
		String path = request.getContextPath();
		System.out.println("url: "+url+" path: "+path);
		ProductDAO dao = new ProductDAO();
		System.out.println("시작");
		if(url.indexOf("list.do")!=-1) {
			List<ProductDTO> list = dao.listProduct();
			request.setAttribute("list", list);
			System.out.println("회원상품 리스트: "+list);
			RequestDispatcher rd = request.getRequestDispatcher("/product/product_list.jsp");
			rd.forward(request, response);
		}
		else if (url.indexOf("detail.do")!=-1) {
			int productNum = Integer.parseInt(request.getParameter("productNum"));
			System.out.println("상품번호:" +productNum);
            ProductDTO dto = dao.detailProduct(productNum);  
            request.setAttribute("dto", dto);
            RequestDispatcher rd = request.getRequestDispatcher("/product/product_detail.jsp");
            rd.forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);	
	}
}
