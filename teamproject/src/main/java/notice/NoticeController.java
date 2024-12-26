package notice;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import product.CategoryDTO;
import product.CompanyDTO;

@MultipartConfig(maxFileSize = 1024*1024*10, location = "c:/upload")
public class NoticeController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String url = request.getRequestURL().toString();
		String contextPath = request.getContextPath();
		NoticeDAO dao = new NoticeDAO();
		
		if(url.indexOf("list.do") != -1) {
			int count = dao.count();
			int cur_page = 1;
			if(request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<NoticeDTO> list = dao.list(start, end);
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/notice/notice_list.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("insert.do") != -1) {
			NoticeDTO dto = new NoticeDTO();
			String noticeFile = "-";
			
			try {
				for (Part part : request.getParts()) {
					noticeFile = part.getSubmittedFileName();
					if(noticeFile != null && !noticeFile.equals("null") && !noticeFile.equals("")) {
						part.write(noticeFile);
						break;
					}
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			String adminId = request.getParameter("adminId");
			String noticeTitle = request.getParameter("noticeTitle");
			String noticeContent = request.getParameter("noticeContent");
			int n_categoryNum = Integer.parseInt(request.getParameter("n_categoryNum"));
			dto.setAdminId(adminId);
			dto.setNoticeTitle(noticeTitle);
			dto.setNoticeContent(noticeContent);
			dto.setN_categoryNum(n_categoryNum);
			
			if(noticeFile == null || noticeFile.trim().equals("")) {
				noticeFile = "-";
			}
			dto.setNoticeFile(noticeFile);
			dao.insert(dto);
			response.sendRedirect(contextPath + "/notice_servlet/list.do");
		} else if(url.indexOf("view.do") != -1) {
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			HttpSession session = request.getSession();
			NoticeDTO dto = dao.view(noticeNum);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/notice/notice_view.jsp");
			rd.forward(request, response);
		}else if(url.indexOf("edit.do") != -1) {
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			NoticeDTO dto = dao.detailNotice(noticeNum);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/notice/notice_edit.jsp");
			rd.forward(request, response);
		}
		else if (url.indexOf("update.do") != -1) {
			NoticeDTO dto = new NoticeDTO();
			String noticeFile = "-";
			
			try {
				for (Part part : request.getParts()) {
					noticeFile = part.getSubmittedFileName();
					if(noticeFile != null) {
						part.write(noticeFile);
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String adminId = request.getParameter("adminId");
			String noticeTitle = request.getParameter("noticeTitle");
			String noticeContent = request.getParameter("noticeContent");
			int noticeNum = Integer.parseInt(request.getParameter("noticeContent"));
			String delete_file = request.getParameter("delete_file");
			if(delete_file != null && delete_file.equals("on")) {
				String noticeFile2 = dao.getFilename(noticeNum);
				File f = new File("c:/upload/" + noticeFile2);
				f.delete();
				dto.setNoticeNum(noticeNum);
				dto.setAdminId(adminId);
				dto.setNoticeTitle(noticeTitle);
				dto.setNoticeContent(noticeContent);
				dao.update(dto);
			}
			dto.setNoticeNum(noticeNum);
			dto.setAdminId(adminId);
			dto.setNoticeTitle(noticeTitle);
			dto.setNoticeContent(noticeContent);
			
			if(noticeFile == null || noticeFile.trim().equals("")) {
				NoticeDTO dto2 = dao.view(noticeNum);
				String name = dto2.getNoticeFile();
				dto.setNoticeFile(noticeFile);
			} else {
				dto.setNoticeFile(noticeFile);
			}
			dao.update(dto);
			String page = contextPath + "/notice_servlet/list.do";
			response.sendRedirect(page);
		} else if(url.indexOf("delete.do") != -1) {
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			dao.delete(noticeNum);
			String page = contextPath + "/notice_servlet/list.do";
			response.sendRedirect(page);
		} else if(url.indexOf("search.do") != -1) {
			String search_option = request.getParameter("search_option");
			String keyword = request.getParameter("keyword");
			int count = dao.count(search_option, keyword);
			int cur_page = 1;
			if(request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<NoticeDTO> list = dao.list_search(search_option, keyword, start, end);
			request.setAttribute("list", list);
			request.setAttribute("keyword", keyword);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/notice/search.jsp");
			rd.forward(request, response);
		}
		else if (url.indexOf("select_category.do")!=-1) {
			System.out.println("하니");
        	List<NoticeCategoryDTO> n_category = dao.listn_category();
        	request.setAttribute("n_category", n_category);
        	RequestDispatcher rd = request.getRequestDispatcher("/notice/notice_write.jsp");
        	rd.forward(request, response);
        }
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}
}
