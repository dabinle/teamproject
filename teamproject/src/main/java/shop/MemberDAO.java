package shop;

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
}
