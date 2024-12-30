package notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import product.CompanyDTO;
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
	            String adminId = dto.getAdminId();
	            String noticeTitle = dto.getNoticeTitle();
	            String n_categoryName = dto.getN_categoryName();

	            switch (search_option) {
	                case "all":
	                    adminId = adminId.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    noticeTitle = noticeTitle.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    n_categoryName = n_categoryName.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    break;
	                case "noticeTitle":
	                    noticeTitle = noticeTitle.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    break;
	                case "n_categoryName":
	                    n_categoryName = n_categoryName.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    break;
	            }
	            dto.setAdminId(adminId);
	            dto.setNoticeTitle(noticeTitle);
	            dto.setN_categoryName(n_categoryName);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (session != null)
	            session.close();
	    }
	    return list;
	}
	
	public String getFilename(int num) {
		String result = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			result = session.selectOne("notice.filename", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return result;
	}
	
	public NoticeDTO detailNotice(int noticeNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		NoticeDTO dto = session.selectOne("notice.detail_notice", noticeNum);
		session.close();
		return dto;
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
			if(session != null)
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
			if(session != null)
				session.close();
		}
	}
	
	public List<NoticeDTO> list(int pageStart, int pageEnd){
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
			if(session != null)
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
			if(session != null)
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
			if(session != null)
				session.close();
		}
	}
	
	public NoticeDTO view(int noticeNum) {
		NoticeDTO dto = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			dto = session.selectOne("notice.detail_notice", noticeNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return dto;
	}
	
	public List<NoticeCategoryDTO> listn_category() {
        SqlSession session = Mybatis.getInstance().openSession();
        List<NoticeCategoryDTO> n_category = session.selectList("notice.list_n_category");
        session.close();
        return n_category;
     }
}
