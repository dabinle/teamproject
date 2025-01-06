package order;

import java.sql.Date;


public class OrderDTO {
	private String userName;
	private String phoneNum;
	
	private int orderNum;
	private String userID;
	private int productNum;
	private int orderAmount;
	private long orderDate;
	private String recipient;
	private String rec_phoneNum;
	private int zipCode;
	private String address;
	private String addressDetail;
	
	private String productName;
	private String productImage;
	private int price;
	
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public long getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(long orderDate) {
		this.orderDate = orderDate;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductImage() {
		return productImage;
	}
	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public int getZipCode() {
		return zipCode;
	}
	public void setZipCode(int zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getOrderAmount() {
		return orderAmount;
	}
	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getRec_phoneNum() {
		return rec_phoneNum;
	}
	public void setRec_phoneNum(String rec_phoneNum) {
		this.rec_phoneNum = rec_phoneNum;
	}
	
	
	public OrderDTO() {
		// TODO Auto-generated constructor stub
	}
	public OrderDTO(String userName, String phoneNum, String userID, int productNum, int orderAmount, long orderDate,
			String recipient, String rec_phoneNum, int zipCode, String address, String addressDetail,
			String productName, String productImage, int price) {
		super();
		this.userName = userName;
		this.phoneNum = phoneNum;
		this.userID = userID;
		this.productNum = productNum;
		this.orderAmount = orderAmount;
		this.orderDate = orderDate;
		this.recipient = recipient;
		this.rec_phoneNum = rec_phoneNum;
		this.zipCode = zipCode;
		this.address = address;
		this.addressDetail = addressDetail;
		this.productName = productName;
		this.productImage = productImage;
		this.price = price;
	}

	
	

	
}
