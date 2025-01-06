package product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class AdminProductDAO {
   public List<ProductDTO> listProduct(){
      SqlSession session = Mybatis.getInstance().openSession();
      List<ProductDTO> list = session.selectList("productAdmin.list_product");
      session.close();
      return list;
   }
   
   public ProductDTO detailProduct(int productNum) {
	  SqlSession session = Mybatis.getInstance().openSession();
	  ProductDTO dto = session.selectOne("productAdmin.detail", productNum);
	  session.close();
	  return dto;
}
   
   public void updateProduct(ProductDTO dto) {
      SqlSession session = Mybatis.getInstance().openSession();
      session.update("productAdmin.update_product", dto);
      session.commit();
      session.close();
   }
   
   public void deleteProduct(int productNum) {
      SqlSession session = Mybatis.getInstance().openSession();
      session.delete("productAdmin.delete_product", productNum);
      session.commit();
      session.close();
   }
   
   public void insertProduct(ProductDTO dto) {
      SqlSession session = Mybatis.getInstance().openSession();
      session.insert("productAdmin.insert_product", dto);
      session.commit();
      session.close();
   }
   
   public String fileInfo(int productNum) {
      SqlSession session = Mybatis.getInstance().openSession();
      String result = session.selectOne("productAdmin.file_info", productNum);
      session.close();
      return result;
   }
   
   // 부모카테고리 리스트
   public List<CategoryDTO> p_listCategory() {
      SqlSession session = Mybatis.getInstance().openSession();
      List<CategoryDTO> p_category = session.selectList("productAdmin.p_list_category");
      session.close();
      return p_category;   
   }
   
   public List<CategoryDTO> listCategory(int p_categoryNum) {
	   SqlSession session = Mybatis.getInstance().openSession();
	   List<CategoryDTO> category = session.selectList("productAdmin.list_category", p_categoryNum);
	   session.close();
	   return category;
}
   // 업체 리스트
   public List<CompanyDTO> listCompany() {
      SqlSession session = Mybatis.getInstance().openSession();
      List<CompanyDTO> company = session.selectList("productAdmin.list_company");
      session.close();
      return company;
   }
   
   // 업체별 상품
   public List<ProductDTO> companyProduct(int companyNum) {
      SqlSession session = Mybatis.getInstance().openSession();
      List<ProductDTO> list_cate = session.selectList("productAdmin.company_product", companyNum);
      session.close();
      return list_cate;
   }
   
   // 카테고리별 상품
   public List<ProductDTO> categoryProduct(int p_categoryNum) {
      SqlSession session = Mybatis.getInstance().openSession();
      List<ProductDTO> list_com = session.selectList("productAdmin.category_product", p_categoryNum);
      session.close();
      return list_com;
   }
}
