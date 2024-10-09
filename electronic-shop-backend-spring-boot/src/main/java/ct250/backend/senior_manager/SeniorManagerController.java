package ct250.backend.senior_manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/senior-managers")
public class SeniorManagerController {

    @Autowired
    SeniorManagerService seniorManagerService;

    @GetMapping
    public ArrayList<SeniorManager> getAllSeniorManagers() {
        return this.seniorManagerService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getSeniorManagerById(@PathVariable Long id) {
        SeniorManager seniorManager = seniorManagerService.findById(id);
        if (seniorManager == null) {
            return new ResponseEntity<>("This senior manager is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(seniorManager, HttpStatus.FOUND);
    }

    @PostMapping
    public ResponseEntity<?> addSeniorManager(@RequestBody SeniorManager seniorManager) {
        this.seniorManagerService.add(seniorManager);
        return new ResponseEntity<>(seniorManager, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteSeniorManagerById(@PathVariable Long id) {
        SeniorManager seniorManager = seniorManagerService.findById(id);
        if (seniorManager == null) {
            return new ResponseEntity<>("This senior manager is not exist", HttpStatus.NOT_FOUND);
        }
        this.seniorManagerService.deleteById(id);
        return new ResponseEntity<>("A senior manager with id=" + id + " is deleted successfully", HttpStatus.OK);
    }
}
