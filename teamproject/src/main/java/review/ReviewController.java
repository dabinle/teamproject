package review;

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
import jakarta.servlet.http.Part;
import jakarta.websocket.Session;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10, location ="c:/upload/")
public class ReviewController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI().toString();
		String contextPath = request.getContextPath();
		ReviewDAO dao = new ReviewDAO();
		ReviewDTO dto = new ReviewDTO();
		if (url.indexOf("list.do") != -1) {
			int count = dao.count();
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<ReviewDTO> list = dao.list(start, end);
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/review/review_list.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("insert.do") != -1) {
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
			String userID = request.getParameter("userID");
			String reviewContent = request.getParameter("reviewContent");
			int reviewScore = Integer.parseInt(request.getParameter("reviewScore"));
			dto.setUserID(userID);
			dto.setReviewContent(reviewContent);
			dto.setReviewScore(reviewScore);
			if (reviewFile == null || reviewFile.trim().equals("")) {
				reviewFile = "-";
			}
			dto.setReviewFile(reviewFile);
			dao.insert(dto);
			response.sendRedirect(contextPath + "/review_servlet/list.do");
		} else if (url.indexOf("update.do") != -1) {
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
			String userID = request.getParameter("userID");
			String reviewContent = request.getParameter("reviewContent");
			int reviewScore = Integer.parseInt(request.getParameter("reviewScore"));
			int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
			dto.setUserID(userID);
			dto.setReviewContent(reviewContent);
			dto.setReviewScore(reviewScore);
			dto.setReviewNum(reviewNum);
			if (reviewFile == null || reviewFile.trim().equals("")) {
				ReviewDTO dto2 = dao.view(reviewNum);
				reviewFile = dto2.getReviewFile();
				dto.setReviewFile(reviewFile);
			} else {
				dto.setReviewFile(reviewFile);
			}
			dao.update(dto);
			response.sendRedirect(contextPath + "/review_serlvet/list.do");
		} else if (url.indexOf("view.do") != -1) {
			int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
			dto = dao.view(reviewNum);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/review/my_review_edit.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("delete.do") != -1) {
			int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
			request.setAttribute("dto", dao.view(reviewNum));
			String page = "/review/my_review_edit.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (url.indexOf("abc.do") != -1) {
			String userID = request.getParameter("userID");
			List<ReviewDTO> list = dao.my_review(userID);
			request.setAttribute("list", list);
			RequestDispatcher rd = request.getRequestDispatcher("/review/my_review.jsp");
			rd.forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}	
}
