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

@MultipartConfig(maxFileSize = 1024*1024*10)
public class ProductAdminController extends HttpServlet{
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
      String url = request.getRequestURI();
      String path = request.getContextPath();
      AdminProductDAO dao = new AdminProductDAO();
    
      if (url.indexOf("list.do") !=-1) {
         List<ProductDTO> list = dao.listProduct();
         request.setAttribute("list", list);
         RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_list.jsp");
         rd.forward(request, response);
      }
      else if (url.indexOf("select_category.do")!=-1) {
         List<CategoryDTO> p_category = dao.p_listCategory();
         request.setAttribute("p_category", p_category);
         List<CompanyDTO> company = dao.listCompany();
         request.setAttribute("company", company);
         RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_insert.jsp");
         rd.forward(request, response);
      }
      else if(url.indexOf("if_category.do")!=-1){
    	  int p_categoryNum = Integer.parseInt(request.getParameter("p_categoryNum"));
    	  List<CategoryDTO> category = dao.listCategory(p_categoryNum);
    	  request.setAttribute("category", category);
    	  RequestDispatcher rd = request.getRequestDispatcher("/product/select_category.jsp");
    	  rd.forward(request, response);
      }
      else if (url.indexOf("insert.do")!=-1) {
         ServletContext application = request.getSession().getServletContext();
         String img_path = application.getRealPath("/images/");
         String productImage = "";
         try {
            for (Part part : request.getParts()) {
               productImage = part.getSubmittedFileName();
               if(productImage != null && !productImage.trim().equals("")) {
                  part.write(img_path+productImage);
                  break;
               }
            } 
         } catch (Exception e) {
            e.printStackTrace();
         }
         String productName = request.getParameter("productName");
         int companyNum = Integer.parseInt(request.getParameter("companyNum"));
         int p_categoryNum = Integer.parseInt(request.getParameter("p_categoryNum"));
         String description = request.getParameter("description");
         int price = Integer.parseInt(request.getParameter("price"));
         int amount = Integer.parseInt(request.getParameter("amount"));
         ProductDTO dto = new ProductDTO();
         dto.setProductName(productName);
         dto.setCompanyNum(companyNum);
         dto.setP_categoryNum(p_categoryNum);
         dto.setDescription(description);
         dto.setPrice(price);
         dto.setAmount(amount);
         if (productImage == null || productImage.trim().equals("")) {
            productImage = "-";
         }
         dto.setProductImage(productImage);
         dao.insertProduct(dto);
         String page = path + "/productAdmin_servlet/list.do";
         response.sendRedirect(page);
      }
      else if (url.indexOf("edit.do")!=-1) {
         int productNum = Integer.parseInt(request.getParameter("productNum"));
         ProductDTO dto = dao.detailProduct(productNum);
         request.setAttribute("dto", dto);
         RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_edit.jsp");
         rd.forward(request, response);
      }
      else if (url.indexOf("update.do")!=-1) {
         ServletContext application = request.getSession().getServletContext();
         String img_path = application.getRealPath("/images/");
         String productImage = "";
         try {
            for (Part part : request.getParts()) {
               productImage = part.getSubmittedFileName();
               if(productImage !=null && !productImage.trim().equals("")) {
                  part.write(img_path+productImage);
                  break;
               }
            }
         }catch (Exception e) {
            e.printStackTrace();
         }
         int productNum = Integer.parseInt(request.getParameter("productNum"));
         String productName = request.getParameter("productName");
         String description = request.getParameter("description");
         int price = Integer.parseInt(request.getParameter("price"));
         int amount = Integer.parseInt(request.getParameter("amount"));
         ProductDTO dto = new ProductDTO();
         dto.setProductName(productName);
         dto.setDescription(description);
         dto.setPrice(price);
         dto.setAmount(amount);
         dto.setProductNum(productNum);
         if (productImage== null || productImage.trim().equals("")) {
            ProductDTO dto2 = dao.detailProduct(productNum);
            productImage = dto2.getProductImage();
            dto.setProductImage(productImage);
         }else {
            dto.setProductImage(productImage);
         }
         dao.updateProduct(dto);
         String page = path + "/productAdmin_servlet/list.do";
         response.sendRedirect(page);
      }
      else if (url.indexOf("delete.do")!=-1) {
         int productNum = Integer.parseInt(request.getParameter("productNum"));
         dao.deleteProduct(productNum);
         String page = path + "/productAdmin_servlet/list.do";
         response.sendRedirect(page);
      }
   }
   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   doGet(request, response);
   }
}

