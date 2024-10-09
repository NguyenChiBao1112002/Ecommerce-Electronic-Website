package ct250.backend.employee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/employees")
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @GetMapping
    public ArrayList<Employee> getAllEmployees() {
        return this.employeeService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getEmployeeById(@PathVariable Long id) {
        Employee employee = employeeService.findById(id);
        if (employee == null) {
            return new ResponseEntity<>("This employee is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(employee, HttpStatus.FOUND);
    }

    @PostMapping
    public ResponseEntity<?> addEmployee(@RequestBody Employee employee) {
        // Check if customer exist or not?
        Employee isExistedEmployee = employeeService.findById(employee.getId());
        if (isExistedEmployee == null) {
            this.employeeService.add(employee);
            return new ResponseEntity<>(employee, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("The employee with id=" + employee.getId() + " existed. Try again!",
                HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteEmployeeById(@PathVariable Long id) {
        Employee employee = employeeService.findById(id);
        if (employee == null) {
            return new ResponseEntity<>("This employee is not exist", HttpStatus.NOT_FOUND);
        }
        this.employeeService.deleteById(id);
        return new ResponseEntity<>("An employee with id=" + id + " is deleted successfully", HttpStatus.OK);
    }

    @PostMapping("/loginEmployee")
    public ResponseEntity<?> loginEmployee(@RequestBody Employee employee) {
        // Check if customer exists in the database
        Employee existingEmployee = employeeService.findByAccount(employee.getAccount());
        if (existingEmployee == null) {
            return new ResponseEntity<>("Employee not found", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(existingEmployee, HttpStatus.OK);
    }
}
