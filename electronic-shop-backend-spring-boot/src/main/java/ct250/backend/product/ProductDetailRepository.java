package ct250.backend.product;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
interface ProductDetailRepository extends JpaRepository<ProductDetail, Long> {

    ArrayList<ProductDetail> findByProduct_Id(Long productId);
    ArrayList<ProductDetail> findByColor(String color);
    ArrayList<ProductDetail> findBySize(String size);
    ArrayList<ProductDetail> findByColorAndSize(String color, String size);
}
