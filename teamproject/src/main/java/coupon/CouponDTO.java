package coupon;

import java.sql.Date;
import java.util.List;

public class CouponDTO {
	private int couponNum;
	private String couponName;
	private String couponImage;
	private int couponPrice;
	private int couponCount;
	private Date couponStart;
	private Date couponEnd;
	private List<CouponMemberDTO> couponmemberDTO; // LIST 말고 dto로 하면 값 하나만 나와야함
	
	public CouponDTO() {
		// TODO Auto-generated constructor stub
	}
	
	

	public CouponDTO(int couponNum, String couponName, String couponImage, int couponPrice, int couponCount,
			Date couponStart, Date couponEnd, List<CouponMemberDTO> couponmemberDTO) {
		super();
		this.couponNum = couponNum;
		this.couponName = couponName;
		this.couponImage = couponImage;
		this.couponPrice = couponPrice;
		this.couponCount = couponCount;
		this.couponStart = couponStart;
		this.couponEnd = couponEnd;
		this.couponmemberDTO = couponmemberDTO;
	}



	public int getCouponNum() {
		return couponNum;
	}

	public void setCouponNum(int couponNum) {
		this.couponNum = couponNum;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public String getCouponImage() {
		return couponImage;
	}

	public void setCouponImage(String couponImage) {
		this.couponImage = couponImage;
	}

	public int getCouponPrice() {
		return couponPrice;
	}

	public void setCouponPrice(int couponPrice) {
		this.couponPrice = couponPrice;
	}

	public int getCouponCount() {
		return couponCount;
	}

	public void setCouponCount(int couponCount) {
		this.couponCount = couponCount;
	}

	public Date getCouponStart() {
		return couponStart;
	}

	public void setCouponStart(Date couponStart) {
		this.couponStart = couponStart;
	}

	public Date getCouponEnd() {
		return couponEnd;
	}

	public void setCouponEnd(Date couponEnd) {
		this.couponEnd = couponEnd;
	}

	public List<CouponMemberDTO> getCouponmemberDTO() {
		return couponmemberDTO;
	}

	public void setCouponmemberDTO(List<CouponMemberDTO> couponmemberDTO) {
		this.couponmemberDTO = couponmemberDTO;
	}
	
	

}