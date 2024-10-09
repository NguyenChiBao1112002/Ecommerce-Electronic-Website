<script setup lang="ts">
import { ref, computed, onMounted, inject } from 'vue';
import Header from '@/components/common/Header.vue';
import Carousel from '@/components/common/Carousel.vue';
import Banner from '@/components/common/Banner.vue';
import ProductList from '../components/products/ProductList.vue';
import ProductListFixed from '@/components/products/ProductListFixed.vue';
import ProductListByType from '@/components/products/ProductListByType.vue';
import Brands from '@/components/common/Brands.vue';
import CollectionList from '@/components/common/CollectionList.vue';
import CategoryList from '@/components/common/CategoryList.vue';
import Footer from '@/components/common/Footer.vue';

import CartService from "@/services/cart.service";

const { cartService }: { cartService: CartService } = inject('cartService')!;

cartService.getCart();

const collectionList = [
    {
        id: 1,
        material: "APPLE",
        title: "SẢN PHẨM APPLE",
        banner: {
            src: "https://m.media-amazon.com/images/G/01/apple/iPad_Air_Product_Page_Alt_L_5G_Amazon__en-US_01_updated._CB573781543_.jpg",
            text: "Light. Bright. Full of might.",
            content: "Không gì có thể giống iPad!!!",
        },
    },
    {
        id: 2,
        material: "OPPO",
        title: "SẢN PHẨM OPPO",
        banner: {
            src: "https://www.oppo.com/content/dam/oppo/product-asset-library/reno/reno11-series/en/reno11-f-5g/v2/assets/images-kv-mzl-phones-pad-1.png.avif",
            text: "OPPO Reno11F 5G",
            content: "Chuyên Gia Chân Dung",
        }
    },
    {
        id: 3,
        material: "HP",
        title: "SẢN PHẨM HP",
        banner: {
            src: "https://www.hp.com/content/dam/sites/worldwide/homepage/images/banners/VISID-elitebooks-1000-series-desktop_2x.jpg",
            text: "Phá vỡ mọi rào cản với HP Elite x360 1040.",
            content: "Giới thiệu dòng HP EliteBook 1040",
        }
    }
];

const productTypeList = [{
    id: 1,
    title: "ĐIỆN THOẠI NỔI BẬT",
    type: "PHONE",
},
{
    id: 2,
    title: "TABLET NỔI BẬT",
    type: "TABLET",
},
{
    id: 3,
    title: "ĐỒNG HỒ THÔNG MINH",
    type: "SMARTWATCH",
},
{
    id: 4,
    title: "LAPTOP BÁN CHẠY",
    type: "LAPTOP",
},
{
    id: 5,
    title: "MÀN HÌNH MÁY TÍNH",
    type: "SCREEN",
},
{
    id: 6,
    title: "PHỤ KIỆN KHÁC",
    type: "OTHER",
}];

</script>

<template>
    <!-- <main> -->
    <Header />
    <Carousel />
    <ProductList />

    <div v-for="(item, index) in collectionList">
        <Banner :banner="item.banner" :key="index" />
        <ProductListFixed :collection="item" :key="index" />
    </div>

    <div v-for="(item, index) in productTypeList">
        <ProductListByType :collection="item" :key="index" />
    </div>

    <Brands />
    <CollectionList />
    <CategoryList />

    <Footer />
    <!-- </main> -->
</template>
