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
		
	}
}
