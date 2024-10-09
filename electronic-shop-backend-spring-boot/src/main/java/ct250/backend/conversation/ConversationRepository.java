package ct250.backend.conversation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
interface ConversationRepository extends JpaRepository<Conversation, Long> {
    
}
