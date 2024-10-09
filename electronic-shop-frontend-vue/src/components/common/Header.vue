<template>
    <header class="header">
        <nav class="navbar navbar-expand-sm">
            <!-- Links -->
            <div class="header_logo">
                <router-link to="/home">
                    <img class="rounded-full" src="../../assets/images/logo/logo_bb.jpg" alt="" srcset="" />
                </router-link>
            </div>
            <div class="navbar-nav">
                <div class="nav-item">
                    <router-link :to="{
                        name: 'products',
                    }" class="nav-link">
                        SẢN PHẨM
                        <i class="fa-solid fa-chevron-down dropdown-icon"></i>
                    </router-link>
                    <div class="subnav">
                        <ul class="subnav-list">
                            <li class="subnav-item">
                                <a href=""> Điện thoại </a>
                            </li>
                            <li class="subnav-item">
                                <a href=""> Laptop </a>
                            </li>
                            <li class="subnav-item">
                                <a href=""> Tablet </a>
                            </li>
                            <li class="subnav-item">
                                <a href=""> SmartWatch </a>
                            </li>
                            <li class="subnav-item">
                                <a href=""> Màn hình máy tính </a>
                            </li>
                            <li class="subnav-item">
                                <a href=""> Tai nghe </a>
                            </li>
                            <li class="subnav-item">
                                <a href=""> Loa </a>
                            </li>
                            <li class="subnav-item">
                                <a href=""> Máy in </a>
                            </li>
                            <li class="subnav-item">
                                <a href=""> Bàn phím </a>
                            </li>
                            <li class="subnav-item">
                                <a href=""> Chuột máy tính </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="nav-item">
                    <a class="nav-link" href="#">GIỚI THIỆU</a>
                </div>
                <div class="nav-item">
                    <a class="nav-link" href="#">LIÊN HỆ</a>
                </div>
                <div class="nav-item">
                    <a class="nav-link" href="/branch">CHI NHÁNH</a>
                </div>
            </div>
            <div class="header_actions">
                <div class="header_actions_search-box">
                    <label class="header_actions_search-field">
                        <a href="#" class="header_actions_search-icon">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </a>
                        <input class="header_actions_search-control" type="text" name="search" id="search-input"
                            placeholder="Tìm kiếm sản phẩm..." @click="isSearchActive = true" />
                    </label>
                </div>
                <div class="header_actions_button dropdown-center">
                    <div class="header_actions_button-link dropdown" data-bs-toggle="dropdown" aria-expanded="false"
                        type="button">
                        <i class="fa-solid fa-user"></i>
                    </div>
                    <ul class="dropdown-menu">
                        <li v-if="isLoggedIn"><router-link to="/account/info" class="dropdown-item">Thông tin tài
                                khoản</router-link>
                        </li>
                        <li v-if="isLoggedIn" @click="logOut()"><router-link to="/login" class="dropdown-item">Đăng
                                xuất</router-link>
                        </li>
                        <li v-if="!isLoggedIn"><router-link to="/login" class="dropdown-item">Đăng nhập</router-link>
                        </li>
                    </ul>
                </div>
                <div class="header_actions_button">
                    <router-link to="/cart" class="header_actions_button-link">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </router-link>
                    <span class="cart-count"> {{ cartService.cartQuantity }}</span>
                </div>
                <div class="header-search" :class="isSearchActive ? 'is-active' : ''">
                    <div class="form">
                        <div class="header-search__wrapper">
                            <label class="header-search__field">
                                <input id="input-spotlight" type="text" name="search" placeholder="Tìm kiếm sản phẩm..."
                                    autocomplete="off" class="header-search__control one-whole" v-model="searchText"
                                    @keydown.enter="search">
                                <button class="homepage-search__submit"
                                    style="top: 13px; right: 30px; width: unset; height: unset; z-index: 10;"
                                    @click="search">
                                    <svg width="21" height="21" viewBox="0 0 21 21" fill="none"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M20.8002 19.6905L17.9213 16.5856C19.5193 14.6641 20.3123 12.1989 20.1342 9.70609C19.9561 7.21325 18.8208 4.88587 16.9659 3.21104C15.1109 1.5362 12.68 0.643744 10.182 0.720377C7.68398 0.79701 5.31241 1.83678 3.56359 3.62217C1.81477 5.40756 0.824241 7.80016 0.79931 10.2992C0.774379 12.7983 1.71695 15.2102 3.4298 17.0301C5.14266 18.8501 7.49307 19.9369 9.98907 20.0634C12.4851 20.1898 14.9332 19.346 16.8212 17.7085L19.6462 20.7575C19.7892 20.9041 19.9838 20.9889 20.1884 20.9941C20.3931 20.9992 20.5916 20.9242 20.7418 20.785C20.8919 20.6458 20.9818 20.4535 20.9921 20.2491C21.0025 20.0446 20.9325 19.8442 20.7972 19.6905H20.8002ZM2.57025 10.5415C2.57025 8.96444 3.03792 7.42275 3.91412 6.11143C4.79031 4.80011 6.03567 3.77807 7.49273 3.17454C8.94979 2.57101 10.5531 2.41306 12.0999 2.72074C13.6467 3.02842 15.0675 3.78787 16.1827 4.90306C17.2979 6.01824 18.0574 7.43908 18.365 8.98588C18.6727 10.5327 18.5148 12.136 17.9112 13.5931C17.3077 15.0501 16.2857 16.2955 14.9744 17.1717C13.663 18.0479 12.1214 18.5155 10.5442 18.5155C8.42997 18.5134 6.40288 17.6726 4.90777 16.1777C3.41265 14.6828 2.57159 12.6558 2.56921 10.5415H2.57025Z"
                                            fill="#80949D">
                                        </path>
                                    </svg>
                                </button>
                            </label>
                            <button class="homepage-search__close"
                                style="top: 13px; right: -100px; width: unset; height: unset; z-index: 10;">
                                <svg width="18" height="18" viewBox="0 0 22 22" fill="none"
                                    xmlns="http://www.w3.org/2000/svg" @click.prevent="closeSearch">
                                    <g opacity="0.6">
                                        <path
                                            d="M0.710153 1.39081C1.10215 0.719768 1.8828 0.603147 2.4538 1.13033L20.9665 18.2226C21.5375 18.7498 21.6826 19.7211 21.2906 20.3922V20.3922C20.8986 21.0632 20.118 21.1798 19.547 20.6526L1.03426 3.56039C0.463267 3.0332 0.318158 2.06185 0.710153 1.39081V1.39081Z"
                                            fill="black"></path>
                                        <path
                                            d="M0.821701 20.5854C0.421822 19.9218 0.552504 18.9506 1.11359 18.4163L19.4354 0.967765C19.9965 0.433427 20.7755 0.538253 21.1754 1.2019V1.2019C21.5753 1.86555 21.4446 2.83671 20.8835 3.37105L2.56168 20.8196C2.00059 21.3539 1.22158 21.2491 0.821701 20.5854V20.5854Z"
                                            fill="black"></path>
                                    </g>
                                </svg>
                            </button>
                        </div>
                        <div class="spotlight-header-search__float">
                            <div class="spotlight-search-content is-active">
                                <div class="spotlight-search-content__wrapper">
                                    <div v-if="searchResultProducts.length > 0"
                                        class="spotlight-search-content__inner is-active">
                                        <div class="spotlight-search-content__topkeyword is-active">
                                            <div class="homepage-search__content one-whole" style="display: block;">
                                                <h4 class="homepage-search__description" style="text-align: left;">
                                                    Từ khóa nổi bật ngày hôm nay
                                                </h4>
                                                <div class="homepage-search__buttons">
                                                    <a href="#" class="homepage-search__button"> Iphone 15 promax</a>
                                                    <a href="#" class="homepage-search__button"> Laptop Acer Nitro 5</a>
                                                    <a href="#" class="homepage-search__button"> Giảm giá sốc</a>
                                                    <a href="#" class="homepage-search__button"> Săn sale</a>
                                                    <a href="#" class="homepage-search__button"> iPad</a>
                                                    <a href="#" class="homepage-search__button"> Apple Watch</a>
                                                    <a href="#" class="homepage-search__button"> Giờ vàng giá sốc</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="spotlight-search-content__recentview is-active">
                                            <h4>Sản phẩm đã xem gần đây</h4>
                                            <div>
                                                <div class="grid-view grid--four-columns recent-product-list">

                                                    <div v-for="(item, index) in searchResultProducts" :key="index"
                                                        class="grid__column">
                                                        <router-link :to="{
                                                            name: 'product',
                                                            params: {
                                                                id: item.id,
                                                            },
                                                        }" :product-id="item.id" class="recent-product__item">
                                                            <div class="recent-product__thumbnail">
                                                                <img loading="lazy" :src="item.imageData.base64String"
                                                                    :alt="item.name" class="home-banner">
                                                            </div>

                                                            <div class="recent-product__content">
                                                                <p class="recent-product__title">
                                                                    {{ item.name }}
                                                                </p>
                                                            </div>
                                                        </router-link>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div v-else class="spotlight-header-search is-active">
                                        <div class="spotlight-header-search__suggestions">
                                            <ul id="search-suggestions" class="search-suggestions"></ul>
                                        </div>
                                        <div class="spotlight-header-search__wrapper" style="justify-content: center;">
                                            <div class="text--center"><i>Không tìm thấy kết quả phù hợp!</i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="spotlight-header-search__background" @click="closeSearch"></div>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    </header>
</template>

<script setup lang="ts">
import { ref, onMounted, inject, computed } from 'vue';
import { useProductStore } from '@/stores/productStore';
import { useRouter } from 'vue-router';
import ProductService from "@/services/product.service";
import CartService from "@/services/cart.service";

const router = useRouter();

const productStore = useProductStore()

const { cartService }: { cartService: CartService } = inject('cartService')!;

const isLoggedIn = ref(false);

const isSearchActive = ref(false);

const searchText = ref('');

const handleViewWhenSearch = () => {

}

const logOut = () => {
    // Xóa tài khoản khỏi localStorage
    localStorage.removeItem('account');
    // Đặt trạng thái đăng nhập về false
    isLoggedIn.value = false;
}

const products = ref([]);

const searchResultProducts = computed(() => {
    let regex = new RegExp('^.*' + searchText.value.toLowerCase().trim() + '.*$');
    let from = "àáãảạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệđùúủũụưừứửữựòóỏõọôồốổỗộơờớởỡợìíỉĩịäëïîöüûñçýỳỹỵỷ",
        to = "aaaaaaaaaaaaaaaaaeeeeeeeeeeeduuuuuuuuuuuoooooooooooooooooiiiiiaeiiouuncyyyyy";
    if (searchText.value === '') {
        return products.value.slice(0, 4);
    }
    return (products.value.filter((item) => {
        return regex.test(item.name.toLowerCase());
    })).slice(0, 4);
});

const recentViewProducts = computed(() => {
    return products.value.slice(0, 4);
})

const retrieveProducts = async () => {
    try {
        products.value = await ProductService.getAll();
    } catch (error) {
        console.log(error);
    }
};

const search = () => {
    if (searchText.value.trim() !== '') {
        // console.log(router);
        router.push({ name: 'search', query: { q: searchText.value.trim() } });
        closeSearch();
    }
}

const closeSearch = () => {
    isSearchActive.value = false
};

onMounted(() => {
    retrieveProducts();
    // Kiểm tra localStorage để xác định trạng thái đăng nhập
    const loggedIn = localStorage.getItem('account');
    if (loggedIn) {
        isLoggedIn.value = true;
    } else {
        isLoggedIn.value = false;
    }
});
</script>

<style>
h1,
h2,
h3,
h4,
h5,
h6 {
    margin-top: 0;
    margin-bottom: 0.5rem;
    color: #231f20;
    font-weight: 400;
}

.h4,
h4 {
    font-size: 17px;
}

img {
    text-indent: -9999px;
    color: transparent;
    border-style: none;
    vertical-align: middle;
    max-width: 100%;
    height: auto;
}

img.hover {
    display: none;
}

a {
    background-color: transparent;
    text-decoration: none;
    color: inherit;
    transition: all .2s;
}

.mt-0 {
    margin-top: 0;
}

.one-whole {
    width: 100%;
}

.visible {
    visibility: visible;
    opacity: 1;
    transition: opacity 2s linear;
}

.hidden {
    visibility: hidden;
    opacity: 0;
    transition: visibility 0s 2s, opacity 2s linear;
}

.grid-view {
    display: flex;
    display: -webkit-flex;
    -moz-flex-direction: row;
    flex-direction: row;
    flex-wrap: wrap;
    margin-left: -9px;
    margin-right: -9px;
    padding: 0;
    position: relative;
    float: none;
}

.grid__column {
    position: relative;
    box-sizing: border-box;
    min-height: 1px;
    vertical-align: top;
    margin-left: 0 !important;
    margin-right: 0 !important;
    padding: 9px;
    width: 100%;
}

.grid--four-columns>.grid__column {
    width: 25%;
}

.text--center {
    text-align: center;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }

    to {
        opacity: 1;
    }
}

@keyframes fadeOut {
    from {
        opacity: 1;
    }

    to {
        opacity: 0;
    }
}

@keyframes fade-in-to-upper-right {
    from {
        opacity: 0;
        top: 350px;
        left: 0px;
        scale: 0;
    }

    to {
        opacity: 1;
        top: 0px;
        left: 350px;
        scale: 1;
    }
}

ul {
    padding-left: 0 !important;
}

@media (max-width: 1660px) {
    .spotlight-header-search__wrapper {
        padding: 0 80px;
    }
}

header {
    position: fixed;
    top: 0;
    display: flex;
    background-color: rgb(10 10 10);
    height: 83px;
    z-index: 999;
    width: 100% !important;
}

.header_logo {
    width: 100px;
}

.header_logo img {
    max-height: 60px;
    height: auto;
    cursor: pointer;
}

.navbar {
    padding: 0 64px;
    --bs-navbar-padding-y: 0px !important;
}

.navbar-nav {
    --bs-nav-link-padding-x: 0 !important;
    --bs-nav-link-padding-y: 0 !important;
    --bs-nav-link-color: #fff !important;
    --bs-nav-link-hover-color: #fff;
    height: inherit;
    min-width: 940px;
    padding: 0px;
}

.nav-item {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 31px 16px;
    font-size: 16px;
    cursor: pointer;
    position: relative;
}

.nav-item .dropdown-icon {
    padding-left: 2px;
    position: relative;
    top: -2px;
    font-size: 0.7rem;
}

.nav-item:hover {
    background-color: #3c3c3c;
}

.nav-item>.nav-link {
    font-size: 0.875rem;
    font-weight: 500;
}

.nav-item .subnav {
    display: none;
}

.nav-item:hover .subnav {
    display: flex;
    position: absolute;
    top: 100%;
    left: 0;
    padding: 0;
    min-width: 300px;
    background-color: #ededed;
    /* border-top: 2px solid #ee4266; */
    z-index: 9999;
    animation: fadeIn 0.3s;
}

.subnav .subnav-list {
    list-style-type: none;
    width: 100%;
    box-shadow: 0 0 4px 0 rgba(0, 0, 0, 0.05);
}

.subnav .subnav-item {
    padding: 10px 30px;
}

.subnav .subnav-item:hover {
    background-color: #212121;
}

.subnav-item a {
    text-decoration: none;
    color: #212121;
}

.subnav-item:hover a {
    color: #ededed;
}

.header_actions {
    display: flex;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.5;
    color: #231f20;
    text-align: left;
}

.header_actions_search-field {
    position: relative;
}

.header_actions_search-icon {
    position: absolute;
    top: 13px;
    left: 10px;
    width: unset;
    height: unset;
    z-index: 10;
    text-decoration: none;
}

.header_actions_search-icon i,
.header_actions_button i {
    font-size: 1.4rem;
    vertical-align: middle;
}

.header_actions_search-icon i {
    color: #000;
}

.header_actions_search-icon i:hover,
.header_actions_button i:hover {
    opacity: 0.6;
}

.header_actions_search-control {
    border: 0;
    background-color: #e8e8e8;
    box-shadow: none;
    height: 50px;
    padding: 0 20px 0 40px;
    border-radius: 33px;
}

.header_actions_button {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 48px;
    height: 48px;
}

.header_actions_button i {
    color: #fff;
}

.cart-count {
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 100px;
    position: absolute;
    right: 4px;
    top: 4px;
    width: 15px;
    height: 15px;
    background-color: red;
    color: #fff;
    font-size: 10px;
    font-weight: 700;
    pointer-events: none;
}

.header-search {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0;
    pointer-events: none;
    visibility: hidden;
    background-color: #fff;
    transition: all .3s;
}

.header-search.is-active {
    z-index: 10;
    opacity: 1;
    pointer-events: visible;
    visibility: visible;
}

.header-search>.form {
    width: 100%;
    height: 107px;
    display: flex;
    background: #fff;
}

.header-search__wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    max-width: 532px;
    margin: 0 auto;
    transition: all .3s;
    padding-left: 16px;
    padding-right: 16px;
    position: relative;
}

.header-search__field {
    flex: 1;
    max-width: 100%;
    transition: all .3s;
    position: relative;
}

.header-search__control {
    border: 0;
    background-color: hsla(0, 0%, 83.1%, .4);
    box-shadow: none;
    height: 50px;
    padding: 0 20px;
    border-radius: 33px;
}

.homepage-search__submit {
    position: absolute;
    bottom: 15px;
    right: 15px;
    background-color: #0000;
    border: 0;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
}

.homepage-search__close {
    position: absolute;
    bottom: 15px;
    right: 15px;
    background-color: #0000;
    border: 0;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
}

.spotlight-header-search__float {
    position: fixed;
    width: 100%;
    height: 100%;
    pointer-events: visible;
    transition: all .3s;
    margin-top: 107px;
}

.spotlight-search-content {
    border-bottom: 1px solid #d9d9d9;
    display: none;
    transition: all .2s;
}

.spotlight-search-content.is-active {
    background: #fff;
    display: block;
    width: 1000px;
    overflow: hidden;
    border-radius: 10px;
    margin: 10px auto 0;
}

.spotlight-search-content__wrapper {
    position: relative;
    min-height: 200px;
    background-color: #fff;
    z-index: 10;
}

.spotlight-search-content__inner {
    display: none;
    max-width: 1200px;
    width: 100%;
    margin: 0 auto;
    justify-content: space-between;
    align-items: baseline;
    flex-direction: column;
    row-gap: 50px;
    padding: 50px 80px 20px;
}

.spotlight-search-content__inner.is-active {
    display: flex;
}

.spotlight-search-content__topkeyword {
    display: none;
}

.spotlight-search-content__topkeyword.is-active {
    display: block;
}

.spotlight-header-search {
    opacity: 0;
    pointer-events: none;
    visibility: hidden;
    z-index: 1;
    display: none;
    width: 100%;
}

.spotlight-header-search.is-active {
    display: block;
    opacity: 1;
    pointer-events: visible;
    visibility: visible;
}

.spotlight-header-search__suggestions {
    display: flex;
    align-content: center;
    padding: 20px 80px;
    border-bottom: 1px solid #e6e6e6;
    margin-bottom: 30px;
}

.spotlight-header-search .search-suggestions {
    list-style: none;
    padding: 0;
    margin: 0;
    font-size: 16px;
}

.spotlight-header-search__wrapper {
    padding: 0 80px 25px;
}


.homepage-search__description {
    text-align: center;
    margin-bottom: 0.25rem;
    margin-top: 0.25rem;
}

.homepage-search__buttons {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    justify-content: center;
    gap: 6px;
}

.homepage-search__button,
.product-search {
    display: flex;
    align-items: center;
}

.homepage-search__button {
    justify-content: center;
    padding: 0.475rem 0.75rem;
    border-radius: 1rem;
    border: 1px solid #d9d9d9;
    white-space: nowrap;
    line-height: 1rem;
    font-size: .75rem;
}

.spotlight-search-content__recentview {
    width: 100%;
    height: 422px;
    display: none;
}

.spotlight-search-content__recentview.is-active {
    display: block;
}

.spotlight-search-content__recentview .recent-product__thumbnail {
    max-height: 280px;
    border-radius: 10px;
    overflow: hidden;
}

.spotlight-search-content__recentview h4 {
    font-size: 17px;
    margin-top: 0;
    margin-bottom: 0.5rem;
    color: #231f20;
    font-weight: 400;
}

.spotlight-header-search__background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    transition: all .3s;
    background: rgba(0, 0, 0, .6);
}

input {
    font-family: inherit;
    font-size: 100%;
    line-height: 1.15;
}

.dropdown-item {
    font-size: 14px;
    font-weight: 500;
}

.dropdown-item:focus,
.dropdown-item:hover {
    color: white;
    background-color: black;
    font-weight: 500;
    transition: all 0.1s;
}
</style>
