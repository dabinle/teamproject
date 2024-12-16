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
        ProductDAO productDao = new ProductDAO();  
        AdminProductDAO adminDao = new AdminProductDAO();  

        // 고객 관련 요청
        if (url.indexOf("list.do") != -1) {
            List<ProductDTO> items = productDao.listProduct(); 
            request.setAttribute("list", items);
            RequestDispatcher rd = request.getRequestDispatcher("/product/product_list.jsp");
            rd.forward(request, response);

        } else if (url.indexOf("detail.do") != -1) {
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            ProductDTO dto = productDao.detailProduct(productNum);  
            request.setAttribute("dto", dto);
            RequestDispatcher rd = request.getRequestDispatcher("/product/product_detail.jsp");
            rd.forward(request, response);

        } else if (url.indexOf("category_list.do") != -1) {
            int p_categoryNum = Integer.parseInt(request.getParameter("p_categoryNum"));
            List<ProductDTO> items = productDao.listProductByCategory(p_categoryNum);  
            request.setAttribute("list", items);
            RequestDispatcher rd = request.getRequestDispatcher("/product/product_list.jsp");
            rd.forward(request, response);

        // 관리자 관련 요청
        } else if (url.indexOf("admin_insert.do") != -1) {
        	List<CategoryDTO> category = adminDao.adminListCategory();
            List<CompanyDTO> company = adminDao.adminListCompany();
            request.setAttribute("category", category);
            request.setAttribute("company", company);
            
        	ServletContext application = request.getSession().getServletContext();
        	String img_path = application.getRealPath("/images/");
        	String productImage = "";
        	
        	try {
        		for (Part part : request.getParts()) { // 요청에서 받은 파일 처리 후 이미지 파일을 지정된 경로에 저장
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
            int p_categoryNum = Integer.parseInt(request.getParameter("p_categoryNum"));
            int companyNum = Integer.parseInt(request.getParameter("companyNum"));
            
            ProductDTO dto = new ProductDTO();
            dto.setProductName(productName);
            dto.setPrice(price);
            dto.setDescription(description);
            dto.setP_categoryNum(p_categoryNum);
            dto.setCompanyNum(companyNum);
        	
            if (productImage == null || productImage.trim().equals("")) {
            	productImage = "-";
            }
            dto.setProductImage(productImage);
            adminDao.adminInsertProduct(dto);
            String page = path + "/product_servlet/admin_list.do";
            response.sendRedirect(page);

        } else if (url.indexOf("admin_edit.do") != -1) {
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            ProductDTO dto = adminDao.adminDetailProduct(productNum); 
            request.setAttribute("dto", dto);
            RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_edit.jsp");
            rd.forward(request, response);

        } else if (url.indexOf("admin_delete.do") != -1) {
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            adminDao.adminDeleteProduct(productNum);  
            String page = path + "/product_servlet/admin_list.do";
            response.sendRedirect(page);
            
        } else if (url.indexOf("admin_list.do") != -1) {
            List<ProductDTO> items = adminDao.adminListProduct();  
            request.setAttribute("list", items);
            RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_list.jsp");
            rd.forward(request, response);  
        
        } else if (url.indexOf("admin_update.do") != -1) {
        	List<CategoryDTO> category = adminDao.adminListCategory();
            List<CompanyDTO> company = adminDao.adminListCompany();
            request.setAttribute("category", category);
            request.setAttribute("company", company);
            
        	ServletContext application = request.getSession().getServletContext();
        	String img_path = application.getRealPath("/images/");
        	String productImage = "";
        	
        	try {
        		for (Part part : request.getParts()) { // 요청에서 받은 파일 처리 후 이미지 파일을 지정된 경로에 저장
                    productImage = part.getSubmittedFileName();
                    if (productImage != null && !productImage.trim().equals("")) {
                        part.write(img_path + productImage);
                        break;
                    }
                }
        	} catch (Exception e) {
				e.printStackTrace();
			}
        	
        	int productNum = Integer.parseInt(request.getParameter("produceNum"));
        	String productName = request.getParameter("productName");
            int price = Integer.parseInt(request.getParameter("price"));
            String description = request.getParameter("description");
            int p_categoryNum = Integer.parseInt(request.getParameter("p_categoryNum"));
            int companyNum = Integer.parseInt(request.getParameter("companyNum"));
            
            ProductDTO dto = new ProductDTO();
            dto.setProductNum(productNum);
            dto.setProductName(productName);
            dto.setPrice(price);
            dto.setDescription(description);
            dto.setP_categoryNum(p_categoryNum);
            dto.setCompanyNum(companyNum);
        	
            if (productImage == null || productImage.trim().equals("")) {
            	ProductDTO dto2 = adminDao.adminDetailProduct(productNum);
            	productImage = dto2.getProductImage();
            	dto.setProductImage(productImage);
            } else {
            	dto.setProductImage(productImage);
            }
            adminDao.adminUpdateProduct(dto);
            String page = path + "/product_servlet/admin_list.do";
            response.sendRedirect(page);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); 
    }
}