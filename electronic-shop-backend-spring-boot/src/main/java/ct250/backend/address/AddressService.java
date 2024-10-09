package ct250.backend.address;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AddressService {

    @Autowired
    private AddressRepository addressRepository;

    public ArrayList<Address> findAll() {
        return (ArrayList<Address>) addressRepository.findAll();
    }

    @SuppressWarnings("null")
    public Address findById(Long id) {
        return addressRepository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    public ArrayList<Address> findByCustomerId(Long id) {
        return addressRepository.findByCustomer_Id(id);
    }

    @SuppressWarnings("null")
    public ArrayList<Address> findDefaultAddress(Long id) {
        List<Address> defaultAddresses = this.findByCustomerId(id)
                .stream()
                .filter(a -> a.getIsDefault() == true)
                .toList();

        return new ArrayList<>(defaultAddresses);
    }

    public void add(Address address) {
        this.addressRepository.save(address);
    }

    @SuppressWarnings("null")
    public void deleteById(Long id) {
        this.addressRepository.deleteById(id);
    }

    public Address updateAddress(Long id, Address address) {
        Address existingAddress = findById(address.getId());

        if (existingAddress != null) {
            existingAddress.setBelongsTo(address.getBelongsTo());
            existingAddress.setPhone(address.getPhone());
            existingAddress.setAddress(address.getAddress());
            existingAddress.setCityId(address.getCityId());
            existingAddress.setDistrictId(address.getDistrictId());
            existingAddress.setWardId(address.getWardId());
            existingAddress.setCustomer(address.getCustomer());
            existingAddress.setWarehouse(address.getWarehouse());

            if (!address.getIsDefault()) {
                existingAddress.setIsDefault(address.getIsDefault());
            }

            if (address.getIsDefault() && this.findDefaultAddress(id).size() >= 0) {
                this.findDefaultAddress(id).forEach(a -> {
                    a.setIsDefault(false);
                    this.addressRepository.save(a);
                });

                existingAddress.setIsDefault(address.getIsDefault());
            }

            this.addressRepository.save(existingAddress);
            return existingAddress;
        }
        return null;
    }
}
