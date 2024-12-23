package cart;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class CartDAO {
	public List<CartDTO> cart_money() {
		SqlSession session = Mybatis.getInstance().openSession();
		List<CartDTO> items = session.selectList("cart.product_money");
		session.close();
		return items;
	}
	
	public void insert_cart(CartDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.insert("cart.insert_cart", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public List<CartDTO> list_cart(String userID) {
		SqlSession session = null;
		List<CartDTO> list = null;
		try {
			session = Mybatis.getInstance().openSession();
			list = session.selectList("cart.list_cart", userID);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}
	
	public void delete_cart(int cartID) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.delete("cart.delete_cart", cartID);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void update_cart(CartDTO dto) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.update("cart.update_cart", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public void clear_cart(String userID) {
		SqlSession session = null;
		try {
			session = Mybatis.getInstance().openSession();
			session.delete("cart.clear_cart", userID);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}
	
	public int sum_money(String userID) {
		int total = 0;
		SqlSession session = Mybatis.getInstance().openSession();
		total = session.selectOne("cart.sum_money", userID);
		session.close();
		return total;
	}
}