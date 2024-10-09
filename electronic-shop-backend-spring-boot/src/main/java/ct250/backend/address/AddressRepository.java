package ct250.backend.address;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;

public interface AddressRepository extends JpaRepository<Address, Long> {

    ArrayList<Address> findByCustomer_Id(Long id);

}