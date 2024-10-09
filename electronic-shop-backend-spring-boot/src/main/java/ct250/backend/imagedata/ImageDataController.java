package ct250.backend.imagedata;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "http://localhost:8081")
@RestController
@RequestMapping("/imagedata")
public class ImageDataController {

    @Autowired
    private ImageDataService imageDataService;

    @GetMapping
    public ResponseEntity<?> getAllImageData() {
        return new ResponseEntity<>(this.imageDataService.findAllImageDatas(), HttpStatus.OK);

    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getImageDataById(@PathVariable Long id) {
        ImageData imageData = this.imageDataService.findImageDataById(id);
        if (imageData == null) {
            return new ResponseEntity<>("This imageData is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(imageData, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteImageDataById(@PathVariable Long id) {
        ImageData imageData = this.imageDataService.findImageDataById(id);
        if (imageData == null) {
            return new ResponseEntity<>("This imageData is not exist", HttpStatus.NOT_FOUND);
        }

        this.imageDataService.deleteImageData(id);
        return new ResponseEntity<>("An imageData with id=" + id + " is deleted successfully", HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateImageDataById(@PathVariable Long id, @RequestBody ImageData imageData) {
        if (this.imageDataService.updateImageData(id, imageData) != null) {
            return new ResponseEntity<>("An imageData with id=" + id + " is updated successfully", HttpStatus.OK);
        }
        return new ResponseEntity<>("The imageData with id=" + imageData.getId() + " fail updated. Try again!",
                HttpStatus.BAD_REQUEST);
    }

    @PostMapping
    public String addImageData(@RequestBody ImageData imageData) {
        imageData = imageDataService.addImageData(imageData);
        if (imageData == null) {
            return "Call add imageData function \n" + "Add imageData failed";
        }
        return "Call add imageData function \n" + imageData.toString();
    }

}
