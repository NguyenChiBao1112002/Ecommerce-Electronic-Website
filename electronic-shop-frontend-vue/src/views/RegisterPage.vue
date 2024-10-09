<template>
    <div class="max-md:gap-3 max-md:flex-col min-h-screen h-screen flex">
        <!-- Thông báo lỗi -->
        <div v-if="isRegisterFailed"
            class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-100 text-red-700 p-6 text-center text-lg z-50 rounded-md"
            role="alert">
            <span class="font-medium">Lỗi!</span> Đăng ký không thành công. Vui lòng thử lại.
        </div>
        <div v-if="isRegisterOK"
            class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-green-100 text-green-700 p-6 text-center text-lg z-50 rounded-md"
            role="alert">
            <span class="font-medium">Đăng ký thành công!</span>
        </div>
        <div class="max-md:h-[250px] lg:flex-auto bg-[#191a24] flex items-center px-6">
            <img class="w-full h-full object-cover opacity-[80%]" src="/src/assets/images/register-image.png" alt="" />
        </div>
        <div class="max-md:w-full w-[60%] flex justify-start justify-center">
            <div class="max-md:w-full w-[80%] flex flex-col items-center justify-center h-full px-10">
                <div class="w-full flex flex-col items-center justify-center">
                    <p class="text-4xl font-bold">Đăng ký</p>
                    <p class="text-base font-medium mt-2">Hãy đăng ký và thoả thích mua sắm!</p>
                </div>
                <div class="w-full flex flex-col items-center justify-center mt-3">
                    <div class="w-full mt-3">
                        <AInput v-model="name" name="name" label="Tên đăng nhập"
                            style-custom="border-[#AFA2C3] py-3 p-2 border-[1px] border-[#3E334E] cursor-text"
                            is-required placeholder=" Nhập tên đăng nhập..." />
                    </div>
                    <div class="w-full mt-3">
                        <AInput v-model="password" name="password" label="Mật khẩu"
                            style-custom="border-[#AFA2C3] py-3 p-2 border-[1px] border-[#3E334E] cursor-text"
                            is-required placeholder=" Nhập mật khẩu..." type="password" />
                    </div>
                    <div class="w-full mt-3">
                        <AInput v-model="confirmPassword" name="confirmPassword" label="Xác nhận mật khẩu"
                            style-custom="border-[#AFA2C3] py-3 p-2 border-[1px] border-[#3E334E] cursor-text"
                            is-required placeholder=" Nhập lại mật khẩu xác nhận..." type="password" />
                    </div>
                    <div class="w-full flex gap-3 mt-5">
                        <button @click="onRegister"
                            class="bg-[#3E334E] text-white flex-[1] w-full py-3 font-bold rounded-lg">
                            Đăng ký
                        </button>
                        <RouterLink to="/login"
                            class="block text-center border-[1px] border-[#3E334E] text-[#3E334E] flex-[1] w-full font-bold py-3 rounded-lg">
                            Đăng nhập
                        </RouterLink>
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

const isRegisterFailed = ref(false);
const isRegisterOK = ref(false);
const router = useRouter();

const register = async (data) => {
    try {
        // Băm mật khẩu trước khi gửi đi
        const hashedPassword = await bcrypt.hash(data.password, 10);
        console.log('Registration data:', {
            account: data.name,
            password: hashedPassword,
        });
        // Sử dụng hashedPassword thay vì data.password khi gửi đi
        const response = await axios.post(`http://localhost:8080/customers/register`, {
            account: data.name,
            password: hashedPassword,
        });
        console.log(response.data);
        if (response.status === 201) {
            isRegisterOK.value = true;
            setTimeout(() => {
                isRegisterOK.value = false;
                router.push('/login');
            }, 1500);
        }
    } catch (error) {
        console.error(error);
        //toast.error('Register failed!');
        isRegisterFailed.value = true;
        setTimeout(() => {
            isRegisterFailed.value = false; // Clear the flag after 5 seconds
        }, 5000);
    }
};

const { handleSubmit } = useForm({
    validationSchema: yup.object({
        name: yup.string().required("Tên đăng nhập là trường bắt buộc"),
        password: yup
            .string()
            .matches(/^(?=.*[A-Za-z])(?=.*\d).+$/, 'Mật khẩu phải chứa ít nhất 1 số và 1 chữ cái')
            .min(8, 'Mật khẩu ít nhất 8 ký tự')
            .max(20, 'Mật khẩu tối đa 20 ký tự')
            .required('Mật khẩu là trường bắt buộc'),
        confirmPassword: yup
            .string()
            .required('Xác nhận mật khẩu là trường bắt buộc')
            .oneOf([yup.ref('password'), null], 'Mật khẩu không khớp'),
    }),
});

const onRegister = () => {
    handleSubmit(async (values) => {
        await register(values);
    })();
};
</script>
