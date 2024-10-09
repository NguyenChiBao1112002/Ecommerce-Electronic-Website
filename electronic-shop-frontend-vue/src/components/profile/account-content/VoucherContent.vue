<template>
  <div class="account-content my-50">
    <div id="info-tab" class="account-info">
      <h2 class="account-page-title">Ví voucher</h2>

      <div class="coupon-container">
        <Coupon />
        <Coupon />
        <Coupon />
        <Coupon />
        <Coupon />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Coupon from "@/components/common/Coupon.vue";
export default {
  name: "VoucherContent",
  components: {
    Coupon,
  },
};
</script>

<style scoped>
.account-content {
  position: relative;
  padding: 3rem 3rem;
  transition: all 0.1s;
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

.coupon-container {
  display: flex;
  flex-wrap: wrap;
}
</style>
