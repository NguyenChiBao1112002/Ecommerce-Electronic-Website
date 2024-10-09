<template>
    <ProductAddForm @add-product-done="retriveProducts" />
    <ProductUpdateForm @update-product="retriveProducts" :product-for-updating="selectedProduct" />
    <ProductDetails @add-detail-done="showDetails" @update-detail-done="showDetails" @reset-details="reloadDetails"
        :product-details="productDetails" :product-id="selectedProduct.id" />
    <div class="product-management m-3">
        <div class="w-full">
            <div class="w-full">
                <!-- Các thông báo -->
                <div class="alerts">
                    <div v-if="isUpdatedOK"
                        class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-green-100 text-green-700 p-6 text-center text-lg z-50 rounded-md"
                        role="alert">
                        <span class="font-medium">Cập nhật thành công!!!</span>
                    </div>
                    <div v-if="isNotEnteredID"
                        class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-100 text-red-700 p-6 text-center text-lg z-50 rounded-md"
                        role="alert">
                        <span class="font-medium">Chưa nhập ID!!!</span>
                    </div>
                    <div v-if="isNotFoundEmployee"
                        class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-100 text-red-700 p-6 text-center text-lg z-50 rounded-md"
                        role="alert">
                        <span class="font-medium">Không tìm thấy khách hàng!!!</span>
                    </div>
                </div>
                <!-- Tìm kiếm và Khoá/Mở Khoá tài khoản khách hàng -->
                <div class="w-full flex">
                    <div class="w-1/6 mr-2">
                        <label class="text-gray-700" for="id">
                            ID:
                        </label>
                        <input v-model="selectedProduct.id"
                            class="input-id w-full bg-gray-200 text-gray-800 py-2 px-3 rounded-md focus:outline-none">
                    </div>
                    <!-- <div class="mr-2">
                        <label class="text-gray-700" for="id">
                            Tên sản phẩm:
                        </label>
                        <input v-model="selectedProduct.name"
                            class="w-full bg-gray-200 text-gray-800 py-2 px-3 rounded-md focus:outline-none">
                    </div> -->
                    <div class="mr-2 flex items-end">
                        <!-- <button @click=""
                            class="mr-2 bg-gradient-to-b from-blue-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Tìm
                            kiếm
                        </button> -->
                        <button @click="showDetails"
                            class="mr-2 bg-gradient-to-b from-violet-600 to-violet-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                            Xem chi tiết
                        </button>
                        <button @click="activeAddForm"
                            class="mr-2 bg-gradient-to-b from-green-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                            Thêm sản phẩm
                        </button>
                        <button @click="activeUpdateForm"
                            class="mr-2 bg-gradient-to-b from-blue-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                            Cập nhật sản phẩm
                        </button>
                        <button @click="handleClickDelete"
                            class="mr-2 bg-gradient-to-b from-red-500 to-pink-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                            Xóa sản phẩm
                        </button>
                    </div>
                </div>
                <div class="flex items-end mt-2">Tổng số: {{ currentTotalProduct }}</div>
            </div>
        </div>
        <div class="relative overflow-x-auto custom-scrollbar" style="max-height: 500px;">
            <table id="table-data" class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                <thead
                    class="fixed-header font-sans text-xs text-gray-700 uppercase bg-gray-200 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-4 py-3">
                            ID
                        </th>
                        <!-- <th scope="col" class="px-4 py-3 w-1/10">
                            ID Sản phẩm
                        </th> -->
                        <th scope="col" class="px-4 py-3">
                            Tên sản phẩm
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Giá
                        </th>
                        <!-- <th scope="col" class="px-4 py-3 w-1/12">
                            Giá gốc
                        </th> -->
                        <th scope="col" class="px-4 py-3 w-1/10">
                            Giảm giá (%)
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Loại
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Thương hiệu
                        </th>
                        <!-- <th scope="col" class="px-4 py-3">
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
                        </th> -->
                        <th scope="col" class="px-4 py-3 text-center">
                            Ảnh
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(item, index) in products" :key="index" @click="selectProduct(item)"
                        class="row-data border-b dark:bg-gray-800 cursor-pointer">
                        <th scope="row" class="px-4 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            {{ item.id ? item.id :
                                "Chưa cập nhật" }}
                        </th>
                        <td class="px-4 py-4">
                            {{ item.name ? item.name :
                                "Chưa cập nhật" }}
                        </td>
                        <td class="px-4 py-4">
                            {{ item.price ? item.price :
                                "Chưa cập nhật" }}
                        </td>
                        <td class="px-4 py-4 w-1/10">
                            {{ item.salePercent ? item.salePercent :
                                0 }}
                        </td>
                        <td class="px-4 py-4 overflow-x-auto custom-scrollbar-cell" style="max-width: 150px">
                            {{ item.type ? item.type :
                                "Chưa cập nhật" }}
                        </td>
                        <td class="px-4 py-4">
                            {{ item.material ? item.material :
                                "Chưa cập nhật" }}
                        </td>
                        <td class="px-4 py-4 d-flex justify-content-center align-items-center">
                            <img width="80" :src="item.imageData.base64String" alt="">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div v-if="confirmDeleteModalVisible" class="modal modal-delete">
            <div class="modal-content">
                <span class="close" @click="handleCloseDeleteModal">&times;</span>
                <p>Bạn có chắc về việc xóa sản phẩm này không?</p>
                <div class="d-flex justify-content-center">
                    <button class="btn confirm" @click="handleConfirmDeleteSaveChanges">Có</button>
                    <button class="btn cancel" @click="handleCloseDeleteModal">Không</button>
                </div>
            </div>
        </div>
    </div>

</template>

<script setup lang="ts">
import ProductAddForm from '@/components/manager/ProductAddForm.vue';
import ProductUpdateForm from '@/components/manager/ProductUpdateForm.vue';
import ProductDetails from '@/components/manager/ProductDetails.vue';
import { ref, onBeforeMount } from 'vue';
import { useProductStore } from '@/stores/productStore';
import axios from 'axios';

const productStore = useProductStore();

interface ProductObject {
    id: number | String,
    name: String,
    price: number,
    salePercent: number,
    type: String,
    material: String,
    imageData: {
        id: number | String,
        base64String: String
        type: String
    }
}
interface ProductDetailObject {
    id: number,
    color: String,
    size: String,
    quantity: number,
    imageLinks: string
}

const products = ref<ProductObject[] | null>(null);
const productDetails = ref<ProductDetailObject[] | null>(null);
const selectedProduct = ref<ProductObject>({
    id: '',
    name: '',
    price: 0,
    salePercent: 0,
    type: '',
    material: '',
    imageData: {
        id: '',
        base64String: '',
        type: ''
    }
});

const currentTotalProduct = ref<number>(0);

const confirmDeleteModalVisible = ref(false);

const retriveProducts = async () => {
    try {
        const response = await axios.get(`http://localhost:8080/products`);
        products.value = response.data;
        currentTotalProduct.value = products.value?.length!;
    } catch (error) {
        console.error('Lỗi khi lấy thông tin sản phẩm', error);
    }
}

onBeforeMount(async () => {
    retriveProducts();
});
const isNotEnteredID = ref(false);
const isUpdatedOK = ref(false);

const isNotFoundProductDetail = ref(false);

const selectProduct = (product: ProductObject) => {
    selectedProduct.value = { ...product };
};

const activeAddForm = () => {
    productStore.setIsShowAddFormClick(true);
}

const activeUpdateForm = () => {
    if (selectedProduct.value.id > 0)
        productStore.setIsShowUpdateFormClick(true);
}
const showDetails = async () => {
    try {
        const response = await axios.get(`http://localhost:8080/products/${selectedProduct.value.id}/details`);
        productDetails.value = response.data;
        productDetails.value.forEach(detail => {
            const imageLinksArray = detail.imageLinks.split(", ");
            detail.imageLinks = imageLinksArray;
        })
    } catch (error) {
        console.error('Lỗi khi lấy thông tin sản phẩm', error);
    }
    productStore.setIsShowDetails(true);
}

const reloadDetails = async () => {
    try {
        const response = await axios.get(`http://localhost:8080/products/${selectedProduct.value.id}/details`);
        productDetails.value = response.data;
        productDetails.value.forEach(detail => {
            const imageLinksArray = detail.imageLinks.split(", ");
            detail.imageLinks = imageLinksArray;
        })
    } catch (error) {
        console.error('Lỗi khi lấy thông tin sản phẩm', error);
    }
}

const deteleProduct = async () => {
    try {
        const response = await axios.delete(`http://localhost:8080/products/${selectedProduct.value.id}`);
        selectedProduct.value = {
            id: '',
            name: '',
            price: 0,
            salePercent: 0,
            type: '',
            material: '',
        };
        await retriveProducts();
        return response;
    } catch (error) {
        console.error('Lỗi khi xóa sản phẩm', error);
    }
}

const handleClickDelete = () => {
    confirmDeleteModalVisible.value = true;
}

const handleConfirmDeleteSaveChanges = async () => {
    await deteleProduct();
    confirmDeleteModalVisible.value = false;
}

const handleCloseDeleteModal = () => {
    confirmDeleteModalVisible.value = false;
}
</script>
<style scoped>
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 88vh;
    margin: 0;
}

.w-1\/8 {
    width: 12.5%;
}

.w-1\/10 {
    width: 10%;
}

.w-1\/12 {
    width: 8.33%;
}

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