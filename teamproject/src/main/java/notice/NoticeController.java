package notice;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import page.PageUtil;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10, location="c:/upload/")
public class NoticeController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		String contextPath = request.getContextPath();
		NoticeDAO dao = new NoticeDAO();
		if (url.indexOf("list.do") != -1) {
			int count = dao.count();
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
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
			int filesize = 0;
			try {
				for (Part part : request.getParts()) {
					noticeFile = part.getSubmittedFileName();
					if (noticeFile != null && !noticeFile.equals("null") && !noticeFile.equals("")) {
						filesize = (int) part.getSize();
						part.write(noticeFile);
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String writer = request.getParameter("writer");
			String noticeTitle = request.getParameter("noticeTitle");
			String noticeContent = request.getParameter("noticeContent");
			String adminPwd = request.getParameter("adminPwd");
			String ip = request.getRemoteAddr();
			dto.setWriter(writer);
			dto.setNoticeTitle(noticeTitle);
			dto.setNoticeContent(noticeContent);
			dto.setAdminPwd(adminPwd);
			dto.setIp(ip);
			if (noticeFile == null || noticeFile.trim().equals("")) {
				noticeFile = "-";
			}
			dto.setNoticeFile(noticeFile);
			dto.setFilesize(filesize);
			dao.insert(dto);
			response.sendRedirect(contextPath + "/notice_servlet/list.do");
		} else if (url.indexOf("view.do") != -1) {
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			HttpSession session = request.getSession();
			dao.plus_hit(noticeNum, session);
			NoticeDTO dto = dao.view(noticeNum);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/notice/notice_view.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("download.do") != -1) {
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			String noticeFile = dao.getFilename(noticeNum);
			String path = "c:/upload/" + noticeFile;
			byte[] buffer = new byte[4096];
			FileInputStream fis = new FileInputStream(path);
			String mimeType = getServletContext().getMimeType(path);
			if (mimeType == null) {
				mimeType = "application/octet-stream;charset=UTF-8";
			}
			noticeFile = new String(noticeFile.getBytes("utf-8"), "8859_1");
			response.setHeader("Content-Disposition", "attachment;noticeFile=" + noticeFile);
			ServletOutputStream out = response.getOutputStream();
			int len;
			while (true) {
				len = fis.read(buffer, 0, buffer.length);
				if (len == -1) {
					break;
				}
				out.write(buffer, 0, len);
			}
			out.flush();
			out.close();
			fis.close();
			dao.plus_down(noticeNum);
		} 
		//else if (url.indexOf("insert_comment.do") != -1) {
			//noticeCommentDTO dto = new noticeCommentDTO();
			//int notice_noticeNum = Integer.parseInt(request.getParameter("notice_noticeNum"));
			//String writer = request.getParameter("writer");
			//String noticeContent = request.getParameter("noticeContent");
			//dto.setnotice_noticeNum(notice_noticeNum);
			//dto.setWriter(writer);
			//dto.setnoticeContent(noticeContent);
			//dao.insert_comment(dto);
	//	} 
		 // else if (url.indexOf("list_comment.do") != -1) {
			//int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			//List<noticeCommentDTO> list = dao.list_comment(noticeNum);
			//request.setAttribute("list", list);
			//String page = "/notice/list_comment.jsp";
			//RequestDispatcher rd = request.getRequestDispatcher(page);
			//rd.forward(request, response);
		// } 
		 else if (url.indexOf("check_pwd.do") != -1) {
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			String adminPwd = request.getParameter("adminPwd");
			String result = dao.check_pwd(noticeNum, adminPwd);
			String page = "";
			if (result != null) {
				page = "/notice/edit.jsp";
				request.setAttribute("dto",dao.view(noticeNum));
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			} else {
				page = contextPath + "/notice_servlet/view.do?noticeNum=" + noticeNum + "&message=error";
				response.sendRedirect(page);
			}
		} else if (url.indexOf("update.do") != -1) {
			NoticeDTO dto = new NoticeDTO();
			String noticeFile = "-";
			int filesize = 0;
			try {
				for (Part part : request.getParts()) {
					noticeFile = part.getSubmittedFileName();
					if (noticeFile != null) {
						filesize = (int) part.getSize();
						part.write(noticeFile);
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String writer = request.getParameter("writer");
			String noticeTitle = request.getParameter("noticeTitle");
			String noticeContent = request.getParameter("noticeContent");
			String adminPwd = request.getParameter("adminPwd");
			String ip = request.getRemoteAddr();
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			String delete_file = request.getParameter("delete_file");
			if (delete_file != null && delete_file.equals("on")) {
				String noticeFile2 = dao.getFilename(noticeNum);
				File f = new File("c:/upload/" + noticeFile2);
				f.delete();
				dto.setNoticeNum(noticeNum);
				dto.setWriter(writer);
				dto.setNoticeTitle(noticeTitle);
				dto.setNoticeContent(noticeContent);
				dto.setAdminPwd(adminPwd);
				dto.setIp(ip);
				dto.setNoticeFile("-");
				dto.setFilesize(0);
				dto.setDown(0);
				dao.update(dto);
			}
			dto.setNoticeNum(noticeNum);
			dto.setWriter(writer);
			dto.setNoticeTitle(noticeTitle);
			dto.setNoticeContent(noticeContent);
			dto.setAdminPwd(adminPwd);
			dto.setIp(ip);
			if (noticeFile == null || noticeFile.trim().equals("")) {
				NoticeDTO dto2 = dao.view(noticeNum);
				String name = dto2.getNoticeFile();
				int size = dto2.getFilesize();
				int down = dto2.getDown();
				dto.setNoticeFile(name);
				dto.setFilesize(size);
				dto.setDown(down);
			} else {
				dto.setNoticeFile(noticeFile);
				dto.setFilesize(filesize);
			}
			String result = dao.check_pwd(noticeNum, adminPwd);
			if (result != null) {
				dao.update(dto);
				String page = contextPath + "/notice_servlet/list.do";
				response.sendRedirect(page);
			} else {
				request.setAttribute("dto", dto);
				String page = "/notice/notice_edit.jsp?pwd_error=y";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
		} else if (url.indexOf("delete.do") != -1) {
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			String adminPwd = request.getParameter("adminPwd");
			String result = dao.check_pwd(noticeNum, adminPwd);
			if (result != null) {
				dao.delete(noticeNum);
				String page = contextPath + "/notice_servlet/list.do";
				response.sendRedirect(page);
			} else {
				request.setAttribute("dto", dao.view(noticeNum));
				String page = "/notice/edit.jsp?pwd_error=y";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
		} else if (url.indexOf("input_reply.do") != -1) {
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			NoticeDTO dto = dao.view(noticeNum);
			dto.setNoticeContent("===noticeContent===\n" + dto.getNoticeContent());
			request.setAttribute("dto", dto);
			String page = "/notice/reply.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (url.indexOf("insert_reply.do") != -1) {
			int noticeNum = 0;
			if (request.getParameter("noticeNum") != null) {
				noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			}
			NoticeDTO dto = dao.view(noticeNum);
			int group_noticeNum = dto.getGroup_num();
			int re_order = dto.getRe_order() + 1;
			int re_depth = dto.getRe_depth() + 1;
			String writer = request.getParameter("writer");
			String noticeTitle = request.getParameter("noticeTitle");
			String noticeContent = request.getParameter("noticeContent");
			String adminPwd = request.getParameter("adminPwd");
			dto.setWriter(writer);
			dto.setNoticeTitle(noticeTitle);
			dto.setNoticeContent(noticeContent);
			dto.setAdminPwd(adminPwd);
			dto.setGroup_num(group_noticeNum);
			dto.setRe_order(re_order);
			dto.setRe_depth(re_depth);
			dto.setNoticeFile("-");
			dto.setFilesize(0);
			dto.setDown(0);
			dao.update_order(group_noticeNum, re_order);
			dao.insert_reply(dto);
			String page = "/notice_servlet/list.do";
			response.sendRedirect(request.getContextPath() + page);
		} else if (url.indexOf("search.do") != -1) {
			String search_option = request.getParameter("search_option");
			String keyword = request.getParameter("keyword");
			int count = dao.count(search_option, keyword);
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<NoticeDTO> list = dao.list_search(search_option, keyword, start, end);
			request.setAttribute("list", list);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/notice/notice_search.jsp");
			rd.forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}
}