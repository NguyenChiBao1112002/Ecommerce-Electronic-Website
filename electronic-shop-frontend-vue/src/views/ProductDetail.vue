<script setup lang="ts">
import { ref, reactive, computed, onBeforeMount, inject } from 'vue';
import { useRoute } from 'vue-router';
import _ from 'lodash';
import Header from '@/components/common/Header.vue';
import Footer from '@/components/common/Footer.vue';
import ProductReview from '@/components/products/ProductReview.vue';
import ProductService from "@/services/product.service";
import ProductRecommended from '@/components/products/ProductRecommended.vue';

const { cartService }: { cartService: CartService } = inject('cartService')!;

let count = ref(1);

const decrease = () => {
    if (count.value == 1) {
        count.value = 1;
    } else count.value--;
}

const increase = () => {
    if (count.value == 99) {
        count.value = 99;
    } else count.value++;
}

const route = useRoute();

const product = reactive({});

const productDetails = ref([]);

const productDetailActive = reactive({});

const productColors = ref([]);

const productsByColor = ref([]);

const activeColor = reactive({});

const activeColorInGallery = ref({});

const activeSize = reactive({});

const sizes = [
    {
        size: 'S',
        height: "1m50 - 1m59",
        weight: "48kg - 54kg",
        isChecked: false
    },
    {
        size: 'M',
        height: "1m60 - 1m65",
        weight: "55kg - 61kg",
        isChecked: false
    },
    {
        size: 'L',
        height: "1m66 - 1m72",
        weight: "62kg - 68kg",
        isChecked: false
    },
    {
        size: 'XL',
        height: "1m72 - 1m77",
        weight: "69kg - 75kg",
        isChecked: false
    },
    {
        size: '2XL',
        height: "1m77 - 1m83",
        weight: "76kg - 82kg",
        isChecked: false
    },
    {
        size: '3XL',
        height: "1m83 - 1m90",
        weight: "83kg - 89kg",
        isChecked: false
    },
];

const sizeOrder = ["S", "M", "L", "XL", "2XL", "3XL"];

const productSizes = ref([]);

const productId = computed(() => {
    return parseInt(route.params.id);
});

// const breadcrumbItems = [
//     {
//         text: 'Trang chủ',
//         href: "#"
//     },
//     {
//         text: 'Áo thể thao',
//         active: true,
//     }
// ];

const VND = new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND',
});

const productPrice = computed(() => {
    return product.value.price;
})

const formatedPrice = computed(() => {
    return VND.format(product.value.price);
});

const formatedSalePrice = computed(() => {
    let salePrice = product.value.price * (1 - product.value.salePercent / 100);
    salePrice = Math.floor(salePrice / 1000);
    salePrice *= 1000;
    return VND.format(salePrice);
})

const modifyColorLink = (url) => {
    const pattern = /\/width=\d+,height=\d+,quality=\d+/;
    const modifiedURL = url?.replace(pattern, "/format=auto");
    return modifiedURL;
}

const toggleActiveRadio = (index, list) => {
    const item = list[index];
    list.forEach(item => {
        item.isActive = false;
    });
    item.isActive = true;
    activeColorInGallery.value = item;
}

const getColorActive = (detail) => {
    activeColor.value = Object.assign(activeColor.value,
        {
            'color': detail.color,
            'imageLinks': (detail.imageLinks?.split(", ")).map((item) => ({
                'link': item,
                'isActive': false,
            })),
            'colorImage': detail.colorImage
        }
    );
    activeColor.value.imageLinks[0].isActive = true;
    activeColorInGallery.value = activeColor.value.imageLinks[0];
    productsByColor.value = productDetails.value.filter((item) => item.color == detail.color);
    productSizes.value = _.uniqWith(productsByColor.value.map(({ size }) => ({ size })), _.isEqual);
    productSizes.value = productSizes.value.map((item) => {
        const matchedSize = sizes.find((size) => size.size === item.size);
        if (matchedSize) {
            return matchedSize;
        } else {
            return item;
        }
    });
    productSizes.value.sort((a, b) => sizeOrder.indexOf(a.size) - sizeOrder.indexOf(b.size));
    productSizes.value.forEach((item) => item.isChecked = false);
}

const getSizeActive = (index, sizeValue) => {
    productSizes.value.forEach((item) => item.isChecked = false);
    productSizes.value.at(index).isChecked = true;
    productDetailActive.value = productsByColor.value.find((item) => item.size == sizeValue);
}

const retrieveProduct = async (id) => {
    try {
        product.value = await ProductService.get(id);
    } catch (error) {
        console.log(error);
    }
};

const retrieveAllProductDetails = async (productId) => {
    try {
        productDetails.value = await ProductService.getAllDetails(productId);
        retrieveProductDetail(productId.value, 0)
        productColors.value = _.uniqWith(productDetails.value.map(({ color, imageLinks, colorImage }) =>
            ({ color, imageLinks, colorImage })
        ), _.isEqual);
        productsByColor.value = productDetails.value.filter((detail) =>
            (detail.color === productColors.value.at(0).color));
        productSizes.value = _.uniqWith(productsByColor.value.map(({ size }) =>
            ({ size })
        ), _.isEqual);
        productSizes.value = productSizes.value.map((item) => {
            const matchedSize = sizes.find((size) => size.size === item.size);
            if (matchedSize) {
                return matchedSize;
            } else {
                return item;
            }
        })
        productSizes.value.sort((a, b) => sizeOrder.indexOf(a.size) - sizeOrder.indexOf(b.size));
        productSizes.value.forEach((item) => item.isChecked = false);
    } catch (error) {
        console.log(error);
    }
};

const retrieveProductDetail = async (productId, id) => {
    try {
        // let detailId = id;
        // if (productDetails.value[0] !== undefined) {
        let detailId = productDetails.value[0].id;
        // }
        productDetailActive.value = await ProductService.getDetail(productId, detailId);
        activeColor.value = {
            'color': productDetailActive.value.color,
            'imageLinks': (productDetailActive.value?.imageLinks.split(", ")).map((item) => ({
                'link': item,
                'isActive': false,
            })),
            'colorImage': productDetailActive.value.colorImage
        };
        activeColor.value.imageLinks[0].isActive = true;
        activeColorInGallery.value = activeColor.value.imageLinks[0];
    } catch (error) {
        console.log(error);
    }
};

const addToCart = async () => {

    var toastContainer = document.getElementById('addCartMessage')!;
    toastContainer.style.display = 'none';
    toastContainer.style.display = '';

    setTimeout(function () {
        toastContainer.style.display = 'none';
    }, 1500);
    await cartService.addProductDetailToCart(productDetailActive.value, count.value);
};

onBeforeMount(() => {
    retrieveProduct(productId.value);
    retrieveAllProductDetails(productId.value);
    retrieveProductDetail(productId.value, 1);

});


</script>

<template>
    <Header />
    <!-- <div class="fixed top-35 bg-green-100 text-green-700 p-6 text-center text-lg z-50 rounded-md" role="alert"
        id="addCartMessage" style="right: 10px; margin-top: 15px; display: none;">
        <span class="font-medium">Thêm sản phẩm vào giỏ hàng thành công!</span>
    </div> -->
    <div class="fixed mt-24 left-1/2 transform -translate-x-1/2 -translate-y-full bg-green-100 text-green-700 p-6 text-center text-lg z-50 rounded-md"
        role="alert" id="addCartMessage" style="display: none;">
        <span class="font-medium">Thêm sản phẩm vào giỏ hàng thành công!</span>
    </div>
    <main class="product-single">
        <section class="product-single__information">
            <div class="product-single__container">
                <div class="breadcrumb">
                    <ol class="page-breadcrumb breadcrumb-list">
                        <li>
                            <a href="" class="breadcrumb-item">Trang chủ</a>
                        </li>
                        <li>
                            <a href="" class="breadcrumb-item">Áo Thể Thao Nam</a>
                        </li>
                    </ol>
                </div>
                <div class="product-single__wrapper">
                    <div class="product-single__images">
                        <div class="product-single__thumbnails">
                            <div class="product-single__inner">
                                <div class="thumbnails">
                                    <a href="#" class="image">
                                        <img :src="modifyColorLink(activeColorInGallery.link)"
                                            :alt="product.value?.name">
                                    </a>
                                </div>
                            </div>
                            <div class="thumbs">
                                <div class="product-single__gallery product-single__gallery-slider">
                                    <div class="product-single__gallery-list draggable">
                                        <div class="product-single__gallery-track"
                                            style="opacity: 1; width: 240px; transform: translate3d(0px, 0px, 0px);">
                                            <div v-for="(item, index) in activeColor.value.imageLinks" :key="index"
                                                class="image image-lazyload is-current product-single__gallery-slide"
                                                :class="item.isActive ? 'product-single__gallery-current' : ''"
                                                style="width: 40px;"
                                                @click="toggleActiveRadio(index, activeColor.value.imageLinks)">
                                                <img loading="lazy" :src="item.link"
                                                    :alt="productDetailActive.value?.name">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="product-single__summary">
                        <div class="product-single__sticky">
                            <h1 class="product-single__title">
                                {{ product.value?.name }}
                                <span class="product-grid__sub-title">Mỏng nhẹ</span>
                            </h1>
                            <a href="#" class="product-single__ratings scroll-to-step">
                                <div class="reviews-rating">
                                    <div class="reviews-rating__star is-active"></div>
                                    <div class="reviews-rating__star is-active"></div>
                                    <div class="reviews-rating__star is-active"></div>
                                    <div class="reviews-rating__star is-active"></div>
                                    <div class="reviews-rating__star is-half"></div>
                                    <div class="reviews-rating__count">
                                        (2)
                                    </div>
                                </div>
                                <div style="margin: 0px 20px;">
                                    |
                                </div>
                                <div class="reviews-rating__label">
                                    Đã bán (web): 20 </div>
                            </a>
                            <div class="product-single__price-infomation">
                                <div class="product-single__prices">
                                    <ins class="product-single__regular-price">{{ formatedSalePrice }}</ins>
                                    <div v-if="product.value.salePercent > 0">
                                        <del class="product-single__compare-price">{{ formatedPrice }}</del>
                                        <span class="product-single__percent-price">-{{ product.value.salePercent
                                            }}%</span>
                                    </div>
                                </div>
                            </div>
                            <div class="product-single__addtocart">
                                <form action="">
                                    <div class="product-single__options">
                                        <div class="product-single__option">
                                            <div class="option-heading">
                                                <span class="option-heading__title">
                                                    Màu sắc:
                                                    <span class="text--bold">{{ activeColor.value.color }}</span>
                                                </span>
                                            </div>
                                            <div class="option-select option-select--color">
                                                <label v-for="(item, index) in productColors" :key="index + 1"
                                                    class="option-select__item option-select__item--color">
                                                    <div class="option-select__inner">
                                                        <input type="radio" name="color" :value="item.color"
                                                            :checked="index === 0" @click="getColorActive(item)">
                                                        <span class="checkmark checkmark--color"
                                                            :style="{ backgroundImage: 'url(' + item.colorImage + ')' }"></span>
                                                    </div>
                                                </label>
                                                <!-- <label class="option-select__item option-select__item--color den">
                                                    <div class="option-select__inner">
                                                        <input type="radio" name="color" value="den">
                                                        <span class="checkmark checkmark--color den"
                                                            style="background-image: url(&quot;https://media.coolmate.me/cdn-cgi/image/width=160,height=160,quality=80,format=auto/uploads/October2023/mau_vai_combo-2.jpg&quot;);"></span>
                                                    </div>
                                                </label>
                                                <label class="option-select__item option-select__item--color xam-nhat">
                                                    <div class="option-select__inner">
                                                        <input type="radio" name="color" value="xam-nhat">
                                                        <span class="checkmark checkmark--color xam-nhat"
                                                            style="background-image: url(&quot;https://media.coolmate.me/cdn-cgi/image/width=160,height=160,quality=80,format=auto/uploads/January2024/xamnhatz_copyv2.jpg&quot;);"></span>
                                                    </div>
                                                </label> -->
                                            </div>
                                        </div>
                                        <div class="product-single__option">
                                            <div class="option-heading">
                                                <span class="option-heading__title">
                                                    Kích thước:
                                                    <span class="text--bold"></span>
                                                    <span class="product-option-size shorts_size"></span>
                                                </span>
                                                <a href="#" class="option-heading__sizeguide">
                                                    Hướng dẫn chọn size
                                                </a>
                                            </div>
                                            <div class="option-select option-select--shorts_size">
                                                <label v-for="(item, index) in productSizes" :key="index"
                                                    class="option-select__item option-size"
                                                    @click="getSizeActive(index, item.size)">
                                                    <div class="option-select__inner">
                                                        <input type="radio" name="shorts_size" :checked="item.isChecked"
                                                            :value="item.size">
                                                        <span class="checkmark">{{ item.size }}</span>
                                                    </div>
                                                    <div class="option-size-tooltip">
                                                        <div class="option-size-tooltip__arrow"></div>
                                                        <div class="option-size-tooltip__inner">
                                                            <span> {{ item.height }}</span>
                                                            <br>
                                                            <span> {{ item.weight }}</span>
                                                        </div>
                                                    </div>
                                                </label>
                                                <!-- <label class="option-select__item option-size">
                                                    <div class="option-select__inner">
                                                        <input type="radio" name="shorts_size" value="m" data-title="M">
                                                        <span class="checkmark">M</span>
                                                    </div>
                                                    <div class="option-size-tooltip">
                                                        <div class="option-size-tooltip__arrow"></div>
                                                        <div data-size-height="1m60 - 1m65"
                                                            data-size-weight="55kg - 61kg" data-size-type=""
                                                            class="option-size-tooltip__inner">
                                                            <span> 1m60 - 1m65</span>
                                                            <br>
                                                            <span> 55kg - 61kg</span>
                                                        </div>
                                                    </div>
                                                </label>
                                                <label class="option-select__item option-size">
                                                    <div class="option-select__inner">
                                                        <input type="radio" name="shorts_size" value="l" data-title="L">
                                                        <span class="checkmark">L</span>
                                                    </div>
                                                    <div class="option-size-tooltip">
                                                        <div class="option-size-tooltip__arrow"></div>
                                                        <div data-size-height="1m66 - 1m72"
                                                            data-size-weight="62kg - 68kg" data-size-type=""
                                                            class="option-size-tooltip__inner">
                                                            <span> 1m66 - 1m72</span>
                                                            <br>
                                                            <span> 62kg - 68kg</span>
                                                        </div>
                                                    </div>
                                                </label>
                                                <label class="option-select__item option-size">
                                                    <div class="option-select__inner">
                                                        <input type="radio" name="shorts_size" value="xl"
                                                            data-title="XL">
                                                        <span class="checkmark">XL</span>
                                                    </div>
                                                    <div class="option-size-tooltip">
                                                        <div class="option-size-tooltip__arrow"></div>
                                                        <div data-size-height="1m72 - 1m77"
                                                            data-size-weight="69kg - 75kg" data-size-type=""
                                                            class="option-size-tooltip__inner">
                                                            <span> 1m72 - 1m77</span>
                                                            <br>
                                                            <span> 69kg - 75kg</span>
                                                        </div>
                                                    </div>
                                                </label>
                                                <label class="option-select__item option-size">
                                                    <div class="option-select__inner">
                                                        <input type="radio" name="shorts_size" value="2xl"
                                                            data-title="2XL">
                                                        <span class="checkmark">2XL</span>
                                                    </div>
                                                    <div class="option-size-tooltip">
                                                        <div class="option-size-tooltip__arrow"></div>
                                                        <div data-size-height="1m77 - 1m83"
                                                            data-size-weight="76kg - 82kg" data-size-type=""
                                                            class="option-size-tooltip__inner">
                                                            <span> 1m77 - 1m83</span>
                                                            <br>
                                                            <span> 76kg - 82kg</span>
                                                        </div>
                                                    </div>
                                                </label> <label class="option-select__item option-size">
                                                    <div class="option-select__inner">
                                                        <input type="radio" name="shorts_size" value="3xl"
                                                            data-title="3XL"> <span class="checkmark">3XL
                                                        </span>
                                                    </div>
                                                    <div class="option-size-tooltip">
                                                        <div class="option-size-tooltip__arrow"></div>
                                                        <div data-size-height="1m83 - 1m90"
                                                            data-size-weight="83kg - 89kg" data-size-type=""
                                                            class="option-size-tooltip__inner">
                                                            <span> 1m83 - 1m90</span>
                                                            <br>
                                                            <span> 83kg - 89kg</span>
                                                        </div>
                                                    </div>
                                                </label> -->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-single__actions">
                                        <div class="product-single__quantity">
                                            <div class="quantity">
                                                <div class="quantity__reduce" @click="decrease()">-</div>
                                                <input type="number" :value="count" max="99" min="1"
                                                    class="quantity__control">
                                                <div class="quantity__augure" @click="increase()">+</div>
                                            </div>
                                        </div>
                                        <div class="product-single__button" id="showToast" @click.prevent="addToCart()">
                                            <a href="#" class="cart-button">Thêm vào giỏ hàng</a>
                                        </div>
                                    </div>
                                </form>

                            </div>
                            <div class="product-shipping-info">
                                <div class="product-shipping-info__wrapper">
                                    <h4>Miễn phí giao hàng nhanh toàn quốc cho đơn hàng trên 200.000đ</h4>
                                    <ul>
                                        <li>
                                            <svg width="28" height="28" viewBox="0 0 28 28" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" clip-rule="evenodd"
                                                    d="M11.0539 7.97635C12.4497 6.72799 14.2825 5.96922 16.289 5.96922C20.6591 5.96922 24.2078 9.56811 24.2078 14C24.2078 18.4319 20.6591 22.0308 16.289 22.0308C14.2825 22.0308 12.4497 21.272 11.0539 20.0236C10.7153 19.7201 10.1964 19.7522 9.89716 20.0967C9.59788 20.4401 9.63065 20.9652 9.96924 21.2687C11.6546 22.7773 13.8675 23.6923 16.289 23.6923C21.5635 23.6923 25.8462 19.349 25.8462 14C25.8462 8.65094 21.5635 4.30768 16.289 4.30768C13.8675 4.30768 11.6546 5.22263 9.96924 6.73131C9.63065 7.03482 9.59788 7.55986 9.89716 7.90325C10.1964 8.24774 10.7153 8.27986 11.0539 7.97635Z"
                                                    fill="#2F5ACF"></path>
                                                <path fill-rule="evenodd" clip-rule="evenodd"
                                                    d="M14.8516 9.5921V13.5993C14.8516 13.7986 14.9307 13.99 15.072 14.1302L18.2777 17.336C18.5702 17.6295 19.0471 17.6295 19.3396 17.336C19.6331 17.0434 19.6331 16.5666 19.3396 16.2741L16.3543 13.2877V9.5921C16.3543 9.17736 16.0176 8.84076 15.6029 8.84076C15.1882 8.84076 14.8516 9.17736 14.8516 9.5921Z"
                                                    fill="#2F5ACF"></path>
                                                <path fill-rule="evenodd" clip-rule="evenodd"
                                                    d="M2.90528 11.2451H8.91603C9.33077 11.2451 9.66738 10.9085 9.66738 10.4937C9.66738 10.079 9.33077 9.74237 8.91603 9.74237H2.90528C2.49053 9.74237 2.15393 10.079 2.15393 10.4937C2.15393 10.9085 2.49053 11.2451 2.90528 11.2451Z"
                                                    fill="#2F5ACF"></path>
                                                <path fill-rule="evenodd" clip-rule="evenodd"
                                                    d="M3.90711 14.7513H9.91786C10.3326 14.7513 10.6692 14.4147 10.6692 14C10.6692 13.5853 10.3326 13.2487 9.91786 13.2487H3.90711C3.49236 13.2487 3.15576 13.5853 3.15576 14C3.15576 14.4147 3.49236 14.7513 3.90711 14.7513Z"
                                                    fill="#2F5ACF"></path>
                                                <path fill-rule="evenodd" clip-rule="evenodd"
                                                    d="M4.90882 18.2576H10.9196C11.3343 18.2576 11.6709 17.921 11.6709 17.5063C11.6709 17.0915 11.3343 16.7549 10.9196 16.7549H4.90882C4.49407 16.7549 4.15747 17.0915 4.15747 17.5063C4.15747 17.921 4.49407 18.2576 4.90882 18.2576Z"
                                                    fill="#2F5ACF"></path>
                                            </svg>
                                            Nội thành Hà Nội và HCM nhận hàng trong 1-2 ngày
                                        </li>
                                        <li>
                                            <svg width="32" height="29" viewBox="0 0 32 29" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <g clip-path="url(#clip0_796_10786)">
                                                    <path
                                                        d="M28.7062 8.64788L18.964 3.29844C18.7943 3.20529 18.5885 3.20529 18.4188 3.29844L14.7553 5.31006C14.6726 5.33307 14.5954 5.37533 14.5299 5.43374L8.67664 8.64788C8.49543 8.74744 8.38281 8.93772 8.38281 9.14437V10.3024H1.8479C1.53505 10.3024 1.28149 10.5562 1.28149 10.8688C1.28149 11.1817 1.53505 11.4352 1.8479 11.4352H8.38281V13.4743H5.13549C4.82264 13.4743 4.56908 13.7281 4.56908 14.0407C4.56908 14.3535 4.82264 14.6071 5.13549 14.6071H8.38281V17.5524H3.625C3.31215 17.5524 3.05859 17.8062 3.05859 18.1188C3.05859 18.4317 3.31215 18.6852 3.625 18.6852H8.38281V19.8435C8.38281 20.0501 8.49543 20.2404 8.67664 20.34L18.4188 25.6894C18.5038 25.7361 18.5976 25.7593 18.6914 25.7593C18.7852 25.7593 18.879 25.7361 18.964 25.6894L28.7062 20.34C28.8874 20.2404 29 20.0501 29 19.8435V17.307C29 16.9944 28.7464 16.7406 28.4336 16.7406C28.1207 16.7406 27.8672 16.9944 27.8672 17.307V19.5083L19.2578 24.2358V14.829L21.9958 13.3256V15.7116C21.9958 15.912 22.1016 16.0974 22.2739 16.1992C22.3626 16.2517 22.4624 16.278 22.5622 16.278C22.656 16.278 22.7501 16.2548 22.8352 16.2079L24.923 15.0589C25.1037 14.9593 25.2161 14.7693 25.2161 14.5626V11.5573L27.8672 10.1017V12.7758C27.8672 13.0886 28.1207 13.3422 28.4336 13.3422C28.7464 13.3422 29 13.0886 29 12.7758V9.14437C29 8.93772 28.8874 8.74744 28.7062 8.64788ZM18.125 24.2358L9.51562 19.5083V10.1017L18.125 14.829V24.2358ZM18.6914 13.8478L10.1261 9.14437L12.818 7.66618L21.3836 12.3696L18.6914 13.8478ZM22.5604 11.7233L13.9949 7.0199L14.9235 6.51014L23.4888 11.2135L22.5604 11.7233ZM24.0833 14.2279L23.1286 14.7533V12.7037L24.0833 12.1793V14.2279ZM24.6657 10.5672L16.1003 5.86386L18.6914 4.44121L27.2568 9.14437L24.6657 10.5672Z"
                                                        fill="#2F5ACF"></path>
                                                    <path
                                                        d="M28.4336 14.4752C28.2847 14.4752 28.1384 14.5352 28.0331 14.6412C27.9278 14.7465 27.8672 14.8921 27.8672 15.0416C27.8672 15.1905 27.9278 15.3368 28.0331 15.4421C28.1384 15.5474 28.2847 15.608 28.4336 15.608C28.5825 15.608 28.7287 15.5474 28.8341 15.4421C28.9394 15.3368 29 15.1905 29 15.0416C29 14.8921 28.9394 14.7465 28.8341 14.6412C28.7287 14.5352 28.5825 14.4752 28.4336 14.4752Z"
                                                        fill="#2F5ACF"></path>
                                                    <path
                                                        d="M1.37818 17.5524H0.566406C0.253555 17.5524 0 17.8062 0 18.1188C0 18.4317 0.253555 18.6852 0.566406 18.6852H1.37818C1.69103 18.6852 1.94459 18.4317 1.94459 18.1188C1.94459 17.8062 1.69103 17.5524 1.37818 17.5524Z"
                                                        fill="#2F5ACF"></path>
                                                    <path
                                                        d="M3.43652 14.0407C3.43652 13.8918 3.3759 13.7458 3.27036 13.6404C3.16505 13.5349 3.01902 13.4743 2.87012 13.4743C2.72099 13.4743 2.57497 13.5349 2.46965 13.6404C2.36367 13.7458 2.30371 13.8918 2.30371 14.0407C2.30371 14.1898 2.36367 14.3358 2.46965 14.4411C2.57497 14.5465 2.72099 14.6071 2.87012 14.6071C3.01902 14.6071 3.16505 14.5467 3.27036 14.4411C3.3759 14.3358 3.43652 14.1898 3.43652 14.0407Z"
                                                        fill="#2F5ACF"></path>
                                                </g>
                                                <defs>
                                                    <clipPath id="clip0_796_10786">
                                                        <rect width="29" height="29" fill="white"></rect>
                                                    </clipPath>
                                                </defs>
                                            </svg>
                                            Ở tỉnh thành khác nhận hàng từ 2-5 ngày
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="product-single__policy">
                                <div class="product-policy">
                                    <div class="product-policy__item">
                                        <div class="product-policy__icon">
                                            <img src="https://www.coolmate.me/images/icons/icon3.svg"
                                                alt="Đổi trả với số điện thoại">
                                        </div>
                                        <span class="product-policy__title">
                                            Đổi trả cực dễ chỉ cần số
                                            <br>
                                            điện thoại
                                        </span>
                                    </div>
                                    <div class="product-policy__item">
                                        <div class="product-policy__icon">
                                            <img src="https://www.coolmate.me/images/icons/icon5.svg"
                                                alt="Đổi hàng trong 60 ngày">
                                        </div>
                                        <span class="product-policy__title">
                                            60 ngày đổi trả vì bất kỳ lý do gì
                                        </span>
                                    </div>
                                    <div class="product-policy__item">
                                        <div class="product-policy__icon">
                                            <img src="https://www.coolmate.me/images/icons/icon2.svg"
                                                alt="Hotline 1900.27.27.37" style="width: 25px;">
                                        </div>
                                        <span class="product-policy__title">
                                            Hotline 1900.27.27.37 hỗ
                                            <br>
                                            trợ từ 8h30 - 22h mỗi ngày
                                        </span>
                                    </div>
                                    <div class="product-policy__item">
                                        <div class="product-policy__icon">
                                            <img src="https://www.coolmate.me/images/icons/icon1.svg"
                                                alt="Trả hàng tận nơi">
                                        </div>
                                        <span class="product-policy__title">
                                            Đến tận nơi nhận hàng trả,
                                            <br>
                                            hoàn tiền trong 24h
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
        <ProductRecommended />
        <ProductReview :productId="productId" />
    </main>
    <Footer />
</template>

<style>
body {
    font-size: 14px;
    font-weight: 400;
    line-height: 1.5;
    color: #231f20;
    text-align: left;
}

.text--bold {
    font-weight: 700;
}

.cart-button {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    height: 40px;
    border-radius: 16px;
    border: 2px solid #000;
    background-color: #000;
    color: #fff;
    padding: 0 30px;
    transition: all .2s;
    cursor: pointer;
}

.product-single {
    padding-top: 30px;
    margin-top: 82px;
}

.product-single__information {
    padding-bottom: 30px;
    margin-bottom: 100px;
}

.product-single__container {
    max-width: 1120px;
    padding-left: 0;
    padding-right: 0;
    width: 100%;
    margin: 0 auto;
}

.breadcrumb {
    padding-left: 10px;
    padding-right: 25px;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.5;
    color: #231f20;
    text-align: left;
}

.breadcrumb .page-breadcrumb {
    display: flex;
    padding: 0;
    margin: 0;
}

.breadcrumb .page-breadcrumb li {
    list-style: none;
}

.breadcrumb .page-breadcrumb li a {
    color: grey;
}

.breadcrumb .page-breadcrumb li:last-of-type a {
    color: #000;
}

.breadcrumb .page-breadcrumb li+li:before {
    content: "/";
    display: inline-block;
    margin: 0 5px;
}

.product-single__wrapper {
    display: flex;
    max-width: 100%;
    margin: 0 auto;
    justify-content: center;
}

.product-single__images {
    position: sticky;
    width: 42%;
    flex: unset;
    top: 30px;
    height: 100%;
    padding: 0 10px;
}

.product-single__thumbnails {
    padding-top: 0;
    position: relative;
}

.product-single__inner:before {
    content: "";
    background-image: url(https://www.coolmate.me/images/zoom-in-icon.svg?9367bf9df81bf29177515e819646ae05);
    width: 25px;
    height: 25px;
    position: absolute;
    right: 15px;
    top: 15px;
    z-index: 1;
    background-repeat: no-repeat;
    background-size: contain;
    pointer-events: none;
}

.product-single__thumbnails .thumbnails {
    position: relative;
    display: block;
}

.product-single__thumbnails .thumbnails a {
    width: 451px;
    position: relative;
    left: 0px;
    top: 0px;
    z-index: 999;
    opacity: 1;
}

.product-single__thumbnails .thumbnails .image {
    position: relative;
    overflow: hidden;
    border-radius: 8px;
    cursor: zoom-in;
}

.product-single__thumbnails .thumbs {
    position: absolute;
    top: 0;
    left: -55px;
    z-index: 2;
}

.product-single__gallery {
    width: 50px;
}

.product-single__gallery-list,
.product-single__gallery-slider {
    position: relative;
    display: block;
}

.product-single__gallery-slider {
    box-sizing: border-box;
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
    touch-action: pan-y;
    -webkit-tap-highlight-color: transparent;
}

.product-single__gallery.product-single__gallery-slider .product-single__gallery-list {
    max-height: 400px;
    padding-right: 10px;
    overflow-y: auto;
    /* overflow-x: hidden; */
    /* -webkit-overflow-scrolling: touch; */
}

.product-single__gallery.product-single__gallery-slider .product-single__gallery-list::-webkit-scrollbar {
    width: 3px;
    height: 5px;
}

.product-single__gallery.product-single__gallery-slider .product-single__gallery-list::-webkit-scrollbar-thumb {
    background-color: rgba(0, 0, 0, 0.2);
    border-radius: 3px;
}

.product-single__gallery.product-single__gallery-slider .product-single__gallery-list::-webkit-scrollbar-track {
    background-color: rgba(0, 0, 0, 0.1);
    border-radius: 3px;
}

.product-single__gallery-slider .product-single__gallery-list,
.product-single__gallery-slider .product-single__gallery-track {
    /* transform: translateZ(0); */
}

.product-single__gallery-list {
    overflow: hidden;
    margin: 0;
    padding: 0;
}

.product-single__gallery.product-single__gallery-slider .product-single__gallery-track {
    display: flex;
    transform: none !important;
    flex-flow: column !important;
}

.product-single__gallery-track {
    position: relative;
    left: 0;
    top: 0;
    display: block;
    margin-left: auto;
    margin-right: auto;
}

.product-single__gallery-track:after,
.product-single__gallery-track:before {
    content: "";
    display: table;
}

.product-single__gallery .image.product-single__gallery-current {
    opacity: 1;
}

.product-single__gallery .image {
    position: relative;
    display: block;
    width: 48px;
    height: 58px;
    overflow: hidden;
    border-radius: 4px;
    opacity: .4;
    transition: all .3s;
    cursor: pointer;
}

.product-single__gallery .image+.image {
    margin-top: 13px;
}

.product-single__gallery .image img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    -o-object-fit: cover;
    object-fit: cover;
}

.product-single__gallery-slide img {
    display: block;
}

.product-single__summary {
    width: 60%;
    padding: 0 35px;
}

.product-single__title {
    font-size: 32px;
    line-height: 1.25em;
    font-weight: 600;
    margin-bottom: 20px;
}

.product-single__title h1 {
    margin-top: 0;
}

.product-single__summary .product-grid__sub-title {
    font-size: 18px;
    display: block;
    margin-top: -0.5rem !important;
    font-weight: normal;
    color: #0009;
    margin: -10px 0 5px;
}

.product-single__ratings {
    display: flex;
    align-items: center;
    font-size: 12px;
    line-height: 15px;
    letter-spacing: .03em;
    font-weight: 400;
    margin-bottom: 15px;
}

.product-single__ratings a {
    background-color: transparent;
    text-decoration: none;
    color: inherit;
    transition: all .2s;
}

.reviews-rating {
    display: flex;
    align-items: center;
    margin-left: -3px;
    margin-right: -3px;
}

.reviews-rating__star.is-active,
.reviews-rating__star.is-full {
    background-image: url(https://www.coolmate.me/images/star.svg?2a5188496861d26e5547c524320ec875);
}

.reviews-rating__star.is-half {
    background-image: url(https://www.coolmate.me/images/star-half.svg?8aea9e9938db110e66ea06732737184a);
}

.product-single__ratings .reviews-rating__label {
    margin-left: 5px;
}

.product-single__price-infomation {
    margin-bottom: 20px;
}

.product-single__prices {
    font-weight: 400;
    font-size: 24px;
    line-height: 20px;
    letter-spacing: .03em;
    display: flex;
    align-items: center;
}

.product-single__prices ins {
    text-decoration: none;
    font-weight: 500;
}

.product-single__prices del {
    color: #c4c4c4;
    margin-left: 14px;
}

.product-single__prices span {
    color: #ff3102;
    font-size: 80%;
    margin-left: 5px;
}

.product-single__addtocart {
    padding-bottom: 35px;
    border-bottom: 1px solid #d9d9d9;
}

.product-single__option {
    position: relative;
    transition: all .3s;
}

.option-heading__title {
    display: flex;
    align-items: center;

}

.product-single__options .option-heading__title span.text--bold {
    margin-left: 5px;
}

.product-single__options .option-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 14px;
    font-weight: 300;
    line-height: 1.5;
    color: #231f20;
    text-align: left;
}

.product-single__options .option-select {
    position: unset;
    display: flex;
    flex-wrap: wrap;
    margin-left: -6px;
    margin-right: -6px;
}

.product-single__options .option-select__item {
    padding: 6px;
    min-width: 16.6666666667%;
}

.product-single__options .option-select__item--color {
    position: relative;
    overflow: hidden;
    min-width: 65px;
}

.product-single__options .option-select__inner {
    position: relative;
    overflow: hidden;
}

.product-single__options .option-select__item input {
    display: none;
}

.product-single__options .option-select__item input:checked~.checkmark {
    background-color: #000;
    color: #fff;
}

.product-single__options .option-select__item input:checked~.checkmark:before,
.product-single__options .option-select__item input:checked~.checkmark:after {
    opacity: 1;
}

.product-single__options .option-select__item .checkmark--color {
    background-size: cover;
    background-repeat: no-repeat;
    background-position: 50%;
    height: 32px;
    max-width: 51px;
}

.product-single__options .option-select__item .checkmark--color:before {
    border: 4px solid #fff;
}

.product-single__options .option-select__item .checkmark--color:after {
    border: 2px solid #2f5acf;
}

.product-single__options .option-select__item .checkmark--color:before,
.product-single__options .option-select__item .checkmark--color:after {
    content: "";
    position: absolute;
    width: 100%;
    height: 100%;
    border-radius: 1.125rem;
    opacity: 0;
    pointer-events: none;
    transition: all .3s;
}

.product-single__options .option-heading__sizeguide {
    color: #2f5acf;
    text-decoration: underline;
}

.product-single__options .option-select__item.option-size {
    position: relative;
}

.product-single__options .option-select__item.option-size:hover .option-size-tooltip {
    visibility: visible;
}

.product-single__options .option-select__item .checkmark {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 32px;
    border-radius: 16px;
    background-color: #d9d9d9;
    color: #000;
    transition: all .3s;
    cursor: pointer;
    position: relative;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
    padding-left: 5px;
    padding-right: 5px;
}

.product-single__options .option-size-tooltip {
    visibility: hidden;
    position: absolute;
    z-index: 2;
    left: -2px;
    top: 100%;
}

.product-single__options .option-size-tooltip__arrow {
    position: absolute;
    width: 0;
    height: 0;
    border-color: transparent;
    border-style: solid;
}

.product-single__options .option-size-tooltip__inner {
    background-color: #fff !important;
    color: #000 !important;
    box-shadow: 0 0 10px 0 rgba(0, 0, 0, .0666666667);
    border: 1px solid #d9d9d9;
    padding: 5px 15px;
    border-radius: 8px;
    white-space: nowrap;
    font-size: 14px;
}

.product-single__options .option-size-tooltip__inner:before {
    background-color: #fff;
    box-shadow: -1px -1px 1px 0 hsla(0, 0%, 69.8%, .4);
    content: "\A0";
    display: block;
    width: 8px;
    height: 8px;
    position: absolute;
    left: 0;
    right: 0;
    top: -5px;
    transform: rotate(45deg);
    -moz-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    -o-transform: rotate(45deg);
    -webkit-transform: rotate(45deg);
    margin: 2px auto auto;
}

.product-single__actions {
    padding-top: 15px;
    display: flex;
    align-items: center;
    margin-top: 2.5rem;
}

.quantity {
    display: flex;
    width: 100px;
    height: 40px;
    border: 1px solid #000;
    border-radius: 1.8rem;
    font-weight: 500;
    font-size: 18px;
    line-height: 23px;
}

.quantity__augure,
.quantity__reduce {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 35px;
    height: 100%;
    line-height: 1em;
    cursor: pointer;
}

.quantity input {
    position: relative;
    left: 7%;
    border: 0;
    background-color: transparent;
    pointer-events: none;
    text-align: center;
    flex: 1;
    max-width: 40px;
}

.product-single__button {
    flex: 1;
    padding-left: 14px;
}

.product-single__button .cart-button {
    position: relative;
    width: 100%;
    border-radius: 1.5rem;
    transition: all .3s;
    user-select: none;
}

.product-single__button .cart-button:before {
    content: "";
    display: inline-block;
    width: 18px;
    height: 18px;
    background-image: url(https://www.coolmate.me/images/icon-cart.svg?708f2c22fb85099a3e6641a2a81b3b67);
    background-size: contain;
    background-repeat: no-repeat;
    background-position: 50%;
    margin-right: 7px;
}

.product-shipping-info {
    margin-top: 1rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #d9d9d9;
}

.product-shipping-info__wrapper {
    background: #F0F0F0;
    padding: 26px 20px;
    border-radius: 6px;
    gap: 16px;
}

.product-shipping-info h4 {
    font-size: 14px;
    font-weight: 600;
    line-height: 18px;
    letter-spacing: 0;
    text-align: left;
    margin-top: 0;
    margin-bottom: 0.5rem;
    color: #231f20;
}

.product-shipping-info ul {
    margin: 0;
    padding: 0;
}

.product-shipping-info ul li {
    display: flex;
    align-items: center;
    list-style: none;
    font-size: 14px;
}

.product-shipping-info ul li+li {
    margin-top: 0.25rem;
}

.product-shipping-info ul li svg {
    width: 28px;
    height: 28px;
    margin-right: 0.25rem;
}

.product-single__policy {
    padding-top: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid #d9d9d9;
}

.product-policy {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    font-weight: 400;
    font-size: 12px;
    line-height: 15px;
    text-align: center;
    letter-spacing: .03em;
}

.product-policy__item {
    width: 50%;
    display: flex;
    flex-flow: row;
    text-align: left;
    justify-content: flex-start;
    align-items: center;
    padding-top: 15px;
    padding-bottom: 15px;
}

.product-policy__icon {
    position: relative;
    width: 35px;
    height: 35px;
    flex: 0 0 35px;
    margin: 0 0.25rem 0 0;
}

.product-policy__icon img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    -o-object-fit: contain;
    object-fit: contain;
}

.product-policy__title {
    flex: 1;
}
</style>
