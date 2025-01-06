package cart;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CartDTO {
	private int cartNum;
	private String userID;
	private int productNum;
	private int cartAmount;
	private int price;
	private String productName;
	private String productImage;
	private String description;
	private int money;
}
