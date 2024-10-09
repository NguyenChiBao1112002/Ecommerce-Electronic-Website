package ct250.backend.privilege;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/privileges")
public class PrivilegeController {

    @Autowired
    PrivilegeService privilegeService;

    @GetMapping
    public List<PrivilegeDTO> getAllPrivileges() {
        return this.privilegeService.findAll();
    }

    @GetMapping("/{id}")
//    public ResponseEntity<?> getPrivilegeById(@PathVariable Long id) {
//        Privilege privilege = this.privilegeService.findById(id);
//        if (privilege == null) {
//            return new ResponseEntity<>("This privilege is not exist", HttpStatus.NOT_FOUND);
//        }
//        return new ResponseEntity<>(privilege, HttpStatus.FOUND);
//    }

    public ResponseEntity<?> getPrivilegeById(@PathVariable Long id) {
        PrivilegeDTO privilegeDTO = privilegeService.findById(id);
        if (privilegeDTO == null) {
            return new ResponseEntity<>("This privilege is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(privilegeDTO, HttpStatus.FOUND);
    }

    @PostMapping
    public ResponseEntity<?> addPrivilege(@RequestBody Privilege privilege) {
        Privilege isExistedPrivilege = this.privilegeService.findByName(privilege.getName());
        if (isExistedPrivilege == null) {
            this.privilegeService.add(privilege);
            return new ResponseEntity<>(privilege, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("The privilege with id=" + privilege.getId() + " existed. Try again!", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deletePrivilegeById(@PathVariable Long id) {
        PrivilegeDTO privilegeDTO = this.privilegeService.findById(id);
        if (privilegeDTO == null) {
            return new ResponseEntity<>("This privilege is not exist", HttpStatus.NOT_FOUND);
        }
        this.privilegeService.deleteById(id);
        return new ResponseEntity<>("A privilege with id=" + id + " is deleted successfully", HttpStatus.OK);
    }
}
