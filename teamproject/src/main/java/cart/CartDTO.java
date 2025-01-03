package cart;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartDTO {
	private int cartNum;
	private String userID;
	private int productNum;
	private int cartAmount;
	private String productImage;
	private String productName;
	private int price;
	private int money;
}
