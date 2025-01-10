package coupon;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class CouponDAO {
	// 쿠폰 전체 리스트
	public List<CouponDTO> couponList() {
		SqlSession session = Mybatis.getInstance().openSession();
		List<CouponDTO> couponList = session.selectList("coupon.list");
		session.close();
		return couponList;
	}
}
