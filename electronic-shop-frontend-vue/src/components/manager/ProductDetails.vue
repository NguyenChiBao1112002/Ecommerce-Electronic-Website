<template>
    <ProductDetailAddForm @add-detail-done="addDetailDone()" :product-id="props.productId" />
    <ProductDetailUpdateForm @update-detail-done="updateDetailDone()" :detail-for-updating="selectedProductDetail"
        :product-id="props.productId" />
    <div class="product-detail-table__float" :class="productStore.isShowDetails ? 'is-active' : ''">
        <div class="container" style="overflow-y: scroll;">
            <div class="product-detail-table-container">
                <div>
                    <div class="title text-center fixed-header">Chi tiết sản phẩm</div>
                    <button class="product-detail-table__close" style="z-index: 10;">
                        <svg width="18" height="18" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"
                            @click.prevent="closeDetailTable">
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
                    <div class="w-full flex">
                        <div class="w-1/6 mr-2">
                            <label class="text-gray-700" for="id">
                                ID:
                            </label>
                            <input v-model="selectedProductDetail.id"
                                class="input-id w-full bg-gray-200 text-gray-800 py-2 px-3 rounded-md focus:outline-none">
                        </div>
                        <div class="mr-2 flex items-end">
                            <button @click="activeAddDetailForm"
                                class="mr-2 mb-2 bg-gradient-to-b from-green-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                                Thêm chi tiết
                            </button>
                            <button @click="activeUpdateDetailForm"
                                class="mr-2 mb-2 bg-gradient-to-b from-blue-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                                Cập nhật chi tiết
                            </button>
                            <button @click="handleClickDeleteDetail"
                                class="mr-2 mb-2 bg-gradient-to-b from-red-500 to-pink-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                                Xóa chi tiết
                            </button>
                        </div>
                    </div>
                    <div class="flex items-end mt-2">Tổng số: {{ props.productDetails?.length }}</div>

                </div>
                <div class="relative overflow-x-auto custom-scrollbar" style="max-height: 400px;">
                    <table id="table-data"
                        class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                        <thead
                            class="text-center fixed-header font-sans text-xs text-gray-700 uppercase bg-gray-200 dark:bg-gray-700 dark:text-gray-400">
                            <tr>
                                <th scope="col" class="px-4 py-3">
                                    ID
                                </th>
                                <th scope="col" class="px-4 py-3">
                                    Màu
                                </th>
                                <th scope="col" class="px-4 py-3">
                                    Kích cỡ
                                </th>
                                <th scope="col" class="px-4 py-3">
                                    Hiện có
                                </th>
                                <th scope="col" class="7px-4 py-3">
                                    Đã bán
                                </th>
                                <th scope="col" class="px-4 py-3 text-center">
                                    Ảnh
                                </th>
                            </tr>
                        </thead>
                        <tbody class="text-center">
                            <tr v-for="(item, index) in props.productDetails" :key="index"
                                @click="selectProductDetail(item)"
                                class="row-data border-b dark:bg-gray-800 cursor-pointer">
                                <th scope="row"
                                    class="px-4 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                    {{ item.id ? item.id :
        "Chưa cập nhật" }}
                                </th>
                                <td class="px-4 py-4">
                                    {{ item.color ? item.color :
        "Chưa cập nhật" }}
                                </td>
                                <td class="px-4 py-4">
                                    {{ item.size ? item.size :
        "Chưa cập nhật" }}
                                </td>
                                <td class="px-4 py-4">
                                    {{ item.quantity ? item.quantity :
        "Chưa cập nhật" }}
                                </td>
                                <td class="px-4 py-4">
                                    {{ item.sold >= 0 ? item.sold :
        "Chưa cập nhật" }}
                                </td>
                                <td class="px-4 py-4 d-flex justify-content-center align-items-center">
                                    <img width="80" :src="item.imageLinks[0] ? item.imageLinks[0] :
        'Chưa cập nhật'" alt="">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div v-if="confirmDeleteDetailModalVisible" class="modal modal-delete container">
            <div class="modal-content">
                <span class="close" @click="handleCloseDeleteDetailModal">&times;</span>
                <p>Bạn có chắc về việc xóa chi tiết này không?</p>
                <div class="d-flex justify-content-center">
                    <button class="btn confirm" @click="handleConfirmDeleteDetailSaveChanges">Có</button>
                    <button class="btn cancel" @click="handleCloseDeleteDetailModal">Không</button>
                </div>
            </div>
        </div>
        <div class="product-detail-table__background" @click="closeDetailTable"></div>
    </div>

</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { useProductStore } from '@/stores/productStore';
import axios from 'axios';
import { number } from 'yup';
import ProductDetailAddForm from '@/components/manager/ProductDetailAddForm.vue'
import ProductDetailUpdateForm from '@/components/manager/ProductDetailUpdateForm.vue'

const emit = defineEmits(['add-detail-done', 'update-detail-done', 'reset-details']);

interface ProductObject {
    name: String,
    price: number,
    salePercent: number,
    type: String,
    material: String,
}

interface ProductDetailObject {
    id: number | String,
    color: String,
    size: String,
    quantity: number,
    sold: number,
    imageLinks: string
}

const props = defineProps({
    productId: {
        type: Number
    },
    productDetails: {
        type: Array
    }
});

const selectedProductDetail = ref<ProductDetailObject>({
    id: '',
    color: '',
    size: '',
    quantity: null,
    sold: null,
    imageLinks: [],
});

const selectProductDetail = (detail: DetailObject) => {
    selectedProductDetail.value = { ...detail };
};

const productDetailForAdding = ref<ProductObject>({ name: '', price: 0, salePercent: 0, material: '', type: '' });

const productStore = useProductStore();

const closeDetailTable = () => {
    productStore.setIsShowDetails(false);
}

const productDetails = ref<ProductDetailObject[] | null>(null);

const retrivedDetails = async () => {
    try {
        const response = await axios.get(`http://localhost:8080/products/${props.productId}/details`);
        productDetails.value = response.data;
        productDetails.value.forEach(detail => {
            const imageLinksArray = detail.imageLinks.split(", ");
            detail.imageLinks = imageLinksArray;
        })
    } catch (error) {
        console.log(error);
    }
}

const addDetailDone = () => {
    emit('add-detail-done');
}

const updateDetailDone = () => {
    emit('update-detail-done');
}

const deteleDetail = async () => {
    try {
        const response = await axios.delete(`http://localhost:8080/products/${props.productId}/details/${selectedProductDetail.value.id}`);
        selectedProductDetail.value = {
            id: '',
            color: '',
            size: '',
            quantity: 0,
            sold: 0,
            imageLinks: [],
        }
        emit('reset-details');
        return response;
    } catch (error) {
        console.error('Lỗi khi xóa sản phẩm', error);
    }
}

const activeAddDetailForm = () => {
    productStore.setIsShowAddDetailFormClick(true);
}

const activeUpdateDetailForm = () => {
    productStore.setIsShowUpdateDetailFormClick(true);
}

const confirmDeleteDetailModalVisible = ref(false);

const handleClickDeleteDetail = () => {
    confirmDeleteDetailModalVisible.value = true;
}

const handleConfirmDeleteDetailSaveChanges = async () => {
    await deteleDetail();
    confirmDeleteDetailModalVisible.value = false;
}

const handleCloseDeleteDetailModal = () => {
    confirmDeleteDetailModalVisible.value = false;
}
</script>

<style>
.fixed-header {
    position: sticky;
    top: 0;
    z-index: 1;
}

.custom-scrollbar::-webkit-scrollbar {
    width: 5px;
    height: 5px;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
    background-color: rgba(0, 0, 0, 0.2);
    border-radius: 3px;
}

.custom-scrollbar::-webkit-scrollbar-track {
    background-color: rgba(0, 0, 0, 0.1);
    border-radius: 3px;
}

.row-data:hover {
    background-color: rgb(237, 239, 238) !important;
}

.row-data.font-bold {
    border: 2px solid blue;
}

.found {
    background-color: rgb(196, 199, 199);
}

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

.product-detail-table-container {
    position: relative;
    width: 1000px;
    border: 1px solid #ccc;
    border-radius: 16px;
    background-color: #f9f9f9;
    padding: 20px;
    z-index: 2;
}

.product-detail-table-container label,
.product-detail-table-container input {
    display: block;
    margin-bottom: 10px;
}

.product-detail-table-container input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
}

.product-detail-table-container input[type="submit"]:hover {
    background-color: #0056b3;
}

.product-detail-table__float {
    display: none;
    top: 92px;
    position: fixed;
    width: 100%;
    height: 100%;
    pointer-events: visible;
    transition: all .3s;
    z-index: 2;
}

.product-detail-table__float.is-active {
    display: block;
    opacity: 1;
    pointer-events: visible;
    visibility: visible;
}

.product-product-detail-table-content {
    background: #fff;
    display: block;
    width: 1000px;
    overflow: hidden;
    border-radius: 10px;
    margin: 10px auto 0;
}

.product-product-detail-table-content__wrapper {
    position: relative;
    min-height: 200px;
    background-color: #fff;
    z-index: 10;
}

.product-detail-table__close {
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

.product-detail-table__background {
    position: absolute;
    top: -16px;
    left: 0;
    width: 100%;
    height: 100%;
    transition: all .3s;
    background: rgba(0, 0, 0, .6);
}

.modal-delete {
    top: 0;
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