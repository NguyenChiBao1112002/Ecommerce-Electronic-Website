<template>
  <div class="my-3">
    <CustomerHeader />
  </div>
  <div class="cart-section">
    <ShipmentBlock/>
  </div>
  <div class="cart-section cart-payment-scroll">
    <PaymentBlock />
  </div>
</template>

<script setup lang="ts">
import CustomerHeader from "./payment-shipment/CustomerHeader.vue";
import PaymentBlock from "./payment-shipment/PaymentBlock.vue";
import ShipmentBlock from "./payment-shipment/ShipmentBlock.vue";
</script>

<style scoped>
.cart-section {
  padding: 0 20px;
}

.cart-payment-scroll {
  position: sticky;
  top: 20px;
}
</style>
