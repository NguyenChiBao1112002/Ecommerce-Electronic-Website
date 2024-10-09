package ct250.backend.warehouse;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import jakarta.transaction.Transactional;

@Service
public class WarehouseService {

    @Autowired
    private WarehouseRepository warehouseRepository;

    public ArrayList<Warehouse> findAllWarehouses() {
        return (ArrayList<Warehouse>) this.warehouseRepository.findAll();
    }

    @SuppressWarnings("null")
    public Warehouse findWarehouseById(Long id) {
        return this.warehouseRepository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    @Transactional
    public Warehouse addWarehouse(Warehouse warehouse) {
        return this.warehouseRepository.save(warehouse);
    }

    @Transactional
    public Warehouse updateWarehouse(Long id, Warehouse warehouse) {
        Warehouse existingWarehouse = findWarehouseById(id);
        if (existingWarehouse != null) {
            // Update fields based on your requirements
            existingWarehouse.setName(warehouse.getName());
            existingWarehouse.setAddress(warehouse.getAddress());
            existingWarehouse.setPhone(warehouse.getPhone());

            this.warehouseRepository.save(existingWarehouse);
            return existingWarehouse;
        }
        return null;
    }

    @Transactional
    public boolean deleteWarehouse(Long id) {
        Warehouse resultFindWarehouse = findWarehouseById(id);
        if (resultFindWarehouse != null) {
            this.warehouseRepository.delete(resultFindWarehouse);
            return true;
        } else {
            return false;
        }
    }
}
