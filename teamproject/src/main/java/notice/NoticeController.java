package notice;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig(maxFileSize = 1024*1024*10, location = "c:/upload")
public class NoticeController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) {
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
		}
	}
}
