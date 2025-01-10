package order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Or;

import product.ProductDTO;
import sqlmap.Mybatis;

public class OrderDAO {
	// 단일구매 상품 정보 넘기는 용도 ( 나중에 join으로 바꿀 수도 )
	public ProductDTO orderOne(int productNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		ProductDTO productDTO = session.selectOne("order.order_one", productNum);
		session.close();
		return productDTO;
	}
	
	// 구매 ( orders 테이블에 insert )
	public void insert(OrderDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.insert("order.insert", dto);
		session.commit();
		session.close();
	}
	
	// 주문 상세 정보
	public List<OrderDTO> detailAll(Long orderDate) {
		SqlSession session = Mybatis.getInstance().openSession();
		List<OrderDTO> orderList= session.selectList("order.detail_all", orderDate);
		session.close();
		return orderList;
	}
	// 주문 상세 정보 2
	public OrderDTO detailOne(Long orderDate, int orderNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderDate", orderDate);
		map.put("orderNum", orderNum);
		OrderDTO orderDTO = session.selectOne("order.detail_one", map); 
		return orderDTO;
	}
	
	// 한 회원의 주문 목록 리스트
	public List<OrderDTO> orderList(String userID) {
		SqlSession session = Mybatis.getInstance().openSession();
		List<OrderDTO> list = session.selectList("order.list", userID);
		session.close();
		return list;
	}
	
	// 주문 취소
	public void delete(int orderNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.delete("order.delete", orderNum);
		session.commit();
		session.close();
	}
}
