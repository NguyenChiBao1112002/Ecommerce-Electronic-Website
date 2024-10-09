package ct250.backend.cart;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
interface CartRepository extends JpaRepository<Cart, Long> {
    
    Optional<Cart> findByCustomer_Id(Long customerId);
    
}
