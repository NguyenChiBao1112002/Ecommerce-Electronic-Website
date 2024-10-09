<template>
    <div v-if="isUpdatedOK"
        class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-green-200 text-green-700 p-6 text-center text-lg z-50 rounded-md mt-16"
        role="alert">
        <span class="font-medium">Cập nhật thành công!!!</span>
    </div>
    <div v-if="isUpdatedFailed"
        class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-200 text-red-700 p-6 text-center text-lg z-50 rounded-md mt-16"
        role="alert">
        <span class="font-medium">Cập nhật thất bại!!!</span>
    </div>
    <div class="account-content my-50">
        <div id="info-tab" class="account-info">
            <h2 class="account-page-title">
                Thông tin tài khoản
            </h2>
            <div>
                <div class="account-info-form">
                    <div class="account-info-field">
                        <div class="account-info-label">
                            Họ và tên
                        </div>
                        <div class="account-info-value">
                            {{ userInfo && userInfo.name ? userInfo.name : 'Chưa cập nhật!' }}
                        </div>
                    </div>
                    <div class="account-info-field">
                        <div class="account-info-label">
                            Email
                        </div>
                        <div class="account-info-value">
                            <span style="opacity: 0.6; font-size: 0.85em;">
                                <i>{{ userInfo && userInfo.email ? userInfo.email : 'Chưa cập nhật!' }}</i>
                            </span>
                        </div>
                    </div>
                    <div class="account-info-field">
                        <div class="account-info-label">
                            Số điện thoại
                        </div>
                        <div class="account-info-value">
                            <span style="opacity: 0.6; font-size: 0.85em;">
                                <i>{{ userInfo && userInfo.phone ? userInfo.phone : 'Chưa cập nhật!' }}</i>
                            </span>
                        </div>
                    </div>
                    <div class="account-info-field" style="position: relative;">
                        <div class="account-info-label">
                            Ngày sinh <i class="bday-note">(ngày/tháng/năm)</i>
                        </div>
                        <div class="account-info-value">
                            <span style="opacity: 0.6; font-size: 0.85em;">
                                <i>{{ userInfo && userInfo.dob ? formatDate(userInfo.dob) : 'Chưa cập nhật!' }}</i>
                            </span>
                        </div>
                    </div>
                    <div class="account-info-field">
                        <div class="account-info-label">
                            Địa chỉ
                        </div>
                        <div class="account-info-value">
                            <span style="opacity: 0.6; 
                            font-size: 0.85em;">
                                <i>{{ userInfo && userInfo.address ? userInfo.address : 'Chưa cập nhật!' }}</i>
                            </span>
                        </div>
                    </div>
                </div>
                <h3 class="account-page-title">
                    Thông tin đăng nhập
                </h3>
                <div class="account-info-field">
                    <div class="account-info-label">
                        Tên đăng nhập
                    </div>
                    <div class="account-info-value">
                        {{ userInfo && userInfo.account ? userInfo.account : 'Chưa cập nhật!' }}
                    </div>
                </div>
                <div class="account-info-field">
                    <div class="account-info-label">
                        Mật khẩu
                    </div>
                    <div class="account-info-value">
                        **********************
                    </div>
                </div>
                <div class="account-info-field">
                    <button @click="clickUpdate()" class="btn account-info-btn">
                        Cập nhật
                    </button>
                </div>

                <!-- Pop-up cập nhật thông tin -->
                <div v-if="showUpdateModal" class="fixed inset-0 flex items-center justify-center z-50">
                    <div v-if="isWrongForm"
                        class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-200 text-red-700 p-6 text-center text-lg z-50 rounded-md mt-16"
                        role="alert">
                        <span class="font-medium">Thông tin cập nhật không hợp lê! Nhập lại!</span>
                    </div>

                    <form class="max-w-3xl mt-5" @submit.prevent="submitUpdateInfo">
                        <div
                            class="bg-white dark:bg-gray-800 shadow-2xl rounded-lg overflow-hidden w-screen max-w-xl p-4">
                            <h2 class="text-xl text-gray-900 dark:text-gray-300 pb-2 font-bold">Thông tin tài khoản cá
                                nhân</h2>
                            <div class="flex flex-col gap-2 w-full border-gray-400">
                                <div>
                                    <label class="text-gray-600 dark:text-gray-400">Họ và tên
                                    </label>
                                    <input v-model="userInfo!.name" @input="validateName"
                                        class="w-full py-3 border border-slate-200 rounded-lg px-3 focus:outline-none focus:border-slate-500 hover:shadow dark:bg-gray-600 dark:text-gray-100"
                                        type="text">
                                    <span v-if="nameError" class="text-red-500">{{ nameError }}</span>
                                </div>
                                <div>
                                    <label class="text-gray-600 dark:text-gray-400">Email</label>
                                    <input v-model="userInfo!.email" @input="validateEmail"
                                        class="w-full py-3 border border-slate-200 rounded-lg px-3 focus:outline-none focus:border-slate-500 hover:shadow dark:bg-gray-600 dark:text-gray-100"
                                        type="email">
                                    <span v-if="emailError" class="text-red-500">{{ emailError }}</span>
                                </div>
                                <div>
                                    <label class="text-gray-600 dark:text-gray-400">Số điện thoại</label>
                                    <input v-model="userInfo!.phone" @input="validatePhone"
                                        class="w-full py-3 border border-slate-200 rounded-lg px-3 focus:outline-none focus:border-slate-500 hover:shadow dark:bg-gray-600 dark:text-gray-100"
                                        type="text">
                                    <span v-if="phoneError" class="text-red-500">{{ phoneError }}</span>
                                </div>
                                <div>
                                    <label class="text-gray-600 dark:text-gray-400">Ngày sinh</label>
                                    <input v-model="userInfo!.dob"
                                        class="w-full py-3 border border-slate-200 rounded-lg px-3 focus:outline-none focus:border-slate-500 hover:shadow dark:bg-gray-600 dark:text-gray-100"
                                        type="date">
                                </div>
                                <div>
                                    <label class="text-gray-600 dark:text-gray-400">Địa chỉ</label>
                                    <input v-model="userInfo!.address" @input="validateAddress"
                                        class="w-full py-3 border border-slate-200 rounded-lg px-3 focus:outline-none focus:border-slate-500 hover:shadow dark:bg-gray-600 dark:text-gray-100"
                                        type="text">
                                    <span v-if="addressError" class="text-red-500">{{ addressError }}</span>
                                </div>
                                <div class="flex justify-end">
                                    <button
                                        class="py-1.5 px-3 m-1 text-center bg-violet-700 border rounded-md text-white  hover:bg-violet-500 hover:text-gray-100 dark:text-gray-200 dark:bg-violet-700"
                                        type="submit">Lưu thay đổi</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import axios from 'axios';

const showUpdateModal = ref(false);
const isUpdatedOK = ref(false);
const isUpdatedFailed = ref(false);
const clickUpdate = () => {
    showUpdateModal.value = true;
}

const nameError = ref<string | null>(null);
const validateName = () => {
    // Kiểm tra nếu tên không được điền vào
    if (!userInfo.value || !userInfo.value.name.trim()) {
        nameError.value = 'Vui lòng nhập họ và tên';
        return false;
    } else {
        nameError.value = null;
        return true;
    }
};

const phoneError = ref<string | null>(null);
const validatePhone = () => {
    // Kiểm tra nếu số điện thoại không được điền vào hoặc không đúng định dạng
    if (!userInfo.value || !userInfo.value.phone.trim() || !/^\d{10}$/.test(userInfo.value.phone.trim())) {
        phoneError.value = 'Số điện thoại không hợp lệ';
        return false;
    } else {
        phoneError.value = null;
        return true;
    }
};

const emailError = ref<string | null>(null);

const validateEmail = () => {
    // Kiểm tra nếu email không được điền vào hoặc không đúng định dạng
    if (!userInfo.value || !userInfo.value.email.trim() || !/\S+@\S+\.\S+/.test(userInfo.value.email.trim())) {
        emailError.value = 'Email không hợp lệ';
        return false;
    } else {
        emailError.value = null;
        return true;
    }
};

const addressError = ref<string | null>(null);

const validateAddress = () => {
    // Kiểm tra nếu địa chỉ không được điền vào
    if (!userInfo.value || !userInfo.value.address.trim()) {
        addressError.value = 'Địa chỉ không được để trống';
        return false;
    } else {
        addressError.value = null;
        return true;
    }
};


const isWrongForm = ref<Boolean>(false);
const submitUpdateInfo = async () => {
    nameError.value = null;
    ;
    // Xóa thông báo lỗi trước khi kiểm tra lại
    phoneError.value = null;
    // Kiểm tra định dạng số điện thoại
    ;
    emailError.value = null;
    // Kiểm tra định dạng email
    ;
    addressError.value = null;
    // Kiểm tra định dạng địa chỉ
    ;
    if (validateName() && validatePhone() && validateEmail() && validateAddress()) {
        try {
            const response = await axios.put(`${baseUrl}/customers/${userInfo.value?.id}/updateInfo`, userInfo.value);
            if (response.status === 200) {
                isUpdatedOK.value = true;
                setTimeout(() => {
                    isUpdatedOK.value = false;
                }, 2000);
                showUpdateModal.value = false;
            } else {
                isUpdatedFailed.value = false;
            }
        } catch (error) {
            console.error(error);
        }
        isWrongForm.value = false;
    } else {
        isWrongForm.value = true;
        setTimeout(() => {
            isWrongForm.value = false;
        }, 2500);

    }

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
onMounted(() => {
    const storedAccount = localStorage.getItem('account');
    if (storedAccount) {
        accountInfo.value = JSON.parse(storedAccount);
        if (accountInfo.value) {
            fetchUserInfo(accountInfo.value.account);
        }
    }
});

const baseUrl = 'http://localhost:8080';
async function fetchUserInfo(username: string) {
    try {
        const response = await axios.get(`${baseUrl}/users/account/${username}`);
        userInfo.value = response.data;
    } catch (error) {
        console.error('Lỗi khi lấy thông tin người dùng:', error);
    }
}

const formatDate = (Dob: string) => {
    const parts = Dob.split('-');
    const reversedDob = `${parts[2]}/${parts[1]}/${parts[0]}`;
    const dateOfBirthToDisplay = reversedDob;
    return dateOfBirthToDisplay;
}



</script>

<style scoped>
.account-content {
    position: relative;
    display: flex;
    align-items: center;
    padding: 2rem 3rem;
    transition: all .2s;
    border-radius: 0.5rem;
    font-size: 1rem;
    box-sizing: border-box;
    background-color: white;
    width: 100%;
    box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
}

.account-page-title {
    margin-bottom: 25px;
    font-size: 2.5rem;
}

.account-info-field {
    display: flex;
    align-items: center;
    font-size: 18px;
    margin-bottom: 1.5rem;
}

.account-info-label {
    width: 300px;
    max-width: 50%;
    font-size: 18px;
    color: rgba(0, 0, 0, .5333333333);
}

.account-info-value {
    text-wrap: wrap;
}

.account-info-btn {
    height: 50px;
    border: 1px solid #000;
    background-color: #fff;
    border-radius: 100vmax;
    color: #000;
    text-transform: uppercase;
    font-weight: 700;
    padding: 0px 30px;
}

.account-info-btn:hover {
    background-color: #000;
    border: 1px solid #000;
    color: #fff;
    transition: 0.4s;
}

.bday-note {
    color: #999;
    font-size: 0.9rem;
}
</style>