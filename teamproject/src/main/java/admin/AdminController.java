package admin;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String url = request.getRequestURI();
		String path = request.getContextPath();
		
		if (url.indexOf("login.do") != -1) {
			AdminDAO dao = new AdminDAO();
			String adminId = request.getParameter("adminId");
			String adminPwd = request.getParameter("adminPwd");
			AdminDTO dto = new AdminDTO();
			dto.setAdminId(adminId);
			dto.setAdminPwd(adminPwd);
			String adminName = dao.login(dto);
			
			if(adminName == null) {
				String page = path + "/shop/admin_login.jsp?message=error";
				response.sendRedirect(page);
			} else {
				HttpSession session = request.getSession();
				session.setAttribute("admin_adminId", dto.getAdminId());
				session.setAttribute("admin_adminName", adminName);
				session.setAttribute("adminId", adminId);
				session.setAttribute("adminName", adminName);
				session.setAttribute("result", adminName + "님 환영합니다.");
				String page = "/shop/admin_result.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
		} else if (url.indexOf("logout.do") != -1){
			HttpSession session = request.getSession();
			session.invalidate();
			String page = path + "/shop/home.jsp";
			response.sendRedirect(page);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
