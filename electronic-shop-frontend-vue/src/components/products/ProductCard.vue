<script setup>
import { computed } from 'vue';

const props = defineProps({
    product: {
        type: Object,
        required: true,
    },
    gridCol: String
})

const VND = new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND',
});

const formatedPrice = computed(() => {
    return VND.format(props.product.price);
});

const formatedSalePrice = computed(() => {
    let salePrice = props.product.price * (1 - props.product.salePercent / 100);
    salePrice = Math.floor(salePrice / 1000);
    salePrice *= 1000;
    return VND.format(salePrice);
})
</script>

<template>
    <div class="product-card card" :class="gridCol">
        <div class="product-card__thumbnail">
            <div class="product-card__image-container">
                <router-link :to="{
        name: 'product',
        params: {
            id: product.id,
        },
    }" :product-id="product.id">
                    <img class="card-img-top" :src="product.imageData.base64String" alt="Card image" style="width:100%">
                </router-link>
            </div>
            <span class="product-card__tags">New</span>
            <div class="product-card__select"></div>
        </div>
        <div class="product-card__content card-body">
            <div class="product-card__options"></div>
            <h3 class="product-card__title card-title">
                <router-link :to="{
        name: 'product',
        params: {
            id: product.id,
        },
    }">
                    {{ product.name }}
                </router-link>
            </h3>
            <p class="product-card__sub-title card-text">{{ product.material }}</p>
            <div class="product-card__prices">
                <div class="product-prices">
                    <span v-if="product.salePercent > 0" style="color: red;margin-left: 10px;">-{{ product.salePercent
                        }}%</span>
                    <del v-if="product.salePercent > 0">{{ formatedPrice }}</del>
                    <ins>{{ formatedSalePrice }}</ins>
                </div>
            </div>
        </div>
    </div>
</template>

<style>
.col-2-4 {
    width: 20%;
}

a {
    background-color: transparent;
    text-decoration: none;
    color: inherit;
    transition: all .2s;
}

.product-card {
    position: relative;
    padding: 9px;
    padding-bottom: 12px;
    border: none;
}

.product-card>* {
    transition: all .3s;
}

.product-card__thumbnail {
    position: relative;
    margin-bottom: 15px;
    border-radius: 8px;
    overflow: hidden;
}

.product-card__image-container {
    position: relative;
}

.product-card__image-container img {
    background-color: transparent;
    text-decoration: none;
    color: inherit;
    transition: all .2s;
}

.product-card__tags {
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    top: 0.625rem;
    right: 0.75rem;
    font-size: .625rem;
    height: 21px;
    padding: 0 10px;
    border-radius: 5px;
    font-weight: 500;
    color: #fff;
    background-color: #2f5acf;
    text-transform: capitalize;
    z-index: 2;
}

.product-card__title {
    font-size: 14px;
    line-height: 1.2em;
    height: 2.4em;
    font-weight: 400;
    margin-bottom: 0.75rem;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
    text-overflow: ellipsis;
}

.product-card__sub-title {
    font-size: 14px;
    color: #0009;
    margin: -10px 0 5px;
}

.product-prices {
    display: flex;
    justify-content: flex-end;
    flex-flow: row-reverse;
    font-size: 14px;
    font-weight: 400;
}

.product-prices span {
    color: red;
    margin-left: 10px;
}

.product-prices del+ins {
    margin-right: 14px;
}

.product-prices del {
    color: #c4c4c4;
}

.product-prices ins {
    text-decoration: none;
    color: #242424;
    font-weight: 700;
}
</style>
