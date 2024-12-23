package notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import jakarta.servlet.http.HttpSession;
import sqlmap.Mybatis;

public class NoticeDAO {
	public int count(String search_option, String keyword) {
		int result = 0;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			result = session.selectOne("notice.search_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public List<NoticeDTO> list_search(String search_option, String keyword, int start, int end) {
		List<NoticeDTO> list = null;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			map.put("start", start);
			map.put("end", end);
			list = session.selectList("notice.search_list", map);
			for (NoticeDTO dto : list) {
				// String writer = dto.getWriter();
				String noticeTitle = dto.getNoticeTitle();
				String noticeContent = dto.getNoticeContent();
				switch (search_option) {
				case "all": 
					noticeTitle = noticeTitle.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					noticeContent = noticeContent.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				case "noticeTitle": 
					noticeTitle = noticeTitle.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				case "noticeContent": 
					noticeContent = noticeContent.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				}
				dto.setNoticeTitle(noticeTitle);
				dto.setNoticeContent(noticeContent);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}
	
	public String getFilename(int noticeNum) {
		String result = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			result = session.selectOne("notice.filename", noticeNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public void plus_down(int noticeNum) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.update("notice.plus_down", noticeNum);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public String check_pwd(int noticeNum, String adminPwd) {
		String result = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("noticeNum", noticeNum);
			map.put("adminPwd", adminPwd);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public void update(NoticeDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.update("notice.update", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void delete(int noticeNum) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.delete("notice.delete", noticeNum);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public List<NoticeDTO> list(int pageStart, int pageEnd) {
		List<NoticeDTO> list = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("start", pageStart);
			map.put("end", pageEnd);
			list = session.selectList("notice.list", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}
	
	public int count() {
		int result = 0;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			result = session.selectOne("notice.count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public void insert(NoticeDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.insert("notice.insert", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void plus_hit(int noticeNum, HttpSession count_session) {
		SqlSession session = null;
		try {
			long read_time = 0;
			if (count_session.getAttribute("read_time_" + noticeNum) != null) {
				read_time = (long) count_session.getAttribute("read_time_" + noticeNum);
			}
			long current_time = System.currentTimeMillis();
			session = Mybatis.getInstance().openSession();
			if (current_time - read_time > 5 * 1000) {
				session.update("notice.plus_hit", noticeNum);
				session.commit();
				count_session.setAttribute("read_time_" + noticeNum, current_time);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public NoticeDTO view(int noticeNum) {
		NoticeDTO dto = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			dto = session.selectOne("notice.view", noticeNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return dto;
	}
	
	public void update_order(int group_num, int re_order) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("group_num", group_num);
			map.put("re_order", re_order);
			session.update("notice.update_order", map);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void insert_reply(NoticeDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.insert("notice.insert_reply", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
}