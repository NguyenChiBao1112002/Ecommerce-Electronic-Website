package ct250.backend.address;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/addresses")
public class AddressController {

    @Autowired
    AddressService addressService;

    @GetMapping
    public ArrayList<Address> getAllAddresses() {
        return this.addressService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getAddressById(@PathVariable Long id) {
        Address address = addressService.findById(id);
        if (address == null) {
            return new ResponseEntity<>("This address is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(address, HttpStatus.OK);
    }

    @GetMapping("/customer/{id}/default")
    public ResponseEntity<?> getDefaultAddress(@PathVariable Long id) {
        ArrayList<Address> addresses = addressService.findDefaultAddress(id);
        if (addresses == null) {
            return new ResponseEntity<>("This user has not have default address", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(addresses, HttpStatus.OK);
    }

    @GetMapping("/customer/{id}")
    public ResponseEntity<?> getAddressByCustomerId(@PathVariable Long id) {
        List<Address> addresses = addressService.findByCustomerId(id);
        return new ResponseEntity<>(addresses, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<?> addAddress(@RequestBody Address address) {
        this.addressService.add(address);
        return new ResponseEntity<>(address, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteAddressById(@PathVariable Long id) {
        Address address = addressService.findById(id);
        if (address == null) {
            return new ResponseEntity<>("This address is not exist", HttpStatus.NOT_FOUND);
        }
        this.addressService.deleteById(id);
        return new ResponseEntity<>("A address with id=" + id + " is deleted successfully", HttpStatus.OK);
    }

    @PutMapping("/customer/{id}")
    public ResponseEntity<String> updateAddressByCustomerId(@PathVariable Long id, @RequestBody Address address) {
        if (this.addressService.updateAddress(id, address) != null) {
            return new ResponseEntity<>("A address with id=" + address.getId() + " is updated successfully",
                    HttpStatus.OK);
        }
        return new ResponseEntity<>("The address with id=" + address.getId() + " fail updated. Try again!",
                HttpStatus.BAD_REQUEST);
    }
}
