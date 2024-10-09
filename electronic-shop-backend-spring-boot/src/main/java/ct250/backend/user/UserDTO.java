package ct250.backend.user;

import ct250.backend.role.RoleDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class UserDTO {
    private Long id;
    private String account;
    private String password;
    private String name;
    private String phone;
    private String email;
    private String userType;
    private String address;
    private Date dob;
    private Boolean locked;
    private List<RoleDTO> roles;

    public UserDTO(User user) {
        this.id = user.getId();
        this.account = user.getAccount();
        this.password = user.getPassword();
        this.name = user.getName();
        this.phone = user.getPhone();
        this.email = user.getEmail();
        this.userType = user.getUserType();
        this.dob = user.getDob();
        this.address = user.getAddress();
        this.locked = user.isLocked();
        this.roles = user.getRoles().stream().map(RoleDTO::new).collect(Collectors.toList());
    }
}
