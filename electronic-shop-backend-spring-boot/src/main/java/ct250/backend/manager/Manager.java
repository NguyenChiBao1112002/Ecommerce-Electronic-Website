package ct250.backend.manager;

import org.springframework.stereotype.Component;

import ct250.backend.employee.Employee;
import ct250.backend.warehouse.Warehouse;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Component
@Entity
@AllArgsConstructor
@NoArgsConstructor
@DiscriminatorValue("manager")
public class Manager extends Employee {

    @OneToOne
    @JoinColumn(name = "warehouse_id", referencedColumnName = "id")
    private Warehouse warehouse;

    // @Column
    // private String nickname;

}