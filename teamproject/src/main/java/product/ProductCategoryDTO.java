package product;

public class ProductCategoryDTO {
  	private int p_categoryNum;
  	private String p_categoryName;
  	private int p_parentCategory;
  	
  	public ProductCategoryDTO() {
		// TODO Auto-generated constructor stub
	}

	public ProductCategoryDTO(int p_categoryNum, String p_categoryName, int p_parentCategory) {
		super();
		this.p_categoryNum = p_categoryNum;
		this.p_categoryName = p_categoryName;
		this.p_parentCategory = p_parentCategory;
	}

	public int getP_categoryNum() {
		return p_categoryNum;
	}

	public void setP_categoryNum(int p_categoryNum) {
		this.p_categoryNum = p_categoryNum;
	}

	public String getP_categoryName() {
		return p_categoryName;
	}

	public void setP_categoryName(String p_categoryName) {
		this.p_categoryName = p_categoryName;
	}

	public int getP_parentCategory() {
		return p_parentCategory;
	}

	public void setP_parentCategory(int p_parentCategory) {
		this.p_parentCategory = p_parentCategory;
	}
  	
  	
}
