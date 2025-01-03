package faq;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import notice.NoticeCategoryDTO;
import notice.NoticeDTO;
import notice.PageUtil;

public class FaqController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		String contextPath = request.getContextPath();
		FaqDAO dao = new FaqDAO();
		
		if(url.indexOf("list.do") != -1) {
			String search_option = request.getParameter("search_option");
			String keyword = request.getParameter("keyword");
			int count;
			
			if(search_option != null && keyword != null && !keyword.isEmpty()) {
				count = dao.count(search_option, keyword);
			} else {
				count = dao.count();
			}
			
			int cur_page = 1;
			if(request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			
			List<FaqDTO> list;
			if(search_option != null && keyword != null && !keyword.isEmpty()) {
				list = dao.list_search(search_option, keyword, start, end);
			} else {
				list = dao.list(start, end);
			}
			
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword); 
			
			RequestDispatcher rd = request.getRequestDispatcher("/faq/faq_list.jsp");
			rd.forward(request, response);
		} else if(url.indexOf("insert.do") != -1) {
			FaqDTO dto = new FaqDTO();
			
			
			String adminId = request.getParameter("adminId");
			String qusetion = request.getParameter("qusetion");
			String f_answer = request.getParameter("f_answer");
			int f_categoryNum = Integer.parseInt(request.getParameter("f_categoryNum"));
			
			dto.setAdminId(adminId);
			dto.setQusetion(qusetion);
			dto.setF_answer(f_answer);
			dto.setF_categoryNum(f_categoryNum);
			dao.insert(dto);
			
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("<script>alert('FAQ가 등록되었습니다.'); location.href='" + contextPath + "/faq_servlet/list.do';</script>");
			
		}
		else if(url.indexOf("view.do") != -1) {
			int faqNum = Integer.parseInt(request.getParameter("faqNum"));
			HttpSession session = request.getSession();
			FaqDTO dto = dao.view(faqNum);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/faq/faq_view.jsp");
			rd.forward(request, response);
		}
		else if(url.indexOf("edit.do") != -1) {
			int faqNum = Integer.parseInt(request.getParameter("faqNum"));
			FaqDTO dto = dao.detailFaq(faqNum);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/faq/faq_edit.jsp");
			rd.forward(request, response);
		}
		else if(url.indexOf("update.do") != -1) {
			FaqDTO dto = new FaqDTO();
			
			String adminId = request.getParameter("adminId");
			String qusetion = request.getParameter("qusetion");
			String f_answer = request.getParameter("f_answer");
			int faqNum = Integer.parseInt(request.getParameter("faqNum"));
			
			dto.setFaqNum(faqNum);
			dto.setAdminId(adminId);
			dto.setQusetion(qusetion);
			dto.setF_answer(f_answer);
			dao.update(dto);
			
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("<script> alert('FAQ가 수정되었습니다.'); location.href='" + contextPath + "/faq_servlet/list.do';</script>");
		}
		else if(url.indexOf("delete.do") != -1) {
			int faqNum = Integer.parseInt(request.getParameter("faqNum"));
			dao.delete(faqNum);
			
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("<script> alert('FAQ가 삭제되었습니다.'); location.href='" + contextPath + "/faq_servlet/list.do';</script>");
		}
		else if(url.indexOf("search.do") != -1) {
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

			    List<FaqDTO> list = dao.list_search(search_option, keyword, start, end);

			    request.setAttribute("list", list); 
			    request.setAttribute("page", page); 
			    request.setAttribute("search_option", search_option); 
			    request.setAttribute("keyword", keyword); 

			    RequestDispatcher rd = request.getRequestDispatcher("/faq/search.jsp");
			    rd.forward(request, response);
		}
		else if (url.indexOf("select_category.do")!=-1) {
        	List<FaqCategoryDTO> f_category = dao.listf_category();
        	request.setAttribute("f_category", f_category);
        	RequestDispatcher rd = request.getRequestDispatcher("/faq/faq_write.jsp");
        	rd.forward(request, response);
        }
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
