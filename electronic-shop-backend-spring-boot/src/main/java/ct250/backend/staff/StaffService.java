package ct250.backend.staff;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class StaffService {

    @Autowired
    private StaffRepository staffRepository;

    public ArrayList<Staff> findAll() {
        return (ArrayList<Staff>) staffRepository.findAll();
    }

    @SuppressWarnings("null")
    public Staff findById(Long id) {
        return staffRepository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    public void add(Staff manager) {
        this.staffRepository.save(manager);
    }


    @SuppressWarnings("null")
    public void deleteById(Long id) {
        this.staffRepository.deleteById(id);
    }
}
