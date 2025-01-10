package product;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import review.ReviewDAO;

public class ProductController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI();
		String path = request.getContextPath();
		System.out.println("url: "+url+" path: "+path);
		ProductDAO dao = new ProductDAO();
		ReviewDAO reviewDAO = new ReviewDAO();
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
			request.setAttribute("productNum", productNum);
			System.out.println("상품번호:" +productNum);
            ProductDTO dto = dao.detailProduct(productNum);  
            request.setAttribute("dto", dto);
            int count = reviewDAO.count(productNum);
            request.setAttribute("count", count);
            RequestDispatcher rd = request.getRequestDispatcher("/product/product_detail.jsp");
            rd.forward(request, response);
		}
		
		else if (url.indexOf("selected_category.do")!=-1) {
			List<ProductCategoryDTO> p_categoryList = dao.p_allCategory();
			request.setAttribute("P_Clist", p_categoryList);
			List<ProductCategoryDTO> categoryList = dao.allCategory();
			request.setAttribute("Clist", categoryList);
			RequestDispatcher rd = request.getRequestDispatcher("/product/all_category.jsp");
			rd.forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);	
	}
}
