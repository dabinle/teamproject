package product;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class ProductController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI();
		String path = request.getContextPath();
		ProductDAO dao = new ProductDAO();
		if (url.indexOf("list.do") != -1) {
			List<ProductDTO> items = dao.listProduct();
			request.setAttribute("list", items);
			RequestDispatcher rd = request.getRequestDispatcher("/product/product_list.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("detail.do") != -1) {
			int productNum = Integer.parseInt(request.getParameter("productNum"));
			ProductDTO dto = dao.detailProduct(productNum);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/product/product_list.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("insert_product.do") != -1) {
			ServletContext application = request.getSession().getServletContext();
			String img_path = application.getRealPath("/images/");
			String productImage = "";
			try {
				for (Part part : request.getParts()) {
					productImage = part.getSubmittedFileName();
					if (productImage != null && !productImage.trim().equals("")) {
						part.write(img_path + productImage);
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String productName = request.getParameter("productName");
			int price = Integer.parseInt(request.getParameter("price"));
			String description = request.getParameter("description");
			ProductDTO dto = new ProductDTO();
			dto.setProductName(productName);
			dto.setPrice(price);
			dto.setDescription(description);
			if (productImage == null || productImage.trim().equals("")) {
				productImage = "-";
			}
			dto.setProductImage(productImage);
			dao.insertProduct(dto);
			String page = path + "/product_servlet/list.do";
			response.sendRedirect(page);
		} else if (url.indexOf("edit.do") != -1) {
			int productNum = Integer.parseInt(request.getParameter("productNum"));
			ProductDTO dto = dao.detailProduct(productNum);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/product/product_list.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("update.do") != -1) {
			ServletContext application = request.getSession().getServletContext();
			String img_path = application.getRealPath("/images/");
			String productImage = "";
			try {
				for (Part part : request.getParts()) {
					productImage = part.getSubmittedFileName();
					if (productImage != null && !productImage.trim().equals("")) {
						part.write(img_path + productImage);
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String productName = request.getParameter("productName");
			int price = Integer.parseInt(request.getParameter("price"));
			String description = request.getParameter("description");
			int productNum = Integer.parseInt(request.getParameter("productNum"));
			ProductDTO dto = new ProductDTO();
			dto.setProductName(productName);
			dto.setPrice(price);
			dto.setDescription(description);
			dto.setProducNum(productNum);
			if (productImage == null || productImage.trim().equals("")) {
				ProductDTO dto2 = dao.detailProduct(productNum);
				productImage = dto2.getProductImage();
				dto.setProductImage(productImage);
			} else {
				dto.setProductImage(productImage);
			}
			dao.updateProduct(dto);
			String page = path + "/product_servlet/list.do";
			response.sendRedirect(page);
		} else if (url.indexOf("delete.do") != -1) {
			int productNum = Integer.parseInt(request.getParameter("productNum"));
			dao.deleteProduct(productNum);
			String page = path + "/product_servlet/list.do";
			response.sendRedirect(page);
		}
	} 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}