package wish;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class WishDAO {
	public int wish_Count() {
		int result = 0;
		SqlSession session = Mybatis.getInstance().openSession();
		try {
			result = session.selectOne("wish.wish_count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return result;
	}
	
	public void insert(WishDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.insert("wish_insert", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
	}
	
	public List<WishDTO> listWish(){
		SqlSession session= Mybatis.getInstance().openSession();
		List<WishDTO> list = session.selectList("wish.wish_getproductNum");
		session.close();
		return list;
	}
	
	public void delete(int wishNum) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.delete("wish.wish_delete", wishNum);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
	} 
}
