package coupon;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class CouponMemberDAO {
	// 쿠폰 다운로드
	public void insert(CouponMemberDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.insert("coupon.insert", dto);
		session.commit();
		session.close();
		}
	
	// 사용 가능 쿠폰 리스트
	public List<CouponDTO> ableList(String userID) {
		SqlSession session = Mybatis.getInstance().openSession();
		List<CouponDTO> ableList = session.selectList("coupon.able_list", userID);
		session.close();
		return ableList;
	}
	
	// 사용 불가 쿠폰 리스트
	public List<CouponDTO> disableList(String userID) {
		SqlSession session = Mybatis.getInstance().openSession();
		List<CouponDTO> disableList = session.selectList("coupon.disable_list", userID);
		session.close();
		return disableList;
	}
	
	// 쿠폰 사용
	public void selected(int couponID, Long orderDate) {
		SqlSession session = Mybatis.getInstance().openSession();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("couponID", couponID);
		map.put("orderDate", orderDate);
		session.update("coupon.done", map);
		session.commit();
		session.close();
	}
	
	// 쿠폰 사용 취소
	public void canceled(int couponID) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.update("coupon.cancel", couponID);
		session.commit();
		session.close();
	}
	
	// 쿠폰 삭제
	public void delete(int couponID) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.delete("coupon.delete", couponID);
		session.commit();
		session.close();
	}
	
	// 사용 쿠폰 상세 정보
	public CouponDTO detail(Long orderDate, String userID) { 
		SqlSession session = Mybatis.getInstance().openSession();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderDate", orderDate);
		map.put("userID", userID);
		CouponDTO couponDTO = session.selectOne("coupon.detail", map);
		session.close();
		return couponDTO;
	}
	
	// 쿠폰 다운 여부
	public int count(String userID, int couponNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userID", userID);
		map.put("couponNum", couponNum);
		int count = session.selectOne("coupon.count", map);
		session.close();
		return count;
	}
}
