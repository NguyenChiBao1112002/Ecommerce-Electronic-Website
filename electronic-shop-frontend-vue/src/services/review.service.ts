import type { Review } from '@/components/profile/account-content/OrderCard.vue';
import axios from 'axios';

export class ReviewService {
   
    constructor() {
    }

    public async postReview(productId, orderDetailId, postData, formData : any) {
        const baseUri = this.getBaseUri();
        const review = await axios.post(`${baseUri}/products/${productId}/reviews/order-details/${orderDetailId}`, postData);
        
        if (formData) {
            return await this.updateImages(productId, review.data.id, formData)
        }
        else return review;
    }

    public async updateImages(productId, reviewId, imageFiles) {
        const baseUri = this.getBaseUri();
        return await axios.put(`${baseUri}/products/${productId}/reviews/${reviewId}/upload`, imageFiles, 
        {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        });
    }

    public async getReviewByOrderDetailId(orderDetailId) {
        const baseUri = this.getBaseUri();
        return (await axios.get(`${baseUri}/products/0/reviews/order-details/${orderDetailId}`));
    }

    public async getAllReviewByCustomerId(customerId) {
        const baseUri = this.getBaseUri();
        return await axios.get(`${baseUri}/products/0/reviews/customer/${customerId}`);
    }

    public async getAllReviewByOrderId(orderId) {
        const baseUri = this.getBaseUri();
        return await axios.get(`${baseUri}/products/0/reviews/orders/${orderId}`);
    }

    public async getAllReviewByOrderDetailId(orderDetailId) {
        const baseUri = this.getBaseUri();
        return await axios.get(`${baseUri}/products/0/reviews/order-details/${orderDetailId}`);
    }

    public async getAllReviews() {
        const baseUri = this.getBaseUri();
        return await axios.get<Review[]>(`${baseUri}/products/0/reviews?all=true`);
    }

    public async getAllReviewsByProductId(productId) {
        const baseUri = this.getBaseUri();
        return await axios.get<Review[]>(`${baseUri}/products/${productId}/reviews?all=false`);
    }

    getBaseUri() {
        return import.meta.env.VITE_BACKEND_BASE_URL;
    }

}

const reviewService = new ReviewService();
export const provideReviewService = () => {
    return {
        reviewService,
    };
};