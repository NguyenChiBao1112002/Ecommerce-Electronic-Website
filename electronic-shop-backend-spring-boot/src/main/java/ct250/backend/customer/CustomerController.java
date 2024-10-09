package ct250.backend.customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;

@RestController
@RequestMapping("/customers")
public class CustomerController {

    @Autowired
    CustomerService customerService;

    @GetMapping
    public ArrayList<Customer> getAllCustomers() {
        return this.customerService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getCustomerById(@PathVariable Long id) {
        Customer customer = customerService.findById(id);
        if (customer == null) {
            return new ResponseEntity<>("This customer is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(customer, HttpStatus.FOUND);
    }

    @GetMapping("/account/{account}")
    public ResponseEntity<?> getCustomerAccount(@PathVariable String account) {
        Customer customer = customerService.findByAccount(account);
        if (customer == null) {
            return new ResponseEntity<>("This customer is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(customer, HttpStatus.FOUND);
    }

    @PostMapping
    public ResponseEntity<?> addCustomer(@RequestBody Customer customer) {
        // Check if customer is exist or not?
        // Customer isExistedCustomer = customerService.findById(customer.getId());
        // if (isExistedCustomer == null) {
        // this.customerService.add(customer);
        // return new ResponseEntity<>(customer, HttpStatus.CREATED);
        // }
        // return new ResponseEntity<>("The customer with id=" + customer.getId() + "
        // existed. Try again!", HttpStatus.BAD_REQUEST);
        this.customerService.add(customer);
        return new ResponseEntity<>(customer, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteCustomerById(@PathVariable Long id) {
        Customer customer = customerService.findById(id);
        if (customer == null) {
            return new ResponseEntity<>("This customer is not exist", HttpStatus.NOT_FOUND);
        }
        this.customerService.deleteById(id);
        return new ResponseEntity<>("A customer with id=" + id + " is deleted successfully", HttpStatus.OK);
    }

    @PostMapping("/register")
    public ResponseEntity<?> registerCustomer(@RequestBody Customer customer) {
        // Check if customer exists in the database
        Customer existingCustomer = customerService.findByAccount(customer.getAccount());
        if (existingCustomer != null) {
            return new ResponseEntity<>("Customer existed", HttpStatus.CONFLICT);
        }
        this.customerService.add(customer);
        return new ResponseEntity<>(existingCustomer, HttpStatus.CREATED);
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginCustomer(@RequestBody Customer customer) {
        // Check if customer exists in the database
        Customer existingCustomer = customerService.findByAccount(customer.getAccount());
        if (existingCustomer == null) {
            return new ResponseEntity<>("Customer not found", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(existingCustomer, HttpStatus.OK);
    }

    @PostMapping("/loginGoogle")
    public ResponseEntity<?> loginGGCustomer(@RequestBody Customer customer) {
        Customer existingCustomer = customerService.findByAccount(customer.getAccount());
        if (existingCustomer == null) {
            this.customerService.add(customer);
            Customer getNewCustomer = customerService.findByAccount(customer.getAccount());
            return new ResponseEntity<>(getNewCustomer, HttpStatus.CREATED);
        }
        return new ResponseEntity<>(existingCustomer, HttpStatus.OK);
    }

    @PutMapping("/{id}/updateLockedStatus")
    public ResponseEntity<?> updateStatusCustomer(@PathVariable Long id) {
        Customer customer = customerService.findById(id);
        if (customer == null) {
            return new ResponseEntity<>("Customer not found", HttpStatus.NOT_FOUND);
        } else {
            if (this.customerService.updateCustomer(id, customer) != null) {
                customer = customerService.findById(id);
                return new ResponseEntity<>(customer, HttpStatus.OK);
            }
            return new ResponseEntity<>("Update failed",
                    HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping("/{id}/updateInfo")
    public ResponseEntity<?> updateInfoCustomer(@PathVariable Long id, @RequestBody Customer customer) {
        if (customer == null) {
            return new ResponseEntity<>("Customer not found", HttpStatus.NOT_FOUND);
        } else {
            if (this.customerService.updateCustomerInfo(id, customer) != null) {
                customer = customerService.findById(id);
                return new ResponseEntity<>(customer, HttpStatus.OK);
            }
            return new ResponseEntity<>("Update failed",
                    HttpStatus.BAD_REQUEST);
        }
    }

}
