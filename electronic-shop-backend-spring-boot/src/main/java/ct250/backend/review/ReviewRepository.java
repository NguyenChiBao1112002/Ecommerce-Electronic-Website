package ct250.backend.review;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
interface ReviewRepository extends JpaRepository<Review, Long> {

    ArrayList<Review> findByOrderDetail_ProductDetail_Product_Id(Long productId);

    ArrayList<Review> findByCustomer_Id(Long customerId);

    ArrayList<Review> findByOrderDetail_Id(Long orderDetailId);

    ArrayList<Review> findByOrderDetail_Order_Id(Long orderId);
}