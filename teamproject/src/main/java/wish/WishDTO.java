package wish;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WishDTO {
	private int wishNum;
	private String userID;
	private int productNum;
	private String productName;
	private String productImage;
	private int price;
}
