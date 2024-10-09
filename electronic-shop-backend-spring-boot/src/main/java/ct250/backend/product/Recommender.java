package ct250.backend.product;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.apache.mahout.cf.taste.impl.model.file.FileDataModel;
import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood;
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity;

import org.apache.mahout.cf.taste.model.DataModel;
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood;

import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.recommender.UserBasedRecommender;

import org.apache.mahout.cf.taste.similarity.UserSimilarity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ct250.backend.review.Review;
import ct250.backend.review.ReviewService;

@Service
public class Recommender {
    @Autowired
    ReviewService reviewService;

    public List<RecommendedItem> recommendation(Long customerID) {
        try {
            LocalDate currentDate = LocalDate.now();
            LocalDate yesterday = LocalDate.now().minusDays(1);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String dateString = currentDate.format(formatter);
            String yesterdayString = yesterday.format(formatter);
            ArrayList<Review> reviews = this.reviewService.getAllReviewRecommend();

            String filePath = "C:\\Users\\BaoNguyen\\OneDrive\\Máy tính\\LVTN\\test-" + dateString + ".txt";

            File fileData = new File(filePath);

            if (!fileData.exists()) {
                fileData.createNewFile();
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileData))) {
                    for (Review review : reviews) {
                        writer.write(review.getCustomer().getId() + ","
                                + review.getOrderDetail().getProductDetail().getProduct().getId() + ","
                                + review.getRate());
                        writer.newLine();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }

                // Delete yesterday file data
                File yesterayData = new File(
                        "C:\\Users\\BaoNguyen\\OneDrive\\Máy tính\\LVTN\\test-" + yesterdayString + ".txt");
                yesterayData.delete();
            }

            // Creating data model
            DataModel datamodel = new FileDataModel(fileData); // data

            // Creating UserSimilarity object.
            UserSimilarity usersimilarity = new PearsonCorrelationSimilarity(datamodel);

            // Creating UserNeighbourHHood object.
            UserNeighborhood userneighborhood = new NearestNUserNeighborhood(3, usersimilarity, datamodel);

            // Create UserRecomender
            UserBasedRecommender recommender = new GenericUserBasedRecommender(datamodel, userneighborhood,
                    usersimilarity);

            List<RecommendedItem> recommendations = recommender.recommend(customerID, 5);

            for (RecommendedItem recommendation : recommendations) {
                System.out.println(recommendation);
            }

            return recommendations;

        } catch (Exception e) {
            e.printStackTrace(); // In ra thông tin ngoại lệ để phát hiện và sửa lỗi
            return new ArrayList<>();
        }
    }

}