package shop;

public class ProductDTO {
	private int producNum;
	private String productName;
	private String description;
	private int price;
	private int amount;
	private String productImage;
	
	public int getProducNum() {
		return producNum;
	}
	public void setProducNum(int producNum) {
		this.producNum = producNum;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getProductImage() {
		return productImage;
	}
	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}
	@Override
	public String toString() {
		return "ProductDTO [producNum=" + producNum + ", productName=" + productName + ", description=" + description
				+ ", price=" + price + ", amount=" + amount + ", productImage=" + productImage + "]";
	}
}
