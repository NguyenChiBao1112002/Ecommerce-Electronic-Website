package ct250.backend.staff;

import ct250.backend.employee.Employee;
import ct250.backend.warehouse.Warehouse;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.stereotype.Component;

@Component
@Entity
@AllArgsConstructor
@NoArgsConstructor
@DiscriminatorValue("staff")
public class Staff extends Employee {

    @OneToOne
    @JoinColumn(name = "warehouse_id", referencedColumnName = "id")
    private Warehouse warehouse;

}
