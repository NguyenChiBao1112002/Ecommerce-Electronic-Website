<template>
    <div class="w-full h-full flex">
        <div class="w-1/3">
            <div class="my-2 text-center">
                <div class="flex flex-col items-center"><img class="w-48 h-48 rounded-full"
                        :src="accountInfo ? accountInfo.avatar : 'https://inkythuatso.com/uploads/thumbnails/800/2023/03/9-anh-dai-dien-trang-inkythuatso-03-15-27-03.jpg'">
                </div>
                <div class="my-2 text-2xl">{{ accountInfo &&
                            accountInfo.account ? accountInfo.account : 'Chưa cập nhật!' }}</div>
            </div>
            <div class="flex items-center justify-center">
                <div class="py-4"></div>
                <div class="py-4"><button
                        class="my-2 mx-2 text-center text-white bg-gradient-to-r from-cyan-400 via-cyan-500 to-cyan-600 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-cyan-300 dark:focus:ring-cyan-800 font-medium rounded-lg text-sm px-5 py-2.5">
                        Cập nhật
                        thông tin</button></div>
                <div class="py-8"></div>
            </div>

        </div>

        <div class="w-2/3 mx-3 overflow-auto " style="max-height: 500px;">
            <div class="w-2/3 m-2 px-3 py-4 bg-orange-200 rounded-lg font-light overflow-auto"><b class="font-bold"> Mã
                    nhân viên:</b>
                {{ accountInfo &&
                            accountInfo.id ? accountInfo.id : 'Chưa cập nhật!' }}</div>
            <div class="w-2/3 m-2 px-3 py-4 bg-orange-200 rounded-lg font-light overflow-auto"><b class="font-bold">Tên
                    tài khoản:</b>
                {{ accountInfo &&
                            accountInfo.account ? accountInfo.account : 'Chưa cập nhật!' }}</div>
            <div class="w-2/3 m-2 px-3 py-4 bg-orange-200 rounded-lg font-light overflow-auto"><b class="font-bold">Họ
                    và tên:</b> {{
                            accountInfo &&
                                accountInfo.name ? accountInfo.name : 'Chưa cập nhật! ' }}</div>
            <div class="w-2/3 m-2 px-3 py-4 bg-orange-200 rounded-lg font-light overflow-auto"><b class="font-bold">Số
                    điện thoại:</b>
                {{ accountInfo &&
                            accountInfo.phone ? accountInfo.phone : 'Chưa cập nhật!' }}</div>
            <div class="w-2/3 m-2 px-3 py-4 bg-orange-200 rounded-lg font-light overflow-auto"><b
                    class="font-bold">Email:</b> {{
                            accountInfo &&
                                accountInfo.email ? accountInfo.email : 'Chưa cập nhật!' }}</div>
            <div class="w-2/3 m-2 px-3 py-4 bg-orange-200 rounded-lg font-light overflow-auto"><b class="font-bold">Địa
                    chỉ:</b> {{
                            accountInfo &&
                                accountInfo.address ? accountInfo.address : 'Chưa cập nhật!' }}
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeMount } from 'vue';
import axios from 'axios';

interface AccountInfo {
    id: number;
    account: string;
    dob: string;
    phone: string;
    email: string;
    name: string;
    address: string;
    avatar: string;
}

const accountInfo = ref<AccountInfo | null>(null);
const userInfo = ref<AccountInfo | null>(null);
const isDataLoaded = ref(false);

onBeforeMount(() => {
    // Lấy thông tin tài khoản từ localStorage
    const storedAccount = localStorage.getItem('accountSeniorManager');
    if (storedAccount) {
        accountInfo.value = JSON.parse(storedAccount);
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
        // Đảo ngược chuỗi dob thành định dạng ngày/tháng/năm
        if (userInfo.value && userInfo.value.dob) {
            const parts = userInfo.value.dob.split('-');
            const reversedDob = `${parts[2]}/${parts[1]}/${parts[0]}`;
            userInfo.value.dob = reversedDob;
        }
    } catch (error) {
        console.error('Lỗi khi lấy thông tin người dùng:', error);
    }
}
</script>

<style scoped></style>