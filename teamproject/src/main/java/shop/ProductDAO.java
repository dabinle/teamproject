package shop;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class ProductDAO {
	public List<ProductDTO> listProduct() {
		SqlSession session = Mybatis.getInstance().openSession();
		List<ProductDTO> list = session.selectList("product.list_product");
		session.close();
		return list;
	}
	
	public ProductDTO detailProduct(int productNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		ProductDTO dto = session.selectOne("product.detail_product", productNum);
		session.close();
		return dto;
	}
	
	public void updateProduct(ProductDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.update("product.update_product", dto);
		session.commit();
		session.close();
	}
	
	public void deleteProduct(int productNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.delete("product.delete_product", productNum);
		session.commit();
		session.close();
	}
	
	public void insertProduct(ProductDTO dto) {
		SqlSession session = Mybatis.getInstance().openSession();
		session.insert("product.insert_product", dto);
		session.commit();
		session.close();
	}
	
	public String fileInfo(int productNum) {
		SqlSession session = Mybatis.getInstance().openSession();
		String result = session.selectOne("product.file_info", productNum);
		session.close();
		return result;
	}
}
