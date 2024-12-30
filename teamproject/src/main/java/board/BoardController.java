package board;

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

@MultipartConfig(maxFileSize = 1024 * 1024 * 10, location = "c:/upload/")
public class BoardController extends HttpServlet {
	BoardDAO dao = new BoardDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		String contextPath = request.getContextPath();
		BoardDAO dao = new BoardDAO();
		if (url.indexOf("list.do") != -1) {
			int count = dao.count();
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<BoardDTO> list = dao.list(start, end);
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/board/board_list.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("insert.do") != -1) {
			BoardDTO dto = new BoardDTO();
			String boardFileName = "-";
			int boardFileSize = 0;
			try {
				for (Part part : request.getParts()) {
					boardFileName = part.getSubmittedFileName();
					if (boardFileName != null && !boardFileName.equals("null") && !boardFileName.equals("")) {
						boardFileSize = (int) part.getSize();
						part.write(boardFileName);
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String userID = request.getParameter("userID");
			String boardTitle = request.getParameter("boardTitle");
			String boardContent = request.getParameter("boardContent");
			String userpwd = request.getParameter("userPwd");
			dto.setUserID(userID);
			dto.setBoardTitle(boardTitle);
			dto.setBoardContent(boardContent);
			dto.setUserPwd(userpwd);
			if (boardFileName == null || boardFileName.trim().equals("")) {
				boardFileName = "-";
			}
			dto.setBoardFileName(boardFileName);
			dto.setBoardFileSize(boardFileSize);
			dao.insert(dto);
			response.sendRedirect(contextPath + "/board_servlet/board_list.do");
		} else if (url.indexOf("view.do") != -1) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			HttpSession session = request.getSession();
			dao.plus_hit(boardNum, session);
			BoardDTO dto = dao.view(boardNum);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/board/board_view.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("download.do") != -1) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String boardFileName = dao.getFilename(boardNum);
			String path = "c:/upload/" + boardFileName;
			byte[] buffer = new byte[4096];
			FileInputStream fis = new FileInputStream(path);
			String mimeType = getServletContext().getMimeType(path);
			if (mimeType == null) {
				mimeType = "application/octet-stream;charset=UTF-8";
			}
			boardFileName = new String(boardFileName.getBytes("utf-8"), "8859_1");
			response.setHeader("Content-Disposition", "attachment; boardFileName=" + boardFileName);
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
			dao.plus_down(boardNum);
		} else if (url.indexOf("insert_comment.do") != -1) {
			BoardCommentDTO dto = new BoardCommentDTO();
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String adminId = request.getParameter("userID");
			String commentContent = request.getParameter("boardContent");
			dto.setBoardNum(boardNum);
			dto.setAdminId(adminId);
			dto.setCommentContent(commentContent);
			dao.inser_comment(dto);
		} else if (url.indexOf("list_comment.do") != -1) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			List<BoardCommentDTO> list = dao.list_comment(boardNum);
			request.setAttribute("list", list);
			String page = "/board/list_comment.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (url.indexOf("check_pwd.do") != -1) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String userPwd = request.getParameter("userPwd");
			String result = null;
			String page = "";
			
			result = dao.check_pwd(boardNum, userPwd);
			
			if (result != null) {
				page = "/board/board_edit.jsp";
				request.setAttribute("dto", dao.view(boardNum));
			} else {
				page = contextPath + "/board_servlet/view.do?boardNum=" + boardNum + "&message=error";
				response.sendRedirect(page);
				return;
			}
		} else if (url.indexOf("admin_check_pwd.do") != -1) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String adminPwd = request.getParameter("adminPwd");
			String result = null;
			String page = "";
			
			result = dao.admin_check_pwd(boardNum, adminPwd);
			
			if (result != null) {
				page = "/board/board_edit.jsp";
				request.setAttribute("dto", dao.view(boardNum));
			} else {
				page = contextPath + "/board_servlet/view.do?boardNum=" + boardNum + "&message=error";
				response.sendRedirect(page);
				return;
			}
		} else if (url.indexOf("update.do") != -1) {
			BoardDTO dto = new BoardDTO();
			String boardFileName = "-";
			int boardFileSize = 0;
			try {
				for (Part part : request.getParts()) {
					boardFileName = part.getSubmittedFileName();
					if (boardFileName != null) {
						boardFileSize = (int) part.getSize();
						part.write(boardFileName);
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String userID = request.getParameter("userID");
			String boardTitle = request.getParameter("boardTitle");
			String boardContent = request.getParameter("boardContent");
			String userpwd = request.getParameter("userPwd");
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String delete_file = request.getParameter("delete_file");
			if (delete_file != null && delete_file.equals("on")) {
				String fileName = dao.getFilename(boardNum);
				File f = new File("c:/upload/" + fileName);
				f.delete();
				dto.setBoardNum(boardNum);
				dto.setUserID(userID);
				dto.setBoardTitle(boardTitle);
				dto.setBoardContent(boardContent);
				dto.setUserPwd(userpwd);
				dto.setBoardFileName("-");
				dto.setBoardFileSize(0);
				dto.setDown(0);
				dao.update(dto);
			}
			dto.setBoardNum(boardNum);
			dto.setUserID(userID);
			dto.setBoardTitle(boardTitle);
			dto.setBoardContent(boardContent);
			dto.setUserPwd(userpwd);
			if (boardFileName == null || boardFileName.trim().equals("")) {
				BoardDTO dto2 = dao.view(boardNum);
				String name = dto2.getBoardFileName();
				int size = dto2.getBoardFileSize();
				int down = dto2.getDown();
				dto.setBoardFileName(name);
				dto.setBoardFileSize(size);
				dto.setDown(down);
			} else {
				dto.setBoardFileName(boardFileName);
				dto.setBoardFileSize(boardFileSize);
			}
			String result = dao.check_pwd(boardNum, userpwd);
			if (result != null) {
				dao.update(dto);
				String page = contextPath + "/board_servlet/list.do";
				response.sendRedirect(page);
			} else {
				request.setAttribute("dto", dto);
				String page = "/board/board_edit.jsp?pqd_error=y";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
		} else if (url.indexOf("delete.do") != -1) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String userpwd = request.getParameter("userPwd");
			String result = dao.check_pwd(boardNum, userpwd);
			if (result != null) {
				dao.delete(boardNum);
				String page = contextPath + "/board_servlet/list.do";
				response.sendRedirect(page);
			} else {
				request.setAttribute("dto", dao.view(boardNum));
				String page = "/board/board_edit.jsp?pwd_error=y";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
		} else if (url.indexOf("input_reply.do") != -1) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			BoardDTO dto = dao.view(boardNum);
			dto.setBoardContent("=====contents====\n" + dto.getBoardContent());
			request.setAttribute("dto", dto);
			String page = "/board/board_reply.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (url.indexOf("insert_reply.do") != -1) {
			int boardNum = 0;
			if (request.getParameter("boardNum") != null) {
				boardNum = Integer.parseInt(request.getParameter("boardNum")); 
			}
			BoardDTO dto = dao.view(boardNum);
			int group_num = dto.getGroupNum();
			int re_order = dto.getRe_order() + 1;
			int re_depth = dto.getRe_depth() + 1;
			String adminId = request.getParameter("adminId");
			String boardTitle = request.getParameter("boardTitle");
			String boardContent = request.getParameter("boardTitle");
			// String userpwd = request.getParameter("userPwd");
			dto.setAdminId(adminId);
			dto.setBoardTitle(boardTitle);
			dto.setBoardContent(boardContent);
			// dto.setUserPwd(userpwd);
			dto.setGroupNum(group_num);
			dto.setRe_order(re_order);
			dto.setRe_depth(re_depth);
			dto.setBoardFileName("-");
			dto.setBoardFileSize(0);
			dto.setDown(0);
			dao.update_order(group_num, re_order);
			dao.insert_reply(dto);
			String page = "/board_servlet/list.do";
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
			List<BoardDTO> list = dao.list_search(search_option, keyword, start, end);
			request.setAttribute("list", list);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/board/board_search.jsp");
			rd.forward(request, response);
		}
	
	}

	// 관리자 비밀번호 체크
	private String checkAdminPwd(int boardNum, String adminPwd) {
	    return dao.admin_check_pwd(boardNum, adminPwd);
	}

	// 일반 사용자 비밀번호 체크
	private String checkUserPwd(int boardNum, String userPwd) {
	    return dao.check_pwd(boardNum, userPwd);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);	
	}
}