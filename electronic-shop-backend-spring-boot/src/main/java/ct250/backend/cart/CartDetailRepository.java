package ct250.backend.cart;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    
    Optional<CartDetail> findByProductDetailId(Long productId);
}