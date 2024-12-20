package product;

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
public class ProductDTO {
   private int productNum;
   private String productName;
   private int price;
   private int amount;
   private int companyNum;
   private String companyName;
   private int p_parentCategory;
   private String p_categoryName;
   private int p_categoryNum;
   private String description;
   private String productImage;
}