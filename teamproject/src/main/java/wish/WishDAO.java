package wish;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import sqlmap.Mybatis;

public class WishDAO {

    // 찜 여부 확인
    public int wishCount(String userID, int productNum) {
        int result = 0;
        SqlSession session = Mybatis.getInstance().openSession();
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("userID", userID);
            map.put("productNum", productNum);
            result = session.selectOne("wish.wish_count", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) 
            	session.close();
        }
        return result;
    }

    // 찜 추가
    public void insertWish(WishDTO dto) {
        SqlSession session = null;
        try {
            session = Mybatis.getInstance().openSession();
            session.insert("wish.wish_insert", dto);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) 
            	session.close();
        }
    }

    // 찜 목록 
    public List<WishDTO> listWish(String userID) {
        SqlSession session = Mybatis.getInstance().openSession();
        List<WishDTO> list = session.selectList("wish.wish_list", userID);
        session.close();
        return list;
    }
    
    public List<WishDTO> detailWish(int wishNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		List<WishDTO> detailWish = session.selectList("wish.detail_wish", wishNum);
		session.close();
		return detailWish;
	}
    
    public void wish_deleteAll(String userID) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.delete("wish.wish_delete_all", userID);
		session.commit();
		session.close();
	}
    
    public void wish_deleteSelected(int wishNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.delete("wish.wish_delete_selected", wishNum);
		session.commit();
		session.close();
	}

}
