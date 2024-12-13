package shop;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductDTO {
	private int producNum;
	private String productName;
	private String description;
	private int price;
	private String productImage;
	private int companyNum;
	private String companyName;
	private int p_categoryNum;
	private int p_parentCatogory;
}