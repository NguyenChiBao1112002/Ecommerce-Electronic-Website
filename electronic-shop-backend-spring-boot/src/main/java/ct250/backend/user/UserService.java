package ct250.backend.user;

import java.util.List;

import org.hibernate.Hibernate;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ModelMapper modelMapper;

    public List<UserDTO> findAll() {
        List<User> users = this.userRepository.findAll();
        return users.stream().map(UserDTO::new).toList();
    }

    @SuppressWarnings("null")
    public UserDTO findById(Long id) {
        User user = userRepository.findById(id).orElse(null);

        if (user != null) {
            Hibernate.initialize(user.getRoles()); // Eagerly fetch roles
            return modelMapper.map(user, UserDTO.class);
        }
        return null;
    }

    public User findByAccount(String account) {
        return this.userRepository.findUserByAccount(account).orElse(null);
    }

    public void add(User user) {
        if (this.findById(user.getId()) == null) {
            this.userRepository.save(user);
        }
    }

    @SuppressWarnings("null")
    public void deleteById(Long id) {
        this.userRepository.deleteById(id);
    }

    @SuppressWarnings("null")
    @Transactional
    public User update(Long id, UserDTO userDTO) {
        User existingUser = userRepository.findById(id).orElse(null);
        if (existingUser != null) {
            existingUser.setLocked(!existingUser.isLocked());
            this.userRepository.save(existingUser);
            return existingUser;
        }
        return null;
    }

    @SuppressWarnings("null")
    public User updateAvatar(Long id, String avatar) {
        User existUser = this.userRepository.findById(id).orElse(null);
        if (existUser != null) {
            existUser.setAvatar(avatar);
            this.userRepository.save(existUser);
            return existUser;
        }
        return null;
    }
}
