package ct250.backend.product;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
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
@Table(name = "product_detail")
@AllArgsConstructor
@NoArgsConstructor
public class ProductDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;

    private String size;

    private String color;

    private String colorImage;

    private String unit;
    
    private int quantity;

    private int sold;

    @Column(columnDefinition = "TEXT")
    private String imageLinks;
    @Column(columnDefinition = "TEXT")
    private String imageLink;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

}
