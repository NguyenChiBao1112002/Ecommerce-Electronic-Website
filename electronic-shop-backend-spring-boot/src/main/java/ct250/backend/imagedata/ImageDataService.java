package ct250.backend.imagedata;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
public class ImageDataService {

    @Autowired
    private ImageDataRepository imageDataRepository;

    public ArrayList<ImageData> findAllImageDatas() {
        return (ArrayList<ImageData>) this.imageDataRepository.findAll();
    }

    public ImageData findImageDataById(Long id) {
        return this.imageDataRepository.findById(id).orElse(null);
    }

    @Transactional
    public ImageData addImageData(ImageData data) {
        return this.imageDataRepository.save(data);
    }

    @Transactional
    public ImageData updateImageData(Long id, ImageData data) {
        ImageData existingImageData = findImageDataById(id);
        if (existingImageData != null) {
            // Update fields based on your requirements
            existingImageData.setBase64String(data.getBase64String());
            this.imageDataRepository.save(existingImageData);
            return existingImageData;
        }
        return null;
    }

    @Transactional
    public boolean deleteImageData(Long id) {
        ImageData resultFindImageData = findImageDataById(id);
        if (resultFindImageData != null) {
            this.imageDataRepository.delete(resultFindImageData);
            return true;
        } else {
            return false;
        }
    }
}
