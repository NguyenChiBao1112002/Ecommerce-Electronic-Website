<template>
    <div class="customer-management">
        <div class="w-full">
            <div class="w-full mt-1">
                Tổng số tài khoản: {{ users?.length }}
            </div>
        </div>
        <div class="mt-2 relative overflow-x-auto custom-scrollbar" style="max-height: 550px;">
            <table class="w-full text-xs text-left font-sans rtl:text-right text-gray-500 dark:text-gray-400">
                <thead
                    class="fixed-header text-xs text-gray-700 uppercase bg-gray-100 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-4 py-3">
                            ID
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Tên tài khoản
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Tên khách hàng
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Loại người dùng
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Trạng thái
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Số điện thoại
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Email
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Ngày sinh
                        </th>
                        <th scope="col" class="px-4 py-3">
                            Địa chỉ
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(user, index) in users" :key="index"
                        class="row-data border-b dark:bg-gray-800 cursor-pointer">
                        <th scope="row" class="px-4 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            {{ user.id ? user.id :
                                "Chưa cập nhật" }}
                        </th>
                        <td class="px-4 py-4">
                            {{ user.account ? user.account :
                                "Chưa cập nhật" }}
                        </td>
                        <td class="px-4 py-4">
                            {{ user.name ? user.name :
                                "Chưa cập nhật" }}
                        </td>
                        <td class="px-4 py-4">
                            {{ user.userType ? user.userType :
                                "Chưa cập nhật" }}
                        </td>
                        <td class="px-4 py-4">
                            {{ user.locked ? "Đã khoá" :
                                "Hoạt động" }}
                        </td>
                        <td class="px-4 py-4">
                            {{ user.phone ? user.phone :
                                "Chưa cập nhật" }}
                        </td>
                        <td class="px-4 py-4">
                            {{ user.email ? user.email :
                                "Chưa cập nhật" }}
                        </td>
                        <td class="px-4 py-4">
                            {{ user.dob ? user.dob :
                                "Chưa cập nhật" }}
                        </td>
                        <!-- <td class="px-4 py-4 overflow-x-auto custom-scrollbar-cell" style="max-width: 150px">
                            {{ user.address ? user.address :
                            "Chưa cập nhật" }}
                        </td> -->
                        <td class="px-4 py-4">
                            {{ user.address ? user.address :
                                "Chưa cập nhật" }}
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onBeforeMount } from 'vue';
import axios from 'axios';

interface User {
    id: string,
    account: string,
    password: string,
    name: string,
    phone: string,
    email: string,
    address: string,
    dob: string,
    locked: boolean,
    userType: string,
}
const users = ref<User[] | null>(null);

function formatDate(dateString) {
    const date = new Date(dateString);
    const day = date.getDate();
    const month = date.getMonth() + 1; // Tháng trong JavaScript bắt đầu từ 0, nên cần cộng thêm 1
    const year = date.getFullYear();
    const formattedDate = `${day}-${month}-${year}`;
    return formattedDate;
}

const apiUrl = 'http://localhost:8080';
onBeforeMount(async () => {
    try {
        const response = await axios.get(`${apiUrl}/users`);
        users.value = response.data;
        if (users.value) {
            users.value.forEach(async (user) => {
                user.dob = formatDate(user.dob);
            });
        }
        console.log(users.value)
    } catch (error) {
        console.error('Lỗi khi lấy thông tin người dùng:', error);
    }
});
</script>

<style scoped>
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
</style>