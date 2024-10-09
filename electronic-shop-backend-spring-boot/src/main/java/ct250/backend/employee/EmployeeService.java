package ct250.backend.employee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    public ArrayList<Employee> findAll() {
        return (ArrayList<Employee>) employeeRepository.findAll();
    }

    @SuppressWarnings("null")
    public Employee findById(Long id) {
        return employeeRepository.findById(id).orElse(null);
    }

    public Employee findByAccount(String account) {
        return employeeRepository.findByAccount(account).orElse(null);
    }

    @SuppressWarnings("null")
    public void add(Employee employee) {
        this.employeeRepository.save(employee);
    }

    @SuppressWarnings("null")
    public void deleteById(Long id) {
        this.employeeRepository.deleteById(id);
    }
}
