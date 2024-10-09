package ct250.backend.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;

    public ArrayList<Admin> findAll() {
        return (ArrayList<Admin>) adminRepository.findAll();
    }

    @SuppressWarnings("null")
    public Admin findById(Long id) {
        return adminRepository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    public void add(Admin admin) {
        this.adminRepository.save(admin);
    }

    @SuppressWarnings("null")
    public void deleteById(Long id) {
        this.adminRepository.deleteById(id);
    }
}
