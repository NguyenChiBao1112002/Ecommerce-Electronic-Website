<script setup>
import { ref, reactive } from 'vue';
import Header from '@/components/common/Header.vue';
import Footer from '@/components/common/Footer.vue';
import ProductFilter from '@/components/products/ProductFilter.vue';
import ProductsCollection from '@/components/products/ProductsCollection.vue';

const materialList = reactive([
    {
        name: "Áo",
        isActive: false
    },
    {
        name: "Quần",
        isActive: false
    },
    {
        name: "Áo khoác",
        isActive: false
    },
    {
        name: "Phụ kiện",
        isActive: false
    },
]);

const toggleActive = (index) => {
    const item = materialList[index];
    item.isActive = !item.isActive;
}

</script>

<template>
    <Header />
    <main class="site-collections">
        <div class="site-collections__container">
            <h1 class="collections-filter__heading">Tất cả sản phẩm</h1>
            <div class="running-products__head">
                <a href="#" id="hideLeftContentButton" class="tab-header__item">
                    <span>
                        <i class="fa-solid fa-sliders"></i>
                        Ẩn bộ lọc
                    </span>
                </a>
                <div class="tab-header tab-collection-get-header" style="display: none;">
                    <a href="#" data-param="ao" class="tab-header__item is-active">Áo</a>
                    <a href="#" data-param="quan" class="tab-header__item">Quần</a>
                    <a href="#" data-param="ao-khoac" class="tab-header__item">Áo khoác</a>
                    <a href="#" data-param="tat-ca-phu-kien" class="tab-header__item">Phụ kiện</a>
                </div>
            </div>
        </div>
        <div class="collection-grid">
            <div class="collection-grid__left">
                <ProductFilter />
            </div>
            <div class="collection-grid__right">
                <ProductsCollection />
            </div>
        </div>

    </main>
    <Footer />
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Prompt:wght@500&display=swap');

html {
    -webkit-text-size-adjust: 100%;
}

body {
    font-size: 14px;
    font-weight: 400;
    line-height: 1.5;
    color: #231f20;
    text-align: left;
}

.site-collections__container {
    padding-left: 64px;
    padding-right: 64px;
    max-width: 1920px;
    width: 100%;
    margin: 0 auto;
    margin-top: 132px;
}

.collections-filter__heading {
    font-family: 'Prompt', sans-serif;
    padding: 0;
    text-transform: uppercase;
    font-weight: 600;
    font-size: 24px;
    line-height: 30px;
    margin-bottom: 10px;
    margin-right: 15px;
}

.running-products__head {
    display: flex;
    align-items: center;
}

#hideLeftContentButton {
    min-width: 130px;
    margin-bottom: 20px;
}

#hideLeftContentButton span {
    display: flex;
    align-items: center;
}

#hideLeftContentButton span i {
    margin-right: 5px;
}

.tab-header {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.tab-header__item {
    background: #DBDBDB;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-flow: column;
    min-width: 100px;
    padding: 10px 12px;
    border-radius: 41px;
    margin: 0 10px 0 0;
    color: #000;
    text-align: center;
    font-size: 14px;
}

.tab-header__item.is-active,
.tab-header__item:hover {
    background-color: #000;
    color: #fff;
}

.collection-grid {
    display: flex;
    justify-content: center;
    margin-top: 1rem;
}

.collection-grid__right {
    width: 100%;
}
</style>