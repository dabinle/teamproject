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
		
		ProductDAO dao = new ProductDAO();
		ReviewDAO reviewDAO = new ReviewDAO();
		
		if(url.indexOf("list.do")!=-1) {
			String searchkey = "all";
	         String search = "";
	         if(request.getParameter("searchkey")!=null) {
	            searchkey = request.getParameter("searchkey");
	         }
	         if(request.getParameter("search")!=null) {
	            search = request.getParameter("search");
	         }
	         List<ProductDTO> list = dao.listProduct(searchkey, search);
	         request.setAttribute("list", list);
	         request.setAttribute("searchkey", searchkey);
	         request.setAttribute("search", search);
	         
	         RequestDispatcher rd = request.getRequestDispatcher("/product/product_list.jsp");
	         rd.forward(request, response);
		}
		else if (url.indexOf("detail.do")!=-1) {
			int productNum = Integer.parseInt(request.getParameter("productNum"));
			request.setAttribute("productNum", productNum);
			
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
		
		   else if (url.indexOf("cate_product.do")!=-1) {
		         int p_categoryNum = Integer.parseInt(request.getParameter("p_categoryNum"));
		         List<ProductDTO> cateProductList = dao.categoryProduct(p_categoryNum);
		         request.setAttribute("cateProductList", cateProductList);
		         RequestDispatcher rd = request.getRequestDispatcher("/product/cate_product_list.jsp");
		         rd.forward(request, response);
		      }
		      
		      else if (url.indexOf("com_product.do")!=-1) {
		         int companyNum = Integer.parseInt(request.getParameter("companyNum"));
		         System.out.println("ee:"+companyNum);
		         List<ProductDTO> comProductList = dao.companyProduct(companyNum);
		         System.out.println("e22e:"+comProductList);
		         request.setAttribute("comProductList", comProductList);
		         RequestDispatcher rd = request.getRequestDispatcher("/product/com_product_list.jsp");
		         rd.forward(request, response);
		      }
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);	
	}
}
