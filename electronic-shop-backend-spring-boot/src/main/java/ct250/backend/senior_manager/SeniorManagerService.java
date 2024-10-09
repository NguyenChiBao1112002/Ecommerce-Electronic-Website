package ct250.backend.senior_manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class SeniorManagerService {

    @Autowired
    private SeniorManagerRepository seniorManagerRepository;

    public ArrayList<SeniorManager> findAll() {
        return (ArrayList<SeniorManager>) seniorManagerRepository.findAll();
    }

    @SuppressWarnings("null")
    public SeniorManager findById(Long id) {
        return seniorManagerRepository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    public void add(SeniorManager manager) {
        this.seniorManagerRepository.save(manager);
    }

    @SuppressWarnings("null")
    public void deleteById(Long id) {
        this.seniorManagerRepository.deleteById(id);
    }
}
