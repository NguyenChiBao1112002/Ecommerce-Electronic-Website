package ct250.backend.notification;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import jakarta.transaction.Transactional;
import java.util.ArrayList;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    public ArrayList<Notification> findAllNotifications() {
        return (ArrayList<Notification>) this.notificationRepository.findAll();
    }

    @SuppressWarnings("null")
    public Notification findNotificationById(Long id) {
        return this.notificationRepository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    @Transactional
    public Notification addNotification(Notification notification) {
        return this.notificationRepository.save(notification);
    }

    @Transactional
    public Notification updateNotification(Long id, Notification notification) {
        Notification existingNotification = findNotificationById(id);
        if (existingNotification != null) {
            // Update fields based on your requirements
            existingNotification.setTitle(notification.getTitle());
            existingNotification.setContent(notification.getContent());
            // existingNotification.setDateTime(notification.getDateTime());
            existingNotification.setStatus(notification.getStatus());
            existingNotification.setCustomer(notification.getCustomer());
            existingNotification.setOrder(notification.getOrder());

            this.notificationRepository.save(existingNotification);
            return existingNotification;
        }
        return null;
    }

    @Transactional
    public boolean deleteNotification(Long id) {
        Notification resultFindNotification = findNotificationById(id);
        if (resultFindNotification != null) {
            this.notificationRepository.delete(resultFindNotification);
            return true;
        } else {
            return false;
        }
    }
}