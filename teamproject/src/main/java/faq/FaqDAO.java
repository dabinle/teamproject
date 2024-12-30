package faq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class FaqDAO {
	public int count(String search_option, String keyword) {
		int result = 0;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			result = session.selectOne("faq.search_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return result;
	}
	
	public int count() {
		int result = 0;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			result = session.selectOne("faq.count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return result;
	}
	
	public List<FaqDTO> list_search(String search_option, String keyword, int start, int end){
		List<FaqDTO> list = null;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			map.put("start", start);
			map.put("end", end);
			list = session.selectList("faq.search_list", map);
			
			for (FaqDTO dto : list) {
				String adminId = dto.getAdminId();
				String qusetion = dto.getQusetion();
				String f_categoryName = dto.getF_categoryName();
				
				switch(search_option) {
				case "all":
					adminId = adminId.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					qusetion = qusetion.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					f_categoryName = f_categoryName.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				case "qusetion":
					qusetion = qusetion.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				case "f_categoryName":
					f_categoryName = f_categoryName.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				}
				dto.setAdminId(adminId);
				dto.setQusetion(qusetion);
				dto.setF_categoryName(f_categoryName);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return list;
	}
	
	public FaqDTO detailFaq(int faqNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		FaqDTO dto = session.selectOne("faq.detail_faq", faqNum);
		session.close();
		return dto;
	}
	
	public void update(FaqDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.update("faq.update", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
	}
	
	public void delete(int faqNum) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.delete("faq.delete", faqNum);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
	}
	public List<FaqDTO> list(int pageStart, int PageEnd){
		List<FaqDTO> list = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("start", pageStart);
			map.put("end", PageEnd);
			list = session.selectList("faq.list", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return list;
	}
	
	public void insert(FaqDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.insert("faq.insert", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
	}
	
	public FaqDTO view(int faqNum) {
		FaqDTO dto = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			dto = session.selectOne("faq.detail_faq", faqNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return dto;
	}
	
	public List<FaqCategoryDTO> listf_category(){
		SqlSession session = Mybatis.getInstance().openSession();
		List<FaqCategoryDTO> f_category = session.selectList("faq.list_f_category");
		session.close();
		return f_category;
	}
}
