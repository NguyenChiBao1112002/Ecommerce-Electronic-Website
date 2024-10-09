package ct250.backend.conversation;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ConversationService {
    
    @Autowired
    private ConversationRepository conversationRepository;
    
    @SuppressWarnings("null")
    void addConversation(Conversation conversation) {
        this.conversationRepository.save(conversation);
    }

    ArrayList<Conversation> getAllConversations() {
        return (ArrayList<Conversation>) this.conversationRepository.findAll();
    }

    @SuppressWarnings("null")
    public Conversation findConversationById(Long id) {
        return  this.conversationRepository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    void deleteConversationById(Long id) {
        this.conversationRepository.deleteById(id);
    }

}
