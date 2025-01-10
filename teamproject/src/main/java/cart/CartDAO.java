package cart;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class CartDAO {
	public List<CartDTO> listCart(String userID) {
		SqlSession session = Mybatis.getInstance().openSession();
		List<CartDTO> list = session.selectList("cart.list", userID);
		session.close();
		return list;
	}
	
	public List<CartDTO> detailCart(int cartNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		List<CartDTO> detailCart = session.selectList("cart.detail_cart", cartNum);
		session.close();
		return detailCart;
	}
	
	public void insertCart(CartDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.insert("cart.insert", dto);
		session.commit();
		session.close();
	}
	
	public void updateCart(CartDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.update("cart.update", dto);
		session.commit();
		session.close();
		}
	
	public void deleteAll(String userID) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.delete("cart.delete_all", userID);
		session.commit();
		session.close();
	}
	
	public void deleteSelected(int cartNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.delete("cart.delete_selected", cartNum);
		session.commit();
		session.close();
	}
	
	public int sumMoney(String userID) {
		SqlSession session = Mybatis.getInstance().openSession();
		int sum = session.selectOne("cart.sum", userID);
		session.close();
		return sum;
	}
	
	// 주문 후 장바구니 삭제
	public void ordered_delete(String userID, int productNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userID", userID);
		map.put("productNum", productNum);
		session.delete("cart.ordered_delete", map);
		session.commit();
		session.close();
	}
	
	// 장바구니 존재 여부
	public int count(CartDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		int count = session.selectOne("cart.count", dto);
		session.close();
		return count;
	}
	
	// 존재하면 수량 update
	public void merge(CartDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.update("cart.merge", dto);
		session.commit();
		session.close();
		}
}
