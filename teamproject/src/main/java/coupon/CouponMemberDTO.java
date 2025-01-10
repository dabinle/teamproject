package coupon;

public class CouponMemberDTO {
	private int couponID;
	private int couponNum;
	private String userID;
	private int couponStatus;
	private Long orderDate;
	
	public CouponMemberDTO() {
		// TODO Auto-generated constructor stub
	}
	
	
	
	public CouponMemberDTO(int couponID, int couponNum, String userID, int couponStatus, Long orderDate) {
		super();
		this.couponID = couponID;
		this.couponNum = couponNum;
		this.userID = userID;
		this.couponStatus = couponStatus;
		this.orderDate = orderDate;
	}

	public int getCouponID() {
		return couponID;
	}
	public void setCouponID(int couponID) {
		this.couponID = couponID;
	}
	public int getCouponNum() {
		return couponNum;
	}
	public void setCouponNum(int couponNum) {
		this.couponNum = couponNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getCouponStatus() {
		return couponStatus;
	}
	public void setCouponStatus(int couponStatus) {
		this.couponStatus = couponStatus;
	}

	public Long getOrderDate() {
		return orderDate;
	}



	public void setOrderDate(Long orderDate) {
		this.orderDate = orderDate;
	}

	@Override
	public String toString() {
		return "CouponMemberDTO [couponID=" + couponID + ", couponNum=" + couponNum + ", userID=" + userID
				+ ", couponStatus=" + couponStatus + ", orderDate"+ orderDate +"]";
	}



	
	
	
	
}
