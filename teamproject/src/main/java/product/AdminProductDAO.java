package product;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import sqlmap.Mybatis;

public class AdminProductDAO {

    // 관리자용 상품 목록 조회
    public List<ProductDTO> admin_listProduct() {
        SqlSession session = Mybatis.getInstance().openSession();
        List<ProductDTO> list = session.selectList("product.list_product");
        session.close();
        return list;
    }

    // 관리자용 상품 상세 조회
    public ProductDTO admin_detailProduct(int productNum) {
        SqlSession session = Mybatis.getInstance().openSession();
        ProductDTO dto = session.selectOne("product.detail_product", productNum);
        session.close();
        return dto;
    }

    // 관리자용 상품 정보 수정
    public void admin_updateProduct(ProductDTO dto) {
        SqlSession session = Mybatis.getInstance().openSession();
        try {
            session.update("product.update_product", dto);
            session.commit();
        } finally {
            session.close();
        }
    }

    // 관리자용 상품 삭제
    public void admin_deleteProduct(int productNum) {
        SqlSession session = Mybatis.getInstance().openSession();
        try {
            session.delete("product.delete_product", productNum);
            session.commit();
        } finally {
            session.close();
        }
    }

    // 관리자용 상품 추가
    public void admin_insertProduct(ProductDTO dto) {
        SqlSession session = Mybatis.getInstance().openSession();
        try {
            session.insert("product.insert_product", dto);
            session.commit();
        } finally {
            session.close();
        }
    }

    // 관리자용 파일 정보 조회
    public String admin_fileInfo(int productNum) {
        SqlSession session = Mybatis.getInstance().openSession();
        String result = session.selectOne("product.file_info", productNum);
        session.close();
        return result;
    }

    // 관리자용 업체 목록 조회
    public List<CompanyDTO> admin_listCompany() {
        SqlSession session = Mybatis.getInstance().openSession();
        List<CompanyDTO> list = session.selectList("product.list_company");
        session.close();
        return list;
    }

    // 관리자용 카테고리 목록 조회
    public List<CategoryDTO> admin_listCategories() {
        SqlSession session = Mybatis.getInstance().openSession();
        List<CategoryDTO> categories = session.selectList("category.list_category");
        session.close();
        return categories;
    }

    // 관리자용 특정 카테고리에 속한 상품 조회
    public List<ProductDTO> admin_listProductsByCategory(int p_categoryNum) {
        SqlSession session = Mybatis.getInstance().openSession();
        List<ProductDTO> list = session.selectList("product.list_products_by_category", p_categoryNum);
        session.close();
        return list;
    }
}
