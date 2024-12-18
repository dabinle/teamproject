package member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class MemberDAO {
	public String login(MemberDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		String userName = session.selectOne("member.login", dto);
		session.close();
		return userName;
	}
	
	public void join(MemberDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			session.insert("member.join", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}		
	}
	
	public MemberDTO getMemberInfo(String userID) {
	    SqlSession session = Mybatis.getInstance().openSession();
	    try {
	        return session.selectOne("member.getMemberInfo", userID);
	    } finally {
	        if (session != null) 
	            session.close();
	    }
	}

	
	public boolean idCheck(String userID) {
	    SqlSession session = Mybatis.getInstance().openSession();
	    try {
	        int count = session.selectOne("member.idCheck", userID);
	        return count > 0;  // 중복이면 true
	    } finally {
	        if (session != null) 
	        	session.close();
	    }
	}
	
	public String idFind(MemberDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		String userID = session.selectOne("member.idFind", dto);
		session.close();
		return userID;
	}
	
	public void update(MemberDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			session.update("member.update", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void delete(String userID) {
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			session.delete("member.delete", userID);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public int check_pwd(String userID, String userPwd) {
		int result = 0;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userID", userID);
			map.put("userPwd", userPwd);
			result = session.selectOne("member.check_pwd", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

}