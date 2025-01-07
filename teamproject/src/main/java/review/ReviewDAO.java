package review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import board.BoardDTO;
import sqlmap.Mybatis;

public class ReviewDAO {
	public String getFileName(int reviewNum) {
		String result = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			result = session.selectOne("review.filename", reviewNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public void plus_down(int reviewNum) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.update("review.plus_down", reviewNum);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void update(ReviewDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.update("review.update", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void delete(int reviewNum) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.delete("review.delete", reviewNum);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public List<ReviewDTO> list(int pageStart, int pageEnd) {
		List<ReviewDTO> list = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("start", pageStart);
			map.put("end", pageEnd);
			list = session.selectList("review.list", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}
	
	public List<ReviewDTO> my_review(String userID) {
		SqlSession session = Mybatis.getInstance().openSession();
		List<ReviewDTO> list = session.selectList("review.my_review", userID);
		session.close();
		return list;
	}

	public String getFilename(int reviewNum) {
		String result = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			result = session.selectOne("review.filename", reviewNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public int count() {
		int result = 0;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			result = session.selectOne("review.count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public void insert(ReviewDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.insert("review.insert", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public ReviewDTO view(int reviewNum) {
		ReviewDTO dto = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			dto = session.selectOne("review.view", reviewNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return dto;
	}
}