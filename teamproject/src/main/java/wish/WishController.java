package wish;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class WishController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getRequestURL().toString();
        String contextPath = request.getContextPath();
        WishDAO dao = new WishDAO();

        if (url.indexOf("insert.do") != -1) {
            String userID = request.getParameter("userID");
            int productNum = Integer.parseInt(request.getParameter("productNum"));

            WishDTO dto = new WishDTO();
            dto.setUserID(userID);
            dto.setProductNum(productNum);

            if (dao.wishCount(userID, productNum) == 0) { // 중복 여부 확인
                dao.insert(dto);
                response.getWriter().write("<script>alert('찜목록에 추가되었습니다.'); location.href='" + contextPath + "/wish_servlet/list.do';</script>");
            } else {
            	response.getWriter().write("<script>alert('이미 찜목록에 있습니다'); location.href='" + contextPath + "/wish_servlet/list.do';</script>");
            }
        }
        else if (url.indexOf("list.do") != -1) {
            String userID = request.getParameter("userID");
            List<Map<String, Object>> list = dao.listWish(userID);
            request.setAttribute("list", list);
            request.getRequestDispatcher("/wish/wish_list.jsp").forward(request, response);
        }
        else if (url.indexOf("delete.do") != -1) {
            int productNum = Integer.parseInt(request.getParameter("productNum"));
            String userID = request.getParameter("userID"); 
            // userID와 productNum으로 삭제 처리
            dao.delete(productNum, userID);
            
            response.sendRedirect(contextPath + "/wish_servlet/list.do?userID=" + userID); // 목록 페이지로 이동
         }
        else if (url.indexOf("list.do") != -1) {
            String userID = request.getParameter("userID");
            List<Map<String, Object>> list = dao.listWish(userID);

            request.setAttribute("wishList", list);
            request.getRequestDispatcher("/wish/wish_list.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
