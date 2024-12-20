package product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import sqlmap.Mybatis;

public class AdminProductDAO {

    public List<ProductDTO> adminListProduct() { // 관리자용 상품 목록 조회
        SqlSession session = Mybatis.getInstance().openSession();
        List<ProductDTO> list = session.selectList("product.list_product");
        session.close();
        return list;
    }

    public ProductDTO adminDetailProduct(int productNum) { // 상품 상세 조회(관리자)
        SqlSession session = Mybatis.getInstance().openSession();
        ProductDTO dto = session.selectOne("product.detail_product", productNum);
        session.close();
        return dto;
    }

    public void adminUpdateProduct(ProductDTO dto) { //상품 정보 수정
        SqlSession session = Mybatis.getInstance().openSession();
        session.update("product.update_product", dto);
        session.commit();
        session.close();
        
    }

    public void adminDeleteProduct(int productNum) { // 상품 삭제
        SqlSession session = Mybatis.getInstance().openSession();
        session.delete("product.delete_product", productNum);
        session.commit();
        session.close();
        
    }

    public void adminInsertProduct(ProductDTO dto) { // 상품 추가
        SqlSession session = Mybatis.getInstance().openSession();
        session.insert("product.insert_product", dto);
        session.commit();
        session.close();
        
    }

    public String adminFileInfo(int productNum) { // 파일 정보 조회
        SqlSession session = Mybatis.getInstance().openSession();
        String result = session.selectOne("product.file_info", productNum);
        session.close();
        return result;
    }

    public List<CompanyDTO> adminListCompany() { // 업체 목록 조회
        SqlSession session = Mybatis.getInstance().openSession();
        List<CompanyDTO> list = session.selectList("product.list_company");
        session.close();
        return list;
    }
    
    // 업체 리스트
    public List<CompanyDTO> listCompany() {
       SqlSession session = Mybatis.getInstance().openSession();
       List<CompanyDTO> company = session.selectList("product.list_company");
       session.close();
       return company;
    }

    
    public List<CategoryDTO> adminListCategory() { // 카테고리 조회
    	SqlSession session = Mybatis.getInstance().openSession();
    	List<CategoryDTO> list = session.selectList("product.list_category");
    	session.close();
    	return list;
    }
    
    // 부모카테고리 리스트
    public List<CategoryDTO> p_listCategory() {
       SqlSession session = Mybatis.getInstance().openSession();
       List<CategoryDTO> p_category = session.selectList("product.p_list_category");
       session.close();
       return p_category;   
    }
    
	 // 업체별 상품
	public List<ProductDTO> companyProduct(int companyNum) {
	   SqlSession session = Mybatis.getInstance().openSession();
	   List<ProductDTO> list_cate = session.selectList("product.company_product", companyNum);
	   session.close();
	   return list_cate;
	}
	
	public List<CategoryDTO> listCategory(int p_parentCategory) {
		   SqlSession session = Mybatis.getInstance().openSession();
		   List<CategoryDTO> category = session.selectList("product.list_category", p_parentCategory);
		   session.close();
		   return category;
	}
	
		// 카테고리별 상품
	   public List<ProductDTO> categoryProduct(int p_categoryNum) {
	      SqlSession session = Mybatis.getInstance().openSession();
	      List<ProductDTO> list_com = session.selectList("product.category_product", p_categoryNum);
	      session.close();
	      return list_com;
	   }
    
//    public List<ProductDTO> adminListProductByCategory(int p_categoryNum) { // 특정 카테고리에 속한 상품 조회
//        SqlSession session = Mybatis.getInstance().openSession();
//        List<ProductDTO> list = session.selectList("product.list_product_by_category", p_categoryNum);
//        session.close();
//        return list;
//    }
}
