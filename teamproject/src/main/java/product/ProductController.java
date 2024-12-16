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
        if (url.contains("list.do")) {
            List<ProductDTO> items = productDao.listProduct(); 
            request.setAttribute("list", items);
            RequestDispatcher rd = request.getRequestDispatcher("/product/product_list.jsp");
            rd.forward(request, response);

        } else if (url.contains("detail.do")) {
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            ProductDTO dto = productDao.detailProduct(productNum);  
            request.setAttribute("dto", dto);
            RequestDispatcher rd = request.getRequestDispatcher("/product/product_detail.jsp");
            rd.forward(request, response);

        } else if (url.contains("category_list.do")) {
            int p_categoryNum = Integer.parseInt(request.getParameter("p_categoryNum"));
            List<ProductDTO> items = productDao.listProductsByCategory(p_categoryNum);  
            request.setAttribute("list", items);
            RequestDispatcher rd = request.getRequestDispatcher("/product/product_list.jsp");
            rd.forward(request, response);

        // 관리자 관련 요청
        } else if (url.contains("admin_insert.do")) {
            setupCategoryCompanyData(request, adminDao);
            RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_insert.jsp");
            rd.forward(request, response);

        } else if (url.contains("admin_edit.do")) {
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            ProductDTO dto = adminDao.admin_detailProduct(productNum); 
            setupCategoryCompanyData(request, adminDao);
            request.setAttribute("dto", dto);
            RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_edit.jsp");
            rd.forward(request, response);

        } else if (url.contains("admin_delete.do")) {
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            adminDao.admin_deleteProduct(productNum);  
            RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_list.jsp");
            rd.forward(request, response);
            
        } else if (url.contains("admin_list.do")) {
            List<ProductDTO> items = adminDao.admin_listProduct();  
            request.setAttribute("list", items);
            RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_list.jsp");
            rd.forward(request, response);  
        
        } else if (url.contains("admin_update.do")) {
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            ProductDTO dto = adminDao.admin_detailProduct(productNum); // 기존 상품 정보를 가져옴
            request.setAttribute("dto", dto);
            setupCategoryCompanyData(request, adminDao);
            RequestDispatcher rd = request.getRequestDispatcher("/product/admin_product_edit.jsp");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); 
    }

    // 상품 추가/수정 공통 처리
    private void insertOrUpdateProduct(HttpServletRequest request, AdminProductDAO dao, boolean isUpdate) throws IOException, ServletException {
        String img_path = request.getSession().getServletContext().getRealPath("/images/"); 
        String productImage = handleFileUpload(request, img_path);
        
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

        if (isUpdate) {
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            dto.setProductNum(productNum);
        }

        dto.setProductImage(productImage.isEmpty() ? "-" : productImage);
        
        if (isUpdate) {
            dao.admin_updateProduct(dto);  // 관리자용 상품 정보 수정
        } else {
            dao.admin_insertProduct(dto);  // 관리자용 상품 추가
        }
    }

    // 파일 업로드 처리 메서드
    private String handleFileUpload(HttpServletRequest request, String img_path) throws IOException, ServletException {
        String productImage = "";
        for (Part part : request.getParts()) { // 요청에서 받은 파일 처리 후 이미지 파일을 지정된 경로에 저장
            productImage = part.getSubmittedFileName();
            if (productImage != null && !productImage.trim().isEmpty()) {
                part.write(img_path + productImage);
                break;
            }
        }
        return productImage;
    }

    // 카테고리와 회사 목록 설정
    private void setupCategoryCompanyData(HttpServletRequest request, AdminProductDAO dao) {
        List<CategoryDTO> category = dao.admin_listCategories();
        List<CompanyDTO> company = dao.admin_listCompany();
        request.setAttribute("category", category);
        request.setAttribute("company", company);
    }

    // JSP 페이지로 포워딩
    private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(path);
        rd.forward(request, response);
    }
}
