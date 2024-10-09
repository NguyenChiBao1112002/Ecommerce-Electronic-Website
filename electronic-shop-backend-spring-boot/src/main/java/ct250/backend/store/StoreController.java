package ct250.backend.store;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/store")
public class StoreController {

    @Autowired
    private StoreService storeService;

    @GetMapping
    public ResponseEntity<?> getAllStore() {
        return new ResponseEntity<>(this.storeService.findAllStores(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getStoreById(@PathVariable Long id) {
        Store store = this.storeService.findStoreById(id);
        if (store == null) {
            return new ResponseEntity<>("This store is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(store, HttpStatus.FOUND);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteStoreById(@PathVariable Long id) {
        Store store = this.storeService.findStoreById(id);
        if (store == null) {
            return new ResponseEntity<>("This store is not exist", HttpStatus.NOT_FOUND);
        }

        this.storeService.deleteStore(id);
        return new ResponseEntity<>("A store with id=" + id + " is deleted successfully", HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateStoreById(@PathVariable Long id, @RequestBody Store store) {
        if (this.storeService.updateStore(id, store) != null) {
            return new ResponseEntity<>("A store with id=" + id + " is updated successfully", HttpStatus.OK);
        }
        return new ResponseEntity<>("The store with id=" + store.getId() + " fail updated. Try again!",
                HttpStatus.BAD_REQUEST);
    }

    @PostMapping
    public ResponseEntity<?> addStore(@RequestBody Store store) {
        Store isExistedStore = this.storeService.findStoreById(store.getId());
        if (isExistedStore == null) {
            this.storeService.addStore(store);
            return new ResponseEntity<>(store, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("The store with id=" + store.getId() + " existed. Try again!",
                HttpStatus.BAD_REQUEST);
    }
}
