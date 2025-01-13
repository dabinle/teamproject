package product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class ProductDAO {
	// 상품 리스트
	   public List<ProductDTO> listProduct(String searchkey, String search){
	      SqlSession session = Mybatis.getInstance().openSession();
	      List<ProductDTO> list = null;
	      if(searchkey.equals("all")) {
	         list = session.selectList("product.all_list_product", search);
	      } else {
	         Map<String, Object> map = new HashMap<String, Object>();
	         map.put("searchkey", searchkey);
	         map.put("search", search);
	         list = session.selectList("product.list_product", map);
	      }
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
