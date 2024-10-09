<template>
    <div class="flex flex-col mb-3">
        <div class="overflow-auto sm:-mx-6 lg:-mx-8">
            <div class="inline-block min-w-full py-2 sm:px-6 lg:px-8 mb-2">
                <div class="border-b-2 mt-1 border-neutral-200 dark:border-white/10"></div>
                <div class="custom-scrollbar mt-1 relative overflow-x-auto mb-2 shadow-md" style="max-height: 580px;">
                    <table id="table-data" class="w-full text-sm text-left rtl:text-right">
                        <thead
                            class="fixed-header text-center text-gray-700 dark:bg-gray-700 dark:text-gray-400 border-neutral-200 dark:border-white/10">
                            <tr class="bg-gray-300">
                                <th scope="col" class="px-6 py-3">
                                    ID
                                </th>
                                <th scope="col" class="px-3 py-3">
                                    Ngày đánh giá
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Mã đơn hàng
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Chi tiết (Mã chi tiết sp/ Số lượng)
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Nội dung đánh giá
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Mức độ hài lòng
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Nhân viên xử lý
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Phản hồi
                                </th>
                            </tr>
                        </thead>
                        <tbody class="text-center">
                            <!-- <tr v-for="(order, index) in orders" :key="index" @click="selectOder(order)"
                                class="row-data hover:bg-gray-200 border-b mt-2 border-neutral-200 dark:border-white/10"> -->
                            <tr v-for="(review, index) in reviews" :key="index"
                                class="row-data hover:bg-gray-200 border-b mt-2 border-neutral-200 dark:border-white/10">
                                <td v-if="!review.staff" class="px-6 py-4">{{ review.id }}</td>
                                <td v-if="!review.staff" class="px-6 py-4">{{ review.createDate }}</td>
                                <td v-if="!review.staff" class="px-6 py-4">{{ review.orderDetail.order?.id }}</td>
                                <td v-if="!review.staff" class="px-6 py-4">
                                    Mã chi tiết sp: {{ review.orderDetail.productDetail.id }}
                                    Số lượng: {{ review.orderDetail.quantity }}
                                </td>
                                <td v-if="!review.staff" class="px-6 py-4">{{ review.content || '' }}</td>
                                <td v-if="!review.staff" class="px-6 py-4">{{ review.rate || '' }}</td>
                                <td v-if="!review.staff" class="px-6 py-4">{{ "Chưa cập nhật" }}</td>
                                <td v-if="!review.staff" type="button" data-bs-toggle="modal"
                                    class="px-6 py-4 text-instruction" :data-bs-target="`#review-${review.id}`"
                                    @click="getAllReviewByOrderDetailId(review.orderDetail.id)">Phản hồi
                                </td>
                                <!-- <button type="button" class="btn btn--outline" data-bs-toggle="modal"
                                    :data-bs-target="`#review-${review.id}`" @click="getReviewById(review.id)">
                                </button> -->
                                <!-- Modal -->
                                <div class="modal fade" style="text-align: left !important" :id="`review-${review.id}`"
                                    tabindex="-1" aria-labelledby="exampleModalLabel" data-bs-backdrop="false"
                                    data-bs-focus="true" aria-hidden="false">
                                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <div class="modal-title h4" id="exampleModalLabel">Đánh giá đơn hàng
                                                </div>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="order-item">
                                                    <div class="order-item-thumbnail">
                                                        <router-link
                                                            :to="{ name: 'product', params: { id: review.orderDetail.productDetail.product.id.toString() } }">
                                                            <img :src="review.orderDetail.productDetail.imageLinks?.split(', ')[0]
                                                                .toString().replace('width=80,height=80', 'width=300,height=442')"
                                                                :alt="review.orderDetail.productDetail.product.name.toString()"
                                                                style="height: 150px; width: 100px;" />
                                                        </router-link>

                                                    </div>
                                                    <div class="order-item-info">
                                                        <router-link
                                                            :to="{ name: 'product', params: { id: review.orderDetail.productDetail.product.id.toString() } }"
                                                            class="order-item-title">
                                                            {{ review.orderDetail.productDetail.product.name }}
                                                        </router-link>

                                                        <div class="order-item-variant-label">{{
                                                            review.orderDetail.productDetail.color }} /
                                                            {{ review.orderDetail.productDetail.size }}</div>
                                                        <!-- <div class="order-item-price"> {{ VND.format(review.orderDetail.total) }}</div> -->
                                                        <div class="reviews-rating">
                                                            <div
                                                                :class="['reviews-rating-star', review.rate >= 1 ? 'is-active' : '']">
                                                            </div>
                                                            <div
                                                                :class="['reviews-rating-star', review.rate >= 2 ? 'is-active' : '']">
                                                            </div>
                                                            <div
                                                                :class="['reviews-rating-star', review.rate >= 3 ? 'is-active' : '']">
                                                            </div>
                                                            <div
                                                                :class="['reviews-rating-star', review.rate >= 4 ? 'is-active' : '']">
                                                            </div>
                                                            <div
                                                                :class="['reviews-rating-star', review.rate == 5 ? 'is-active' : '']">
                                                            </div>

                                                        </div>
                                                        <div class="grid">
                                                            <div class="upload__box">

                                                                <div class="upload__img-wrap">
                                                                    <div v-for="image in review.imageUrls?.split(',')"
                                                                        class="upload__img-box">
                                                                        <div class="img-bg"
                                                                            :style="{ backgroundImage: 'url(' + image + ')' }">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="grid-column d-flex flex-column border-top"
                                                                style="width: 100%;">
                                                                <div
                                                                    v-for="(reviewInOrderDetail, index) in reviewsByOrderDetailId">
                                                                    <div v-if="reviewInOrderDetail.content" :class="[
                                                                        'flex-column',
                                                                        `item-${index}`,
                                                                        reviewInOrderDetail.staff ? 'd-flex align-items-end' : 'd-flex align-items-start'
                                                                    ]" style="
                                            overflow-y: hidden;
                                            height: auto;
                                            /* background-color: #D9D9D9; */
                                            white-space: normal" :readonly="true" :disabled="true">
                                                                        <div class="form-control col-12" :style="{
                                                                            'background-color': !reviewInOrderDetail.staff ? '#D9D9D9' : '#83B5FF',
                                                                            'max-width': '350px',
                                                                            'width': 'fit-content',
                                                                            'min-height': '40px',
                                                                        }"> {{ reviewInOrderDetail.content }}</div>
                                                                        </br>
                                                                        <div class="text-secondary  px-1"> {{
                                                                            reviewInOrderDetail.createDate }}</div>
                                                                    </div>
                                                                </div>

                                                                <div style="width: 100%; margin-bottom: 10px;">
                                                                    <textarea :class="[
                                                                        'form-control', `item-${index}`,
                                                                    ]" style="
                                            overflow-y: hidden;
                                            resize: vertical;
                                            min-height: 40px; 
                                            height: auto;
                                            " v-model="replyContent">
                                        </textarea>
                                                                </div>

                                                                <div :class="[
                                                                    'btn-review-save', `item-${index}`
                                                                ]" @click="sendReply(review.orderDetail)">Gửi phản hồi
                                                                </div>

                                                            </div>
                                                            <!-- <div class="grid-column d-flex align-items-end flex-column">
                                                                <div style="width: 100%;" v-for="(reviewInOrderDetail, index) in reviewsByOrderDetailId">
                                                                    <textarea v-if="reviewInOrderDetail.content"
                                                                        :class="[
                                                                            'form-control', `item-${index}`,
                                                                        ]" style="
                                            overflow-y: hidden;
                                            resize: vertical;
                                            min-height: 40px;
                                            margin-bottom: 10px; 
                                            height: auto;
                                            /* background-color: #D9D9D9; */
                                            white-space: normal" :readonly="true" :disabled="true"
                                                                        :style="{ 'background-color': reviewInOrderDetail.staff ? '#83B5FF' : '#D9D9D9' }"> {{ reviewInOrderDetail.content }}
                                        </textarea>

                                                                </div>

                                                                <div style="width: 100%; margin-bottom: 10px;">
                                                                    <textarea :class="[
                                                                        'form-control', `item-${index}`,
                                                                    ]" style="
                                            overflow-y: hidden;
                                            resize: vertical;
                                            min-height: 40px; 
                                            height: auto;
                                            " v-model="replyContent">
                                        </textarea>
                                                                </div>

                                                                <div :class="[
                                                                    'btn-review-save', `item-${index}`
                                                                ]" @click="sendReply(review.orderDetail)">Gửi phản hồi
                                                                </div>

                                                </div> -->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">Trở
                                                    lại</button>
                                                <!-- <button type="button" class="btn btn-primary btn-save">Lưu</button> -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </tr>
                        </tbody>

                    </table>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ReviewService } from '@/services/review.service';
import { onMounted, ref } from 'vue';
import type { ProductObject } from '../cart/cart-item/DefaultCartItem.vue';
import type { Review } from '../profile/account-content/OrderCard.vue';

const reviewService = new ReviewService();
let reviews = ref<Review[]>([]);

interface Order {
    id: string,
    createDate: string,
    status: string,
    total: string,
    couponId: string,
    customer: Customer,
    paymentId: string;
    shipmentId: string;
    staff: Staff;
    warehouseId: string;
    orderDetails: OrderDetail[];
    phone: string;
}

interface Customer {
    id: string;
}

export interface OrderDetail {
    id: string;
    productDetail: ProductDetail;
    quantity: string,
    total: number
}
interface ProductDetail {
    id: string;
    quantity: string,
    imageLinks: string,
    product: ProductObject,
    color: string,
    size: string
}

interface Staff {
    id: string;
}

const orders = ref<Order[]>();
const replyContent = ref<string>('');

const reviewsByOrderDetailId = ref<Review[]>([]);
const getAllReviewByOrderDetailId = async (orderDetailId) => {
    replyContent.value = '';
    const response = (await reviewService.getAllReviewByOrderDetailId(orderDetailId));
    reviewsByOrderDetailId.value = response.data;

    console.log(reviewsByOrderDetailId.value)
}

const sendReply = async (orderDetail) => {
    let data = {
        staff: JSON.parse(localStorage.getItem('accountStaff')!),
        orderDetail: orderDetail,
        content: replyContent.value
    }

    const response = (await reviewService.postReview(0, orderDetail.id, data, null));
    reviewsByOrderDetailId.value = response.data;

    getAllReviewByOrderDetailId(orderDetail.id);
}

onMounted(async () => {
    reviews.value = (await reviewService.getAllReviews()).data;

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
});

const currentTotalOrder = ref<number>(0);
const selectedStatus = ref<string>('all');
const showPrintOrder = ref(false);
const filterStatus = () => {
    currentTotalOrder.value = orders.value?.length!;
    const table = document.getElementById("table-data");
    const tr = table?.getElementsByTagName("tr");
    let tdContent;
    let temp = 0;
    if (tr !== undefined) {
        for (let i = 0; i < tr?.length; i++) {
            const td = tr[i].getElementsByTagName("td")[6];
            if (td) {
                tdContent = td.textContent?.trim();
                if (tdContent !== selectedStatus.value && selectedStatus.value !== 'all' && tr != undefined) {
                    tr[i].style.display = "none";
                    temp++;
                } else {
                    tr[i].style.display = "";
                }
            }
        }
        currentTotalOrder.value = orders.value?.length! - temp;
        if (selectedStatus.value === "PROCESSING") {
            showPrintOrder.value = true;
        } else {
            showPrintOrder.value = false;
        }
    }
};

</script>

<style scoped>
.fixed-header {
    position: sticky;
    top: 0;
    z-index: 1;
    background-color: #ffffff;
}

.custom-scrollbar::-webkit-scrollbar {
    width: 5px;
    height: 5px;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
    background-color: rgba(0, 0, 0, 0.2);
    border-radius: 3px;
}

.custom-scrollbar::-webkit-scrollbar-track {
    background-color: rgba(0, 0, 0, 0.1);
    border-radius: 3px;
}

.found {
    background-color: rgb(196, 199, 199);
}

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
    max-height: 600px;
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

.form-control:not(:disabled):focus,
.form-control:not(:disabled):active .vs-dropdown-toggle:not(:disabled):focus,
.vs-dropdown-toggle:not(:disabled):active {
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
    margin-top: 10px;
    cursor: pointer;
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


.text-instruction {
    color: #4045ba;
}

.text-instruction:hover {
    color: #151aa1;
    text-decoration: underline;
}
</style>