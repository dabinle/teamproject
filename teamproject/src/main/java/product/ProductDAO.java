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
}
