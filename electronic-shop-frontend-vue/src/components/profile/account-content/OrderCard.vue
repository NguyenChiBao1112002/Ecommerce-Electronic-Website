<script setup lang="ts">
import type { OrderDetail } from '@/components/staff/OrderTable.vue';
import type { CartService } from '@/services/cart.service';
import { ReviewService } from '@/services/review.service';
import { defineProps, inject, ref } from 'vue';
import { ORDER_STATUS, ORDER_STATUS_COLOR } from '../../../constant/order-status.constant';
const { cartService }: { cartService: CartService } = inject('cartService')!;

const props = defineProps<{
    order: any
}>();

const VND = new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND',
});

const orderDetails = ref<OrderDetail[]>([]);
const customerRate = ref<string[]>([]);
const customerReview = ref<string[]>([]);
const isReviewedInIndex = ref<boolean[]>([]);
const uploadedImages = ref<{ id: number, url: string }[]>([]);
let changingReviewImages: { id: number, file: File }[] = [];

setTimeout(async () => {
    orderDetails.value = (await cartService.getOrderDetailsByOrderId(props.order.id)).data;
}, 1000);

const getReviewByOrderId = async (orderId) => {
    let res = (await reviewService.getAllReviewByOrderId(orderId));

    customerReview.value = [];
    res.data.forEach((review) => {
        orderDetails.value.forEach((orderDetail, index) => {
            console.log(review, orderDetail, index)
            if (review.orderDetail.id == orderDetail.id) {
                customerRate.value[index] = review.rate;
                customerReview.value[index] = review.content;
                highlightStars(review.rate, index);
                isReviewedInIndex.value[index] = true;

                uploadedImages.value = [];

                review.imageUrls.split(',').forEach((value, idx) => {
                    uploadedImages.value.push({ id: idx, url: value })
                })
            }
        })
    })
}

const getRatingTitle = (rating) => {
    switch (rating) {
        case 1:
            return 'Tệ';
        case 2:
            return 'Tạm';
        case 3:
            return 'Ổn';
        case 4:
            return 'Tốt';
        case 5:
            return 'Xuất sắc';
        default:
            return '';
    }
}

const highlightStars = (rating, idx) => {
    for (let i = 1; i <= rating; i++) {
        const star = document.querySelector(`.reviews-rating-star[value="${i}"].item-${idx}.order-${props.order.id}`);
        star!.classList.add('is-full');
    }
}

const removeHighlight = (idx) => {
    const stars = document.querySelectorAll(`.reviews-rating-star.item-${idx}.order-${props.order.id}`);
    stars.forEach(star => star.classList.remove('is-full'));
}

const rated = (rating, index) => {
    if (isReviewedInIndex.value[index]) return;

    removeHighlight(index);
    highlightStars(rating, index);
    customerRate.value[index] = rating;
    // isReviewedInIndex.value[index] = true;
}

const reviewService = new ReviewService();

export type Review = {
    id: number;
    content: string;
    createDate: Date;
    rate: number;
    customerId: number;
    orderDetail: OrderDetail;
    imageUrls: string
}

const handleFileInputChange = async (event) => {
    const files = event.target.files;
    const newImages: { id: number, url: string }[] = [];

    for (let i = 0; i < files.length; i++) {
        if (uploadedImages.value.length + newImages.length > 4) break;
        const file = files[i];
        const imageUrl = URL.createObjectURL(file);
        newImages.push({ id: i, url: imageUrl });

        changingReviewImages.push({ id: i, file: file });
    }
    console.log(changingReviewImages)
    uploadedImages.value = uploadedImages.value.concat(newImages);
};

const removeImage = (imageId) => {
    uploadedImages.value = uploadedImages.value.filter(image => image.id !== imageId);
    changingReviewImages = changingReviewImages.filter(file => file.id !== imageId);
};


const saveReview = async (orderDetail: OrderDetail, idx: number) => {
    let orderDetailId = orderDetail.id;
    let productId = orderDetail.productDetail.product.id;

    let data = {
        content: customerReview.value[idx],
        rate: customerRate.value[idx],
    }

    const formData = new FormData();
    for (let i = 0; i < changingReviewImages.length; i++) {
        const file = changingReviewImages[i].file;
        formData.append('images', file);
    }


    await reviewService.postReview(productId, orderDetailId, data, formData);

    const button = document.querySelector<HTMLElement>(`.btn-review-save.item-${idx}`);
    if (button) {
        button.style.pointerEvents = 'none';
        button.classList.add('btn-review-save-disable');
    }
    const stars = document.querySelectorAll<HTMLElement>(`.reviews-rating-star.item-${idx}`);
    stars.forEach(star => {
        star.style.pointerEvents = 'none';
    });
    (document.querySelector(`.form-control.item-${idx}`) as HTMLTextAreaElement).readOnly = true;
}

</script>

<template>
    <div class="order">
        <div class="order-header">
            <div>
                <p class="order-title">#{{ order.id }}</p>
                <p class="order-date">{{ order.createDate }}</p>
            </div>
            <div class="order-status-done" :style="{
                'background-color': ORDER_STATUS_COLOR.get(order.status)
            }">
                <span>{{ ORDER_STATUS.get(order.status) }}</span>
            </div>
        </div>
        <div class="order-body">
            <div>
                <div v-for="(orderDetail, idx) in orderDetails" :key="idx" class="order-item">
                    <div class="order-item-thumbnail">
                        <router-link
                            :to="{ name: 'product', params: { id: orderDetail.productDetail.product.id.toString() } }">
                            <img :src="orderDetail.productDetail.imageLinks?.split(', ')[0]
                                .toString().replace('width=80,height=80', 'width=300,height=442')"
                                :alt="orderDetail.productDetail.product.name.toString()" />
                        </router-link>

                    </div>
                    <div class="order-item-info">
                        <router-link
                            :to="{ name: 'product', params: { id: orderDetail.productDetail.product.id.toString() } }"
                            class="order-item-title">
                            {{ orderDetail.productDetail.product.name }}
                        </router-link>

                        <div class="order-item-variant-label">{{ orderDetail.productDetail.color }} / {{
                            orderDetail.productDetail.size }}</div>
                        <div class="order-item-quantity">x {{ orderDetail.quantity }}</div>
                        <div class="order-item-price"> {{ VND.format(orderDetail.total) }}</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="order-footer">
            <div class="order-footer-left">
                <button v-show="props.order.status === 'DELIVERED'" type="button" class="btn btn--outline"
                    data-bs-toggle="modal" :data-bs-target="`#order-${props.order.id}`"
                    @click="getReviewByOrderId(props.order.id)">
                    Đánh giá
                </button>
            </div>
            <div class="order-footer-right">
                <div><b> {{ VND.format(order.total) }}</b></div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" :id="`order-${props.order.id}`" tabindex="-1" aria-labelledby="exampleModalLabel"
            data-bs-backdrop="false" data-bs-focus="true" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="modal-title h4" id="exampleModalLabel">Đánh giá đơn hàng

                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div v-for="(orderDetailReview, index) in orderDetails" :key="index" class="order-item">
                            <div class="order-item-thumbnail">
                                <router-link
                                    :to="{ name: 'product', params: { id: orderDetailReview.productDetail.product.id.toString() } }">
                                    <img :src="orderDetailReview.productDetail.imageLinks?.split(', ')[0]
                                        .toString().replace('width=80,height=80', 'width=300,height=442')"
                                        :alt="orderDetailReview.productDetail.product.name.toString()"
                                        style="height: 150px; width: 100px;" />
                                </router-link>

                            </div>
                            <div class="order-item-info">
                                <router-link
                                    :to="{ name: 'product', params: { id: orderDetailReview.productDetail.product.id.toString() } }"
                                    class="order-item-title">
                                    {{ orderDetailReview.productDetail.product.name }}
                                </router-link>

                                <div class="order-item-variant-label">{{ orderDetailReview.productDetail.color }} /
                                    {{ orderDetailReview.productDetail.size }}</div>
                                <div class="order-item-price"> {{ VND.format(orderDetailReview.total) }}</div>
                                <div class="reviews-rating">
                                    <div :class="[
                                        'reviews-rating-star', `item-${index}`, `order-${props.order.id}`
                                    ]" v-for="rating in 5" :key="rating" :value="rating" type="button"
                                        data-bs-toggle="tooltip" data-bs-placement="top" :title="getRatingTitle(rating)"
                                        @click="rated(rating, index)">
                                    </div>
                                    <span>&nbsp; {{ getRatingTitle(customerRate[index]) }}</span>
                                </div>
                                <div class="grid">
                                    <div class="upload__box">
                                        <div class="upload__btn-box">
                                            <label v-if="!isReviewedInIndex[index]" class="upload__btn">
                                                Upload images
                                                <input type="file" multiple data-max_length="5"
                                                    class="upload__inputfile" @change="handleFileInputChange">
                                            </label>
                                        </div>
                                        <div class="upload__img-wrap">
                                            <div v-for="image in uploadedImages" :key="image.id"
                                                class="upload__img-box">
                                                <div class="img-bg"
                                                    :style="{ backgroundImage: 'url(' + image.url + ')' }">
                                                    <div v-if="!isReviewedInIndex[index]" class="upload__img-close"
                                                        @click="removeImage(image.id)"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="grid-column d-flex align-items-end flex-column">
                                        <textarea placeholder="Viết đánh giá..." :class="[
                                            'form-control', `item-${index}`,
                                        ]" style="
                                            overflow-y: hidden;
                                            resize: vertical;
                                            min-height: 40px; 
                                            height: auto;" v-model="customerReview[index]"
                                            :readonly="isReviewedInIndex[index]">
                                        </textarea>
                                        <div v-if="!isReviewedInIndex[index]" class="cursor-pointer" :class="[
                                            'btn-review-save', `item-${index}`,
                                            isReviewedInIndex[index] ? 'btn-review-save-disable' : ''
                                        ]" @click="saveReview(orderDetailReview, index)">Lưu đánh giá
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">Trở lại</button>
                        <!-- <button type="button" class="btn btn-primary btn-save">Lưu</button> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style>
.order {
    position: relative;
    display: block;
}

.order-header {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    background-color: #2f5acf;
    border-radius: 0.5rem;
    padding: 10px 30px;
    position: relative;
    z-index: 2;
    box-sizing: border-box;
}

.order-header .order-title {
    font-weight: bold;
    font-size: 1.1rem;
}

.order-title,
.order-date {
    margin: 0px;
}

.order-header .order-date {
    font-size: 0.8rem;
}

.order-status-wait {
    display: flex;
    padding: 6px 12px;
    justify-content: center;
    align-items: center;
    background-color: #f2fd5d;
    border-radius: 47px;
    color: #000;
}

.order-status-done {
    display: flex;
    padding: 6px 12px;
    justify-content: center;
    align-items: center;
    background-color: #57e37f;
    border-radius: 47px;
    color: #000;
}

.order-body {
    border: 1px solid #d9d9d9;
    background-color: rgb(232, 232, 232);
    margin-top: -16px;
    position: relative;
    z-index: 1;
    padding-top: 16px;
}

.order-item:not(:last-child) {
    border-bottom: 1px solid #d9d9d9;
}

.order-item {
    padding: 1rem 30px;
    display: flex;
    width: 100%;
    position: relative;
}

.order-item-thumbnail {
    position: relative;
    width: 100px;
    margin-right: 1rem;
}

.order-item-thumbnail::before {
    content: "";
    display: block;
    padding-top: 111.7647058824%;
    height: 0;
    width: 100%;
}

.order-item-thumbnail img {
    border-radius: 8px;
}

.order-item-thumbnail img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    -o-object-fit: cover;
    object-fit: cover;
}

.order-item-info {
    flex: 1;
}

.order-item-title,
.order-item-price {
    font-weight: 600;
}

.order-item-variant-label,
.order-item-quantity {
    color: rgba(0, 0, 0, 0.6);
}

.order-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    border: 1px solid #d9d9d9;
    background-color: rgba(0, 0, 0, 0.1);
    padding: 0.5rem 30px 0.5rem;
    border-radius: 0 0 0.5rem 0.5rem;
    position: relative;
    z-index: 1;
    box-sizing: border-box;
}

.order-footer-left {
    display: flex;
}

.btn {
    height: auto;
    padding: 0.5rem 2rem;
    border-radius: 100vmax;
    line-height: 1.5;
    box-sizing: border-box;
    font-family: "CriteriaCF", "Pangea", sans-serif;
    margin-right: 10px;
    border: 2px solid #000;
    cursor: pointer;
}

.btn--outline {
    background-color: transparent;
    color: #000;
}

.btn--outline:hover {
    background-color: #000;
    color: #fff;
    border: 2px solid #000;
}

.order-footer-right {
    text-align: right;
}

.modal {
    --bs-modal-width: 700px;
    --bs-modal-zindex: 1071;
}

.modal-body {
    padding: 0px !important;
}

.modal-dialog-scrollable .modal-content {
    max-height: 500px;
    overflow: hidden;
}

.grid {
    display: flex;
    display: -webkit-flex;
    -moz-flex-direction: row;
    flex-direction: row;
    flex-wrap: wrap;
    margin-left: -9px;
    margin-right: -9px;
    padding: 0;
    position: relative;
    float: none;
}


.grid-column {
    position: relative;
    box-sizing: border-box;
    min-height: 1px;
    vertical-align: top;
    margin-left: 0 !important;
    margin-right: 0 !important;
    padding: 9px;
    width: 100%;
}


.form-control:focus,
.form-control:active .vs-dropdown-toggle:focus,
.vs-dropdown-toggle:active {
    border-color: inherit !important;
    -webkit-box-shadow: none !important;
    box-shadow: none !important;
    outline: none !important;
    border: 1px solid #2f5acf !important;
}


.form-control {
    background: #fff;
    border: 1px solid #d9d9d9;
    box-sizing: border-box;
    border-radius: 16px;
    min-height: 40px;
    width: 100%;
    padding: 5px 20px;
    transition: all 0.1s;
}

.btn-save {
    background-color: #2f5acf;
    color: #fff;
    border: 2px solid #2f5acf;
}

.btn-save:hover,
.btn-save:active {
    background-color: #1c3a8e;
    color: #fff;
    border: 2px solid #1c3a8e;
}

.btn-cancel:hover {
    background-color: #dddde6;
    color: #000;
    border: 2px solid #232325;
}

.btn-review-save {
    border-radius: 4px;
    background-color: #3060e2;
    color: whitesmoke;
    width: fit-content;
    padding: 5px 10px;
    margin-top: 10px
}

.btn-review-save-disable {
    border-radius: 4px;
    background-color: #b3c1e6;
    color: whitesmoke;
    width: fit-content;
    padding: 5px 10px;
    margin-top: 10px;
    pointer-events: none
}


.reviews-rating {
    display: flex;
    align-items: center;
    height: 1.5rem;

}

.reviews-rating-star.is-active,
.reviews-rating-star.is-full {
    background-image: url(https://www.coolmate.me/images/star.svg?2a5188496861d26e5547c524320ec875);
    display: block;
    width: 20px;
    height: 20px;
    margin: 0 1px 1px;
    background-repeat: no-repeat;
    background-position: 50%;
    background-size: contain;
}

.reviews-rating-star {
    display: block;
    width: 20px;
    height: 20px;
    margin: 0 1px 1px;
    background-image: url(https://www.coolmate.me/images/star-new.svg?08a379c24952a980d5430515abb8be4e);
    background-repeat: no-repeat;
    background-position: 50%;
    background-size: contain;
}

.reviews-rating-star.is-half {
    background-image: url(https://www.coolmate.me/images/star-half.svg?8aea9e9938db110e66ea06732737184a);
}


.upload__box {
    padding: 9px;
}

.upload__inputfile {
    width: .1px;
    height: .1px;
    opacity: 0;
    overflow: hidden;
    position: absolute;
    z-index: -1;
}

.upload__btn {
    display: inline-block;
    font-weight: 400;
    color: #fff;
    text-align: center;
    min-width: 30px;
    padding: 5px;
    transition: all .3s ease;
    cursor: pointer;
    border: 2px solid;
    background-color: #4045ba;
    border-color: #4045ba;
    border-radius: 10px;
    line-height: 18px;
    font-size: 13px;

}

.upload__btn:hover {
    background-color: unset;
    color: #4045ba;
    transition: all .3s ease;
}

.upload__btn-box {
    margin-bottom: 10px;
}

.upload__img-wrap {
    display: flex;
    flex-wrap: wrap;
    margin: 0 -10px;
}

.upload__img-box {
    width: 100px;
    padding: 0 10px;
    margin-bottom: 12px;
}

.upload__img-close {
    width: 15px;
    height: 15px;
    border-radius: 50%;
    background-color: rgba(0, 0, 0, 0.5);
    position: absolute;
    top: 5px;
    right: 5px;
    text-align: center;
    line-height: 10px;
    z-index: 1;
    cursor: pointer;
}

.upload__img-close:after {
    content: '\2716';
    font-size: 10px;
    color: white;
}

.img-bg {
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    position: relative;
    padding-bottom: 100%;
}
</style>