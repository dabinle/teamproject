package product;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CategoryDTO {
    private int p_categoryNum;
    private String p_categoryName;
    private int p_parentCategory;
}