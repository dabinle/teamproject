package notice;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
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
		
		if (url.indexOf("list.do") != -1) {
		    String search_option = request.getParameter("search_option");
		    String keyword = request.getParameter("keyword");
		    int count;
		    
		    // 키워드에 맞게 페이지
		    if (search_option != null && keyword != null && !keyword.isEmpty()) {
		        count = dao.count(search_option, keyword); // 검색된 데이터 개수
		    } else {
		        count = dao.count(); // 전체 데이터 개수
		    }

		    int cur_page = 1;
		    if (request.getParameter("cur_page") != null) {
		        cur_page = Integer.parseInt(request.getParameter("cur_page"));
		    }

		    PageUtil page = new PageUtil(count, cur_page);
		    int start = page.getPageBegin();
		    int end = page.getPageEnd();

		    List<NoticeDTO> list;
		    if (search_option != null && keyword != null && !keyword.isEmpty()) {
		        list = dao.list_search(search_option, keyword, start, end); 
		    } else {
		        list = dao.list(start, end); 
		    }

		    request.setAttribute("list", list);
		    request.setAttribute("page", page);
		    request.setAttribute("search_option", search_option); 
		    request.setAttribute("keyword", keyword); 

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
			
		    response.setContentType("text/html;charset=UTF-8");  
		   
		    response.getWriter().write("<script> alert('공지사항이 등록되었습니다.'); location.href='" + contextPath + "/notice_servlet/list.do';</script>");
			
		} 
		else if(url.indexOf("view.do") != -1) {
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
		    String uploadDir = "c:/upload";

		    try {
		        for (Part part : request.getParts()) {
		            String uploadedFile = part.getSubmittedFileName();
		            if (uploadedFile != null && !uploadedFile.trim().isEmpty()) {
		                noticeFile = uploadedFile; 
		                part.write(uploadDir + File.separator + uploadedFile); 
		                break;
		            }
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    String adminId = request.getParameter("adminId");
		    String noticeTitle = request.getParameter("noticeTitle");
		    String noticeContent = request.getParameter("noticeContent");
		    int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
		    String deleteFileOption = request.getParameter("delete_file");

		    if ("on".equals(deleteFileOption)) {  // 삭제
		        String existingFile = dao.getFilename(noticeNum);
		        File fileToDelete = new File(uploadDir + File.separator + existingFile);
		        if (fileToDelete.exists()) {
		            fileToDelete.delete(); 
		        }
		        noticeFile = "-"; 
		    }


		    if (noticeFile.equals("-")) { // 기존 데이터
		        NoticeDTO existingNotice = dao.view(noticeNum); // 원래 있던 이미지
		        noticeFile = existingNotice.getNoticeFile(); 
		    }
		    dto.setNoticeNum(noticeNum);
		    dto.setAdminId(adminId);
		    dto.setNoticeTitle(noticeTitle);
		    dto.setNoticeContent(noticeContent);
		    dto.setNoticeFile(noticeFile);

		    dao.update(dto);
		    
		    response.setContentType("text/html;charset=UTF-8");  
			   
		    response.getWriter().write("<script> alert('공지사항이 수정되었습니다.'); location.href='" + contextPath + "/notice_servlet/list.do';</script>");

		    //String page = contextPath + "/notice_servlet/list.do";
		    //response.sendRedirect(page);

		} else if(url.indexOf("delete.do") != -1) {
			int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
			dao.delete(noticeNum);
			
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("<script> alert('공지사항이 삭제되었습니다.'); location.href='" + contextPath + "/notice_servlet/list.do';</script>");
			//String page = contextPath + "/notice_servlet/list.do";
			//response.sendRedirect(page);
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
		    request.setAttribute("page", page); 
		    request.setAttribute("search_option", search_option); 
		    request.setAttribute("keyword", keyword); 

		    RequestDispatcher rd = request.getRequestDispatcher("/notice/search.jsp");
		    rd.forward(request, response);
		}

		else if (url.indexOf("select_category.do")!=-1) {
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
