<template>
    <div class="flex flex-col mb-3">
        <div class="overflow-auto sm:-mx-6 lg:-mx-8">
            <div class="inline-block min-w-full py-2 sm:px-6 lg:px-8 mb-3">

                <div class="whitespace-nowrap mt-2 px-6 row-data text-1xl">Tổng số đơn hàng: {{ orders ? orders.length :
                    0 }}
                </div>
                <div class="border-b-2 border-neutral-200 dark:border-white/10"></div>
                <div class="custom-scrollbar mt-2 relative overflow-x-auto mb-2 shadow-md" style="max-height: 580px;">
                    <table class="w-full text-sm text-left rtl:text-right">
                        <thead
                            class="fixed-header text-center text-gray-700 dark:bg-gray-700 dark:text-gray-400 mt-2 border-neutral-200 dark:border-white/10">
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
                            <tr v-for="(order, index) in orders" :key="index"
                                class="border-b mt-2 border-neutral-200 dark:border-white/10">
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

interface Staff {
    id: string;
    name: string
}

const statusTranslations = {
    'CREATING': 'Đang tạo',
    'PROCESSING': 'Đang xử lý',
    'SHIPPED': 'Đã chuyển hàng',
    'DELIVERED': 'Đã giao hàng',
    'CANCELLED': 'Đã huỷ',
    'REFUNDED': 'Đã hoàn tiền',
    'ON_HOLD': 'Tạm ngưng'
};

const getStatusTranslation = (status) => {
    return statusTranslations[status] || 'Chưa cập nhật';
};

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

const orders = ref<Order[]>();
const apiUrl = 'http://localhost:8080';
const fetchOrderData = async () => {
    try {
        const response = await axios.get(`${apiUrl}/OrderForEmployee`);
        orders.value = response.data;
        if (orders.value) {
            orders.value.forEach(async (order) => {
                order.createDate = formatDate(order.createDate);

                try {
                    const orderDetailsResponse = await axios.get(`${apiUrl}/OrderForEmployee/${order.id}/details`);
                    order.orderDetails = orderDetailsResponse.data;
                } catch (error) {
                    console.error(`Error fetching order details for order ${order.id}:`, error);
                }
                // order.orderDetails.forEach((detail) => {
                //     console.log("productDetailId:", detail.productDetail.id);
                //     console.log("quantity:", detail.quantity);
                // });
            });
        }
        console.log(orders.value);
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
</style>