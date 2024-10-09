package ct250.backend.customer;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CustomerService {

    @Autowired
    private CustomerRepository customerRepository;

    public ArrayList<Customer> findAll() {
        return (ArrayList<Customer>) customerRepository.findAll();
    }

    @SuppressWarnings("null")
    public Customer findById(Long id) {
        return customerRepository.findById(id).orElse(null);
    }

    public Customer findByAccount(String account) {
        return customerRepository.findByAccount(account).orElse(null);
    }

    @SuppressWarnings("null")
    public void add(Customer customer) {
        this.customerRepository.save(customer);
    }

    @SuppressWarnings("null")
    public void deleteById(Long id) {
        this.customerRepository.deleteById(id);
    }

    public Customer updateCustomer(Long id, Customer customer) {
        Customer existingCustomer = findById(id);
        if (existingCustomer != null) {
            existingCustomer.setLocked(!existingCustomer.isLocked());
            this.customerRepository.save(existingCustomer);
            return existingCustomer;
        }
        return null;
    }

    public Customer updateCustomerInfo(Long id, Customer customer) {
        Customer existingCustomer = findById(id);
        if (existingCustomer != null) {
            System.out.println(customer);
            existingCustomer.setName(customer.getName());
            existingCustomer.setEmail(customer.getEmail());
            existingCustomer.setName(customer.getName());
            existingCustomer.setPhone(customer.getPhone());
            existingCustomer.setDob(customer.getDob());
            existingCustomer.setAddress(customer.getAddress());
            this.customerRepository.save(existingCustomer);
            return existingCustomer;
        }
        return null;
    }

}
