package ct250.backend.coupon;

import ct250.backend.employee.Employee;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Date;

@Component
@Entity
@Data
@Table(name = "coupon")
@AllArgsConstructor
@NoArgsConstructor
public class Coupon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "employee_id", referencedColumnName = "id")
    private Employee employee;

    @Column(length = 20)
    private String code;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(length = 50)
    private String type;

    @Column(precision = 10, scale = 2)
    private BigDecimal value;

    @Column(name = "start_date")
    @Temporal(value = TemporalType.DATE)
    private Date startDate;

    @Column(name = "end_date")
    @Temporal(value = TemporalType.DATE)
    private Date endDate;

    @Column(name = "min_spend", precision = 10, scale = 2)
    private BigDecimal minSpend;

    // cappedAt > minSpend
    @Column(name = "capped_at", precision = 10, scale = 2)
    private BigDecimal cappedAt;

    @Column(name = "uses_per_coupon")
    private int usesPerCoupon;

    @Column(length = 20)
    private String status;

    @Column(name = "created_at")
    @Temporal(value = TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "updated_at")
    @Temporal(value = TemporalType.TIMESTAMP)
    private Date updatedAt;

}