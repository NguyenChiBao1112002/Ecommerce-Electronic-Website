package ct250.backend.warehouse;

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
@RequestMapping("/warehouse")
public class WarehouseController {

    @Autowired
    private WarehouseService warehouseService;

    @GetMapping
    public ResponseEntity<?> getAllWarehouse() {
        return new ResponseEntity<>(this.warehouseService.findAllWarehouses(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getWarehouseById(@PathVariable Long id) {
        Warehouse warehouse = this.warehouseService.findWarehouseById(id);
        if (warehouse == null) {
            return new ResponseEntity<>("This warehouse is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(warehouse, HttpStatus.FOUND);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteWarehouseById(@PathVariable Long id) {
        Warehouse warehouse = this.warehouseService.findWarehouseById(id);
        if (warehouse == null) {
            return new ResponseEntity<>("This warehouse is not exist", HttpStatus.NOT_FOUND);
        }

        this.warehouseService.deleteWarehouse(id);
        return new ResponseEntity<>("A warehouse with id=" + id + " is deleted successfully", HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateWarehouseById(@PathVariable Long id, @RequestBody Warehouse warehouse) {
        if (this.warehouseService.updateWarehouse(id, warehouse) != null) {
            return new ResponseEntity<>("A warehouse with id=" + id + " is updated successfully", HttpStatus.OK);
        }
        return new ResponseEntity<>("The warehouse with id=" + warehouse.getId() + " fail updated. Try again!",
                HttpStatus.BAD_REQUEST);
    }

    @PostMapping
    public ResponseEntity<?> addWarehouse(@RequestBody Warehouse warehouse) {
        Warehouse isExistedWarehouse = this.warehouseService.findWarehouseById(warehouse.getId());
        if (isExistedWarehouse == null) {
            this.warehouseService.addWarehouse(warehouse);
            return new ResponseEntity<>(warehouse, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("The warehouse with id=" + warehouse.getId() + " existed. Try again!",
                HttpStatus.BAD_REQUEST);
    }

}
