<template>
    <div class="product-form__float" :class="productStore.isShowUpdateDetailFormClick ? 'is-active' : ''">
        <div class="container">
            <div class="product-form-container">
                <div class="title text-center">Cập nhật chi tiết</div>
                <div>
                    <div id="customer-info-block">
                        <div class="grid-view">
                            <div class="grid-column">
                                <label for="detailColor">Màu:</label>
                                <input v-model="detailForUpdating!.color" type="text" id="detailColor"
                                    name="detailColor" placeholder="" class="form-control" />
                            </div>
                        </div>
                        <div class="grid-view">
                            <div class="grid-column six-twelfths">
                                <label for="detailSize">Kích cỡ:</label>
                                <input v-model="detailForUpdating!.size" type="text" id="detailSize" name="detailSize"
                                    required placeholder="" class="form-control" />
                            </div>
                            <div class="grid-column six-twelfths">
                                <label for="detailQuantity">Hiện có:</label>
                                <input v-model="detailForUpdating!.quantity" type="number" id="detailQuantity"
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
                                                @change="handleFileInputChange($event)">
                                        </label>
                                    </div>
                                    <div class="upload__img-wrap">
                                        <div v-for="(image, index) in uploadedImages" :key="index">
                                            <div class="upload__img-box">
                                                <div class="img-bg" :style="{ backgroundImage: 'url(' + image + ')' }">
                                                    <div class="upload__img-close" @click="removeImage(index)"></div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button @click.prevent="handleClickSaveDetail"
                        class="mr-2 bg-gradient-to-b from-blue-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded w-full mt-3">
                        Cập nhật
                    </button>
                </div>
                <button class="product-form__close" style="z-index: 10;">
                    <svg width="18" height="18" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"
                        @click.prevent="closeDetailUpdateForm">
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
        <div v-if="confirmUpdateDetailModalVisible" class="modal container">
            <div class="modal-content">
                <span class="close" @click="handleCloseUpdateDetailModal">&times;</span>
                <p>Bạn có chắc về việc lưu những thay đổi này không?</p>
                <div class="d-flex justify-content-center">
                    <button class="btn confirm" @click="handleConfirmUpdateDetailSaveChanges">Có</button>
                    <button class="btn cancel" @click="handleCloseUpdateDetailModal">Không</button>
                </div>
            </div>
        </div>
        <div class="product-form__background" @click="closeDetailUpdateForm"></div>
    </div>

</template>

<script setup lang="ts">
import { ref, computed, onBeforeMount, watchEffect } from 'vue';
import { useProductStore } from '@/stores/productStore';
import ProductService from "@/services/product.service";
import axios from 'axios';

const emit = defineEmits(['update-detail-done']);

const props = defineProps({
    productId: {
        type: Number
    },
    detailForUpdating: {
        type: Object
    }
});

interface ProductDetailObject {
    id: number,
    color: String,
    size: String,
    quantity: number,
    sold: number,
    imageLinks: String
}

const imageLinksModel = computed(() => props.detailForUpdating!.imageLinks);

const productDetails = ref<ProductDetailObject[] | null>(null);

const uploadedImages = ref<String[]>([]);

let changingProductDetailImages: { id: number, file: File }[] = [];

const productStore = useProductStore();

const closeDetailUpdateForm = () => {
    productStore.setIsShowUpdateDetailFormClick(false);
}

watchEffect(() => {
    if (props.detailForUpdating!.imageLinks) {
        uploadedImages.value = [...props.detailForUpdating!.imageLinks];
    }
});

const updateDetail = async () => {
    try {
        if (!props.detailForUpdating) {
            throw new Error('props.detailForUpdating.value is not assigned');
        }
        const formData = new FormData();
        for (let i = 0; i < uploadedImages.value.length; i++) {
            const response = await fetch(uploadedImages.value[i]);
            const blob = await response.blob();
            formData.append('images', blob);
        }
        for (let i = 0; i < changingProductDetailImages.length; i++) {
            const file = changingProductDetailImages[i].file;
            formData.append('images', file);
        }
        productDetails.value = { ...props.detailForUpdating, imageLinks: uploadedImages.value.join(', ') };
        const response = await axios.put(`http://localhost:8080/products/${props.productId}/details/${productDetails.value.id}`, productDetails.value);
        await ProductService.updateImages(props.productId, productDetails.value!.id, formData);
        closeDetailUpdateForm();
        emit('update-detail-done');
        return response.data;
    } catch (error) {
        console.error(error);
    }
}
const handleFileInputChange = async (event) => {
    const files = event.target.files;
    const newImages: String[] = [];

    for (let i = 0; i < files.length; i++) {
        // if (uploadedImages.value.length + newImages.length > 4) break;
        const file = files[i];
        const imageUrl = URL.createObjectURL(file);
        newImages.push(imageUrl);
        changingProductDetailImages.push({ id: i, file: file });
    }
    uploadedImages.value = uploadedImages.value.concat(newImages);
};

const removeImage = (imageId) => {
    uploadedImages.value = uploadedImages.value.filter((image, index) => index !== imageId);
    changingProductDetailImages = changingProductDetailImages.filter(file => file.id !== imageId);
};

const confirmUpdateDetailModalVisible = ref(false);

const handleClickSaveDetail = () => {
    confirmUpdateDetailModalVisible.value = true;
}

const handleConfirmUpdateDetailSaveChanges = async () => {
    await updateDetail();
    confirmUpdateDetailModalVisible.value = false;
}

const handleCloseUpdateDetailModal = () => {
    confirmUpdateDetailModalVisible.value = false;
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

.modal {
    display: flex;
    position: absolute;
    top: -16px;
    left: 0;
    width: 100%;
    height: 100%;
    transition: all .3s;
    background: rgba(0, 0, 0, .6);
}

.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 36px 36px 12px 36px;
    border: 1px solid #888;
    width: 30%;
    text-align: center;
}

.close {
    position: absolute;
    top: 0;
    right: 0;
    padding: 0 16px;
    color: #aaa;
    float: left;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.btn {
    display: inline-block;
    padding: 10px 20px;
    margin: 10px;
    border: 1px solid #ccc;
    cursor: pointer;
}

.btn.confirm {
    background-color: green;
    /* Màu xanh lá */
    color: white;
    /* Màu chữ trắng */
}

.btn.confirm:hover {
    background-color: darkgreen;
    /* Màu xanh lá đậm khi hover */
}

.btn.cancel {
    background-color: red;
    /* Màu đỏ */
    color: white;
    /* Màu chữ trắng */
}

.btn.cancel:hover {
    background-color: darkred;
    /* Màu đỏ đậm khi hover */
}
</style>