<template>
    <div class="max-md:gap-3 max-md:flex-col min-h-screen h-screen flex">
        <div v-if="islocked"
            class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-100 text-red-700 p-6 text-center text-lg z-50 rounded-md"
            role="alert">
            <span class="font-medium">Tài khoản của bạn đã bị khoá do vi phạm chính sách.</span>
        </div>
        <div v-if="isloggedInOK"
            class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-green-100 text-green-700 p-6 text-center text-lg z-50 rounded-md"
            role="alert">
            <span class="font-medium">Đăng nhập thành công!</span>
        </div>
        <div v-if="isloggedInFailed"
            class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-100 text-red-700 p-6 text-center text-lg z-50 rounded-md"
            role="alert">
            <span class="font-medium">Đăng nhập thất bại! Xem lại thông tin!!!</span>
        </div>

        <div class="max-md:h-[250px] lg:flex-auto bg-[#191a24] flex items-center px-8">
            <img class="w-full h-full object-cover opacity-[100%]" src="/src/assets/images/login-employee-image.jpg"
                alt="" />
        </div>
        <div class="max-md:w-full w-[47%] flex justify-start justify-center">
            <div class="max-md:w-full w-[80%] flex flex-col items-center justify-center h-full px-10">
                <div class="w-full flex flex-col items-center justify-center">
                    <p class="text-3xl font-bold">Đăng nhập cho Nhân Viên</p>
                    <p class="text-base font-medium mt-2">Đăng nhập vào tài khoản của bạn!</p>
                </div>
                <div class="w-full flex flex-col items-center justify-center mt-10">
                    <div class="w-full">
                        <AInput v-model="name" name="name" label="Tên đăng nhập"
                            style-custom="border-[#AFA2C3] py-3 p-2 border-[1px] border-[#3E334E] cursor-text"
                            is-required placeholder=" Tên đăng nhập..." />
                    </div>
                    <div class="w-full mt-3">
                        <AInput v-model="password" name="password" label="Mật khẩu"
                            style-custom="border-[#AFA2C3] py-3 p-2 border-[1px] border-[#3E334E] cursor-text"
                            is-required placeholder=" Nhập mật khẩu..." type="password" />
                    </div>
                    <div class="w-1/2 flex gap-3 mt-5">
                        <button class="bg-[#3E334E] text-white flex-[1] w-1/2 py-3 font-bold rounded-lg"
                            @click="onLogin">
                            <!-- <button class="bg-[#3E334E] text-white flex-[1] w-full py-3 font-bold rounded-lg" @click=""> -->
                            Đăng nhập
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { useForm } from 'vee-validate';
import * as yup from 'yup';
import { useRouter } from 'vue-router';
import axios from 'axios';
import AInput from '@/components/AInput.vue';
import { ref } from 'vue';
import bcrypt from 'bcryptjs';

const isLoginFailed = ref(false);
const isWrongPass = ref(false);
const router = useRouter();
const islocked = ref(false);
const isloggedInOK = ref(false);

const login = async (data) => {
    try {
        console.log('Login data:', {
            account: data.name,
        });
        // Sử dụng hashedPassword thay vì data.password khi gửi đi
        const response = await axios.post(`http://localhost:8080/users/loginEmployee`, {
            account: data.name,
        });
        // Kiểm tra xem API có trả về dữ liệu hay không
        if (response.data) {
            const hashedPasswordFromAPI = response.data.password;
            bcrypt.compare(data.password, hashedPasswordFromAPI, (err, result) => {
                if (response.data.locked) {
                    islocked.value = true;
                    setTimeout(() => {
                        islocked.value = false;
                    }, 1500);
                    return;
                } else if (err) {
                    console.error(err);
                    return;
                }

                console.log('Mật khẩu khớp.');
                isloggedInOK.value = true;
                setTimeout(() => {
                    isloggedInOK.value = false;
                }, 1000);
                if (result) {
                    if (response.data.userType == 'staff') {
                        // Lưu thông tin tài khoản vào localStorage
                        localStorage.setItem('accountStaff', JSON.stringify(response.data));
                        setTimeout(() => {
                            router.push('/staff')
                        }, 1000);
                    } else if (response.data.userType == 'manager') {
                        // Lưu thông tin tài khoản vào localStorage
                        localStorage.setItem('accountManager', JSON.stringify(response.data));
                        setTimeout(() => {
                            router.push('/manager')
                        }, 1000);
                    } else if (response.data.userType == 'senior_manager') {
                        // Lưu thông tin tài khoản vào localStorage
                        localStorage.setItem('accountSeniorManager', JSON.stringify(response.data));
                        setTimeout(() => {
                            router.push('/senior-manager')
                        }, 1000);
                    } else if (response.data.userType == 'admin') {
                        // Lưu thông tin tài khoản vào localStorage
                        localStorage.setItem('accountAdmin', JSON.stringify(response.data));
                        setTimeout(() => {
                            router.push('/admin')
                        }, 1000);
                    } else {
                        isLoginFailed.value = true;
                        setTimeout(() => {
                            isLoginFailed.value = false;
                        }, 5000);
                    }
                } else {
                    console.log('Mật khẩu không khớp.');
                    isWrongPass.value = true;
                    setTimeout(() => {
                        isWrongPass.value = false;
                    }, 5000);
                }
            });
        } else {
            console.error('Không có dữ liệu trả về từ API.');
        }
    } catch (error) {
        console.error(error);
        isLoginFailed.value = true; // Set the flag to true
        setTimeout(() => {
            isLoginFailed.value = false; // Clear the flag after 5 seconds
        }, 5000);
    }
};

// Validate password have min 8, have number vs uppercase
const { handleSubmit } = useForm({
    validationSchema: yup.object({
        name: yup.string().required("Tên đăng nhập là trường bắt buộc"),
        password: yup
            .string()
            .matches(/^(?=.*[A-Za-z])(?=.*\d).+$/, 'Mật khẩu phải chứa ít nhất 1 số và 1 chữ cái')
            .min(8, 'Mật khẩu ít nhất 8 ký tự')
            .max(20, 'Mật khẩu tối đa 20 ký tự')
            .required('Mật khẩu là trường bắt buộc'),
    }),
})

const onLogin = () => {
    console.log('diem1')
    handleSubmit(async (values) => {
        await login(values);
    })();
};
</script>