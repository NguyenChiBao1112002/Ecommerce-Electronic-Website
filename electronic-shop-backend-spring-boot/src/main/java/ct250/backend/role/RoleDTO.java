package ct250.backend.role;

import ct250.backend.privilege.PrivilegeDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RoleDTO {
    private Long id;
    private String name;
    private List<PrivilegeDTO> privileges;

    public RoleDTO(Role role) {
        this.id = role.getId();
        this.name = role.getName();
        this.privileges = role.getPrivileges().stream().map(PrivilegeDTO::new).collect(Collectors.toList());
    }
}