<script setup lang="ts">
import CartService from '@/services/cart.service';
import { inject, ref } from 'vue';

const { cartService }: { cartService: CartService } = inject('cartService')!;

const VND = new Intl.NumberFormat('vi-VN', {
  style: 'currency',
  currency: 'VND',
});

const customerInfo = JSON.parse(localStorage.getItem('account'));

console.log(customerInfo)

</script>

<template>
  <div class="cart-coolcash-box p-4">
    <div class="cart-coolcash-boxd-wrapper">
      <div class="cart-coolcash-boxd-grid">
        <div class="cart-coolcash-boxd-left">
          <a href="#" class="cart-coolcash-boxd-name"> Hi, {{ customerInfo.name }} </a>
          <p class="cart-coolcash-boxd-content-text">
            Tổng đơn
             <!-- (8 sản phẩm) -->
            <span>{{ VND.format(cartService.subTotal.value) }}</span>
          </p>
        </div>
        <div class="cart-coolcash-boxd-right"></div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.cart-coolcash-box {
  position: relative;
  z-index: 9;
  padding-top: 1rem;
}

.cart-coolcash-boxd-wrapper {
  background-color: #f1f1f1;
  border-radius: 0.5rem;
  padding: 1rem 0.875rem;
}

.cart-coolcash-boxd-grid {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.cart-coolcash-boxd-right {
  text-align: right;
  font-size: 34px;
  font-weight: 700;
  font-family: Pangea, sans-serif;
  line-height: 1.125;
}

.cart-coolcash-boxd-name {
  font-size: 36px;
  font-weight: 700;
}

.cart-coolcash-boxd-content-text {
  font-size: 16px;
  color: #000;
  margin-top: 0;
  margin-bottom: 0;
}

.cart-coolcash-boxd-content-text span {
  font-weight: 700;
  color: #2f5acf;
}

.cart-coolcash-boxd-content-text {
  font-size: 16px;
  color: #000;
  margin-top: 0;
  margin-bottom: 0;
}

.cart-coolcash-boxd-content-text span {
  font-weight: 700;
  color: #2f5acf;
}
</style>
