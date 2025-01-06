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
            if (session != null) session.close();
        }
        return result;
    }

    // 찜 추가
    public void insert(WishDTO dto) {
        SqlSession session = null;
        try {
            session = Mybatis.getInstance().openSession();
            session.insert("wish.wish_insert", dto);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }

    // 찜 목록 조회
    public List<Map<String, Object>> listWish(String userID) {
        SqlSession session = Mybatis.getInstance().openSession();
        List<Map<String, Object>> list = null;
        try {
            list = session.selectList("wish.wish_getproductList", userID);
        } finally {
            if (session != null) session.close();
        }
        return list;
    }

    // 찜 삭제
    public void delete(int productNum, String userID) {
        SqlSession session = null;
        try {
            session = Mybatis.getInstance().openSession();
            Map<String, Object> map = new HashMap<>();
            map.put("productNum", productNum);
            map.put("userID", userID);
            session.delete("wish.wish_delete", map);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }
    }

}
