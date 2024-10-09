<template>
    <div class="loader-container" v-if="isLoading"><span class="loader"></span></div>
    <div class="product-form__float" :class="productStore.isShowAddDetailFormClick ? 'is-active' : ''">
        <div class="container">
            <div class="product-form-container">
                <div class="title text-center">Thêm chi tiết</div>
                <div>
                    <div id="customer-info-block">
                        <div class="grid-view">
                            <div class="grid-column">
                                <label for="detailColor">Màu:</label>
                                <input v-model="detailForAdding.color" type="text" id="detailColor" name="detailColor"
                                    placeholder="" class="form-control" />
                            </div>
                        </div>
                        <div class="grid-view">
                            <div class="grid-column six-twelfths">
                                <label for="detailSize">Kích cỡ:</label>
                                <input v-model="detailForAdding.size" type="text" id="detailSize" name="detailSize"
                                    required placeholder="" class="form-control" />
                            </div>
                            <div class="grid-column six-twelfths">
                                <label for="detailQuantity">Hiện có:</label>
                                <input v-model="detailForAdding.quantity" type="number" id="detailQuantity"
                                    name="detailQuantity" required placeholder="" class="form-control" />
                            </div>
                        </div>
                        <div class="grid-view">
                            <div class="grid-column">
                                <label for="detailImages">Ảnh sản phẩm:</label>
                                <div class="upload__box">
                                    <div class="upload__btn-box">
                                        <label class="upload__btn">
                                            Upload images
                                            <input type="file" multiple data-max_length="5" class="upload__inputfile"
                                                @change="handleFileInputChange($event, index)">
                                        </label>
                                    </div>
                                    <div class="upload__img-wrap">
                                        <div v-for="image in uploadedImages" :key="image.id">
                                            <div class="upload__img-box" v-show="image.productDetailIndex == index">
                                                <div class="img-bg"
                                                    :style="{ backgroundImage: 'url(' + image.url + ')' }">
                                                    <div class="upload__img-close" @click="removeImage(image.id)"></div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button @click.prevent="isLoading = true; addDetail()"
                        class="mr-2 bg-gradient-to-b from-green-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded w-full mt-3">
                        Thêm
                    </button>
                </div>
                <button class="product-form__close" style="z-index: 10;">
                    <svg width="18" height="18" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"
                        @click.prevent="closeDetailAddForm">
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
        </div>
        <div class="product-form__background" @click="closeDetailAddForm"></div>
    </div>

</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useProductStore } from '@/stores/productStore';
import ProductService from "@/services/product.service";
import axios from 'axios';

const emit = defineEmits(['add-detail-done']);

const isLoading = ref(false);

const props = defineProps({
    productId: {
        type: Number
    }
});

interface ProductDetailObject {
    id: number,
    color: String,
    size: String,
    quantity: number,
    sold: number,
    imageLinks: string
}

const productDetails = ref<ProductDetailObject[] | null>(null);

const detailForAdding = ref<any>({ color: '', size: '', quantity: null, sold: 0, imageLinks: '' });
const uploadedImages = ref<{ productDetailIndex: number, id: number, url: string }[]>([]);
let changingProductDetailImages: { id: number, file: File }[] = [];
const productStore = useProductStore();

const closeDetailAddForm = () => {
    productStore.setIsShowAddDetailFormClick(false);
}

const addDetail = async () => {
    try {
        const formData = new FormData();
        for (let i = 0; i < changingProductDetailImages.length; i++) {
            const file = changingProductDetailImages[i].file;
            formData.append('images', file);
        }
        const response = await ProductService.postDetail(props.productId, detailForAdding.value, formData);
        closeDetailAddForm();
        emit('add-detail-done');
        isLoading.value = false;
        return response.data;
    } catch (error) {
        console.log(error);
        isLoading.value = false;
    }
}

const handleFileInputChange = async (event, index) => {
    const files = event.target.files;
    const newImages: { productDetailIndex: number, id: number, url: string }[] = [];

    for (let i = 0; i < files.length; i++) {
        if (uploadedImages.value.length + newImages.length > 4) break;
        const file = files[i];
        const imageUrl = URL.createObjectURL(file);
        newImages.push({ productDetailIndex: index, id: i, url: imageUrl });

        changingProductDetailImages.push({ id: i, file: file });
    }
    console.log(changingProductDetailImages)
    uploadedImages.value = uploadedImages.value.concat(newImages);
};

const removeImage = (imageId) => {
    uploadedImages.value = uploadedImages.value.filter(image => image.id !== imageId);
    changingProductDetailImages = changingProductDetailImages.filter(file => file.id !== imageId);
};
</script>

<style>
.title {
    font-size: 30px;
    font-weight: 700;
    margin: 1rem 0 1rem;
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

.grid-column {
    position: relative;
    box-sizing: border-box;
    min-height: 1px;
    vertical-align: top;
    margin-left: 0 !important;
    margin-right: 0 !important;
    padding: 9px;
    width: 100%;
}

.six-twelfths {
    width: 50%;
}

.four-twelfths {
    width: 33.333%;
}

.grid:after {
    content: "";
    display: table;
    clear: both;
}

.form-control {
    background: #fff;
    border: 1px solid #d9d9d9;
    box-sizing: border-box;
    height: 40px;
    width: 100%;
    padding: 5px 20px;
    transition: all 0.2s;
}

.form-control:focus,
.form-control:active {
    border-color: inherit !important;
    -webkit-box-shadow: none !important;
    box-shadow: none !important;
    outline: none !important;
    border: 1px solid #2f5acf !important;
}

body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

.container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 88vh;
    margin: 0;
}

.product-form-container {
    position: relative;
    width: 800px;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 16px;
    background-color: #f9f9f9;
    z-index: 3;
}

.product-form-container label,
.product-form-container input {
    display: block;
    margin-bottom: 10px;
}

.product-form-container input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
}

.product-form-container input[type="submit"]:hover {
    background-color: #0056b3;
}

.product-form__float {
    display: none;
    top: 92px;
    position: fixed;
    width: 100%;
    height: 100%;
    pointer-events: visible;
    transition: all .3s;
    z-index: 3;
}

.product-form__float.is-active {
    display: block;
    opacity: 1;
    pointer-events: visible;
    visibility: visible;
}

.product-product-form-content {
    background: #fff;
    display: block;
    width: 800px;
    overflow: hidden;
    border-radius: 10px;
    margin: 10px auto 0;
}

.product-product-form-content__wrapper {
    position: relative;
    min-height: 200px;
    background-color: #fff;
    z-index: 10;
}

.product-form__close {
    position: absolute;
    height: 0;
    top: 24px;
    right: 16px;
    background-color: #0000;
    border: 0;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
}

.product-form__background {
    position: absolute;
    top: -16px;
    left: 0;
    width: 100%;
    height: 100%;
    transition: all .3s;
    background: rgba(0, 0, 0, .6);
}

.upload__box {
    padding: 9px;
}

.upload__inputfile {
    width: .1px;
    height: .1px;
    opacity: 0;
    overflow: hidden;
    position: absolute;
    z-index: -1;
}

.upload__btn {
    display: inline-block;
    font-weight: 400;
    color: #fff;
    text-align: center;
    min-width: 30px;
    padding: 5px;
    transition: all .3s ease;
    cursor: pointer;
    border: 2px solid;
    background-color: #4045ba;
    border-color: #4045ba;
    border-radius: 10px;
    line-height: 18px;
    font-size: 13px;

}

.upload__btn:hover {
    background-color: unset;
    color: #4045ba;
    transition: all .3s ease;
}

.upload__btn-box {
    margin-bottom: 10px;
}

.upload__img-wrap {
    display: flex;
    flex-wrap: wrap;
    margin: 0 -10px;
}

.upload__img-box {
    width: 100px;
    padding: 0 10px;
}

.upload__img-close {
    width: 15px;
    height: 15px;
    border-radius: 50%;
    background-color: rgba(0, 0, 0, 0.5);
    position: absolute;
    top: 5px;
    right: 5px;
    text-align: center;
    line-height: 10px;
    z-index: 1;
    cursor: pointer;
}

.upload__img-close:after {
    content: '\2716';
    font-size: 10px;
    color: white;
}

.img-bg {
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    position: relative;
    padding-bottom: 100%;
}

</style>