package ct250.backend.role;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/roles")
public class RoleController {

    @Autowired
    RoleService roleService;

    @GetMapping
    public List<RoleDTO> getAllRoles() {
        return this.roleService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getRoleById(@PathVariable Long id) {
        RoleDTO roleDTO = roleService.findById(id);
        if (roleDTO == null) {
            return new ResponseEntity<>("This role is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(roleDTO, HttpStatus.FOUND);
    }

    @PostMapping
    public ResponseEntity<?> addRole(@RequestBody Role role) {
        Role isExistedRole = this.roleService.findByName(role.getName());
        if (isExistedRole == null) {
            this.roleService.add(role);
            return new ResponseEntity<>(role, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("The role with id=" + role.getId() + " existed. Try again!", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteRoleById(@PathVariable Long id) {
        RoleDTO roleDTO = this.roleService.findById(id);
        if (roleDTO == null) {
            return new ResponseEntity<>("This role is not exist", HttpStatus.NOT_FOUND);
        }
        this.roleService.deleteById(id);
        return new ResponseEntity<>("A role with id=" + id + " is deleted successfully", HttpStatus.OK);
    }
}
