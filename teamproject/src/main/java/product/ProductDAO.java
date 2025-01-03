package product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import sqlmap.Mybatis;

public class ProductDAO {

   public List<ProductDTO> listProduct() { // 상품 목록 조회
      SqlSession session = Mybatis.getInstance().openSession();
      List<ProductDTO> list = session.selectList("product.list_product");
      session.close();
      return list;
   }
   
    public List<CategoryDTO> listCategory() { // 카테고리 조회 
        SqlSession session = Mybatis.getInstance().openSession();
        List<CategoryDTO> category = session.selectList("category.list_category");
        session.close();
        return category;
    }

    public List<ProductDTO> listProductByCategory(int p_categoryNum) { // 특정 카테고리에 속한 상품 조회 
        SqlSession session = Mybatis.getInstance().openSession();
        List<ProductDTO> list = session.selectList("product.list_products_by_category", p_categoryNum);
        session.close();
        return list;
    }

    public ProductDTO detailProduct(int productNum) {  // 상품 상세 조회
        SqlSession session = Mybatis.getInstance().openSession();
        ProductDTO dto = session.selectOne("product.detail_product", productNum);
        session.close();
        return dto;
    }
    
    
    public List<CategoryDTO> p_listCategory() {
        SqlSession session = Mybatis.getInstance().openSession();
        List<CategoryDTO> p_category = session.selectList("product.p_list_category");
        session.close();
        return p_category;   
     }
    
    public List<CompanyDTO> listCompany() {
	     SqlSession session = Mybatis.getInstance().openSession();
	     List<CompanyDTO> company = session.selectList("product.list_company");
	     session.close();
	     return company;
	  }
	  
  
}
