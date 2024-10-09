package ct250.backend.order;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
    
    ArrayList<OrderDetail> findByOrder_Id(Long orderId);
}

