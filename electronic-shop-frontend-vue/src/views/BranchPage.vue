<script setup lang="ts">
import Header from '@/components/common/Header.vue';
import Footer from '@/components/common/Footer.vue';
import { ref, onMounted } from 'vue';
import axios from 'axios';

interface Store {
    name: string;
    address: string;
    phone: string;
    mapUrl: string;
}

const stores = ref<Store[]>([]);
const apiUrl = 'http://localhost:8080';  // URL của backend
const fetchStoreData = async () => {
    try {
        // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint to retrieve store data
        const response = await axios.get(`${apiUrl}/store`);
        stores.value = response.data;
        console.log(stores.value);
        console.log("hi");
    } catch (error) {
        console.error('Error fetching store data:', error);
    }
};

const clickMap = ref(false);
const showMap = (mapUrl) => {
    const mapIframe = `<iframe src="${mapUrl}" width="100%" height="100%" style="border:0;" allowfullscreen="true" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>`;
    clickMap.value = true;
    const mapContainer = document.querySelector('.map-for-branch');
    if (mapContainer) {
        mapContainer.innerHTML = mapIframe;
    }
}


onMounted(() => {
    fetchStoreData();
});
</script>

<template>
    <!-- <main> -->
    <Header />

    <div class="wrapper mx-2 my-2">
        <div class="title uppercase text-4xl font-sans font-bold pt-2">
            <h1>Tìm chi nhánh cửa hàng</h1>
        </div>
        <div class="mid-content">
            <div class="flex">
                <div class="branch w-2/5 border-1 mt-3">
                    <div class="store border-1 pb-3" v-for="(store, index) in stores" :key="index">
                        <h2 class="ml-1 p-1">{{ store.name }}</h2>
                        <p class="ml-1 p-1"><strong>Địa chỉ:</strong> {{ store.address }}</p>
                        <p class="ml-1 p-1"><strong>Số điện thoại:</strong> {{ store.phone }}</p>
                        <p class="ml-1 p-1"><strong>Số điện thoại:</strong> 028 7100 0415</p>
                        <p class="ml-1 p-1"><strong>Giờ mở cửa:</strong> 7:00 – 23:00 * 7 ngày/ tuần</p>
                        <button class="ml-1 p-2 bg-black text-white rounded" @click="showMap(store.mapUrl)">
                            TÌM KIẾM
                        </button>
                    </div>
                </div>
                <div class="map-for-branch w-3/5 mt-3 ml-1 flex items-center justify-center">
                    <!-- Nội dung cho cột 2 (60%) -->
                    <div v-if="!clickMap" class="text-center items-center text-3xl">
                        Hãy nhấn nút "Tìm kiếm" để hiển thị địa chỉ cửa hàng <br>trên GOOGLE
                        MAPS!
                    </div>
                    <iframe v-else id="" width="100" height="100" style="border:0;" allowfullscreen="true"
                        loading="lazy" referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>
            </div>
        </div>
    </div>

    <Footer />
    <!-- </main> -->
</template>

<style>
.title {
    margin-top: 90px;
}

.branch {
    @apply overflow-y-auto max-h-[590px];
    /* Set a maximum height to enable scrolling when content exceeds */
}
</style>
