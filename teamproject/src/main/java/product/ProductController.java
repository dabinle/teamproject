package product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import admin.AdminDAO;
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
        } else if (url.indexOf("insert_detail.do") != -1) {
        	List<CategoryDTO> categoryList = adminDao.adminListCategory();  
            request.setAttribute("category", categoryList);
            
            List<CompanyDTO> companyList = adminDao.adminListCompany();
            request.setAttribute("company", companyList);
            
            RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_insert.jsp");
            rd.forward(request, response);

        } else if (url.indexOf("insert.do") != -1) {
        	List<CategoryDTO> categoryList = adminDao.adminListCategory();  
            request.setAttribute("category", categoryList);
            
            List<CompanyDTO> companyList = adminDao.adminListCompany();
            request.setAttribute("company", companyList);
            
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
            int amount = Integer.parseInt(request.getParameter("amount"));
            String description = request.getParameter("description");
            //int p_categoryNum = Integer.parseInt(request.getParameter("p_categoryNum"));
            String p_categoryName = request.getParameter("p_categoryName");
            // int companyNum = Integer.parseInt(request.getParameter("companyNum"));
            String companyName = request.getParameter("companyName");
            
            ProductDTO dto = new ProductDTO();
            dto.setProductName(productName);
            dto.setPrice(price);
            dto.setAmount(amount);
            dto.setDescription(description);
            dto.setP_categoryName(p_categoryName);
            dto.setCompanyName(companyName);

            if (productImage == null || productImage.trim().equals("")) {
               productImage = "-";
            }
            dto.setProductImage(productImage);
            adminDao.adminInsertProduct(dto);
            
            String page = path + "/product_servlet/admin_list.do";
            response.sendRedirect(page);
            
            
            
        } else if (url.indexOf("admin_edit.do") != -1) { // 수정하려는 상품의 기존 정보를 불러와 수정 페이지에 출력 
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            ProductDTO dto = adminDao.adminDetailProduct(productNum); 
            request.setAttribute("dto", dto);
            RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_edit.jsp");
            rd.forward(request, response);

        } else if (url.indexOf("admin_delete.do") != -1) { // 관리자 상품 삭제
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            adminDao.adminDeleteProduct(productNum);  
            String page = path + "/product_servlet/admin_list.do";
            response.sendRedirect(page);
            
        } else if (url.indexOf("admin_list.do") != -1) { // 관리자 상품 목록
            List<ProductDTO> items = adminDao.adminListProduct();  
            request.setAttribute("list", items);
            
            //response.getWriter().write("<script> location.href='" + path + "/product/admin_product_list.jsp';</script>");
            RequestDispatcher rd = request.getRequestDispatcher("/teamproject/product/admin_product_list.jsp");
            rd.forward(request, response);  
        
           // 수정된 상품 정보를 받아 데이터베이스에 저장
        } else if (url.indexOf("admin_update.do") != -1) { 
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
           
            int productNum = Integer.parseInt(request.getParameter("productNum"));
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
           
			List<CategoryDTO> category = adminDao.adminListCategory();
            List<CompanyDTO> company = adminDao.adminListCompany();
            request.setAttribute("category", category);
            request.setAttribute("company", company);
            
            if (productImage == null || productImage.trim().equals("")) {
               ProductDTO dto2 = adminDao.adminDetailProduct(productNum);
               productImage = dto2.getProductImage();
               dto.setProductImage(productImage);
            } else {
               dto.setProductImage(productImage);
            }
            adminDao.adminUpdateProduct(dto);
            String page = path + "/product_servlet/admin_home.do";
            response.sendRedirect(page);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); 
    }
}