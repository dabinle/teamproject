package member;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String url = request.getRequestURI();
		String path = request.getContextPath();
		MemberDAO dao = new MemberDAO();
		
		if(url.indexOf("login.do") != -1) {
			String userID = request.getParameter("userID");
			String userPwd = request.getParameter("userPwd");
			MemberDTO dto = new MemberDTO();
			dto.setUserID(userID);
			dto.setUserPwd(userPwd);
			String userName = dao.login(dto);
			
			if(userName == null) {
				String page = "/shop/login.jsp?message=error";
				response.sendRedirect(path + page);
			} else {
				HttpSession session = request.getSession();
				session.setAttribute("userID", userID);
				session.setAttribute("userName", userName);
				String page = "/teamproject/shop/home.jsp";
				response.sendRedirect(page);
			}
		} 
		else if (url.indexOf("logout.do") != -1) {
			HttpSession session = request.getSession();
			session.invalidate();
			String page = path + "/shop/home.jsp";
			response.sendRedirect(page);
		} 
		else if(url.indexOf("join.do") != -1) {
			String userID = request.getParameter("userID");
			String userName = request.getParameter("userName");
			String email = request.getParameter("email");
			String userPwd = request.getParameter("userPwd");
			String phoneNum = request.getParameter("phoneNum");
			int zipCode = Integer.parseInt(request.getParameter("zipCode"));
			String address = request.getParameter("address");
			String addressDetail = request.getParameter("addressDetail");
			
			MemberDTO dto = new MemberDTO();
			dto.setUserID(userID);
			dto.setUserName(userName);
			dto.setEmail(email);
			dto.setUserPwd(userPwd);
			dto.setPhoneNum(phoneNum);
			dto.setZipCode(zipCode);
			dto.setAddress(address);
			dto.setAddressDetail(addressDetail);
			dao.join(dto);
			
			request.setAttribute("message", "회원가입이 완료되었습니다.");
			RequestDispatcher rd = request.getRequestDispatcher("/shop/login.jsp");
			rd.forward(request, response);

		} else if (url.indexOf("idCheck.do") != -1) {
		    String userID = request.getParameter("userID");
		    boolean exists = dao.idCheck(userID); // true면 아이디가 이미 존재

		    response.setContentType("application/json"); //  응답 데이터가 JSON 형식
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write("{\"exists\": " + exists + "}");
		    // 아이디가 존재하면 {"exists": true}
		    return;
		}

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}