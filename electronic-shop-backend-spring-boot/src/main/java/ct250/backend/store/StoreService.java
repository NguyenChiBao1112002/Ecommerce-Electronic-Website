package ct250.backend.store;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

@Service
public class StoreService {

    @Autowired
    private StoreRespository storeRespository;

    public ArrayList<Store> findAllStores() {
        return (ArrayList<Store>) this.storeRespository.findAll();
    }

    @SuppressWarnings("null")
    public Store findStoreById(Long id) {
        return this.storeRespository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    @Transactional
    public Store addStore(Store store) {
        return this.storeRespository.save(store);
    }

    @Transactional
    public Store updateStore(Long id, Store store) {
        Store existingStore = findStoreById(id);
        if (existingStore != null) {
            // Update fields based on your requirements
            // existingShipment.setShipDate(shipment.getShipDate());
            existingStore.setPhone(store.getPhone());
            existingStore.setAddress(store.getAddress());
            existingStore.setName(store.getName());

            this.storeRespository.save(existingStore);
            return existingStore;
        }
        return null;
    }

    @Transactional
    public boolean deleteStore(Long id) {
        Store resultFindStore = findStoreById(id);
        if (resultFindStore != null) {
            this.storeRespository.delete(resultFindStore);
            return true;
        } else {
            return false;
        }
    }
}
