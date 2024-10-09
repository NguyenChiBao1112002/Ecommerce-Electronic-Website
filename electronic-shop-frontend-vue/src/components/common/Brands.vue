<script setup lang="ts">
import { Carousel, Navigation, Slide } from 'vue3-carousel'

import 'vue3-carousel/dist/carousel.css'

const slides = [
    { src: 'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn/2024/03/banner/chuyentrang-samsung-390-210-390x210.png' },
    { src: 'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn/2024/01/banner/chuyentrang-appleDT-390x210.png' },
    { src: 'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn/2023/08/banner/chuyentrang-lenovo-390x210-1.png' },
    { src: 'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn/2023/08/banner/chuyentrang-HP-390x210.png' },
];

</script>

<template>
    <section class="brands section-container my-50">
        <div class="care-share__inner">
            <div class="my-2 font-sans text-3xl font-semibold">CHUYÊN TRANG THƯƠNG HIỆU</div>
            <Carousel :items-to-show="3" :wrap-around="true">
                <Slide v-for="slide in slides" :key="slide">
                    <img :src="slide.src" alt="">
                </Slide>
                <template #addons>
                    <Navigation />
                </template>
            </Carousel>
        </div>
    </section>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Prompt:wght@500&display=swap');

.care-share__image img {
    border-style: none;
    max-width: 100%;
    height: auto;
}

.care-share__inner {
    position: relative;
}

.care-share__content {
    top: -14%;
    max-width: 800px;
    position: absolute;
    left: 0;
    height: 100%;
    display: flex;
    flex-flow: column;
    justify-content: flex-end;
    max-width: 600px;
    padding: 0 0 0 2rem;
}
</style>
