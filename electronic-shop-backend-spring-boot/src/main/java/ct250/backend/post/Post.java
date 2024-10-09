package ct250.backend.post;

import java.util.Date;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Component
@Entity
@Data
@Table(name = "post")
@AllArgsConstructor
@NoArgsConstructor
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "title")
    private String title;

    @Column(name = "type")
    private String type;

    @Column(name = "author")
    private String author;

    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    @Column(name = "imagesURL")
    private String imagesURL;

    @Column(name = "public_at", columnDefinition = "TIMESTAMP")
    @JsonFormat(timezone = "Asia/Ho_Chi_Minh")
    @Temporal(TemporalType.TIMESTAMP)
    private Date publicAt;

    // @ManyToOne
    // @JoinColumn(name = "admin_id")
    // private Manager admin;

    public Post(Post post) {
        this.id = post.getId();
        this.title = post.getTitle();
        this.type = post.getType();
        this.author = post.getAuthor();
        this.content = post.getContent();
        this.imagesURL = post.getImagesURL();
        this.publicAt = post.getPublicAt();
        // this.admin = post.getAdmin();
    }

}
