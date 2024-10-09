package ct250.backend.staff;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/staffs")
public class StaffController {

    @Autowired
    StaffService staffService;

    @GetMapping
    public ArrayList<Staff> getAllStaffs() {
        return this.staffService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getStaffById(@PathVariable Long id) {
        Staff staff = staffService.findById(id);
        if (staff == null) {
            return new ResponseEntity<>("This staff is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(staff, HttpStatus.FOUND);
    }

    @PostMapping
    public ResponseEntity<?> addStaff(@RequestBody Staff staff) {
        // Check if customer exist or not?
        // Staff isExistedStaff = staffService.findById(staff.getId());
        // if (isExistedStaff == null) {
        // this.staffService.add(staff);
        // return new ResponseEntity<>(staff, HttpStatus.CREATED);
        // }
        // return new ResponseEntity<>("The staff with id=" + staff.getId() + " existed.
        // Try again!", HttpStatus.BAD_REQUEST);
        this.staffService.add(staff);
        return new ResponseEntity<>(staff, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteStaffById(@PathVariable Long id) {
        Staff staff = staffService.findById(id);
        if (staff == null) {
            return new ResponseEntity<>("This staff is not exist", HttpStatus.NOT_FOUND);
        }
        this.staffService.deleteById(id);
        return new ResponseEntity<>("A staff with id=" + id + " is deleted successfully", HttpStatus.OK);
    }

}
