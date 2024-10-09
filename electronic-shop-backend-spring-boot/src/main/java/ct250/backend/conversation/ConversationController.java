package ct250.backend.conversation;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/conversations")
public class ConversationController {
    
    @Autowired
    ConversationService conversationService;

    @GetMapping
    public ArrayList<Conversation> getAllConversations() {
        return this.conversationService.getAllConversations();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getConversationById(@PathVariable Long id) {
        Conversation Conversation = this.conversationService.findConversationById(id);
        if (Conversation == null) {
            return new ResponseEntity<>("This Conversation is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(Conversation, HttpStatus.OK);
    }
    
    @PostMapping
    public ResponseEntity<Conversation> addConversation(@RequestBody Conversation Conversation) {
        this.conversationService.addConversation(Conversation);
        return new ResponseEntity<>(Conversation, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteConversationById(@PathVariable Long id) {
        Conversation Conversation = this.conversationService.findConversationById(id);
        if (Conversation == null) {
            return new ResponseEntity<>("Can not find Conversation to delete", HttpStatus.NOT_FOUND);
        }
        
        this.conversationService.deleteConversationById(id);
        return new ResponseEntity<>("Deleted successfully", HttpStatus.OK);
    }
    
}
