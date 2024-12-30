package board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

import jakarta.servlet.http.HttpSession;
import sqlmap.Mybatis;

public class BoardDAO {
	public int count(String search_option, String keyword) {
		int result = 0;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			result = session.selectOne("board.search_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public List<BoardDTO> list_search(String search_option, String keyword, int start, int end) {
		List<BoardDTO> list = null;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			map.put("start", start);
			map.put("end", end);
			list = session.selectList("board.search_list", map);
			for (BoardDTO dto : list) {
				String userID = dto.getUserID();
				String boardTitle = dto.getBoardTitle();
				switch (search_option) {
				case "all": 
					userID = userID.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					boardTitle = boardTitle.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				case "userID":
					userID = userID.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				case "boardTitle":
					boardTitle = boardTitle.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;	
				}
				dto.setUserID(userID);
				dto.setBoardTitle(boardTitle);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}
	
	public String getFilename(int boardNum) {
		String result = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			result = session.selectOne("board.filename", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public void plus_down(int boardNum) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.update("board.plus_down", boardNum);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void inser_comment(BoardCommentDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.insert("board.insert_comment", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public List<BoardCommentDTO> list_comment(int boardNum) {
		List<BoardCommentDTO> list = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			list = session.selectList("board.list_comment", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;		
	}
	
	public String check_pwd(int boardNum, String userPwd) {
		String result = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("boardNum", boardNum);
			map.put("userPwd", userPwd);
			result = session.selectOne("board.check_pwd", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public String admin_check_pwd(int boardNum, String adminPwd) {
		String result = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("boardNum", boardNum);
			map.put("adminPwd", adminPwd);
			result = session.selectOne("board.admin_check_pwd", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public void update(BoardDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.update("board.update", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void delete(int boardNum) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.update("board.delete", boardNum);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public List<BoardDTO> list(int pageStart, int pageEnd) {
		List<BoardDTO> list = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("start", pageStart);
			map.put("end", pageEnd);
			list = session.selectList("board.list", map);
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
			result = session.selectOne("board.count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
	
	public void insert(BoardDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.insert("board.insert", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void plus_hit(int boardNum, HttpSession count_session) {
		SqlSession session = null;
		try {
			long read_time = 0;
			if (count_session.getAttribute("read_time_" + boardNum) != null) {
				read_time = (long) count_session.getAttribute("read_time_" + boardNum);
			}
			long current_time = System.currentTimeMillis();
			session = Mybatis.getInstance().openSession();
			if (current_time - read_time > 5 * 1000) {
				session.update("board.plus_hit", boardNum);
				session.commit();
				count_session.setAttribute("read_time_" + boardNum, current_time);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public BoardDTO view(int boardNum) {
		BoardDTO dto = null;
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			dto = session.selectOne("board.view", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return dto;
	}
	
	public void update_order(int groupNum, int re_order) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("groupNum", groupNum);
			map.put("re_order", re_order);
			session.update("board.update_order", map);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void insert_reply(BoardDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.insert("board.insert_reply", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
}