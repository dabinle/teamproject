package coupon;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CouponController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{ 
		String url = request.getRequestURI();
		CouponDAO couponDAO = new CouponDAO();
		CouponMemberDAO couponmemberDAO = new CouponMemberDAO();
		HttpSession session = request.getSession();
		System.out.println("coupon 시작: "+url);
		
		if(url.indexOf("list.do")!=-1) {
			List<CouponDTO> couponList = couponDAO.couponList();
			System.out.println("couponList:"+couponList);
			request.setAttribute("couponList", couponList);
			RequestDispatcher rd = request.getRequestDispatcher("/coupon/coupon_list.jsp");
			rd.forward(request, response);
		}
		else if (url.indexOf("insert.do")!=-1) {
			String userID = (String)session.getAttribute("userID");
			int couponNum = Integer.parseInt(request.getParameter("couponNum"));
			System.out.println("couponNum:"+couponNum);
			int count = couponmemberDAO.count(userID, couponNum);
			System.out.println("count:"+count);
			if (count == 0) {
				CouponMemberDTO couponmemberDTO = new CouponMemberDTO();
				couponmemberDTO.setCouponNum(couponNum);
				couponmemberDTO.setUserID(userID);
				couponmemberDAO.insert(couponmemberDTO);
				response.sendRedirect("/backup/home/home.jsp");
			}
			else {
				response.setContentType("text/html;charset=UTF-8"); 
	            response.getWriter().write("<script> alert('이미 존재합니다.'); location.href='/backup/home/home.jsp';</script>");
			}
			// 일단은 홈으로 가는데 그 페이지에 남도록 바꿔야함
			
		}
		
		else if (url.indexOf("member_coupon.do")!=-1) {
			String userID = (String)session.getAttribute("userID");
			List<CouponDTO> ableList = couponmemberDAO.ableList(userID);
			System.out.println("ableList: "+ ableList);
			request.setAttribute("ableList", ableList);
			List<CouponDTO> disableList = couponmemberDAO.disableList(userID);
			System.out.println("dis:"+disableList);
			request.setAttribute("disableList", disableList);
			RequestDispatcher rd = request.getRequestDispatcher("/coupon/member_coupon_list.jsp");
			rd.forward(request, response);
		}
		
		else if (url.indexOf("delete.do")!=-1) {
			int couponID = Integer.parseInt(request.getParameter("couponID"));
			couponmemberDAO.delete(couponID);
			response.sendRedirect("/backup/member/myPageHome.jsp");
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
