package product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class ProductDAO {
	 public List<ProductDTO> listProduct(){
	      SqlSession session = Mybatis.getInstance().openSession();
	      List<ProductDTO> list = session.selectList("product.list_product");
	      session.close();
	      return list;
	   }
	   
	   public ProductDTO detailProduct(int productNum) {
		  SqlSession session = Mybatis.getInstance().openSession();
		  ProductDTO dto = session.selectOne("product.detail", productNum);
		  session.close();
		  return dto;
	}
	   
	// 부모 카테고리 리스트
	public List<ProductCategoryDTO> p_allCategory() {
		SqlSession session = Mybatis.getInstance().openSession();
		List<ProductCategoryDTO> p_categoryList = session.selectList("product.p_all_category");
		session.close();
		return p_categoryList;
	}
		
	// 전체카테고리 리스트
	public List<ProductCategoryDTO> allCategory() {
		SqlSession session = Mybatis.getInstance().openSession();
		List<ProductCategoryDTO> categoryList = session.selectList("product.all_category");
		session.close();
		return categoryList;
	}   
}
