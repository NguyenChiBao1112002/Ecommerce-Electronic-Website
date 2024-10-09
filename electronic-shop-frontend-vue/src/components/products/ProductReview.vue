<script setup lang="ts">
import type { CartService } from '@/services/cart.service';
import { ReviewService } from '@/services/review.service';
import { inject, reactive, ref } from "vue";
import type { Review } from '../profile/account-content/OrderCard.vue';

const props = defineProps({
    productId: Number
});

const { cartService }: { cartService: CartService } = inject('cartService')!;

const isLoading = ref(true);

const reviews = ref<Review[]>([]);

let overallRating = ref<number>(0);
let averageStar = ref<number>(0);
let reviewService = new ReviewService();

setTimeout(async () => {
    reviews.value = (await reviewService.getAllReviewsByProductId(props.productId)).data;

    reviews.value = reviews.value.reverse().reduce((accumulator: Review[], current: Review) => {
        let exists = accumulator.find(item => {
            return item.orderDetail.id === current.orderDetail.id;
        });
        if (!exists) {
            accumulator = accumulator.concat(current);
        }
        return accumulator;
    }, []);

    reviews.value.reverse();

    console.log(reviews.value);
    overallRating.value = reviews.value.length;
    reviews.value.forEach(r => {
        averageStar.value += r.rate;
    })
    averageStar.value = Number((averageStar.value / overallRating.value || 0).toFixed(1));
    isLoading.value = false;
}, 1000);



const reviewFilters = reactive([
    {
        filterType: 'rating',
        options: [
            {
                value: "",
                content: "Đánh giá",
            },
            {
                value: "1",
                content: "1 sao",
            },
            {
                value: "2",
                content: "2 sao",
            },
            {
                value: "3",
                content: "3 sao",
            },
            {
                value: "4",
                content: "4 sao",
            },
            {
                value: "5",
                content: "5 sao",
            },
        ],
    },
    {
        filterType: 'image',
        options: [
            {
                value: "",
                content: "Ảnh",
            },
            {
                value: "true",
                content: "Có ảnh",
            },
            {
                value: "false",
                content: "Không có ảnh",
            },
        ],
    },
    {
        filterType: 'replied',
        options: [
            {
                value: "",
                content: "Phản hồi",
            },
            {
                value: "true",
                content: "Đã phản hồi",
            },
            {
                value: "false",
                content: "Chưa phản hồi",
            },
        ],
    }
]);

</script>

<template>
    <section id="reviews" class="product-single__reviews">
        <div class="reviews__container">
            <div class="reviews">
                <div class="reviews-leftside" v-if="overallRating == 0">
                    <div class="reviews-leftside__rating">
                        <div class="reviews-rating-mb__title">
                            <h5>Chưa có đánh giá</h5>
                        </div>
                    </div>
                </div>
                <div class="reviews-leftside" v-if="overallRating > 0">
                    <div class="reviews-leftside__rating">
                        <div class="reviews-rating-mb__title">
                            <h5>Đánh giá sản phẩm</h5>
                        </div>
                        <div class="reviews-rating-mb__rating">
                            {{ averageStar }}
                        </div>
                        <div class="reviews-rating yellow">
                            <div
                                :class="['reviews-rating__star', Math.round(averageStar * 10) / 10 >= 1 ? 'is-active' : '']">
                            </div>
                            <div
                                :class="['reviews-rating__star', Math.round(averageStar * 10) / 10 >= 2 ? 'is-active' : Math.round(averageStar * 10) / 10 <= 2.5 ? 'is-half' : 'is-blank']">
                            </div>
                            <div
                                :class="['reviews-rating__star', Math.round(averageStar * 10) / 10 >= 3 ? 'is-active' : Math.round(averageStar * 10) / 10 >= 3.5 ? 'is-half' : 'is-blank']">
                            </div>
                            <div
                                :class="['reviews-rating__star', Math.round(averageStar * 10) / 10 >= 4 ? 'is-active' : Math.round(averageStar * 10) / 10 >= 4.5 ? 'is-half' : 'is-blank']">
                            </div>
                            <div
                                :class="['reviews-rating__star', Math.round(averageStar * 10) / 10 > 4 && Math.round(averageStar * 10) / 10 < 5 ? 'is-half' : Math.round(averageStar * 10) / 10 == 5 ? 'is-active' : 'is-blank']">
                            </div>
                        </div>
                        <div class="reviews-rating-mb__count">
                            {{ overallRating }} đánh giá
                        </div>
                    </div>
                </div>
                <div class="reviews-rightside">
                    <div class="reviews__filter">
                        <div v-for="(item, index) in reviewFilters" :key="index" class="reviews__select">
                            <select>
                                <option v-for="option in item.options" :value="option.value">{{ option.content }}
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="reviews-listing">
                        <div class="grid">

                            <div class="grid__column">
                                <div class="reviews-listing__item border-bottom" v-for="(review, index) in reviews">
                                    <div class="reviews-listing__content">
                                        <div class="reviews-author__name">
                                            {{ review.customer?.name }}
                                        </div>
                                        <div class="reviews-rating">
                                            <div :class="['reviews-rating__star', review.rate >= 1 ? 'is-active' : '']">
                                            </div>
                                            <div :class="['reviews-rating__star', review.rate >= 2 ? 'is-active' : '']">
                                            </div>
                                            <div :class="['reviews-rating__star', review.rate >= 3 ? 'is-active' : '']">
                                            </div>
                                            <div :class="['reviews-rating__star', review.rate >= 4 ? 'is-active' : '']">
                                            </div>
                                            <div :class="['reviews-rating__star', review.rate == 5 ? 'is-active' : '']">
                                            </div>

                                        </div>
                                        <div class="reviews-order">
                                            <div class="order-item-variant-label">
                                                {{ review.orderDetail.productDetail.color }} / {{
                                                    review.orderDetail.productDetail.size }}
                                            </div>
                                        </div>
                                        <div class="reviews-listing__description">
                                            <p>
                                                {{ review.content }}
                                            </p>
                                            <div class="reviews-listing-gallery" rel-script="product-gallery-popup">
                                                <a v-for="image in review.imageUrls?.split(',')"
                                                    class="reviews-listing-image" rel-script="product-lightbox-gallery"
                                                    data-index="0" :data-image=image>
                                                    <img :src=image alt="0" />
                                                </a>

                                            </div>

                                            <span class="reviews-listing__date"> {{ review.createDate }}</span>
                                        </div>
                                    </div>
                                </div>
                                <!-- <div class="reviews-listing__item">
                                    <div class="reviews-listing__content">
                                        <div class="reviews-rating">
                                            <div class="reviews-rating__star is-active"></div>
                                            <div class="reviews-rating__star is-active"></div>
                                            <div class="reviews-rating__star is-active"></div>
                                            <div class="reviews-rating__star is-active"></div>
                                            <div class="reviews-rating__star is-half"></div>
                                        </div>
                                        <div class="reviews-author">
                                            <div class="reviews-author__name">
                                                Thanh Hậu Bui
                                            </div>
                                            <div class="reviews-author__description">
                                                Xanh sáng / 29
                                            </div>
                                        </div>
                                        <div class="reviews-listing__description">
                                            <p>
                                                Quần mặc đẹp 👍👍
                                            </p>
                                            <span class="reviews-listing__date">
                                                28.01.2024
                                            </span>
                                        </div>
                                    </div>
                                </div> -->
                            </div>
                        </div>
                        <!-- <div class="reviews-pagination">
                            <a href="" class="reviews-pagination__prev"></a>
                            <span>1/2</span>
                            <a href="" class="reviews-pagination__next"></a>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<style>
.grid {
    display: flex !important;
    -moz-flex-direction: row;
    flex-direction: row;
    flex-wrap: wrap;
    margin-left: -9px;
    margin-right: -9px;
    padding: 0;
    position: relative;
    float: none;
}

select {
    appearance: none;
}

.reviews__container {
    padding-left: 64px;
    padding-right: 64px;
    max-width: 1920px;
    width: 100%;
    margin: 0 auto;
}

.reviews {
    display: flex;
    margin-top: 3rem;
}

.reviews-leftside {
    padding-right: 50px;
    text-align: center;
}

.reviews-leftside__rating {
    padding: 2rem 2.6rem;
    position: sticky;
    top: 150px;
    border-radius: 0.5rem;
    background: #f1f1f1;
}

.reviews-rating-mb__title {
    white-space: nowrap;
    text-align: center;
}

.reviews-rating-mb__title h5 {
    font-size: 1rem;
    text-transform: uppercase;
    font-weight: 500;
    margin-bottom: 0;
}

.reviews-rating-mb__rating {
    font-size: 4rem;
    font-weight: 500;
    line-height: 5rem;
    text-align: center;
}

.reviews-rating {
    display: flex;
    align-items: center;
    margin-left: -3px;
    margin-right: -3px;
}

.reviews-rating.yellow {
    margin-bottom: 0.44rem;
    justify-content: center;
}

.reviews-rating__star {
    display: block;
    width: 20px;
    height: 20px;
    margin: 0 3px 1px;
    background-image: url(https://www.coolmate.me/images/star-new.svg?08a379c24952a980d5430515abb8be4e);
    background-repeat: no-repeat;
    background-position: 50%;
    background-size: contain;
}

.reviews-rating.yellow .reviews-rating__star {
    width: 34px;
    height: 34px;
    background-image: url(https://www.coolmate.me/images/star-yellow.svg?8f4d13b24f276e8a788250b192548210);
}

.reviews-rating__star.is-active,
.reviews-rating__star.is-full {
    background-image: url(https://www.coolmate.me/images/star-yellow.svg?8f4d13b24f276e8a788250b192548210);
}

.reviews-rating.yellow .reviews-rating__star.is-half {
    background-image: url(https://www.coolmate.me/images/star-yellow-half.svg?6214ae25bffef645dd350fa72b739397);
}

.reviews-rating.yellow .reviews-rating__star.is-blank {
    background-image: url("/src/assets/icon/star-line-yellow-icon.png");
}

.reviews-rating-mb__count {
    text-align: center;
    font-size: .875rem;
    font-style: italic;
    font-weight: 400;
    color: #4d4d4d;
}

.reviews__filter {
    display: flex;
    align-items: center;
}

.reviews__select {
    width: 245px;
    padding: 0 4px;
}

.reviews__select select {
    border-radius: 1.5625rem;
    border: 1px solid #d9d9d9;
    background-color: transparent;
    font-weight: 500;
    font-size: 14px;
    line-height: 18px;
    color: #000;
    width: 100%;
    background-image: url(https://www.coolmate.me/images/arrow-down.svg?a19aea680c08573712a5aca33fcaed3c);
    background-size: 10px 10px;
    background-position: 80%;
    background-repeat: no-repeat;
    padding: 0.875rem 1.8rem 0.875rem 0.875rem;
}

.reviews-listing {
    padding-left: 5px;
    padding-right: 5px;
    padding-top: 20px;
    margin-top: 32px;
    border-top: 1px solid #ddd;
}

.reviews-listing .grid__column {
    border-bottom: 1px solid #d9d9d9;
}

.grid__column {
    position: relative;
    box-sizing: border-box;
    min-height: 1px;
    vertical-align: top;
    margin-left: 0 !important;
    margin-right: 0 !important;
    padding: 9px;
    width: 100%;
}

.six-twelfths {
    width: 50%;
}

.reviews-listing__item {
    display: flex;
    padding: 9px 0;
}

.reviews-listing__content {
    flex: 1;
}

.reviews-rating {
    display: flex;
    align-items: center;
    margin-left: -3px;
    margin-right: -3px;
}

.reviews-author {
    font-size: 14px;
    line-height: 18px;
    color: #000;
    margin-top: 5px;
    margin-bottom: 25px;
    line-height: 1.5em;
}

.reviews-author__name {
    font-weight: 500;
}

.reviews-author__description {
    font-weight: 400;
    color: rgba(0, 0, 0, .4);
    font-style: italic;
    font-size: 12px;
}

.reviews-listing__description p {
    margin: 0;
    font-weight: 400;
}

.reviews-listing__feedback {
    padding: 14px 18px;
    border-radius: 16px;
    margin-top: 15px !important;
    line-height: 1.5em;
    border: 1px solid #d9d9d9;
    background-color: #d9d9d9;
    width: 100%;
}

.reviews-listing__date {
    display: block;
    margin-top: 20px;
    opacity: .5;
}

.reviews-pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 20px;
    padding-bottom: 20px;
    font-size: 14px;
    line-height: 18px;
    text-align: center;
    color: #000;
}

.reviews-pagination__next,
.reviews-pagination__prev {
    display: block;
    width: 20px;
    height: 20px;
}

.reviews-pagination__next:before,
.reviews-pagination__prev:before {
    content: "";
    display: block;
    width: 100%;
    height: 100%;
    background-image: url(https://www.coolmate.me/images/arrow-down.svg?a19aea680c08573712a5aca33fcaed3c);
    background-repeat: no-repeat;
    background-size: 10px;
    background-position: 50%;
}

.reviews-pagination__next:before {
    transform: rotate(-90deg);
}

.reviews-pagination__prev:before {
    transform: rotate(90deg);
}

.reviews-listing-gallery {
    display: flex;
    margin-left: -4px;
    margin-right: -4px;
    margin-top: 10px;
}

.reviews-listing-image {
    overflow: hidden;
    border-radius: 8px;
    width: 60px;
    margin: 0 4px;
    position: relative;
}

.reviews-listing-image:before {
    content: "";
    display: block;
    padding-top: 100%;
    height: 0;
    width: 100%;
}

.reviews-listing-image img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    -o-object-fit: cover;
    object-fit: cover;
}

.order-item-variant-label {
    font-weight: 400;
    color: rgba(0, 0, 0, 0.4);
    font-style: italic;
    font-size: 12px;
}
</style>