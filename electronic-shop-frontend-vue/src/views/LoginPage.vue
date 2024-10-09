<template>
  <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
  <div class="max-md:gap-3 max-md:flex-col min-h-screen h-screen flex">
    <!-- Thông báo lỗi -->
    <div v-if="isLoginFailed"
      class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-100 text-red-700 p-6 text-center text-lg z-50 rounded-md"
      role="alert">
      <span class="font-medium">Lỗi!</span> Đăng nhập không thành công. Vui lòng thử lại.
    </div>
    <div v-if="isWrongPass"
      class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-100 text-red-700 p-6 text-center text-lg z-50 rounded-md"
      role="alert">
      <span class="font-medium">Lỗi!</span> Các thông tin không trùng khớp. Vui lòng thử lại.
    </div>
    <div v-if="isloggedInOK"
      class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-green-100 text-green-700 p-6 text-center text-lg z-50 rounded-md"
      role="alert">
      <span class="font-medium">Đăng nhập thành công!</span>
    </div>
    <div v-if="islocked"
      class="fixed top-20 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-100 text-red-700 p-6 text-center text-lg z-50 rounded-md"
      role="alert">
      <span class="font-medium">Tài khoản của bạn đã bị khoá do vi phạm chính sách.</span>
    </div>
    <div class="max-md:h-[250px] lg:flex-auto bg-[#191a24] flex items-center px-10">
      <img class="w-full h-full object-cover opacity-[90%]" src="/src/assets/images/login-image.png" alt="" />
    </div>
    <div class="max-md:w-full w-[70%] flex justify-start justify-center">
      <div class="max-md:w-full w-[80%] flex flex-col items-center justify-center h-full px-10">
        <div class="w-full flex flex-col items-center justify-center">
          <p class="text-3xl font-bold">Đăng nhập</p>
          <p class="text-base font-medium mt-2">Đăng nhập vào tài khoản của bạn!</p>
        </div>
        <div class="w-full flex flex-col items-center justify-center mt-10">
          <div class="w-full">
            <AInput v-model="name" name="name" label="Tên đăng nhập"
              style-custom="border-[#AFA2C3] py-3 p-2 border-[1px] border-[#3E334E] cursor-text" is-required
              placeholder=" Nhập tên đăng nhập..." />
          </div>
          <div class="w-full mt-2">
            <AInput v-model="password" name="password" label="Mật khẩu"
              style-custom="border-[#AFA2C3] py-3 p-2 border-[1px] border-[#3E334E] cursor-text" is-required
              placeholder=" Nhập mật khẩu..." type="password" />
          </div>

          <!-- forgot -->
          <div class="w-full flex justify-end mt-3">
            <RouterLink to="#" class="text-[#3E334E] text-sm font-medium">Quên mật khẩu?
            </RouterLink>
          </div>
          <div class="w-full flex gap-3 mt-3">
            <button @click="onLogin" class="bg-[#3E334E] text-white flex-[1] w-full py-3 font-bold rounded-lg">
              Đăng nhập
            </button>
            <RouterLink to="/register"
              class="block text-center border-[1px] border-[#3E334E] text-[#3E334E] flex-[1] w-full font-bold py-3 rounded-lg">
              Đăng ký
            </RouterLink>
          </div>
          <div class="w-full flex  justify-center gap-3 mt-4">HOẶC </div>
          <div class="w-full flex gap-3 mt-4">
            <div class="flex justify-center w-full">
              <GoogleLogin :callback="loginGG" prompt auto-login />
            </div>
          </div>
          <div class="w-full flex gap-3 mt-3">
            <div class="flex justify-center w-full">
              <button
                class="social-button flex items-center bg-white border border-gray-300 rounded shadow-md max-w-xs px-6 py-2 text-sm font-medium text-gray-800 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500">
                <svg class="h-6 w-3 mr-2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                  viewBox="0 0 48 48" version="1.1">
                  <g id="Icons" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                    <g id="Color-" transform="translate(-200.000000, -160.000000)" fill="#4460A0">
                      <path
                        d="M225.638355,208 L202.649232,208 C201.185673,208 200,206.813592 200,205.350603 L200,162.649211 C200,161.18585 201.185859,160 202.649232,160 L245.350955,160 C246.813955,160 248,161.18585 248,162.649211 L248,205.350603 C248,206.813778 246.813769,208 245.350955,208 L233.119305,208 L233.119305,189.411755 L239.358521,189.411755 L240.292755,182.167586 L233.119305,182.167586 L233.119305,177.542641 C233.119305,175.445287 233.701712,174.01601 236.70929,174.01601 L240.545311,174.014333 L240.545311,167.535091 C239.881886,167.446808 237.604784,167.24957 234.955552,167.24957 C229.424834,167.24957 225.638355,170.625526 225.638355,176.825209 L225.638355,182.167586 L219.383122,182.167586 L219.383122,189.411755 L225.638355,189.411755 L225.638355,208 L225.638355,208 Z"
                        id="Facebook">

                      </path>
                    </g>
                  </g>
                </svg>
                <span>Đăng nhập với Facebook
                </span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
.social-button:hover {
  background-color: #edf2f7 !important;
}
</style>

<script setup lang="ts">
import { useForm } from 'vee-validate';
import * as yup from 'yup';
import { useRouter } from 'vue-router';
import axios from 'axios';
import AInput from '@/components/AInput.vue';
import { ref, inject } from 'vue';
import bcrypt from 'bcryptjs';
import useUserStore from '@/store/userStore.js';
import CartService from '@/services/cart.service';

const isLoginFailed = ref(false);
const isWrongPass = ref(false);
const isloggedInOK = ref(false);
const islocked = ref(false);
const router = useRouter();
const cartService: { cartService: CartService } = inject('cartService')!; const userStore = useUserStore();

const login = async (data) => {
  try {
    console.log('Login data:', {
      account: data.name,
      userId: data.id
    });
    // Sử dụng hashedPassword thay vì data.password khi gửi đi
    const response = await axios.post(`http://localhost:8080/customers/login`, {
      account: data.name,
    });
    // console.log(response.data.locked + "aaaa")

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
        if (result) {
          console.log('Mật khẩu khớp.');
          isloggedInOK.value = true;
          setTimeout(() => {
            isloggedInOK.value = false;
          }, 1500);

          // Lưu thông tin tài khoản vào localStorage
          cartService.customerId = response.data.id;
          console.log(cartService.customerId)
          localStorage.setItem('account', JSON.stringify(response.data));

          userStore.setUser(response.data);
          setTimeout(() => {
            router.push('/home');
          }, 1000);

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


interface UserData {
  name: string;
  picture: string;
  email: string;
}

const userData = ref<UserData | null>(null);


import { decodeCredential } from 'vue3-google-login'
const loginGG = async (response) => {
  const result = decodeCredential(response.credential);
  userData.value = result;
  console.log("Handle the userData", userData.value.name);
  try {
    const response = await axios.post(`http://localhost:8080/customers/loginGoogle`, {
      account: userData.value?.name,
      avatar: userData.value?.picture,
      email: userData.value?.email,
    });

    if (response.data.locked) {
      islocked.value = true;
      setTimeout(() => {
        islocked.value = false;
      }, 1500);
      return;
    }
    if (response.data) {
      isloggedInOK.value = true;
      setTimeout(() => {
        isloggedInOK.value = false;
      }, 1500);
      cartService.customerId = response.data.id;
      console.log(cartService.customerId)
      localStorage.setItem('account', JSON.stringify(response.data));

      userStore.setUser(response.data);
      setTimeout(() => {
        router.push('/home');
      }, 1000);
    } else {
      console.error('Không có dữ liệu trả về từ API.');
      console.error(response.status);

    }
  } catch (error) {
    console.error(error);
    isLoginFailed.value = true;
    setTimeout(() => {
      isLoginFailed.value = false;
    }, 5000);
  }
}

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
  handleSubmit(async (values) => {
    await login(values);
  })();
};
</script>@/store/store
