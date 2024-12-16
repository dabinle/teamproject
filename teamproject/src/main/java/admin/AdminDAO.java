package admin;

import org.apache.ibatis.session.SqlSession;
import sqlmap.Mybatis;

public class AdminDAO {
	public String login(AdminDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		String name = session.selectOne("admin.login", dto);
		session.close();
		return name;
	}
}
