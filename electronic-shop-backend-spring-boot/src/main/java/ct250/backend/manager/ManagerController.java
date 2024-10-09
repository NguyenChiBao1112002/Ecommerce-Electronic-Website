package ct250.backend.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/managers")
public class ManagerController {

    @Autowired
    ManagerService managerService;

    @GetMapping
    public ArrayList<Manager> getAllManagers() {
        return this.managerService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getManagerById(@PathVariable Long id) {
        Manager manager = managerService.findById(id);
        if (manager == null) {
            return new ResponseEntity<>("This manager is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(manager, HttpStatus.FOUND);
    }

    @PostMapping
    public ResponseEntity<?> addManager(@RequestBody Manager manager) {
        // Check if customer exist or not?
        // Manager isExistedManager = managerService.findById(manager.getId());
        // if (isExistedManager == null) {
        // this.managerService.add(manager);
        // return new ResponseEntity<>(manager, HttpStatus.CREATED);
        // }
        // return new ResponseEntity<>("The employee with id=" + manager.getId() + "
        // existed. Try again!", HttpStatus.BAD_REQUEST);
        this.managerService.add(manager);
        return new ResponseEntity<>(manager, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteManagerById(@PathVariable Long id) {
        Manager manager = managerService.findById(id);
        if (manager == null) {
            return new ResponseEntity<>("This manager is not exist", HttpStatus.NOT_FOUND);
        }
        this.managerService.deleteById(id);
        return new ResponseEntity<>("A manager with id=" + id + " is deleted successfully", HttpStatus.OK);
    }
}
