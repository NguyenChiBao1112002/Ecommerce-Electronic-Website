package ct250.backend.user;

import com.fasterxml.jackson.annotation.JsonFormat;
import ct250.backend.role.Role;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user")
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "user_type", discriminatorType = DiscriminatorType.STRING)
@EntityListeners(AuditingEntityListener.class)
public class User {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;

        @Column(length = 50, name = "account", unique = true, nullable = false)
        private String account;

        @Column(columnDefinition = "TEXT")
        private String password;

        @Column
        private String name;

        @Column(columnDefinition = "TEXT")
        private String address;

        @Column(columnDefinition = "TEXT")
        private String province;

        @Column(columnDefinition = "TEXT")
        private String district;

        @Column(columnDefinition = "TEXT")
        private String ward;

        @Column(length = 12)
        private String phone;

        @Column(length = 80)
        private String email;

        @Column(columnDefinition = "TEXT")
        private String avatar;

        @Temporal(value = TemporalType.DATE)
        @JsonFormat(pattern = "yyyy-MM-dd")
        private Date dob;

        @Column(name = "created_at")
        @Temporal(value = TemporalType.TIMESTAMP)
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Ho_Chi_Minh")
        @CreatedDate
        private Date createdAt;

        @Column(name = "updated_at")
        @Temporal(value = TemporalType.TIMESTAMP)
        private Date updatedAt;

        @ManyToMany(fetch = FetchType.EAGER)
        @JoinTable(name = "users_roles", joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"), inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "id"))
        private List<Role> roles;

        @Column(columnDefinition = "boolean default false")
        private boolean locked;

        @Transient
        public String getUserType() {
                return this.getClass().getAnnotation(DiscriminatorValue.class).value();
        }
}
