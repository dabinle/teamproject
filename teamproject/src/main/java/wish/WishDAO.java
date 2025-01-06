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
        SqlSession session = Mybatis.getInstance().openSession();
        session.insert("wish.insertWish", dto); // MyBatis 쿼리 확인
        session.commit();
        session.close();
    }


    // 찜 목록 조회
    public List<WishDTO> listWish(String userID) {
        SqlSession session = Mybatis.getInstance().openSession();
        List<WishDTO> list = session.selectList("wish.listWish", userID); // MyBatis 쿼리 확인
        session.close();
        return list;
    }

    
    // 특정 찜 항목 조회
    public List<WishDTO> detailWish(int wishNum) {
        try (SqlSession session = Mybatis.getInstance().openSession()) {
            return session.selectList("wish.detail_wish", wishNum);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 모든 찜 삭제
    public void wish_deleteAll(String userID) {
        try (SqlSession session = Mybatis.getInstance().openSession()) {
            session.delete("wish.wish_delete_all", userID);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 선택된 찜 삭제
    public void wish_deleteSelected(int wishNum) {
        try (SqlSession session = Mybatis.getInstance().openSession()) {
            session.delete("wish.wish_delete_selected", wishNum);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
