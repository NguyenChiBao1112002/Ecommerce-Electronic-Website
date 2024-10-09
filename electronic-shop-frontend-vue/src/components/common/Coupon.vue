<template>
  <div class="coupon">
    <div class="coupon-left"></div>
    <div class="coupon-right custom-cursor-on-hover">
      <div class="coupon-title">WELCOMER3X766</div>
      <div class="coupon-description">
        <span>Giảm 15% tối đa 50K</span> (Không áp dụng cho danh mục SALE)
      </div>
      <div class="coupon-available">
        <i>HSD: 01.03.2024</i>
      </div>
      <div class="coupon-conditions-toggle">Điều kiện</div>
    </div>
  </div>
</template>

<script setup lang="ts"></script>

<style>
.coupon {
  flex: 0 0 calc(32% - 10px);
  border-radius: 0.5rem;
  cursor: pointer;
  transition: all 0.1s;
  background-color: #f1f1f1;
  margin: 7px;
  display: flex;
}

.coupon:hover * {
  background-color: #8e8e8e;
  color: black !important;
  border-radius: 0.5rem;
}

.coupon:hover .coupon-left {
  border-radius: 0.5rem 0 0 0.5rem;
}

.coupon:hover .coupon-right {
  border-radius: 0 0.5rem 0.5rem 0;
}

.coupon-left {
  flex: 1;
  border-right: 1px dashed rgba(0, 0, 0, 0.2);
  max-width: 25px;
  position: relative;
}

.coupon-left:before {
  content: "";
  display: block;
  width: 1.375rem;
  height: 1.375rem;
  background: white;
  top: 50%;
  left: -0.6875rem;
  transform: translate(0%, -50%);
  position: absolute;
  border-radius: 0 1rem 1rem 0;
  box-sizing: border-box;
}

.coupon-right {
  flex: 2;
  padding: 0.5rem 2rem 0.5rem 1rem;
  position: relative;
}

.coupon-title {
  font-size: 1rem;
  font-weight: bold;
}

.coupon-description {
  font-size: 12px;
  display: block;
  min-width: 120px;
  margin-bottom: 1rem;
}

.coupon-available {
  font-size: 12px;
  display: block;
  min-width: 120px;
  color: #999;
}

.coupon-conditions-toggle {
  position: absolute;
  bottom: 5px;
  right: 20px;
  font-size: 12px;
  padding: 1px 6px;
  border-radius: 8px;
  color: #2f5acf;
}
</style>
