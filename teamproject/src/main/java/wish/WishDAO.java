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
        try (SqlSession session = Mybatis.getInstance().openSession()) {
            Map<String, Object> map = new HashMap<>();
            map.put("userID", userID);
            map.put("productNum", productNum);
            result = session.selectOne("wish.wish_count", map); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 찜 추가
    public void insertWish(WishDTO dto) {
        try (SqlSession session = Mybatis.getInstance().openSession()) {
            session.insert("wish.insertWish", dto); 
            session.commit(); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 찜 목록 조회
    public List<WishDTO> listWish(String userID) {
        try (SqlSession session = Mybatis.getInstance().openSession()) {
            return session.selectList("wish.listWish", userID); // MyBatis 쿼리 호출
        }
    }

    
    // 선택된 찜 삭제
    public void wish_delete(int wishNum) {
        try (SqlSession session = Mybatis.getInstance().openSession()) {
            session.delete("wish.wish_delete", wishNum);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
