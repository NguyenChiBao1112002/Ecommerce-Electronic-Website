package ct250.backend.customer;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {
    // Tìm kiếm Customer theo tên đăng nhập
    Optional<Customer> findByAccount(String account);
}