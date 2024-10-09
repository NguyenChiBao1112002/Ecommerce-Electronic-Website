package ct250.backend.admin;

import org.springframework.stereotype.Component;

import ct250.backend.employee.Employee;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Component
@Entity
@DiscriminatorValue("admin")
public class Admin extends Employee {

}
