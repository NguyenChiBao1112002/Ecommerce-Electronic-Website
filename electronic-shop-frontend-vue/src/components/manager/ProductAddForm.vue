<template>
    <div class="loader-container" v-if="isLoading"><span class="loader"></span></div>
    <div class="product-form__float" :class="productStore.isShowAddFormClick ? 'is-active' : ''">
        <div class="container">
            <div class="product-form-container">
                <div class="title text-center">Thêm sản phẩm</div>
                <div>
                    <div id="customer-info-block">
                        <div class="grid-view">
                            <div class="grid-column">
                                <label for="productName">Tên sản phẩm:</label>
                                <input v-model="productForAdding.name" type="productName" name="productName"
                                    placeholder="" class="form-control" />
                            </div>
                        </div>
                        <div class="grid-view">
                            <div class="grid-column six-twelfths">
                                <label for="productPrice">Giá:</label>
                                <input v-model="productForAdding.price" type="number" id="productPrice"
                                    name="productPrice" required placeholder="" class="form-control" />
                            </div>
                            <div class="grid-column six-twelfths">
                                <label for="productSalePercent">Giảm giá (%):</label>
                                <input v-model="productForAdding.salePercent" type="number" id="productSalePercent"
                                    name="productSalePercent" required placeholder="" class="form-control" />
                            </div>
                        </div>
                        <div class="grid-view">
                            <div class="grid-column six-twelfths">
                                <label for="productType">Thương hiệu:</label>
                                <input v-model="productForAdding.material" type="text" id="productType"
                                    name="productType" required placeholder="" class="form-control" />
                            </div>
                            <div class="grid-column six-twelfths">
                                <label for="productType">Loại:</label>
                                <input v-model="productForAdding.type" type="text" id="productType" name="productType"
                                    required placeholder="" class="form-control" />
                            </div>
                        </div>
                        <div class="grid-view">
                            <div class="grid-column">
                                <label for="detailImages">Ảnh sản phẩm:</label>
                                <div class="upload__box">
                                    <div class="upload__btn-box">
                                        <label class="upload__btn">
                                            Upload images
                                            <input type="file" 
                                            data-max_length="1" class="upload__inputfile"
                                                @change="handleFileInputChange($event)">
                                        </label>
                                    </div>
                                    <div class="upload__img-wrap">
                                        <div v-for="image in uploadedImages" :key="image.id">
                                            <div class="upload__img-box">
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
                    <button v-if="productStore.isShowAddFormClick" 
                        @click.prevent="isLoading = true; addProduct()"
                        class="mr-2 bg-gradient-to-b from-green-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded w-full mt-3">
                        Thêm
                    </button>
                    <button v-else @click.prevent="isLoading = true; addProduct()"
                        class="mr-2 bg-gradient-to-b from-green-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded w-full mt-3">
                        Sửa
                    </button>
                </div>
                <button class="product-form__close" style="z-index: 10;">
                    <svg width="18" height="18" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"
                        @click.prevent="closeProductAddForm">
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
        <div class="product-form__background" @click="closeProductAddForm"></div>
    </div>

</template>

<script setup lang="ts">
import ProductService from "@/services/product.service";
import { useProductStore } from '@/stores/productStore';
import axios from 'axios';
import { ref } from 'vue';

const emit = defineEmits(['add-product-done']);

const isLoading = ref(false);

interface ProductObject {
    name: String,
    price: number,
    salePercent: number,
    type: String,
    material: String,
}

const productForAdding = ref<ProductObject>({ name: '', price: 0, salePercent: 0, material: '', type: '' });
const uploadedImages = ref<{ id: string | number, url: string }[]>([]);
let changingProductImages: { id: number, file: File }[] = [];
const productStore = useProductStore();

const closeProductAddForm = () => {
    productStore.setIsShowAddFormClick(false);
}

const addProduct = async () => {
    try {
        const formData = new FormData();
        for (let i = 0; i < changingProductImages.length; i++) {
            const file = changingProductImages[i].file;
            formData.append('images', file);
        }
        const response = await axios.post("http://localhost:8080/products", productForAdding.value);
        await ProductService.updateProductImages(response.data.id, formData);
        closeProductAddForm();
        emit('add-product-done');
        isLoading.value = false;
        return response.data;
    } catch (error) {
        console.log(error);
        isLoading.value = false;
    }
}

const handleFileInputChange = async (event) => {
    const files = event.target.files;
    // const newImages: { id: number | string, url: string }[] = [];

    for (let i = 0; i < files.length; i++) {
        // if (uploadedImages.value.length + newImages.length > 1) break;
        const file = files[i];
        const imageUrl = URL.createObjectURL(file);
        // newImages.push({ id: i, url: imageUrl });

        changingProductImages = [{ id: i, file: file }];
        uploadedImages.value = [{ id: i, url: imageUrl }];
    }
    // uploadedImages.value = uploadedImages.value.concat(newImages);
};

const removeImage = (imageId) => {
    uploadedImages.value = [];
    changingProductImages = [];
};

const updateProduct = async () => {
    try {
        const response = await axios.put("http://localhost:8080/products", productForAdding.value);
        closeProductAddForm();
        emit('add-product-done');
        return response.data;
    } catch (error) {
        console.log(error);
    }
}
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
    z-index: 2;
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
    z-index: 2;
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

.loader {
  display: block;
  border-radius: 50%;
  position: relative;
  animation: rotate 1s linear infinite;
  width: 200px;
  height: 200px;
  background: rgba(255, 255, 255, 0.5);
  position: fixed;
  top: 40%;
  left: 40%;
  z-index: 100;
}

.loader::before,
.loader::after {
  content: "";
  box-sizing: border-box;
  position: absolute;
  inset: 0px;
  border-radius: 50%;
  border: 20px solid #e5e3e3;
  animation: prixClipFix 2s linear infinite;
  z-index: 1000;
}

.loader::after {
  border-color: #2424be;
  animation: prixClipFix 2s linear infinite, rotate 0.5s linear infinite reverse;
  inset: 6px;
  z-index: 1000;
}

@keyframes rotate {
  0% {
    transform: rotate(0deg)
  }

  100% {
    transform: rotate(360deg)
  }
}

@keyframes prixClipFix {
  0% {
    clip-path: polygon(50% 50%, 0 0, 0 0, 0 0, 0 0, 0 0)
  }

  25% {
    clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 0, 100% 0, 100% 0)
  }

  50% {
    clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 100% 100%, 100% 100%)
  }

  75% {
    clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 0 100%, 0 100%)
  }

  100% {
    clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 0 100%, 0 0)
  }
}

</style>