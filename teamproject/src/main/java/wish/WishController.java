package wish;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class WishController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getRequestURL().toString();
        String contextPath = request.getContextPath();
        HttpSession session = request.getSession();
        WishDAO dao = new WishDAO();

        if (url.indexOf("insert.do") != -1) {
            String userID = request.getParameter("userID");
            int productNum = Integer.parseInt(request.getParameter("productNum"));

            WishDTO dto = new WishDTO();
            dto.setUserID(userID);
            dto.setProductNum(productNum);

            if (dao.wishCount(userID, productNum) == 0) { // 중복 여부 확인
                dao.insertWish(dto);
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().write("<script>alert('찜목록에 추가되었습니다.'); location.href='" + contextPath + "/wish_servlet/list.do';</script>");
            } else {
            	response.getWriter().write("<script>alert('이미 찜목록에 있습니다'); location.href='" + contextPath + "/wish_servlet/list.do';</script>");
            }
        }
        else if (url.indexOf("list.do") != -1) {
            String userID = (String) session.getAttribute("userID"); // 세션에서 userID 가져오기
            
            // userID가 없으면 로그인 페이지로 리디렉션
            if (userID == null) {
                response.sendRedirect("/teamproject/login.jsp");
                return;
            }
            
            List<WishDTO> list = dao.listWish(userID);
            request.setAttribute("list", list);
            RequestDispatcher rd = request.getRequestDispatcher("/wish/wish_list.jsp");
            rd.forward(request, response);
        }

        else if (url.indexOf("wish_deleteSelected.do") != -1) {
	        int wishNum = Integer.parseInt(request.getParameter("wishNum"));
	        dao.wish_deleteSelected(wishNum);
	        response.sendRedirect("/teamproject/wish_servlet/list.do");
        }
        else if(url.indexOf("wish_deleteAll.do") != -1) {
        	String userID = (String)session.getAttribute("userID");
        	dao.wish_deleteAll(userID);
        	response.sendRedirect("/teamproject/wish_servlet/list.do");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
