package cart;
import java.util.List;


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
}
