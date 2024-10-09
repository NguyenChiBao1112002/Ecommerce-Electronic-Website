<script setup lang="ts">
import { ref, reactive, computed } from 'vue';
import 'vue3-carousel/dist/carousel.css'
import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel'
import ProductCard from './ProductCard.vue';
import ProductService from "@/services/product.service";
import { useProductStore } from '@/stores/productStore';

const productStore = useProductStore()

const productPerRow = 'col-2-4';

const tabItems = reactive([
    {
        name: "newProducts",
        label: "Sản phẩm mới",
        isActive: true,
    },
    {
        name: "bestSellerProducts",
        label: "Bán chạy nhất",
        isActive: false,
    },
])

const toggleActive = (index) => {
    const item = tabItems[index];
    tabItems.forEach((tabItem) => {
        tabItem.isActive = false;
    });
    item.isActive = true;
    productStore.setFilteredType(item.name);
}

const products = ref([]);

const retrieveProducts = async () => {
    try {
        products.value = await ProductService.getAll();
    } catch (error) {
        console.log(error);
    }
};

// const filteredProducts = computed(() => {
//     if (!productStore.filteredType) return products.value;
//     switch (productStore.filteredType) {
//         case "newProducts":
//             return mostSaleProducts.value;
//             break;
//         case "bestSellerProducts":
//             return leastSaleProducts.value;
//             break;
//         default:
//             break;
//     }

// })

const filteredProducts = computed(() => {
    let filtered = products.value;
    if (productStore.filteredType === "newProducts") {
        filtered = mostSaleProducts.value;
    } else if (productStore.filteredType === "bestSellerProducts") {
        filtered = leastSaleProducts.value;
    }
    const startIndex = Math.max(filtered.length - 8, 0); // Bắt đầu lấy từ vị trí này
    return filtered.slice(startIndex); // Lấy 15 sản phẩm cuối cùng
    // return filtered.slice(0, 15); // Giới hạn số lượng sản phẩm không vượt quá 15
})

const mostSaleProducts = computed(() => {
    return [...products.value].sort((a, b) => b.salePercent - a.salePercent);
});

const leastSaleProducts = computed(() => {
    return [...products.value].sort((a, b) => a.salePercent - b.salePercent);
});

const refreshList = () => {
    retrieveProducts();
};

refreshList();

import { defineComponent } from 'vue';

</script>

<template>
    <div class="section-container">
        <div class="products__tab">
            <a v-for="(item, index) in tabItems" :key="index" href="" class="products__tab-item" @click.prevent
                @click="toggleActive(index)" :class="{ active: item.isActive }">{{ item.label }}</a>
        </div>
        <!-- <div class="product-slider row">
            <ProductCard v-for="product in filteredProducts" :product="product" :gridCol="productPerRow" />
        </div> -->
        <Carousel class="product-slider" :items-to-show="5" :wrap-around="true" :autoplay="0">
            <Slide v-for="product in filteredProducts" :key="product">
                <ProductCard :product="product" />
            </Slide>
            <template #addons>
                <Navigation />
                <Pagination />
            </template>
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
