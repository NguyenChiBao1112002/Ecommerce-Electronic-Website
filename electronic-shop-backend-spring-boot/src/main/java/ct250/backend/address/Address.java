package ct250.backend.address;

import org.springframework.stereotype.Component;

import ct250.backend.customer.Customer;
import ct250.backend.warehouse.Warehouse;
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
@Table(name = "address")
@AllArgsConstructor
@NoArgsConstructor
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "TEXT")
    private String belongsTo; // user's name

    @Column
    private String phone;

    @Column(columnDefinition = "TEXT")
    private String address;

    @Column
    private String cityId;

    @Column
    private String districtId;

    @Column
    private String wardId;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @Column
    private Boolean isDefault = false;

    @JoinColumn
    @ManyToOne
    private Warehouse warehouse;

}