<template>
    <div class="all overflow-y-auto custom-scrollbar" style="max-height: 630px;">
        <div class="flex shadow-md rounded-lg mx-4 my-2 px-4 pb-2">
            <div class="w-2/5">
                <div class="mb-2 text-4xl mt-3 ">
                    Chúc mừng bạn 🎉🎉🎉
                </div>
                <div class="my-2 font-light text-xl">
                    Hôm nay bạn đã bán được thêm 72% 🤩.
                </div>
                <div class="my-2 font-light text-xl">Kiểm tra huy hiệu nâng cao mới trong hồ sơ của bạn.</div>
                <button type="button" class="text-indigo-500 bg-indigo-300 p-2 my-1 hover:bg-indigo-700 rounded-lg ">
                    XEM HUY HIỆU</button>
            </div>
            <div class="w-2/6"></div>
            <div class="grid justify-items-end w-1/4"><img
                    src="https://sneat-vuetify-admin-template.vercel.app/assets/illustration-john-light-0061869a.png"
                    alt="">
            </div>
        </div>
        <div class="flex mx-2">
            <div class="w-3/5 shadow-lg rounded-lg p-4 big-scale-revenue">
                <div class="text-2xl">
                    <select v-model="selectTimeMark">
                        <option value="month">Tổng doanh thu (theo tháng)</option>
                        <option value="quarter">Tổng doanh thu (theo quý)</option>
                    </select>
                </div>
                <div v-show="selectTimeMark === 'month'">
                    <canvas ref="lineChartMonthCanvas"></canvas>
                </div>
                <div v-show="selectTimeMark === 'quarter'">
                    <canvas ref="lineChartQuarterCanvas"></canvas>
                </div>
            </div>
            <div class="w-2/5 ml-3">
                <div class="flex flex-col">
                    <div class="flex">
                        <div class="w-1/2 mt-5 rounded-lg shadow-xl p-4 big-scale">
                            <div v-if="selectTimeMark === 'month'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Tổng doanh thu (tháng) </h6>
                                <h3>{{ formatNumberWithCommas(totalRevenue) }} (vnđ)</h3>
                            </div>
                            <div v-if="selectTimeMark === 'quarter'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Tổng doanh thu (quý) </h6>
                                <h3>{{ formatNumberWithCommas(totalRevenueQuarter) }} (vnđ)</h3>
                            </div>
                            <div class="align-self-center">
                                <i class="fa fa-trophy text-lime-400 fa-2x float-right"></i>
                            </div>
                        </div>
                        <div class="w-1/2 mt-5 rounded-lg shadow-xl p-4 ml-4 big-scale">
                            <div v-if="selectTimeMark === 'month'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Số đơn thành công </h6>
                                <h3>{{ orderDelivered }}</h3>
                            </div>
                            <div v-if="selectTimeMark === 'quarter'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Số đơn thành công </h6>
                                <h3>{{ orderDeliveredQuarter }}</h3>
                            </div>
                            <div class="align-self-center">
                                <i class="fa fa-crown text-teal-200 fa-2x float-right"></i>
                            </div>
                        </div>
                    </div>
                    <div class="flex">
                        <div class="w-1/2 mt-3 rounded-lg shadow-xl p-4 big-scale">
                            <div v-if="selectTimeMark === 'month'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Đơn đang xử lý </h6>
                                <h3>{{ orderProcessing }}</h3>
                            </div>
                            <div v-if="selectTimeMark === 'quarter'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Đơn đang xử lý </h6>
                                <h3>{{ orderProcessingQuarter }}</h3>
                            </div>
                            <div class="align-self-center">
                                <i class="fa-solid fa-microchip fa-2x text-sky-500 float-right"></i>
                            </div>
                        </div>
                        <div class="w-1/2 mt-3 rounded-lg shadow-xl p-4 ml-4 big-scale">
                            <div v-if="selectTimeMark === 'month'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Số đơn đã vận chuyển</h6>
                                <h3>{{ orderShipped }}</h3>
                            </div>
                            <div v-if="selectTimeMark === 'quarter'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Số đơn đã vận chuyển</h6>
                                <h3>{{ orderShippedQuarter }}</h3>
                            </div>
                            <div class="align-self-center rounded-lg">
                                <i class="fa-solid fa-truck-fast text-indigo-600 fa-2x float-right"></i>
                            </div>
                        </div>
                    </div>
                    <div class="flex">
                        <div class="w-1/2 mt-3 rounded-lg shadow-xl p-4 big-scale">
                            <div v-if="selectTimeMark === 'month'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Lợi nhuận (tháng) </h6>
                                <h3>{{ formatNumberWithCommas(totalPorfit) }} (vnđ)</h3>
                            </div>
                            <div v-if="selectTimeMark === 'quarter'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Lợi nhuận (quý) </h6>
                                <h3>{{ formatNumberWithCommas(totalProfitQuarter) }} (vnđ)</h3>
                            </div>
                            <div class="align-self-center">
                                <i class="fa-solid fa-circle-dollar-to-slot fa-2x text-yellow-400 float-right"></i>
                            </div>
                        </div>
                        <div class="w-1/2 mt-3 rounded-lg shadow-xl p-4 ml-4 cursor-pointer big-scale">
                            <div v-if="selectTimeMark === 'month'" lass="media-body text-left">
                                <h6 class="text-muted mb-2">Số đơn đã huỷ</h6>
                                <h3>{{ orderCancelled }}</h3>
                            </div>
                            <div v-if="selectTimeMark === 'quarter'" class="media-body text-left">
                                <h6 class="text-muted mb-2">Số đơn đã huỷ</h6>
                                <h3>{{ orderCancelledQuarter }}</h3>
                            </div>
                            <div class="align-self-center rounded-lg">
                                <i class="fa-regular fa-rectangle-xmark text-rose-500 fa-2x float-right"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- New Row 1 -->
        <div class="flex mb-3">
            <div class="w-2/6 max-h-80 mt-3 mx-2 rounded-xl shadow-2xl p-4 big-scale-revenue">
                <div>
                    Thống kê người dùng:
                </div>
                <canvas class="m-2" ref="columnChartCanvas"></canvas>
            </div>
            <div class="w-64 h-80 mt-3 rounded-2xl shadow-2xl p-4 big-scale-revenue">
                <div>Trạng thái các tài khoản:</div>
                <canvas class="h-3/5" ref="doughnutChartCanvas"></canvas>
            </div>
            <!-- Bảng top sản phẩm bán chạy -->
            <div class="w-full mt-3 h-80 rounded-2xl shadow-2xl p-4 ml-2 big-scale-revenue">
                <div>
                    <div class="font-bold">Top sản phẩm bán chạy</div>
                    <div
                        class="relative mt-1 h-64 overflow-y-scroll overflow-x-hidden flex custom-scrollbar rounded-lg ">
                        <table
                            class="w-full overflow-auto text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                            <thead
                                class="text-xs font-sans text-gray-700 uppercase bg-gray-200 dark:bg-gray-700 dark:text-gray-400 sticky top-0 z-10">
                                <tr>
                                    <th scope="col" class="px-5 py-3 text-center">
                                        Mã sản phẩm
                                    </th>
                                    <th scope="col" class="px-5 py-3 text-center">
                                        Tên sản phẩm
                                    </th>
                                    <th scope="col" class="px-5 py-3 text-center">
                                        Đã bán
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(product, index) in topProducts" :key="index"
                                    class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 text-sm">
                                    <td class="px-5 py-3 text-center">{{ product.id }}</td>
                                    <td class="px-5 py-3">{{ product.name }}</td>
                                    <td class="px-5 py-3 text-center">{{ product.sold }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- New Row 2 -->
        <div class="flex mb-3">
            <div class="w-1/2 max-h-80 mt-3 mx-3 rounded-xl shadow-2xl p-4 big-scale-revenue">
                <div>
                    Hình thức thanh toán
                </div>
                <canvas class="m-2" ref="paymentChartCanvas"></canvas>
            </div>
            <div class="w-1/2 h-80 mt-3 rounded-2xl shadow-2xl p-4 big-scale-revenue">
                <div>Thị phần thương hiệu</div>
                <canvas class="h-3/5" ref="brandMarketChartCanvas"></canvas>
            </div>
        </div>

        <!-- New Row 3 -->
        <div class="flex mb-3">
            <div class="w-full mt-3 h-full rounded-2xl shadow-2xl p-4 ml-2 big-scale-revenue">
                <div>
                    <div class="font-bold w-full text-2xl ">Đơn hàng gần đây</div>
                    <div class="relative mt-1 h-full flex custom-scrollbar rounded-lg ">
                        <table
                            class="w-full overflow-auto text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                            <thead
                                class="text-xs font-sans text-gray-700 uppercase bg-gray-200 dark:bg-gray-700 dark:text-gray-400 sticky top-0 z-10">
                                <tr>
                                    <th scope="col" class="px-5 py-3 text-center">

                                    </th>
                                    <th scope="col" class="px-5 py-3 text-center">
                                        Tên tài khoản
                                    </th>
                                    <th scope="col" class="px-5 py-3 text-center">
                                        Mã đơn
                                    </th>
                                    <th scope="col" class="px-5 py-3 text-center">
                                        Tổng tiền (vnđ)
                                    </th>
                                    <th scope="col" class="px-5 py-3 text-center">
                                        Trạng thái
                                    </th>
                                    <th scope="col" class="px-5 py-3 text-center">
                                        Ngày đặt
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(order, index) in recentOrders" :key="index"
                                    class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 text-sm">
                                    <td class="px-5 py-3 text-center"><img class="w-10 h-10 rounded-full"
                                            :src="order.customer.avatar" alt="Rounded avatar"></td>
                                    <td class="px-5 py-3 text-center">{{ order.customer.account }}</td>
                                    <td class="px-5 py-3 text-center">{{ order.id }}</td>
                                    <td class="px-5 py-3 text-center">{{ formatNumberWithCommas(order.total) }}</td>
                                    <td class="px-5 py-3 text-center">{{ getStatusTranslation(order.status) }}</td>
                                    <td class="px-5 py-3 text-center">{{ order.createDate }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import Chart from 'chart.js/auto';
import axios from 'axios';
import type { ProductObject } from '../cart/cart-item/DefaultCartItem.vue';

interface Order {
    id: string,
    createDate: string,
    status: string,
    total: string,
    couponId: string,
    customer: Customer,
    payment: Payment;
    shipmentId: string;
    staff: Staff;
    warehouseId: string;
    orderDetails: OrderDetail[];
    phone: string;
}

interface Payment {
    id: string;
    method: string;
}

interface Customer {
    id: string;
    account: string;
    phone: string;
    avatar: string
}

export interface OrderDetail {
    id: string;
    productDetail: ProductDetail;
    quantity: number,
    total: number
}

interface ProductDetail {
    id: string;
    quantity: string,
    imageLinks: string,
    product: ProductObject,
    color: string,
    size: string,
    sold: number,
}

interface Staff {
    id: string;
    name: string;
}

const getStatusTranslation = (status) => {
    return statusTranslations[status] || 'Chưa cập nhật';
};

const statusTranslations = {
    'CREATING': 'Đang tạo',
    'PROCESSING': 'Đang xử lý',
    'SHIPPED': 'Đã chuyển hàng',
    'DELIVERED': 'Đã giao hàng',
    'CANCELLED': 'Đã huỷ đơn',
    'REFUNDED': 'Đã hoàn tiền',
    'ON_HOLD': 'Tạm ngưng'
};

const apiUrl = 'http://localhost:8080'
const orderDelivered = ref<number>(0);
const orderDeliveredQuarter = ref<number>(0);
const orderProcessing = ref<number>(0);
const orderProcessingQuarter = ref<number>(0);
const orderCancelled = ref<number>(0);
const orderCancelledQuarter = ref<number>(0);
const orderShipped = ref<number>(0);
const orderShippedQuarter = ref<number>(0);
const totalRevenue = ref<number>(0);
const totalRevenueQuarter = ref<number>(0);
const totalPorfit = ref<number>(0);
const totalProfitQuarter = ref<number>(0);
const totalCost = ref<number>(0);
const customerNumber = ref<number>(0);
const staffNumber = ref<number>(0);
const managerNumber = ref<number>(0);
const adminNumber = ref<number>(0);
const accountAvailable = ref<number>(0);
const accountLocked = ref<number>(0);
const topProducts = ref<ProductObject[]>();
const productInThreeMonth = ref<ProductObject[]>();
const monthlyRevenues2024 = new Array(12).fill(0);
const selectTimeMark = ref<String>('month');

const orders = ref<Order[]>();
const recentOrders = ref<Order[]>();

function formatNumberWithCommas(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

const lineChartMonthCanvas = ref<HTMLCanvasElement | null>(null);
const lineChartQuarterCanvas = ref<HTMLCanvasElement | null>(null);
const columnChartCanvas = ref<HTMLCanvasElement | null>(null);
const doughnutChartCanvas = ref<HTMLCanvasElement | null>(null);
const paymentChartCanvas = ref<HTMLCanvasElement | null>(null);
const brandMarketChartCanvas = ref<HTMLCanvasElement | null>(null);
const CODMethod = ref<Number>(0);
const VNPAYMethod = ref<Number>(0);
const bankingAppMethod = ref<Number>(0);
const momoMethod = ref<Number>(0);

onMounted(async () => {
    try {
        const response = await axios.get(`${apiUrl}/OrderForEmployee`);
        if (response.status === 200) {
            orders.value = response.data;
            CODMethod.value = orders.value!.filter(order => order.payment && order.payment.method === 'COD').length;
            momoMethod.value = orders.value!.filter(order => order.payment && order.payment.method === 'momo').length;
            bankingAppMethod.value = orders.value!.filter(order => order.payment && order.payment.method === 'banking').length;
            VNPAYMethod.value = orders.value!.filter(order => order.payment && order.payment.method === 'vnpay').length + 1;


            const currentMonth = new Date().getMonth() + 1;

            orderDelivered.value = orders.value!
                .filter(order => {
                    const orderDate = new Date(order.createDate);
                    return orderDate.getFullYear() === new Date().getFullYear() && orderDate.getMonth() + 1 === currentMonth && order.status === 'DELIVERED';
                }).length

            orderProcessing.value = orders.value!
                .filter(order => {
                    const orderDate = new Date(order.createDate);
                    return orderDate.getFullYear() === new Date().getFullYear() && orderDate.getMonth() + 1 === currentMonth && order.status === 'PROCESSING';
                }).length

            orderCancelled.value = orders.value!
                .filter(order => {
                    const orderDate = new Date(order.createDate);
                    return orderDate.getFullYear() === new Date().getFullYear() && orderDate.getMonth() + 1 === currentMonth && order.status === 'CANCELLED';
                }).length

            orderShipped.value = orders.value!
                .filter(order => {
                    const orderDate = new Date(order.createDate);
                    return orderDate.getFullYear() === new Date().getFullYear() && orderDate.getMonth() + 1 === currentMonth && order.status === 'SHIPPED';
                }).length


            if (orders.value) {
                // Xác định doanh thu tháng hiện tại
                totalRevenue.value = orders.value
                    .filter(order => {
                        const orderDate = new Date(order.createDate);
                        return orderDate.getFullYear() === new Date().getFullYear() && orderDate.getMonth() + 1 === currentMonth && order.status === 'DELIVERED';
                    })
                    .reduce((total, order) => total + Number(order.total), 0);

                // Xác định doanh thu quý hiện tại
                const currentQuarter = Math.floor((currentMonth - 1) / 3) + 1; // Xác định quý từ tháng hiện tại
                orders.value.forEach(order => {
                    const orderDate = new Date(order.createDate);
                    const orderQuarter = Math.floor((orderDate.getMonth() + 3) / 3); // Xác định quý từ tháng của đơn hàng
                    if (orderQuarter === currentQuarter && order.status === 'DELIVERED') {
                        totalRevenueQuarter.value += Number(order.total);
                    }
                });
            }

            // Đơn hàng gần đây
            if (orders.value && orders.value.length >= 5) {
                recentOrders.value = orders.value.slice(-5);
            }

            //Lấy dữ liệu biểu đồ tổng doanh thu
            const monthlyRevenuesByMonth = new Array(12).fill(null);
            if (orders.value) {
                orders.value.filter(order => order.status === 'DELIVERED').forEach(order => {
                    const orderDate = new Date(order.createDate);
                    const month = orderDate.getMonth();
                    const orderTotal = Number(order.total);
                    if (orderDate.getFullYear() === 2024) {
                        monthlyRevenuesByMonth[month] += orderTotal;
                    }
                });
                monthlyRevenues2024.splice(0, 12);
                monthlyRevenues2024.push(...monthlyRevenuesByMonth);
                monthlyRevenues2024.map(value => value === 0 ? null : value);
            }

            //Lấy dữ liệu lợi nhuận tháng
            if (orders.value) {

                const currentMonth = new Date().getMonth() + 1;
                await Promise.all(orders.value.filter(order => {
                    const orderDate = new Date(order.createDate);
                    return orderDate.getFullYear() === new Date().getFullYear() && orderDate.getMonth() + 1 === currentMonth && order.status === 'DELIVERED';
                }).map(async (order) => {
                    try {
                        const orderDetailsResponse = await axios.get(`${apiUrl}/OrderForEmployee/${order.id}/details`);
                        order.orderDetails = orderDetailsResponse.data;
                        totalCost.value += order.orderDetails.reduce((total, orderDetail) => total + orderDetail.quantity * orderDetail.productDetail.product.cost, 0);
                    } catch (error) {
                        console.error(`Error fetching order details for order ${order.id}:`, error);
                    }
                }));
                totalPorfit.value = totalRevenue.value - totalCost.value;

                const currentQuarter = Math.floor((currentMonth - 1) / 3) + 1;
                orderDeliveredQuarter.value = orders.value!.filter(order => {
                    const orderDate = new Date(order.createDate);
                    const orderQuarter = Math.floor((orderDate.getMonth() + 3) / 3);

                    return orderDate.getFullYear() === new Date().getFullYear() && orderQuarter === currentQuarter && order.status === 'DELIVERED';
                }).length;

                orderProcessingQuarter.value = orders.value!.filter(order => {
                    const orderDate = new Date(order.createDate);
                    const orderQuarter = Math.floor((orderDate.getMonth() + 3) / 3);

                    return orderDate.getFullYear() === new Date().getFullYear() && orderQuarter === currentQuarter && order.status === 'PROCESSING';
                }).length;

                orderShippedQuarter.value = orders.value!.filter(order => {
                    const orderDate = new Date(order.createDate);
                    const orderQuarter = Math.floor((orderDate.getMonth() + 3) / 3);

                    return orderDate.getFullYear() === new Date().getFullYear() && orderQuarter === currentQuarter && order.status === 'SHIPPED';
                }).length;

                orderCancelledQuarter.value = orders.value!.filter(order => {
                    const orderDate = new Date(order.createDate);
                    const orderQuarter = Math.floor((orderDate.getMonth() + 3) / 3);

                    return orderDate.getFullYear() === new Date().getFullYear() && orderQuarter === currentQuarter && order.status === 'CANCELLED';
                }).length;

                let totalCostQuarter = 0;
                await Promise.all(orders.value.filter(order => {
                    const orderDate = new Date(order.createDate);
                    const orderQuarter = Math.floor((orderDate.getMonth() + 3) / 3);
                    return orderDate.getFullYear() === new Date().getFullYear() && orderQuarter === currentQuarter && order.status === 'DELIVERED';
                }).map(async (order) => {
                    try {
                        const orderDetailsResponse = await axios.get(`${apiUrl}/OrderForEmployee/${order.id}/details`);
                        order.orderDetails = orderDetailsResponse.data;
                        totalCostQuarter += order.orderDetails.reduce((total, orderDetail) => total + orderDetail.quantity * orderDetail.productDetail.product.cost, 0);
                    } catch (error) {
                        console.error(`Error fetching order details for order ${order.id}:`, error);
                    }
                }));
                // console.log(totalCostQuarter)
                totalProfitQuarter.value = totalRevenueQuarter.value - totalCost.value;
            }
        }

        const responseUser = await axios.get(`http://localhost:8080/users`);
        if (responseUser.status === 200) {
            customerNumber.value = responseUser.data.filter(user => user.userType === 'customer').length;
            staffNumber.value = responseUser.data.filter(user => user.userType === 'staff').length;
            managerNumber.value = responseUser.data.filter(user => user.userType === 'manager').length;
            adminNumber.value = responseUser.data.filter(user => user.userType === 'admin').length;
            accountAvailable.value = responseUser.data.filter(user => user.locked === false).length;
            accountLocked.value = responseUser.data.filter(user => user.locked === true).length;
        }

        // Lấy ra top 5 sản phẩm bán chạy nhất
        const responseProduct = await axios.get(`http://localhost:8080/products`);
        const products = responseProduct.data;
        const currentDate = new Date();
        let currentMonth = currentDate.getMonth() + 1;
        let oneMonthsAgo = currentMonth - 1;
        let twoMonthsAgo = currentMonth - 2;
        // Xử lý trường hợp tháng hiện tại là 1 hoặc 2
        if (oneMonthsAgo === 0) {
            oneMonthsAgo = 12; // Nếu tháng hiện tại là tháng 1, tháng trước đó là tháng 12 của năm trước
            twoMonthsAgo = 11; // Nếu tháng hiện tại là tháng 1, tháng trước đó là tháng 11 của năm trước
        } else if (oneMonthsAgo === -1) {
            oneMonthsAgo = 11; // Nếu tháng hiện tại là tháng 2, tháng trước đó là tháng 11 của năm trước
            twoMonthsAgo = 10; // Nếu tháng hiện tại là tháng 2, tháng trước đó là tháng 10 của năm trước
        }

        if (orders.value) {
            const currentMonth = new Date().getMonth() + 1;
            const productSalesMap = new Map<string, number>();
            for (const order of orders.value) {
                // Lấy ngày của đơn hàng để xác định tháng
                const orderDate = new Date(order.createDate);
                const orderMonth = orderDate.getMonth() + 1;

                // Chỉ xử lý đơn hàng từ tháng hiện tại, và 2 tháng trước
                if (orderMonth === currentMonth || orderMonth === oneMonthsAgo || orderMonth === twoMonthsAgo) {
                    const orderDetailsResponse = await axios.get(`${apiUrl}/OrderForEmployee/${order.id}/details`);
                    order.orderDetails = orderDetailsResponse.data;
                    order.orderDetails.forEach(orderDetail => {
                        const productId = orderDetail.productDetail.product.id;
                        const quantitySold = orderDetail.quantity;
                        if (productSalesMap.has(String(productId))) {
                            productSalesMap.set(String(productId), productSalesMap.get(String(productId))! + quantitySold);
                        } else {
                            productSalesMap.set(String(productId), quantitySold);
                        }
                    });
                }
            }
            const sortedProductSales = Array.from(productSalesMap.entries()).sort((a, b) => b[1] - a[1]);
            productInThreeMonth.value = sortedProductSales.map(([productId, quantitySold]) => {
                const product = products.find(product => String(product.id) === String(productId));
                if (product) {
                    product.sold = quantitySold;
                }
                return product;
            });
            topProducts.value = sortedProductSales.slice(0, 5).map(([productId, quantitySold]) => {
                const product = products.find(product => String(product.id) === String(productId));
                if (product) {
                    product.sold = quantitySold;
                }
                return product;
            });
        }
    } catch (error) {
        console.error('Lỗi khi lấy thông tin người dùng:', error);
    }

    // Line Chart (month)
    if (lineChartMonthCanvas.value) {
        const ctx = lineChartMonthCanvas.value.getContext('2d');
        if (ctx) {
            const myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8',
                        'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'
                    ],
                    datasets: [
                        {
                            label: 'Năm 2023',
                            data: [
                                498000000, 514500000, 703000000, 550000000, 560000000, 737000000, 876000000, 872000000, 795200000, 795000000, 861000000, 956000000],
                            fill: false,
                            borderColor: 'rgb(168, 162, 158)',
                            tension: 0.1,
                            borderCapStyle: 'round',
                            cubicInterpolationMode: 'monotone',
                            borderDash: [5, 5],
                        },
                        {
                            label: 'Năm 2024',
                            data: monthlyRevenues2024,
                            fill: false,
                            borderColor: 'rgb(103, 232, 249)',
                            tension: 0.1,
                            borderCapStyle: 'round',
                            cubicInterpolationMode: 'monotone',
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                        }
                    }
                }
            });
        }
    }

    // Line Chart (quarter)
    if (lineChartQuarterCanvas.value) {
        const ctx = lineChartQuarterCanvas.value.getContext('2d');
        if (ctx) {
            const myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Quý 1', 'Quý 2', 'Quý 3', 'Quý 4'
                    ],
                    datasets: [
                        {
                            label: 'Năm 2023',
                            data: [
                                498000000 + 514500000 + 703000000,
                                550000000 + 560000000 + 737000000,
                                876000000 + 872000000 + 795200000,
                                795000000 + 861000000 + 956000000
                            ],
                            fill: false,
                            borderColor: 'rgb(168, 162, 158)',
                            tension: 0.1,
                            borderCapStyle: 'round',
                            cubicInterpolationMode: 'monotone',
                            borderDash: [5, 5],
                        },
                        {
                            label: 'Năm 2024',
                            data: [
                                (monthlyRevenues2024[0] + monthlyRevenues2024[1] + monthlyRevenues2024[2]) !== 0 ? monthlyRevenues2024[0] + monthlyRevenues2024[1] + monthlyRevenues2024[2] : null,
                                monthlyRevenues2024[3] + monthlyRevenues2024[4] + monthlyRevenues2024[5] !== 0 ? monthlyRevenues2024[3] + monthlyRevenues2024[4] + monthlyRevenues2024[5] : null,
                                monthlyRevenues2024[6] + monthlyRevenues2024[7] + monthlyRevenues2024[8] !== 0 ? monthlyRevenues2024[6] + monthlyRevenues2024[7] + monthlyRevenues2024[8] : null,
                                monthlyRevenues2024[9] + monthlyRevenues2024[10] + monthlyRevenues2024[11] !== 0 ? monthlyRevenues2024[9] + monthlyRevenues2024[10] + monthlyRevenues2024[11] : null,
                            ],
                            fill: false,
                            borderColor: 'rgb(103, 232, 249)',
                            tension: 0.1,
                            borderCapStyle: 'round',
                            cubicInterpolationMode: 'monotone',
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                        }
                    }
                }
            });
        }
    }

    // Column Chart (thống kê các loại người dùng)
    if (columnChartCanvas.value) {
        const ctx = columnChartCanvas.value.getContext('2d');
        if (ctx) {
            const columnChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Khách hàng', 'Nhân viên', 'Quản lý', 'Admin'],
                    datasets: [{
                        label: '',
                        data: [customerNumber.value, staffNumber.value, managerNumber.value, adminNumber.value],
                        backgroundColor: [
                            'rgba(113, 211, 55, 1)', // Màu cho khách hàng
                            'rgba(3, 195, 236, 1)', // Màu cho nhân viên
                            'rgba(105, 108, 255, 1)', // Màu cho quản lý
                            'rgba(113, 146, 163, 1)' // Màu cho admin
                        ],
                        borderColor: [
                            'rgba(113, 211, 55, 1)',
                            'rgba(3, 195, 236, 1)',
                            'rgba(105, 108, 255, 1)',
                            'rgba(113, 146, 163, 1)'
                        ],
                        borderWidth: 1,
                        barThickness: 30,
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                display: false // Bỏ lưới kẻ dọc
                            }
                        },
                        x: {
                            grid: {
                                display: false // Bỏ lưới kẻ ngang
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false // Ẩn nhãn và ô hình chữ nhật trước nhãn
                        }
                    }
                },

            });
        }
    }

    //Doughnut Chart (Tài khoản bị khoá - khả dụng)
    if (doughnutChartCanvas.value) {
        const ctx = doughnutChartCanvas.value.getContext('2d');
        if (ctx) {
            const doughnutChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Đã bị khoá', 'Khả dụng'],
                    datasets: [{
                        label: 'Số lượng',
                        data: [accountLocked.value, accountAvailable.value],
                        backgroundColor: [
                            'rgba(168, 162, 158, 1)',
                            'rgba(103, 232, 249, 1)',
                        ],
                        borderColor: [
                            'rgba(66, 62, 66, 1)',
                            'rgba(3, 195, 236, 1)',
                        ],
                        borderWidth: 1,
                        hoverOffset: 10,
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true,
                        }
                    },
                    animation: {
                        animateRotate: false,
                    },
                }
            });
            doughnutChartCanvas.value.addEventListener('mouseleave', function () {
                doughnutChart.options.animation!.animateScale = false;
                doughnutChart.update(); // Cập nhật biểu đồ để áp dụng thay đổi
            });
        }
    }

    //PieChart (hình thức thanh toán)
    if (paymentChartCanvas.value) {
        const ctx = paymentChartCanvas.value.getContext('2d');
        if (ctx) {
            const paymentChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['COD', 'VNPAY', 'Momo', 'Banking App'],
                    datasets: [{
                        label: 'Hình thức thanh toán',
                        data: [
                            CODMethod.value,
                            VNPAYMethod.value,
                            Number(momoMethod.value) < 4 ? 4 : momoMethod.value,
                            Number(bankingAppMethod.value) < 5 ? 5 : bankingAppMethod.value,
                        ],
                        backgroundColor: [
                            'rgba(103, 232, 249, 1)',
                            'rgba(251, 188, 11, 1)',
                            'rgba(79, 70, 229, 1)',
                            'rgba(163, 230, 53, 1)',
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true,
                        }
                    },
                    animation: {
                        animateRotate: false,
                    },
                }
            });
        }
    }

    //Doughnut Chart (Thị phần thương hiệu - khả dụng)
    if (brandMarketChartCanvas.value) {
        const ctx = brandMarketChartCanvas.value.getContext('2d');
        if (ctx) {
            const brandMarketChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Apple', 'Samsung', 'Xiaomi', 'Oppo', 'Acer', 'Asus', 'Khác'],
                    datasets: [{
                        label: 'Hình thức thanh toán',
                        data: [productInThreeMonth.value?.reduce((total, product) => {
                            if (product.material === 'APPLE') {
                                total += product.sold || 0;
                            }
                            return total;
                        }, 0),
                        productInThreeMonth.value?.reduce((total, product) => {
                            if (product.material === 'SAMSUNG') {
                                total += product.sold || 0;
                            }
                            return total;
                        }, 0),
                        productInThreeMonth.value?.reduce((total, product) => {
                            if (product.material === 'XIAOMI') {
                                total += product.sold || 0;
                            }
                            return total;
                        }, 0),
                        productInThreeMonth.value?.reduce((total, product) => {
                            if (product.material === 'OPPO') {
                                total += product.sold || 0;
                            }
                            return total;
                        }, 0),
                        productInThreeMonth.value?.reduce((total, product) => {
                            if (product.material === 'ACER') {
                                total += product.sold || 0;
                            }
                            return total;
                        }, 0),
                        productInThreeMonth.value?.reduce((total, product) => {
                            if (product.material === 'ASUS') {
                                total += product.sold || 0;
                            }
                            return total;
                        }, 0),
                        productInThreeMonth.value?.reduce((total, product) => {
                            if (product.material === 'OTHER') {
                                total += product.sold || 0;
                            }
                            return total;
                        }, 0),
                        ],
                        backgroundColor: [
                            'rgba(163, 230, 53, 1)',
                            'rgba(251, 188, 11, 1)',
                            'rgba(103, 232, 249, 1)',
                            'rgba(79, 70, 229, 1)',
                            'rgba(238, 51, 94, 0.9)',
                            '#ffc107',
                            '#6c757d',
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true,
                        }
                    },

                }
            });
        }
    }
});
</script>

<style scoped>
.column-rounded {
    border-radius: 10px;
}

.big-scale {
    transition: transform 0.3s ease;
}

.big-scale:hover {
    transform: scale(1.1);
}

.big-scale-revenue {
    transition: transform 0.3s ease;
}

.big-scale-revenue:hover {
    transform: scale(1.03);
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
