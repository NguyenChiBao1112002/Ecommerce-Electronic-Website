package ct250.backend.privilege;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PrivilegeDTO {
    private Long id;
    private String name;

    public PrivilegeDTO(Privilege privilege) {
        this.id = privilege.getId();
        this.name = privilege.getName();
    }
}
