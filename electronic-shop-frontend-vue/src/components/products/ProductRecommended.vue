<script setup>
import ProductService from "@/services/product.service";
import { ref } from 'vue';
import { Carousel, Navigation, Pagination, Slide } from 'vue3-carousel';
import 'vue3-carousel/dist/carousel.css';
import ProductCard from './ProductCard.vue';

const products = ref([]);

const retrieveProducts = async () => {
    try {
        const customerInfo = JSON.parse(localStorage.getItem('account'))
        products.value = await ProductService.findRecommendedProducts(customerInfo.id);

        console.log("recommended", products.value)
    } catch (error) {
        console.log(error);
    }
};

const refreshList = () => {
    retrieveProducts();
};

refreshList();
</script>

<template>
    <div class="h2 accordion text-center font-sans text-4xl mb-4 section-container">GỢI Ý SẢN PHẨM</div>
    <div class="section-container">
        <Carousel class="product-slider" :items-to-show="5" :wrap-around="false" :autoplay="0">
            <Slide v-for="product in products" :key="product">
                <ProductCard :product="product" />
            </Slide>
        </Carousel>
    </div>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Prompt:wght@500&display=swap');

.carousel {
    margin-top: 0;
    text-align: start;
}

.products__tab {
    margin-bottom: 1rem;
    margin-top: 4rem;
    display: flex;
}

.products__heading {
    font-size: 28px;
    margin-bottom: 0;
    text-transform: uppercase;
    font-weight: 500;
}

.products__heading span {
    text-transform: capitalize;
    font-size: 1rem;
    text-decoration: underline;
    cursor: pointer;
    float: right;
    margin-top: 12px;
    font-weight: 400;
}

.slick-arrow {
    font-size: 0;
    line-height: 0;
    position: absolute;
    top: 50%;
    padding: 0;
    border: 0;
    border-radius: 1.5rem;
    width: 40px;
    height: 40px;
    z-index: 1;
    -webkit-transform: translate(0, -50%);
    -ms-transform: translate(0, -50%);
    transform: translate(0, -50%);
    justify-content: center;
    align-items: center;
    background-color: #212121;
    border: none;
    outline: none;
}

.slick-arrow.slick-prev {
    right: 100%;
}

.slick-arrow.slick-next {
    left: 100%;
}

.slick-prev::before {
    content: '←';
}

.slick-next::before {
    content: '→';
}

.slick-prev::before,
.slick-next::before {
    position: relative;
    top: -2px;
    font-size: 24px;
    line-height: 1rem;
    opacity: .75;
    color: white;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}


.products__tab-item {
    border-radius: 2.625rem;
    background: #fff;
    color: #212121;
    font-size: 1.125rem;
    padding: 0.5rem 1.5rem;
    opacity: 1;
    border: 1px solid #212121;
    margin-right: 1.5rem;
    white-space: nowrap;
    display: flex;
    cursor: pointer;
    align-items: center;
    font-family: 'Prompt', sans-serif;
    font-weight: 500;
}

.products__tab-item.active {
    background-color: #212121;
    color: #fff;
}
</style>
