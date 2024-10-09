<script setup lang="ts">
import { ref, onMounted, inject } from 'vue';
import { CartService } from "@/services/cart.service";
import OrderCard from "./OrderCard.vue";

const { cartService }: { cartService: CartService } = inject('cartService')!;

const responseCode = ref<any>(null);

const getQueryParamByName = (name: string) => {
  const urlParams = new URLSearchParams(window.location.search);
  return urlParams.get(name);
}

const orderItems = ref([]);

// Call the function to get the value of the 'paramName' query parameter
onMounted(async () => {
  orderItems.value = (await cartService.getAllOrders()).data;

  responseCode.value = getQueryParamByName('vnp_ResponseCode');
  if (responseCode.value == '00') {
    console.log("Giao dịch thành công");
    cartService.addOrderToSuccessful(+getQueryParamByName('orderId')!);
    window.location.href = "http://localhost:8081/account/orders"
  }
});

</script>

<template>
  <div class="account-content my-50">
    <div id="info-tab" class="account-info">
      <h2 class="account-page-title">Lịch sử đơn hàng</h2>
      <!-- <div class="account-page-label">
        Đơn hàng của bạn
        <span class="d-grid justify-content-center">
          Bạn chưa có đơn hàng nào...
        </span>
      </div> -->
      <div>
        <div class="account-page-label">
          Đơn hàng của bạn<span>: {{ orderItems.length }} đơn hàng</span>
        </div>
        <div class="orders-body mt-3">
          <div class="orders-wrapper">
            <OrderCard v-for="(orderItem, idx) in orderItems" :key="idx" :order="orderItem"/>
          </div>
        </div>
        <div id="loadingIndicator" class="loading-indicator">
          <div class="loader"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
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

a {
  background-color: transparent;
  text-decoration: none;
  color: inherit;
  transition: all 0.2s;
}

.order:not(:last-child) {
  margin-bottom: 27px;
}

/* 
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

.order-footer-left .btn {
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
} */

.loading-indicator {
  display: none;
  position: fixed;
  z-index: 9999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  justify-content: center;
  align-items: center;
}

.loader {
  border: 5px solid #f3f3f3;
  border-top: 5px solid #000;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  animation: spin-d810b37c 2s linear infinite;
}

*,
:after,
:before {
  box-sizing: border-box;
}
</style>
