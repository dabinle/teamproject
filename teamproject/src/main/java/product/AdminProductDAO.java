package product;

import java.util.List;
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
        ProductDTO dto = session.selectOne("product.admin_detail_product", productNum);
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

    public List<CategoryDTO> adminListCategory() { // 카테고리 목록 조회
        SqlSession session = Mybatis.getInstance().openSession();
        List<CategoryDTO> category = session.selectList("product.list_category");
        session.close();
        return category;
    }

    public List<ProductDTO> adminListProductByCategory(int p_categoryNum) { // 특정 카테고리에 속한 상품 조회
        SqlSession session = Mybatis.getInstance().openSession();
        List<ProductDTO> list = session.selectList("product.list_product_by_category", p_categoryNum);
        session.close();
        return list;
    }
}
