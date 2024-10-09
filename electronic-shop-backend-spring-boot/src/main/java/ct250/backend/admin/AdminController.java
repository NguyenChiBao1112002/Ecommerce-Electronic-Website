package ct250.backend.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/admins")
public class AdminController {

    @Autowired
    AdminService adminService;

    @GetMapping
    public ArrayList<Admin> getAllAdmins() {
        return this.adminService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getAdminById(@PathVariable Long id) {
        Admin admin = adminService.findById(id);
        if (admin == null) {
            return new ResponseEntity<>("This admin is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(admin, HttpStatus.FOUND);
    }

    @PostMapping
    public ResponseEntity<?> addAdmin(@RequestBody Admin admin) {
        this.adminService.add(admin);
        return new ResponseEntity<>(admin, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteAdminById(@PathVariable Long id) {
        Admin admin = adminService.findById(id);
        if (admin == null) {
            return new ResponseEntity<>("This admin is not exist", HttpStatus.NOT_FOUND);
        }
        this.adminService.deleteById(id);
        return new ResponseEntity<>("A admin with id=" + id + " is deleted successfully", HttpStatus.OK);
    }
}
