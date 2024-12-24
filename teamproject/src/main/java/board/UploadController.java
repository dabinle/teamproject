package board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10, location = "c:/upload")
public class UploadController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> file_names = new ArrayList<>();
		List<Long> file_sizes = new ArrayList<>();
		try {
			for (Part part : request.getParts()) {
				String noticeFile = part.getSubmittedFileName();
				if (noticeFile != null) {
					file_names.add(noticeFile);
					file_sizes.add(part.getSize());
					part.write(noticeFile);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String adminName = request.getParameter("adminName");
		String noticeName = request.getParameter("noticeName");
		request.setAttribute("adminName", adminName);
	}
}
