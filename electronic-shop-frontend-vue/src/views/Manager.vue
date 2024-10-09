<template>
    <div class="relative flex h-screen min-w-screen">
        <!-- Sidebar -->
        <div class="overflow-hidden bg-gradient-to-b from-yellow-800 to-yellow-300 w-64 space-y-6 px-2 py-4 absolute inset-y-0 left-0 md:relative md:-translate-x-0 transform -translate-x-full transition duration-200 ease-in-out"
            :class="{ 'relative translate-x-0': showSidebar }">
            <div class="text-gray-100 text-xl">
                <div @click="clickPersonalInfo()"
                    class="p-2.5 mt-1 flex items-center hover:text-neutral-800 cursor-pointer">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                        stroke="currentColor" class="w-6 h-6 mr-2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                    </svg>
                    {{ accountInfo && accountInfo.account ? accountInfo.account : 'Chưa cập nhật!' }}
                </div>
                <div class="my-2 bg-gray-400 h-[1px]"></div>
            </div>
            <div @click="clickStaff()"
                class="p-2.5 mt-3 flex items-center rounded-md px-4 duration-300 cursor-pointer hover:bg-yellow-600 text-white">
                <i class="bi bi-bookmark-fill"></i>
                <span class="text-[15px] ml-4 text-gray-200 font-bold">Quản lý nhân viên</span>
            </div>
            <div @click="clickStatistic()"
                class="p-2.5 mt-3 flex items-center rounded-md px-4 duration-300 cursor-pointer hover:bg-yellow-600 text-white">
                <i class="bi bi-house-door-fill"></i>
                <span class="text-[15px] ml-4 text-gray-200 font-bold">Thống kê</span>
            </div>
            <transition class="mt-1" name="fade">
                <div v-if="showReportDropdown" @click="clickReport()">
                    <div
                        class="p-2.5 flex items-center ml-5 rounded-md px-4 duration-300 cursor-pointer hover:bg-yellow-600 text-white">
                        <span class="text-[15px] ml-4 text-gray-200 font-bold">Báo cáo</span>
                    </div>
                </div>
            </transition>
            <div @click="clickProduct"
                class="p-2.5 mt-3 flex items-center rounded-md px-4 duration-300 cursor-pointer hover:bg-yellow-600 text-white">
                <i class="bi bi-house-door-fill"></i>
                <span class="text-[15px] ml-4 text-gray-200 font-bold">Sản phẩm</span>
            </div>
            <!-- <div
                class="p-2.5 mt-3 flex items-center rounded-md px-4 duration-300 cursor-pointer hover:bg-yellow-600 text-white">
                <i class="bi bi-house-door-fill"></i>
                <span class="text-[15px] ml-4 text-gray-200 font-bold">Khuyến mãi</span>
            </div> -->
            <div class="mt-10 bg-gray-400 h-[1px]"></div>
            <div @click="logOut()"
                class="p-2.5 mt-3 flex items-center rounded-md px-4 duration-300 cursor-pointer hover:bg-yellow-600 text-white">
                <span class="text-[15px] ml-4 text-gray-200 font-bold">Đăng xuất</span>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                    class="bi bi-box-arrow-right ml-3" viewBox="0 0 16 16">
                    <path fill-rule="evenodd"
                        d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0z" />
                    <path fill-rule="evenodd"
                        d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z" />
                </svg>
            </div>
        </div>
        <!-- Main content -->
        <div class="flex-1 overflow-hidden">
            <!-- header -->
            <div class="grid justify-items-stretch bg-white shadow px-2 pt-4 py-2">
                <div class="flex justify-between">
                    <div>
                        <button @click="showSidebar = !showSidebar" class="text-yellow-600 font-extrabold">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                stroke="currentColor" class="w-6 h-6">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M3.75 5.25h16.5m-16.5 4.5h16.5m-16.5 4.5h16.5m-16.5 4.5h16.5" />
                            </svg>
                        </button>
                    </div>
                    <div class="font-bold text-4xl animate-gradient">TRANG QUẢN LÝ
                    </div>
                    <div></div>
                </div>
            </div>
            <!-- Content -->
            <div class="mt-1 font-extrabold overflow-hidden">
                <div v-if="showPersonalInfo">
                    <PersonalInformation />
                </div>
                <div v-if="showStaff">
                    <StaffManagement />
                </div>
                <div v-if="showStatistic">
                    <Statistic />
                </div>
                <div v-if="showReport">
                    <Report />
                </div>
                <div v-if="showProduct">
                    <ProductManagement />
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeMount } from 'vue';
import axios from 'axios';
import router from '@/router';
import PersonalInformation from '@/components/manager/PersonalInformation.vue';
import StaffManagement from '@/components/manager/StaffManagement.vue';
import Statistic from '@/components/manager/Statistic.vue';
import ProductManagement from '@/components/manager/ProductManagement.vue';
import Report from '@/components/manager/Report.vue';


const showSidebar = ref(false);
const showStatistic = ref(false);
const showStaff = ref(false);
const showProduct = ref(false);
const showPersonalInfo = ref(true);
const showReportDropdown = ref(false);
const showReport = ref(false);

const clickPersonalInfo = () => {
    showPersonalInfo.value = true;
    showStatistic.value = false;
    showStaff.value = false;
    showProduct.value = false;
}

const clickStaff = () => {
    showPersonalInfo.value = false;
    showStatistic.value = false;
    showStaff.value = true;
    showProduct.value = false;
}

const clickStatistic = () => {
    showReportDropdown.value = !showReportDropdown.value;
    showPersonalInfo.value = false;
    showStatistic.value = true;
    showStaff.value = false;
    showProduct.value = false;
}

const clickProduct = () => {
    showPersonalInfo.value = false;
    showStatistic.value = false;
    showStaff.value = false;
    showProduct.value = true;
    showReport.value = false;

}

const clickReport = () => {
    showPersonalInfo.value = false;
    showStatistic.value = false;
    showStaff.value = false;
    showReport.value = true;
}

interface AccountInfo {
    id: number;
    account: string;
    dob: string;
    phone: string;
    email: string;
    name: string;
    address: string;
}

const accountInfo = ref<AccountInfo | null>(null);
const userInfo = ref<AccountInfo | null>(null);
const isLoggedIn = ref(false);
const isDataLoaded = ref(false);


onBeforeMount(() => {
    // Lấy thông tin tài khoản từ localStorage
    const storedAccount = localStorage.getItem('accountManager');
    if (storedAccount) {
        accountInfo.value = JSON.parse(storedAccount);
        console.log(storedAccount);
        if (accountInfo.value) {
            fetchUserInfo(accountInfo.value.account);
            isDataLoaded.value = true;
        }
    }
    console.log(userInfo.value?.account);
    console.log(isDataLoaded.value);
});

async function fetchUserInfo(username: string) {
    try {
        const response = await axios.get(`http://localhost:8080/users/account/${username}`);
        userInfo.value = response.data;
        if (userInfo.value && userInfo.value.dob) {
            const parts = userInfo.value.dob.split('-');
            const reversedDob = `${parts[2]}/${parts[1]}/${parts[0]}`;
            userInfo.value.dob = reversedDob;
        }
    } catch (error) {
        console.error('Lỗi khi lấy thông tin người dùng:', error);
    }
}

const logOut = () => {
    localStorage.removeItem('accountManager');
    isLoggedIn.value = false;
    router.push('/login/employee');
}
</script>

<style scoped>
@keyframes gradient-animation {
    0% {
        background-position: 0%;
    }

    100% {
        background-position: 100%;
    }
}

.animate-gradient {
    background-image: linear-gradient(to right, #3110c4, #1ab11a, #f1de32);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    animation: gradient-animation 5s infinite linear alternate;
}
</style>