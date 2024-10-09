package ct250.backend.notification;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/notification")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @GetMapping
    public ResponseEntity<?> getAllNotification() {
        return new ResponseEntity<>(this.notificationService.findAllNotifications(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getNotificationById(@PathVariable Long id) {
        Notification notification = this.notificationService.findNotificationById(id);
        if (notification == null) {
            return new ResponseEntity<>("This notification is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(notification, HttpStatus.FOUND);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteNotificationById(@PathVariable Long id) {
        Notification notification = this.notificationService.findNotificationById(id);
        if (notification == null) {
            return new ResponseEntity<>("This notification is not exist", HttpStatus.NOT_FOUND);
        }

        this.notificationService.deleteNotification(id);
        return new ResponseEntity<>("A notification with id=" + id + " is deleted successfully", HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateNotificationById(@PathVariable Long id,
            @RequestBody Notification notification) {
        if (this.notificationService.updateNotification(id, notification) != null) {
            return new ResponseEntity<>("A notification with id=" + id + " is updated successfully", HttpStatus.OK);
        }
        return new ResponseEntity<>("The notification with id=" + notification.getId() + " fail updated. Try again!",
                HttpStatus.BAD_REQUEST);
    }

    @PostMapping
    public ResponseEntity<?> addNotification(@RequestBody Notification notification) {
        Notification isExistedNotification = this.notificationService.findNotificationById(notification.getId());
        if (isExistedNotification == null) {
            this.notificationService.addNotification(notification);
            return new ResponseEntity<>(notification, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("The notification with id=" + notification.getId() + " existed. Try again!",
                HttpStatus.BAD_REQUEST);
    }
}
