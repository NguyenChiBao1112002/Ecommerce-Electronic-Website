package ct250.backend.message;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class MessageService {
    
    @Autowired
    private MessageRepository messageRepository;
    
    @SuppressWarnings("null")
    void addMessage(Message message) {
        this.messageRepository.save(message);
    }

    ArrayList<Message> getAllMessages() {
        return (ArrayList<Message>) this.messageRepository.findAll();
    }

    ArrayList<Message> getAllMessagesByConversation(Long id) {
        return (ArrayList<Message>) this.messageRepository.findByConversation_Id(id);
    }

    @SuppressWarnings("null")
    public Message findMessageById(Long id) {
        return  this.messageRepository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    void deleteMessageById(Long id) {
        this.messageRepository.deleteById(id);
    }

}
