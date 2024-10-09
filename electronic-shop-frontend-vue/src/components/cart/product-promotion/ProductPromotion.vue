<script lang="ts">
import { defineComponent, ref } from "vue";
import ProductPromotionItem from "./ProductPromotionItem.vue";
import { Carousel, Navigation, Slide } from "vue3-carousel";

import "vue3-carousel/dist/carousel.css";
export default defineComponent({
  setup() {
    const myCarousel = ref();
    return {
      myCarousel,
    };
  },
  components: {
    Carousel,
    Slide,
    Navigation,
    ProductPromotionItem,
  },

  data: () => ({
    currentSlide: 0,
  }),
  methods: {
    slideTo(val) {
      this.currentSlide = val;
    },
  },
});
</script>

<template>
  <div class="cart-section">
    <div class="product-promotion-wrapper">
      <div class="product-promotion-tags">
        <svg
          width="19"
          height="17"
          viewBox="0 0 19 17"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M4.20845 5.33386C4.09683 5.33386 3.98979 5.3782 3.91086 5.45713C3.83194 5.53605 3.7876 5.6431 3.7876 5.75472V6.66876C3.7876 6.78037 3.83194 6.88742 3.91086 6.96635C3.98979 7.04527 4.09683 7.08961 4.20845 7.08961C4.32007 7.08961 4.42711 7.04527 4.50604 6.96635C4.58497 6.88742 4.6293 6.78037 4.6293 6.66876V5.75472C4.6293 5.6431 4.58497 5.53605 4.50604 5.45713C4.42711 5.3782 4.32007 5.33386 4.20845 5.33386Z"
            fill="white"
          ></path>
          <path
            d="M4.20845 7.61978C4.09683 7.61978 3.98979 7.66412 3.91086 7.74305C3.83194 7.82197 3.7876 7.92902 3.7876 8.04064V8.95468C3.7876 9.06629 3.83194 9.17334 3.91086 9.25227C3.98979 9.33119 4.09683 9.37553 4.20845 9.37553C4.32007 9.37553 4.42711 9.33119 4.50604 9.25227C4.58497 9.17334 4.6293 9.06629 4.6293 8.95468V8.04064C4.6293 7.92902 4.58497 7.82197 4.50604 7.74305C4.42711 7.66412 4.32007 7.61978 4.20845 7.61978Z"
            fill="white"
          ></path>
          <path
            d="M4.20845 9.90572C4.09683 9.90572 3.98979 9.95006 3.91086 10.029C3.83194 10.1079 3.7876 10.215 3.7876 10.3266V11.2406C3.7876 11.3522 3.83194 11.4593 3.91086 11.5382C3.98979 11.6171 4.09683 11.6615 4.20845 11.6615C4.32007 11.6615 4.42711 11.6171 4.50604 11.5382C4.58497 11.4593 4.6293 11.3522 4.6293 11.2406V10.3266C4.6293 10.215 4.58497 10.1079 4.50604 10.029C4.42711 9.95006 4.32007 9.90572 4.20845 9.90572Z"
            fill="white"
          ></path>
          <path
            d="M2.89008 0.50473C2.39989 0.545773 1.95331 0.872474 1.79027 1.36534L1.22968 3.0578C0.546192 3.11496 0 3.68892 0 4.38612V6.06049C0.000134673 6.2431 0.117999 6.40479 0.291803 6.4608C0.816822 6.63024 1.26238 7.28984 1.26256 8.09736C1.26263 8.90513 0.816991 9.56524 0.291803 9.73474C0.117999 9.79075 0.000134673 9.95244 0 10.135V12.6503C0 13.3848 0.604476 13.9893 1.339 13.9893H7.98307L15.1285 16.4289C15.7882 16.6542 16.5099 16.2855 16.7273 15.6283L17.2731 13.9794C17.9635 13.9295 18.5176 13.3525 18.5176 12.6503V10.1342C18.5174 9.95162 18.3996 9.78993 18.2258 9.73392C17.7007 9.56447 17.2552 8.90487 17.255 8.09736C17.2549 7.28958 17.7006 6.62948 18.2258 6.45997C18.3996 6.40397 18.5174 6.24228 18.5176 6.05967V4.38612C18.5176 3.65159 17.9131 3.04711 17.1786 3.04711H10.5361L3.39149 0.564735C3.22608 0.506811 3.0458 0.514133 2.89008 0.50473ZM2.95173 1.33986C3.0063 1.33614 3.06324 1.34332 3.12023 1.36205C4.73684 1.92342 6.35336 2.48535 7.96992 3.04711H2.11989L2.58923 1.6292C2.6458 1.45821 2.788 1.35103 2.95173 1.33986ZM1.339 3.88882H3.78768V4.28913C3.78768 4.52156 3.97611 4.70998 4.20854 4.70998C4.44097 4.70998 4.62939 4.52156 4.62939 4.28913V3.88882H17.1786C17.4614 3.88882 17.6759 4.10325 17.6759 4.38612V5.81883C16.8986 6.22833 16.4132 7.11084 16.4133 8.09736C16.4135 9.08356 16.8988 9.96573 17.6759 10.3751V12.6503C17.6759 12.9332 17.4614 13.1476 17.1786 13.1476H4.62857C4.63066 13.0023 4.62939 12.8529 4.62939 12.7062C4.62939 12.4738 4.44097 12.2853 4.20854 12.2853C3.97611 12.2853 3.78768 12.4738 3.78768 12.7062C3.78684 12.8523 3.78804 13.0033 3.78852 13.1476H1.33903C1.05608 13.1476 0.841707 12.9332 0.841707 12.6503V10.3759C1.61897 9.96639 2.10436 9.08388 2.10427 8.09736C2.10405 7.11115 1.61875 6.22899 0.841707 5.81965V4.38612C0.841707 4.10325 1.05614 3.88882 1.339 3.88882ZM10.5879 13.9893H16.3829L15.9283 15.3637C15.8528 15.5919 15.6235 15.7086 15.4006 15.6324L10.5879 13.9893Z"
            fill="white"
          ></path>
          <path
            d="M12.9465 9.15636C13.6956 9.15636 14.3118 9.77249 14.3118 10.5217C14.3118 11.2708 13.6956 11.8878 12.9465 11.8878C12.1973 11.8878 11.5803 11.2708 11.5803 10.5217C11.5803 9.77249 12.1973 9.15636 12.9465 9.15636ZM12.9465 9.99806C12.6522 9.99806 12.422 10.2274 12.422 10.5217C12.422 10.8159 12.6522 11.0461 12.9465 11.0461C13.2407 11.0461 13.4701 10.8159 13.4701 10.5217C13.4701 10.2274 13.2407 9.99806 12.9465 9.99806Z"
            fill="white"
          ></path>
          <path
            d="M8.93864 5.14885C9.68781 5.14885 10.3039 5.76498 10.3039 6.51416C10.3039 7.26333 9.68781 7.87947 8.93864 7.87947C8.18946 7.87947 7.57251 7.26333 7.57251 6.51416C7.57251 5.76498 8.18947 5.14885 8.93864 5.14885ZM8.93864 5.99056C8.64436 5.99056 8.41422 6.21988 8.41422 6.51416C8.41422 6.80844 8.64436 7.03776 8.93864 7.03776C9.23292 7.03776 9.46224 6.80844 9.46224 6.51416C9.46224 6.21988 9.23292 5.99056 8.93864 5.99056Z"
            fill="white"
          ></path>
          <path
            d="M12.6485 6.21667L8.64057 10.2246C8.47626 10.389 8.47626 10.6554 8.64057 10.8198C8.80491 10.9841 9.07133 10.9841 9.23568 10.8198L13.2437 6.81178C13.408 6.64743 13.408 6.38101 13.2437 6.21667C13.0717 6.06382 12.8106 6.0478 12.6485 6.21667Z"
            fill="white"
          ></path>
        </svg>
        Ưu đãi dành riêng cho bạn
      </div>
      <div class="product-promotion-body">
        <div
          dir="ltr"
          class="slick-slider product-promotion-slider slick-initialized"
        >
          <button
            type="button"
            data-role="none"
            class="slick-arrow slick-prev mx-1 carousel-pre icon-arrow-left"
            @click="myCarousel.prev"

            style="display: block"
          >
            Previous
          </button>
          <div class="slick-list">
            <div class="slick-track">
              <Carousel
                ref="myCarousel"
                v-model="currentSlide"
                :items-to-show="1.3"
                :wrap-around="true"
              >
                <Slide v-for="slide in 10" :key="slide">
                  <div class="carousel__item"><ProductPromotionItem /></div>
                </Slide>
                <input type="number" min="0" max="9" v-model="currentSlide" />

                <!-- <template #addons>
                  <Navigation />
                </template> -->
                
              </Carousel>
            </div>
          </div>
          <button
            type="button"
            data-role="none"
            class="slick-arrow slick-next carousel-next"
            @click="myCarousel.next"
            style="display: block"
          >
            Next
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.product-promotion-wrapper {
  position: relative;
  margin-top: 1rem;
  border: 1px solid #da2153;
  overflow: hidden;
  border-radius: 0.75rem;
}
.product-promotion-wrapper .product-promotion-tags {
  display: inline-flex;
  align-items: center;
  padding: 5px 20px;
  color: white;
  height: 34px;
  margin: 0;
  background-color: #da2153;
  border-radius: 0 0 0.75rem 0;
  box-sizing: border-box;
}
.product-promotion-wrapper .product-promotion-tags svg {
  width: 20px;
  height: 20px;
  display: block;
  margin-right: 10px;
  fill: white;
}
.product-promotion-body {
  display: flex;
  padding: 1rem 0;
}
.slick-slider {
  position: relative;
  display: block;
  box-sizing: border-box;
  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;
  -webkit-touch-callout: none;
  -khtml-user-select: none;
  touch-action: pan-y;
  -webkit-tap-highlight-color: transparent;
}
.product-promotion-body .slick-slider {
  width: 100%;
}
.product-promotion-body .slick-arrow.slick-disabled {
  opacity: 0.5;
  pointer-events: none;
}
.product-promotion-body .slick-prev {
  left: auto;
  top: -40px;
  right: 3rem;
  transform: rotate(180deg);
}
.product-promotion-body .slick-arrow:after {
  content: "";
  background-image: url(https://mcdn.coolmate.me/image/September2023/mceclip0_73.png);
  background-repeat: no-repeat;
  background-size: contain;
  background-position: 50%;
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
}
.slick-list {
  position: relative;
  display: block;
  overflow: hidden;
  margin: 0;
  padding: 0;
  transform: translateZ(0);
}
.slick-track {
  position: relative;
  left: 0;
  top: 0;
  display: block;
  margin-left: auto;
  margin-right: auto;
  transform: translateZ(0);
}

.slick-track:after,
.slick-track:before {
  display: table;
  content: "";
}
.product-promotion-body .slick-next {
  left: auto;
  right: 1rem;
  top: -30px;
}

.slick-slider {
  position: relative;
  display: block;
  box-sizing: border-box;
  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;
  -webkit-touch-callout: none;
  -khtml-user-select: none;
  touch-action: pan-y;
  -webkit-tap-highlight-color: transparent;
}

.slick-prev,
.slick-next {
  font-size: 0;
  line-height: 0;
  position: absolute;
  top: 50%;
  display: block;
  width: 20px;
  height: 20px;
  padding: 0;
  transform: translate(0, -50%);
  cursor: pointer;
  color: transparent;
  border: none;
  outline: none;
  background: transparent;
}

</style>
