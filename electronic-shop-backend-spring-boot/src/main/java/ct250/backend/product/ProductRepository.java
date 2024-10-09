package ct250.backend.product;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
interface ProductRepository extends JpaRepository<Product, Long> {
    ArrayList<Product> findProductsByType(ProductType type);
}
