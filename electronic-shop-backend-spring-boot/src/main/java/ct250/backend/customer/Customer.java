package ct250.backend.customer;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.stereotype.Component;

import ct250.backend.user.User;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;

@Component
@Entity
// @AllArgsConstructor
// @NoArgsConstructor
@DiscriminatorValue("customer")
@EntityListeners(AuditingEntityListener.class)
public class Customer extends User {
    
}
