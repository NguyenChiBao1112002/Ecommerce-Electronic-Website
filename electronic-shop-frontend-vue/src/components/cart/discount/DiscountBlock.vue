<template>
  <div class="discount-block">
    <div class="coupon-public">
      <div class="coupons">
        <div
          ga-tracking-value="cart-coupon__COOLCLUB99"
          ga-tracking-label="Cart Coupon COOLCLUB99"
          class="coupon coupon--COOLCLUB99 coupon--coolcash custom-cursor-on-hover"
        >
          <div class="coupon-left"></div>
          <div class="coupon-right custom-cursor-on-hover">
            <div class="coupon-title">
              COOLCLUB99
              <span class="coupon-count"><i>(Còn 80)</i></span>
            </div>
            <div class="coupon-description">
              <span>Giảm 10%</span> không giới hạn cho đơn hàng từ 99K (Dành cho
              Coolclub)
            </div>
          </div>
        </div>
        <div
          ga-tracking-value="cart-coupon__NUOCHOA24"
          ga-tracking-label="Cart Coupon NUOCHOA24"
          class="coupon coupon--NUOCHOA24"
        >
          <div class="coupon-left custom-cursor-on-hover"></div>
          <div class="coupon-right custom-cursor-on-hover">
            <div class="coupon-title">
              NUOCHOA24
              <span class="coupon-count"><i>(Còn 125)</i></span>
            </div>
            <div class="coupon-description custom-cursor-on-hover">
              <span class="custom-cursor-on-hover">Tặng nước hoa CM24 9ml</span>
              cho đơn từ 299K (Trừ danh mục SALE)
            </div>
          </div>
        </div>
        <div
          ga-tracking-value="cart-coupon__CMT120"
          ga-tracking-label="Cart Coupon CMT120"
          class="coupon coupon--CMT120"
        >
          <div class="coupon-left"></div>
          <div class="coupon-right custom-cursor-on-hover">
            <div class="coupon-title">
              CMT120
              <span class="coupon-count"><i>(Còn 80)</i></span>
            </div>
            <div class="coupon-description">
              <span>Giảm 120K </span> cho đơn hàng từ 1TR (Trừ Giảm đến 50%)
            </div>
          </div>
        </div>
        <div
          ga-tracking-value="cart-coupon__SUPER50"
          ga-tracking-label="Cart Coupon SUPER50"
          class="coupon coupon--SUPER50"
        >
          <div class="coupon-left"></div>
          <div class="coupon-right">
            <div class="coupon-title">
              SUPER50
              <span class="coupon-count"><i>(Còn 50)</i></span>
            </div>
            <div class="coupon-description">
              <span>Giảm 50K </span> cho đơn hàng từ 499K (Trừ Giảm đến 50%)
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="discount-actions">
      <div class="wishlist-text">
        <img
          src="https://www.coolmate.me/images/header/discount-voucher-wallet.svg"
          alt="Icon Wallet Voucher"
        />
        <span>Ví voucher</span>
      </div>
    </div>
    <div class="discount-box">
      <input type="text" placeholder="Nhập mã giảm giá" />
      <!-- <button disabled="false">Áp dụng</button>
     -->
      <button>Áp dụng</button>
    </div>
    <p class="discount-message text--green">
      Mã giảm giá không áp dụng cho các sản phẩm sau:<br />- Áo dài tay Cotton
      Compact V2<br />- Áo Khoác Nam chạy bộ Fast &amp; Free<br />- Áo Nỉ chui
      đầu Lifewear
    </p>
  </div>
  <div class="discount-block">
    <p class="discount-heading">
      Sử dụng Voucher&nbsp
      <span
        ><img
          src="https://mcdn.coolmate.me/image/April2023/mceclip0_92.png"
          alt="product vote icon"
      /></span>
    </p>
  </div>
</template>

<script setup lang="ts"></script>

<style scoped>
.discount-block .coupon-public {
  margin-top: calc(1.5rem - 10px);
}
.discount-block .coupon-public .coupons .coupon.coupon--coolcash:before {
  content: "BT";
  background-color: #000;
  border-radius: 100vmax;
  position: absolute;
  right: 10px;
  top: 0;
  padding: 3px 12px;
  transform: translateY(-50%);
  z-index: 1;
}
.discount-block .coupon-public .coupons .coupon.coupon--coolcash,
.discount-block .coupon-public .coupons .coupon.active {
  background-color: #2f5acf;
  border: 2px solid #2f5acf;
  color: white;
}
.discount-block .coupon-public .coupons .coupon:hover {
  color: white;
  background-color: black;
}
.discount-block .coupon-public .coupons .coupon.coupon--coolcash .coupon-left,
.discount-block .coupon-public .coupons .coupon.active .coupon-left {
  border-right: 2px dashed #fff;
}

.discount-block .coupon-public .coupons .coupon.coupon--coolcash .coupon-left,
.discount-block .coupon-public .coupons .coupon.active .coupon-left {
  border-right: 2px dashed #fff;
}
.discount-block .coupon-public .coupons .coupon-left {
  flex: 1;
  border-right: 2px dashed rgba(102, 102, 102, 0.7607843137);
  min-width: 20px;
  max-width: 20px;
  position: relative;
}
.discount-block
  .coupon-public
  .coupons
  .coupon.coupon--coolcash
  .coupon-left:before,
.discount-block .coupon-public .coupons .coupon.active .coupon-left:before {
  left: -10%;
  border-top: 2px solid #2f5acf;
  border-right: 2px solid #2f5acf;
  border-bottom: 2px solid rgba(0, 0, 0, 0);
  border-left: 2px solid rgba(0, 0, 0, 0);
}

.discount-block .coupon-public .coupons .coupon-left:before {
  content: "";
  display: block;
  width: 1.3rem;
  height: 1.3rem;
  background: white;
  top: 50%;
  transform: translate(-50%, -50%) rotate(45deg);
  position: absolute;
  border-top: 1px solid rgba(36, 36, 36, 0.3);
  border-right: 1px solid rgba(36, 36, 36, 0.3);
  border-bottom: 1px solid rgba(0, 0, 0, 0);
  border-left: 1px solid rgba(0, 0, 0, 0);
  border-radius: 100em;
}

.discount-block .coupon-public .coupons .coupon-right {
  flex: 2;
  padding: 0.5rem 1rem 0.5rem 1rem;
  position: relative;
}

.discount-block .coupon-public .coupons .coupon-right .coupon-title {
  font-size: 16px;
  font-weight: bold;
}
.discount-block .coupon-public .coupons .coupon-right .coupon-count {
  font-weight: normal;
  font-size: 0.8em;
}
.discount-block
  .coupon-public
  .coupons
  .coupon.coupon--coolcash
  .coupon-right
  .coupon-description,
.discount-block
  .coupon-public
  .coupons
  .coupon.active
  .coupon-right
  .coupon-description {
  color: #fff;
}
.discount-block .coupon-public .coupons .coupon-right .coupon-description {
  font-size: 13px;
  color: #4d4d4d;
  display: block;
  min-width: 135px;
  transition: 0.2s all;
}
.discount-block .coupon-public .coupons {
  overflow-x: auto;
  overflow-y: hidden;
  display: flex;
  padding-bottom: 10px;
  padding-top: 15px;
  -webkit-overflow-scrolling: touch;
}
.discount-block .coupon-public .coupons .coupon:not(:last-child) {
  margin-right: 1rem;
}
.discount-block .coupon-public .coupons .coupon.coupon--coolcash,
.discount-block .coupon-public .coupons .coupon.active {
  background-color: #2f5acf;
  border: 2px solid #2f5acf;
  color: white;
}
.discount-block .coupon-public .coupons .coupon.coupon--coolcash {
  position: relative;
}
.discount-block .coupon-public .coupons .coupon {
  display: flex;
  border: 1px solid rgba(36, 36, 36, 0.3);
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
  min-width: 284px;
}
.discount-block .discount-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.discount-block .wishlist-text {
  color: #2f5acf;
  display: flex;
  cursor: pointer;
  margin-top: 0.5rem;
  margin-bottom: 1rem;
  align-items: center;
  padding: 6px 12px;
  align-items: center;
  border: 1px solid rgba(47, 90, 207, 0.4);
  border-radius: 31px;
}

.discount-block .wishlist-text img {
  height: 14px;
  display: inline-block;
  margin-right: 5px;
}
.discount-block .discount-box {
  width: 100%;
  height: 39px;
  position: relative;
  font-size: 0.9rem;
  display: flex;
  gap: 0.6rem;
}
.discount-block .discount-box input {
  padding: 5px 20px;
  width: 90%;
  height: 100%;
  border-radius: 43px;
  border: none;
  z-index: 3;
  background: rgba(212, 212, 212, 0.4);
}
.discount-block .discount-box input:active,
.discount-block .discount-box input:focus {
  outline: none;
  border: 1px solid #2f5acf;
}

.discount-block .discount-box button:disabled {
  background-color: #d9d9d9;
  border: 1px solid #d9d9d9;
  cursor: not-allowed;
}
.discount-block .discount-box button {
  height: 100%;
  color: white;
  width: -moz-fit-content;
  width: fit-content;
  white-space: nowrap;
  padding: 0 20px;
  border-radius: 43px;
  background-color: black;
  cursor: pointer;
  transition: 0.2s all;
}
.discount-block .discount-box button:not(:disabled):hover {
  background-color: #d9d9d9;
  color: black;
  border: 1px solid #d9d9d9;
}
.discount-block .discount-heading {
  cursor: pointer;
  margin-bottom: 0;
  display: flex;
}
.discount-block .discount-heading span img {
  height: 22px;
  margin-bottom: 4px;
}
.text--green {
  color: #239a1a;
  font-size: 14px;
}
p {
  display: block;
  margin-block-start: 1em;
  margin-block-end: 1em;
  margin-inline-start: 0px;
  margin-inline-end: 0px;
}
</style>
