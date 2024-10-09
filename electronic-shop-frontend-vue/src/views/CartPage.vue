<template>
  <Header />
  <div class="row" id="cart">
    <div class="grid my-50 row">
      <div
        class="grid-column seven-twelfths mobile--one-whole cart-left-section"
      >
        <PaymentShipmentComponent />
      </div>
      <div class="grid-column five-twelfths mobile--one-whole">
        <CartComponent />
      </div>
    </div>
  </div>
  <Footer />
</template>

<script setup lang="ts">
import CartComponent from "@/components/cart/CartComponent.vue";
import PaymentShipmentComponent from "@/components/cart/PaymentShipmentComponent.vue";
import Header from "@/components/common/Header.vue";
import Footer from "@/components/common/Footer.vue";
</script>

<style scoped>
@media (min-width: 1280px) {
  #cart {
    margin: 0px;
    padding: 0px 40px;
    position: relative;
    justify-content: center;
    width: inherit;
    justify-content: center;
  }
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
.cart-left-section {
  position: relative;
  border-right: 1px solid #d9d9d9;
}
.seven-twelfths {
  width: 58.333%;
}
.five-twelfths {
  width: 41.666%;
}
</style>
