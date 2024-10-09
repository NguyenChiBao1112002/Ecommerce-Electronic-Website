<script setup>
import { ref, reactive, computed } from 'vue';
import ProductCard from './ProductCard.vue';
import ProductService from "@/services/product.service";
const props = defineProps({
    collection: {
        type: Object,
    }
});

const products = ref([]);

const productPerRow = 'col-3';

const retrieveProducts = async () => {
    try {
        products.value = await ProductService.getAll();
    } catch (error) {
        console.log(error);
    }
};

//
const filteredProducts = computed(() => {
    return products.value.filter((product) => product.type === props.collection.type).slice(0, 4);
});

const refreshList = () => {
    retrieveProducts();
};

refreshList();
</script>

<template>
    <div class="section-container">
        <div class="products__heading d-flex justify-content-between mt-5">
            <p class="">{{ collection.title }}</p>
            <span>Xem thêm</span>
        </div>
        <div class="product-list row">
            <ProductCard v-for="product in filteredProducts" :product="product" :gridCol="productPerRow" />
        </div>
    </div>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Prompt:wght@500&display=swap');

.products__heading {
    font-size: 28px;
    margin-bottom: 0;
    text-transform: uppercase;
    font-weight: 500;
}

.products__heading span {
    text-transform: none;
    font-size: 1rem;
    text-decoration: underline;
    cursor: pointer;
    float: right;
    margin-top: 12px;
    font-weight: 400;
}
</style>
