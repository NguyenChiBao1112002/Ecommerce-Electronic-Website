<script setup lang="ts">
import type { CartService } from '@/services/cart.service';
import { ReviewService } from '@/services/review.service';
import { defineProps, inject, ref } from 'vue';
import type { Review } from './OrderCard.vue';

const { cartService }: { cartService: CartService } = inject('cartService')!;

const props = defineProps<{
  order: any
}>();

const isLoading = ref(true)

const VND = new Intl.NumberFormat('vi-VN', {
  style: 'currency',
  currency: 'VND',
});

const reviews = ref<Review[]>([]);
const customerRate = ref<string[]>([]);
const customerReview = ref<string[]>([]);
let reviewService = new ReviewService();

setTimeout(async () => {
  reviews.value = (await reviewService.getAllReviewByCustomerId(cartService.customerId)).data;

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

  isLoading.value = false;
}, 1000);


const sendReply = async (orderDetail) => {
  let data = {
    orderDetail: orderDetail,
    content: replyContent.value
  }

  const response = (await reviewService.postReview(0, orderDetail.id, data, null));
  reviewsByOrderDetailId.value = response.data;

  getAllReviewByOrderDetailId(orderDetail.id);
}

const getImageData = (image) => {
  return URL.createObjectURL(image);
}
const replyContent = ref<string>('');
const reviewsByOrderDetailId = ref<Review[]>([]);
const getAllReviewByOrderDetailId = async (orderDetailId) => {
  replyContent.value = '';
  const response = (await reviewService.getAllReviewByOrderDetailId(orderDetailId));
  reviewsByOrderDetailId.value = response.data;

  console.log(reviewsByOrderDetailId.value)
}


</script>
<template>
  <div class="loader-container" v-if="isLoading"><span class="loader"></span></div>

  <div class="account-content my-50">
    <div id="info-tab" class="account-info">
      <h2 class="account-page-title">Đánh giá và phản hồi</h2>
      <div v-if="!isLoading && reviews.length == 0" class="account-page-label mt-4">Bạn chưa có đánh giá nào...</div>
      <div>
        <div class="grid-column mt-3">
          <div class="reviews-listing-items" v-for="(review, index) in reviews">
            <div class="reviews-listing-item" v-show="!review.staff">
              <div class="reviews-listing-content">
                <div class="reviews-rating">
                  <div :class="['reviews-rating-star', review.rate >= 1 ? 'is-active' : '']"></div>
                  <div :class="['reviews-rating-star', review.rate >= 2 ? 'is-active' : '']"></div>
                  <div :class="['reviews-rating-star', review.rate >= 3 ? 'is-active' : '']"></div>
                  <div :class="['reviews-rating-star', review.rate >= 4 ? 'is-active' : '']"></div>
                  <div :class="['reviews-rating-star', review.rate == 5 ? 'is-active' : '']"></div>

                </div>
                <div class="reviews-order">
                  <router-link
                    :to="{ name: 'product', params: { id: review.orderDetail.productDetail.product.id.toString() } }">
                    <div class="order-item-title"> {{ review.orderDetail.productDetail.product.name }}</div>
                  </router-link>
                  <!-- <div class="order-item-title"> {{ review.orderDetail.productDetail.product.name }}</div> -->
                  <div class="order-item-variant-label">
                    {{ review.orderDetail.productDetail.color }} / {{ review.orderDetail.productDetail.size }}
                  </div>
                </div>
                <div class="reviews-listing-description">
                  <p>
                    {{ review.content }}
                  </p>

                  <div class="reviews-listing-gallery" rel-script="product-gallery-popup">
                    <a v-for="image in review.imageUrls?.split(',')" class="reviews-listing-image"
                      rel-script="product-lightbox-gallery" data-index="0" :data-image=image>
                      <img :src=image alt="0" />
                    </a>


                  </div>
                  <!-- <p class="reviews-listing-feedback" *v-if="false">
                    Phản hồi
                  </p> -->
                  <span class="reviews-listing-date"> {{ review.createDate }}</span>
                  <div v-if="!review.staff" type="button" data-bs-toggle="modal" class="py-2 text-instruction"
                    :data-bs-target="`#review-${review.id}`"
                    @click="getAllReviewByOrderDetailId(review.orderDetail.id)">Đánh giá và phản hồi</div>

                  <!-- Modal -->
                  <div class="modal fade" style="text-align: left !important" :id="`review-${review.id}`" tabindex="-1"
                    aria-labelledby="exampleModalLabel" data-bs-backdrop="false" data-bs-focus="true"
                    aria-hidden="false">
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                      <div class="modal-content">
                        <div class="modal-header">
                          <div class="modal-title h4" id="exampleModalLabel">Đánh giá đơn hàng
                          </div>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                                <div :class="['reviews-rating-star', review.rate >= 1 ? 'is-active' : '']"></div>
                                <div :class="['reviews-rating-star', review.rate >= 2 ? 'is-active' : '']"></div>
                                <div :class="['reviews-rating-star', review.rate >= 3 ? 'is-active' : '']"></div>
                                <div :class="['reviews-rating-star', review.rate >= 4 ? 'is-active' : '']"></div>
                                <div :class="['reviews-rating-star', review.rate == 5 ? 'is-active' : '']"></div>

                              </div>
                              <div class="grid">
                                <div class="upload__box">
                                  <div class="upload__img-wrap">
                                    <div v-for="image in review.imageUrls?.split(',')" class="upload__img-box">
                                      <div class="img-bg" :style="{ backgroundImage: 'url(' + image + ')' }">
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <div class="grid-column d-flex flex-column border-top" style="width: 100%;">
                                  <div v-for="(reviewInOrderDetail, index) in reviewsByOrderDetailId">
                                    <div v-if="reviewInOrderDetail.content" :class="[
                                      'flex-column',
                                      `item-${index}`,
                                      !reviewInOrderDetail.staff ? 'd-flex align-items-end' : 'd-flex align-items-start'
                                    ]" style="
                                            overflow-y: hidden;
                                            height: auto;
                                            /* background-color: #D9D9D9; */
                                            white-space: normal" :readonly="true" :disabled="true">
                                      <div class="form-control col-12" :style="{
                                        'background-color': reviewInOrderDetail.staff ? '#D9D9D9' : '#83B5FF',
                                        'max-width': '350px',
                                        'width': 'fit-content',
                                        'min-height': '40px',
                                      }"> {{ reviewInOrderDetail.content }}</div>
                                      </br>
                                      <div class="text-secondary  px-1"> {{ reviewInOrderDetail.createDate }}</div>
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
                                  ]" @click="sendReply(review.orderDetail)">Trả lời
                                  </div>

                                </div>
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
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.loader {
  display: block;
  border-radius: 50%;
  position: relative;
  animation: rotate 1s linear infinite;
  width: 200px;
  height: 200px;
  background: rgba(255, 255, 255, 0.5);
  position: fixed;
  top: 40%;
  left: 40%;
  z-index: 100;
}

.loader::before,
.loader::after {
  content: "";
  box-sizing: border-box;
  position: absolute;
  inset: 0px;
  border-radius: 50%;
  border: 20px solid #e5e3e3;
  animation: prixClipFix 2s linear infinite;
  z-index: 1000;
}

.loader::after {
  border-color: #2424be;
  animation: prixClipFix 2s linear infinite, rotate 0.5s linear infinite reverse;
  inset: 6px;
  z-index: 1000;
}

@keyframes rotate {
  0% {
    transform: rotate(0deg)
  }

  100% {
    transform: rotate(360deg)
  }
}

@keyframes prixClipFix {
  0% {
    clip-path: polygon(50% 50%, 0 0, 0 0, 0 0, 0 0, 0 0)
  }

  25% {
    clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 0, 100% 0, 100% 0)
  }

  50% {
    clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 100% 100%, 100% 100%)
  }

  75% {
    clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 0 100%, 0 100%)
  }

  100% {
    clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 0 100%, 0 0)
  }
}

.account-content {
  position: relative;
  /* display: flex; */
  align-items: center;
  padding: 3rem 3rem;
  transition: all 0.2s;
  border-radius: 0.5rem;
  font-size: 1rem;
  box-sizing: border-box;
  background-color: white;
  width: 100%;
  box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
}

.account-page-title {
  margin-bottom: 25px;
  font-size: 2.5rem;
}

.account-page-label {
  font-size: 18px;
  color: rgba(0, 0, 0, 0.5333333333);
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

.reviews-listing-item {
  display: flex;
  padding: 15px 0;
  border-bottom: 1px solid #d9d9d9;
}

.reviews-listing-item:is(:first-child) {
  border-top: 1px solid #d9d9d9;
}

.reviews-listing-content {
  flex: 1;
}

.reviews-rating {
  display: flex;
  align-items: center;
  margin-left: -3px;
  margin-right: -3px;
}

.reviews-rating-star.is-active,
.reviews-rating-star.is-full {
  background-image: url(https://www.coolmate.me/images/star.svg?2a5188496861d26e5547c524320ec875);
}

.reviews-rating-star {
  display: block;
  width: 20px;
  height: 20px;
  margin: 0 3px 1px;
  background-image: url(https://www.coolmate.me/images/star-new.svg?08a379c24952a980d5430515abb8be4e);
  background-repeat: no-repeat;
  background-position: 50%;
  background-size: contain;
}

.reviews-rating-star.is-half {
  background-image: url(https://www.coolmate.me/images/star-half.svg?8aea9e9938db110e66ea06732737184a);
}

.reviews-order {
  font-size: 14px;
  line-height: 18px;
  color: #000;
  margin-top: 5px;
  margin-bottom: 10px;
  line-height: 1.5em;
}

.order-item-variant-label {
  font-weight: 400;
  color: rgba(0, 0, 0, 0.4);
  font-style: italic;
  font-size: 12px;
}

.reviews-listing-description {
  font-size: 14px;
  line-height: 18px;
  letter-spacing: 0.03em;
  color: #000;
}

.reviews-listing-description p {
  margin: 0;
  font-weight: 400;
}

.reviews-listing-feedback {
  padding: 14px 18px;
  border-radius: 16px;
  margin-top: 15px !important;
  line-height: 1.5em;
  border: 1px solid #d9d9d9;
  background-color: #d9d9d9;
  width: 100%;
}

.reviews-listing-date {
  display: block;
  margin-top: 20px;
  opacity: 0.5;
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
  /* z-index: 1; */
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
