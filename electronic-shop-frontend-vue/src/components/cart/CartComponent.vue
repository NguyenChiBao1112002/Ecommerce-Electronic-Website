<template>
  <div class="cart-section my-50">
    <div class="title">Giỏ hàng</div>
    <div>
      <div v-if="cartItems.length == 0">Giỏ hàng chưa có sản phẩm nào</div>

      <div v-if="cartItems.length > 0">
        <div class="cart-items-header">
          <span style="margin-left: 24px;">Mô tả sản phẩm</span>
          <span>Số lượng</span>
          <span>Giá</span>
        </div>

        <div class="cart-items">
          <DefaultCartItem v-for="(cartItem, idx) in cartItems" :key="idx" :cartDetail="cartItem" />
        </div>
      </div>
    </div>
  </div>
  <!--   
  <div class="cart-viewing-users mgt--10">
    <i>Có <b>4</b> người đang thêm cùng sản phẩm giống bạn vào giỏ hàng.</i>
  </div>

  <ProductPromotion />

  <DiscountBlock /> -->

  <div class="divider"></div>

  <div class="pricing-info">
    <div class="pricing-info-item">
      <p>Tạm tính</p>
      <p class="pricing-info-sub">
        <span> {{ VND.format(cartService.total?.value) }}</span>
        <!-- <span class="pricing-info-saving"
          ><i>(tiết kiệm <span class="text--primary">940k)</span></i></span
        > -->
      </p>
    </div>
    <div class="pricing-info-item">
      <p>Giảm giá</p>
      <p class="">
        <span>{{ VND.format(cartService.discount?.value) }}</span>
      </p>
    </div>
    <div class="pricing-info-item">
      <p>Phí giao hàng</p>
      <p class="">
        <span v-if="cartService.shipCost?.value == 0">Miễn phí</span>
        <span v-if="cartService.shipCost?.value != 0"> {{ VND.format(cartService.shipCost!.value) }}</span>
      </p>
    </div>
    <div class="divider"></div>
    <div class="pricing-info-item pricing-info-total">
      <p style="align-items: center">Tổng</p>
      <p class="">
        <span class="pricing-info-total total"> {{ VND.format(cartService.subTotal?.value) }}</span>
        <span v-if="discount > 0" style="color: red; display: block; font-size: 12px">(Đã giảm 940k trên giá gốc)</span>
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { CartService } from "../../services/cart.service";
import { computed, inject, ref } from "vue";
import DefaultCartItem, { type ProductDetailObject } from "./cart-item/DefaultCartItem.vue";

export type CartDetailObject = {
  id: number,
  quantity: number,
  total: number,
  productDetail: ProductDetailObject
}

const { cartService }: { cartService: CartService } = inject('cartService')!;

const VNDFormatter = new Intl.NumberFormat('vi-VN', {
  style: 'currency',
  currency: 'VND',
});

const VND = computed(() => ({
  format: (value: number) => VNDFormatter.format(value)
}));

const cartItems = ref<CartDetailObject[]>([]);
const setup = async () => {
  await cartService.getCart();
  cartItems.value = cartService.cartItems?._rawValue;
  // cartService.cartDetailsToOrder.value = cartItems?._rawValue.map(item => item.id);

  setTimeout(() => {
    cartService.subTotal.value = Number(cartService.total.value) + Number(cartService.shipCost.value) | 0; // checkkk
  }, 500);
}

setup();

</script>

<style scope>
.title {
  font-size: 30px;
  font-weight: 700;
  margin: 2rem 0 1rem;
}

.cart-items-header {
  display: flex;
  padding-bottom: 12px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  color: rgba(0, 0, 0, 0.4);
  text-transform: uppercase;
  font-size: 12px;
  font-weight: 400;
  margin-bottom: 20px;
}

.cart-items-header span:first-of-type {
  flex: 1;
}

.cart-items-header span:nth-of-type(2) {
  flex: 0 0 20%;
  text-align: center;
}

.cart-items-header span:nth-of-type(3) {
  flex: 0 0 11%;
  text-align: right;
}

.divider {
  margin: 1rem 0;
  border: none;
  border-top: 1px solid #d9d9d9;
  height: 1px;
}

.pricing-info-item:not(:last-child) {
  margin: 0 0 1rem 0;
}

.pricing-info-item {
  display: flex;
  justify-content: space-between;
}

.pricing-info-item p:nth-child(1) {
  text-align: left;
}

.pricing-info-item p:nth-child(2) {
  text-align: right;
}

.pricing-info-item p {
  margin: 0;
}

.pricing-info-saving {
  display: block;
  font-size: 12px;
  white-space: nowrap;
}

.text--primary {
  color: #2f5acf;
}

.pricing-info-item.pricing-info-total p:nth-child(2) {
  font-size: 1.3rem;
}

.pricing-info-total.total {
  font-weight: bold;
}
</style>../../services/cart.service
