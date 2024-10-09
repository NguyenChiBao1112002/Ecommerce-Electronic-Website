package ct250.backend.review;

import java.util.ArrayList;
import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ct250.backend.customer.Customer;
import ct250.backend.order.OrderDetail;
import ct250.backend.order.OrderService;
import ct250.backend.product.ProductService;

@Service
public class ReviewService {

    @Autowired
    ReviewRepository reviewRepository;

    @Autowired
    ProductService productService;

    @Autowired
    OrderService orderService;

    public ArrayList<Review> getAllReviewRecommend() {
        ArrayList<Review> reviewsDB = (ArrayList<Review>) this.reviewRepository.findAll();
        ArrayList<Review> reviewsReverse = new ArrayList<>(reviewsDB);
        if (reviewsDB.size() > 5000) {
            reviewsDB.subList(0, reviewsDB.size() - 5000).clear(); // Xóa các review cũ, giữ lại 5000 review mới nhất
        }
        Collections.reverse(reviewsReverse);
        return reviewsReverse;
    }

    void addReview(Long orderDetailId, Review review) {
        OrderDetail orderDetail = this.orderService.findOrderDetailById(orderDetailId);
        review.setOrderDetail(orderDetail);
        Customer customer = orderDetail.getOrder().getCustomer();
        review.setCustomer(customer);
        this.reviewRepository.save(review);
    }

    ArrayList<Review> getAllReviews() {
        ArrayList<Review> reviewsDB = (ArrayList<Review>) this.reviewRepository.findAll();
        ArrayList<Review> reviewsReverse = new ArrayList<>(reviewsDB);
        Collections.reverse(reviewsReverse);
        return reviewsReverse;
    }

    ArrayList<Review> getAllReviewsByCustomerId(Long customerId) {
        ArrayList<Review> reviewsDB = this.reviewRepository.findByCustomer_Id(customerId);
        ArrayList<Review> reviewsReverse = new ArrayList<>(reviewsDB);
        Collections.reverse(reviewsReverse);
        return reviewsReverse;
    }

    ArrayList<Review> getAllReviewsByProductId(Long productId) {
        ArrayList<Review> reviewsDB = this.reviewRepository.findByOrderDetail_ProductDetail_Product_Id(productId);
        ArrayList<Review> reviewsReverse = new ArrayList<>(reviewsDB);
        Collections.reverse(reviewsReverse);
        return reviewsReverse;
    }

    @SuppressWarnings("null")
    public Review findReviewById(Long id) {
        return this.reviewRepository.findById(id).orElse(null);
    }

    public ArrayList<Review> findReviewByOrderDetailId(Long id) {
        return this.reviewRepository.findByOrderDetail_Id(id);
    }

    public ArrayList<Review> findReviewByOrderId(Long id) {
        return this.reviewRepository.findByOrderDetail_Order_Id(id);
    }

    @SuppressWarnings("null")
    void deleteReviewById(Long id) {
        this.reviewRepository.deleteById(id);
    }

    Review updateReviewImages(Long id, String images) {
        Review review = this.findReviewById(id);
        review.setImageUrls(images);
        return this.reviewRepository.save(review);
    }

}
