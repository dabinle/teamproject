package product;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductDTO {
   private int productNum;
   private String productName;
   private double price;
   private int amount;
   private int companyNum;
   private String companyName;
   private int p_parentCategory;
   private int p_categoryNum;
   private String description;
   private String productImage;
}