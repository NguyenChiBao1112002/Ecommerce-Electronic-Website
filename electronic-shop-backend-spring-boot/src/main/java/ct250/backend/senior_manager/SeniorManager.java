package ct250.backend.senior_manager;

import org.springframework.stereotype.Component;

import ct250.backend.employee.Employee;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Component
@Entity
// @AllArgsConstructor
// @NoArgsConstructor
@DiscriminatorValue("senior_manager")
public class SeniorManager extends Employee {

}
