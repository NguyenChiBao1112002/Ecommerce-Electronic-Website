package ct250.backend.order;

import java.math.BigDecimal;

import org.springframework.stereotype.Component;

import ct250.backend.cart.CartDetail;
import ct250.backend.product.ProductDetail;
import jakarta.persistence.Column;
import jakarta.persistence.ConstraintMode;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Component
@Entity
@Data
@Table(name = "order_detail")
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;

    @Column
    private int quantity;

    @Column(precision = 10, scale = 2)
    private BigDecimal total;

    @ManyToOne
    @JoinColumn(name = "order_id")
    // @JsonIgnore
    private Order order;

    @ManyToOne
    @JoinColumn(name = "product_detail_id", foreignKey = @jakarta.persistence.ForeignKey(value = ConstraintMode.NO_CONSTRAINT))
    private ProductDetail productDetail;

    public OrderDetail(CartDetail cartDetail) {
        this();
        this.quantity = cartDetail.getQuantity();
        this.total = cartDetail.getTotal();
        this.productDetail = cartDetail.getProductDetail();
    }

}
