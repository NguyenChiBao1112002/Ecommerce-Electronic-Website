package ct250.backend.order;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
interface OrderRepository extends JpaRepository<Order, Long> {
    
    ArrayList<Order> findByCustomer_Id(Long customerId);
}

