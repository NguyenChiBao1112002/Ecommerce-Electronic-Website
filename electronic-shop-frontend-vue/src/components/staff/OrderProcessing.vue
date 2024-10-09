<template>
    <div class="flex flex-col mb-3">
        <div class="overflow-auto sm:-mx-6 lg:-mx-8">
            <div class="inline-block min-w-full py-2 sm:px-6 lg:px-8 mb-2">
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
                    <div v-if="isNotFoundOrder"
                        class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-100 text-red-700 p-6 text-center text-lg z-50 rounded-md"
                        role="alert">
                        <span class="font-medium">Không tìm thấy đơn hàng!!!</span>
                    </div>
                    <div v-if="isFoundOrder"
                        class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-green-100 text-green-700 p-6 text-center text-lg z-50 rounded-md"
                        role="alert">
                        <span class="font-medium">Đã tìm thấy đơn hàng!!!</span>
                    </div>
                </div>
                <div class="w-full flex">
                    <div class="w-1/6 mr-2 flex items-end">Tổng số đơn hàng: {{ currentTotalOrder }}
                    </div>
                    <div class="flex w-1/3">
                        <div class="filter-employee mr-2">
                            <label for="userType" class="text-gray-700">Trạng thái</label>
                            <select v-model="selectedStatus" @change="filterStatus" id="status"
                                class="w-full bg-gray-200 text-gray-800 py-2 px-3 rounded-md focus:outline-none">
                                <option value="all">Tất cả</option>
                                <option value="CREATING">Đang tạo</option>
                                <option value="PROCESSING">Đang xử lý</option>
                                <option value="SHIPPED">Đã chuyển hàng</option>
                                <option value="DELIVERED">Đã giao hàng</option>
                                <option value="CANCELLED">Đã huỷ đơn</option>
                                <option value="REFUNDED">Đã hoàn tiền</option>
                                <option value="ON_HOLD">Tạm ngưng</option>
                            </select>
                        </div>
                        <div v-if="selectedStatus === 'PROCESSING'" class="flex items-end"><button @click="PrintOrder()"
                                class="mr-2 bg-gradient-to-b from-green-500 to-sky-300 text-white font-bold py-2 px-4 rounded">
                                In đơn hàng
                            </button></div>
                    </div>
                    <!-- Tìm đơn hàng bằng ID -->
                    <div v-if="selectedStatus === 'all' || selectedStatus === 'CREATING'"
                        class="w-1/2 flex items-end justify-end ">
                        <div class="w-1/4 mr-2">
                            <label class="text-gray-700" for="id">
                                Mã đơn hàng:
                            </label>
                            <input v-model="selectedOrder.id"
                                class="input-id w-full  bg-gray-200 text-gray-800 py-2 px-3 rounded-md focus:outline-none">
                        </div>
                        <div class="search-order w-1/3 mr-2">
                            <button @click="searchOrder"
                                class="button-print-order mr-2 bg-gradient-to-b from-blue-500 to-sky-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Tìm
                                đơn hàng</button>
                        </div>
                    </div>
                    <!-- Cập nhật đơn hàng -->
                    <div v-else class="w-1/2 flex items-end justify-end">
                        <div class="w-1/4 mr-2">
                            <label>Mã đơn hàng</label>
                            <input v-model="selectedOrder.id"
                                class="input-id w-full pl-2 bg-gray-200 text-gray-800 py-2 px-3 rounded-md focus:outline-none">
                        </div>
                        <div class="w-1/4 mr-2"><label>Mã n/viên xử lý</label>
                            <select v-model="selectedOrder.staff.id"
                                class="w-full bg-gray-200 text-gray-800 py-2 px-3 rounded-md focus:outline-none">
                                <!-- <option value="non-data"></option>  -->
                                <option v-for="staff in staffs" :key="staff.id" :value="staff.id">{{
                                    staff.id }}. {{
                                        staff.name }}
                                </option>
                            </select>
                        </div>
                        <div class="w-1/4 mr-2"><label for="status">Trạng thái</label>
                            <select v-model="selectedOrder.status"
                                class="w-full bg-gray-200 text-gray-800 py-2 px-3 rounded-md focus:outline-none">
                                <option value="PROCESSING">Đang xử lý</option>
                                <option value="SHIPPED">Đã chuyển hàng</option>
                                <option value="DELIVERED">Đã giao</option>
                                <option value="CANCELLED">Đã huỷ đơn</option>
                                <option value="REFUNDED">Đã hoàn tiền</option>
                                <option value="ON_HOLD">Tạm ngưng</option>
                            </select>
                        </div>
                        <div class="w-1/4 mr-2"><button @click="updateOrder(selectedOrder)"
                                class="mr-2 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                                Cập nhật</button></div>
                    </div>
                </div>
                <div class="border-b-2 mt-1 border-neutral-200 dark:border-white/10"></div>
                <div class="custom-scrollbar mt-1 relative overflow-x-auto mb-2 shadow-md" style="max-height: 550px;">
                    <table id="table-data" class="w-full text-sm text-left rtl:text-right">
                        <thead
                            class="fixed-header text-center text-gray-700 dark:bg-gray-700 dark:text-gray-400 border-neutral-200 dark:border-white/10">
                            <tr class="bg-gray-300">
                                <th scope="col" class="px-6 py-3">
                                    Mã đơn hàng
                                </th>
                                <th scope="col" class="px-3 py-3">
                                    Ngày đặt
                                    (ngày/tháng/năm giờ/phút/giây)
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Mã khách hàng
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Chi tiết (Mã chi tiết sp/ Số lượng)
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Tổng cộng (vnđ)
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Nhân viên xử lý
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Trạng thái
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Số điện thoại
                                </th>
                            </tr>
                        </thead>
                        <tbody class="text-center">
                            <tr v-for="(order, index) in orders" :key="index" @click="selectOder(order)"
                                class="row-data hover:bg-gray-200 border-b mt-2 border-neutral-200 dark:border-white/10">
                                <td class="px-6 py-4">{{ order.id !== undefined ? order.id :
                                    "Chưa cập nhật" }}</td>
                                <td class="px-6 py-4">{{ order.createDate !== undefined ? order.createDate :
                                    "Chưa cập nhật" }}</td>
                                <td class="px-6 py-4">{{ order.customer.id !== undefined ? order.customer.id :
                                    "Chưa cập nhật" }}</td>
                                <!--  -->
                                <td class="px-6 py-4">
                                    <template v-if="order.orderDetails && order.orderDetails.length > 0">
                                        <span v-for="(detail, detailIndex) in order.orderDetails" :key="detailIndex">
                                            <div v-if="detail.productDetail">
                                                Mã chi tiết sp: {{ detail.productDetail.id }}
                                            </div>
                                            <div>
                                                Số lượng: {{ detail.quantity }}
                                            </div>
                                            <br v-if="detailIndex < order.orderDetails.length - 1">
                                        </span>
                                    </template>
                                    <template v-else>
                                        <div>Không có chi tiết đơn hàng</div>
                                    </template>
                                </td>
                                <td class="px-6 py-4">{{ order.total !== undefined ? order.total :
                                    "Chưa cập nhật" }}</td>
                                <td class="px-6 py-4">{{ order.staff ? order.staff?.id : "Chưa cập nhật"
                                    }}. {{ order.staff?.name }}</td>

                                <td id="statusCell" class="px-6 py-4">{{ getStatusTranslation(order.status) }}</td>
                                <td class="px-6 py-4">{{ order.customer.phone ? order.customer.phone :
                                    "Chưa cập nhật" }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import axios from 'axios';
import type { ProductObject } from '../cart/cart-item/DefaultCartItem.vue';

interface Order {
    id: string,
    createDate: string,
    status: string,
    total: string,
    couponId: string,
    customer: Customer,
    paymentId: string;
    shipmentId: string;
    staff: Staff;
    warehouseId: string;
    orderDetails: OrderDetail[];
    phone: string;
}

interface Customer {
    id: string;
    phone: string;
}

export interface OrderDetail {
    id: string;
    productDetail: ProductDetail;
    quantity: string,
    total: number
}
interface ProductDetail {
    id: string;
    quantity: string,
    imageLinks: string,
    product: ProductObject,
    color: string,
    size: string
}

interface Staff {
    id: string;
    name: string;
}


const statusTranslations = {
    'CREATING': 'Đang tạo',
    'PROCESSING': 'Đang xử lý',
    'SHIPPED': 'Đã chuyển hàng',
    'DELIVERED': 'Đã giao hàng',
    'CANCELLED': 'Đã huỷ đơn',
    'REFUNDED': 'Đã hoàn tiền',
    'ON_HOLD': 'Tạm ngưng'
};

const getStatusTranslation = (status) => {
    return statusTranslations[status] || 'Chưa cập nhật';
};

const orders = ref<Order[]>();
const staffs = ref<Staff[]>();
const apiUrl = 'http://localhost:8080';
const fetchOrderData = async () => {
    try {
        const response = await axios.get(`${apiUrl}/OrderForEmployee`);
        const responseStaff = await axios.get(`${apiUrl}/staffs`);
        staffs.value = responseStaff.data;
        orders.value = response.data;
        currentTotalOrder.value = orders.value?.length!;
        if (orders.value) {
            orders.value.forEach(async (order) => {
                order.createDate = formatDate(order.createDate);
                try {
                    const orderDetailsResponse = await axios.get(`${apiUrl}/OrderForEmployee/${order.id}/details`);
                    order.orderDetails = orderDetailsResponse.data;
                } catch (error) {
                    console.error(`Error fetching order details for order ${order.id}:`, error);
                }
            });
        }
    } catch (error) {
        console.error('Error fetching store data:', error);
    }
};

function formatDate(dateString) {
    const date = new Date(dateString);
    const day = date.getDate();
    const month = date.getMonth() + 1; // Tháng trong JavaScript bắt đầu từ 0, nên cần cộng thêm 1
    const year = date.getFullYear();
    const hours = date.getHours();
    const minutes = date.getMinutes();
    const seconds = date.getSeconds();
    const formattedDate = `${day}-${month}-${year} ${hours}:${minutes}:${seconds}`;
    return formattedDate;
}

onMounted(() => {
    fetchOrderData();
});

const currentTotalOrder = ref<number>(0);
const selectedStatus = ref<string>('all');
const showPrintOrder = ref(false);
const filterStatus = () => {
    currentTotalOrder.value = orders.value?.length!;
    const table = document.getElementById("table-data");
    const tr = table?.getElementsByTagName("tr");
    let tdContent;
    let temp = 0;
    if (tr !== undefined) {
        for (let i = 0; i < tr?.length; i++) {
            const td = tr[i].getElementsByTagName("td")[6];
            if (td) {
                tdContent = td.textContent?.trim();
                if (tdContent !== getStatusTranslation(selectedStatus.value) && getStatusTranslation(selectedStatus.value) !== 'all' && tr != undefined) {
                    tr[i].style.display = "none";
                    temp++;
                } else {
                    tr[i].style.display = "";
                }
            }
        }
        currentTotalOrder.value = orders.value?.length! - temp;
        if (selectedStatus.value === "PROCESSING") {
            showPrintOrder.value = true;
        } else {
            showPrintOrder.value = false;
        }
    }
};

const PrintOrder = () => {
}

const selectedOrder = ref<Order>({
    id: '',
    createDate: '',
    status: '',
    total: '',
    couponId: '',
    customer: {
        id: '',
        phone: '',
    },
    paymentId: '',
    shipmentId: '',
    staff: {
        id: '',
        name: '',
    },
    warehouseId: '',
    orderDetails: [],
    phone: '',
});
const isNotEnteredID = ref(false);
const isNotFoundOrder = ref(false);
const isFoundOrder = ref(false);
const searchOrder = () => {
    let idToSearch = parseInt(selectedOrder.value.id);
    // console.log(idToSearch);
    if (isNaN(idToSearch)) {
        isNotEnteredID.value = true;
        setTimeout(() => {
            isNotEnteredID.value = false;
        }, 1500);
    } else {
        const index = orders.value?.findIndex(order => parseInt(order.id) === idToSearch);
        if (index !== undefined && index !== -1) {
            const element = document.querySelectorAll('.row-data')[index];
            element.scrollIntoView({ behavior: 'smooth', block: 'center' });
            element.classList.add('found');
            setTimeout(() => {
                element.classList.remove('found');
            }, 4000);
            isFoundOrder.value = true;
            setTimeout(() => {
                isFoundOrder.value = false;
            }, 1500);
        } else {
            isNotFoundOrder.value = true;
            setTimeout(() => {
                isNotFoundOrder.value = false;
            }, 1500);
        }
    }
}

const selectOder = (order: Order) => {
    selectedOrder.value = { ...order };
    selectedOrder.value = { ...order };
    if (selectedOrder.value.staff === null) {
        selectedOrder.value.staff = { id: 'non-data', name: '' };
    }
    console.log(selectedOrder.value.staff);
};
const isUpdatedOK = ref(false);
const updateOrder = async (orderToUpdate) => {
    try {
        const customerId = orderToUpdate.customer.id;
        const orderId = orderToUpdate.id;
        const response = await axios.put(`http://localhost:8080/customers/${customerId}/orders/${orderId}`, orderToUpdate);
        if (response.status === 200) {
            isUpdatedOK.value = true;
            setTimeout(() => {
                filterStatus();
                isUpdatedOK.value = false;
            }, 1500);
            fetchOrderData();
        } else {
            console.error('Cập nhật đơn hàng không thành công.');
        }
    } catch (error) {
        console.error('Lỗi khi cập nhật đơn hàng:', error);
    }
};
</script>

<style scoped>
.fixed-header {
    position: sticky;
    top: 0;
    z-index: 1;
    background-color: #ffffff;
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

.found {
    background-color: rgb(196, 199, 199);
}
</style>