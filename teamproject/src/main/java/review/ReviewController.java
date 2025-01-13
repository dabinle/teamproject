package review;

import java.io.File;
import java.io.IOException;
import java.util.List;

import faq.PageUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import jakarta.websocket.Session;
import product.ProductDAO;
import product.ProductDTO;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class ReviewController extends HttpServlet {
   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String url = request.getRequestURI();
      String contextPath = request.getContextPath();
      HttpSession session = request.getSession();
      ReviewDAO dao = new ReviewDAO();
      ReviewDTO dto = new ReviewDTO();
      System.out.println("review 시작:"+url);
   
      if (url.indexOf("list.do") != -1) {
         int productNum = Integer.parseInt(request.getParameter("productNum"));
         List<ReviewDTO> list = dao.list(productNum);
         
         request.setAttribute("list", list);
         request.setAttribute("productNum", productNum);
         
         RequestDispatcher rd = request.getRequestDispatcher("/review/review_list.jsp");
         rd.forward(request, response);
      } 
      
      else if (url.indexOf("insert.do") != -1) {
         ServletContext application = request.getSession().getServletContext();
         String img_path = application.getRealPath("/images/");
         String reviewFile = "-";
         try {
            for (Part part : request.getParts()) {
               reviewFile = part.getSubmittedFileName();
               if (reviewFile != null && !reviewFile.equals("null") && !reviewFile.equals("")) {
                  part.write(img_path + reviewFile);
                  break;
               }
            }
         } catch (Exception e) {
            e.printStackTrace();
         } 
         String userID = (String)session.getAttribute("userID");
         System.out.println("rrss:"+userID);
         String reviewContent = request.getParameter("reviewContent");
         System.out.println("rr:"+reviewContent);
         int reviewScore = Integer.parseInt(request.getParameter("reviewScore"));
         System.out.println("rrw:"+reviewScore);
         int orderNum = Integer.parseInt(request.getParameter("orderNum"));
         System.out.println("rrwsd:"+orderNum);
         dto.setUserID(userID);
         dto.setReviewContent(reviewContent);
         dto.setReviewScore(reviewScore);
         dto.setOrderNum(orderNum);
         if (reviewFile == null || reviewFile.trim().equals("")) {
            reviewFile = "-";
         }
         dto.setReviewFile(reviewFile);
         dao.insert(dto);
         // 일단 홈으로 
         response.sendRedirect(contextPath + "/home/home.jsp");
      } 
      // 리뷰 상세 페이지
      else if (url.indexOf("view.do") != -1) {
         int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
         dto = dao.view(reviewNum);
         request.setAttribute("dto", dto);
         RequestDispatcher rd = request.getRequestDispatcher("/review/my_review_view.jsp");
         rd.forward(request, response);
      } 
      
      else if (url.indexOf("delete.do") != -1) {
          int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
          String userID = request.getParameter("userID"); 
          dao.delete(reviewNum);
          String page = contextPath + "/review_servlet/abc.do?userID=" + userID + "&reviewNum=" + reviewNum;
          response.sendRedirect(page); 
      } 
      
      else if (url.indexOf("abc.do") != -1) {
         String userID = (String)session.getAttribute("userID");
         List<ReviewDTO> list = dao.my_review(userID);
         request.setAttribute("list", list);
         RequestDispatcher rd = request.getRequestDispatcher("/review/my_review.jsp");
         rd.forward(request, response);
      }
      
      else if (url.indexOf("write.do")!=-1) {
         int orderNum = Integer.parseInt(request.getParameter("orderNum"));
         System.out.println("on:"+orderNum);
         request.setAttribute("orderNum", orderNum);
         ProductDTO productDTO = dao.detail(orderNum);
         System.out.println("dto:"+productDTO);
         request.setAttribute("Pdto", productDTO);
         RequestDispatcher rd = request.getRequestDispatcher("/review/review_write.jsp");
         rd.forward(request, response);
      }
   }
   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }   
}
