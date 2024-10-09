<template>
    <section id="demo" class="carousel slide" data-bs-ride="carousel">
        <!-- The slideshow/carousel -->
        <div class="carousel-inner">
            <div class="carousel-item active mt-16">
                <img src="https://theme.hstatic.net/1000375035/1000728788/14/slideshow_1.jpg?v=72" alt=""
                    class="d-block">
            </div>
            <div class="carousel-item mt-16">
                <img src="https://theme.hstatic.net/1000375035/1000728788/14/slideshow_3.jpg?v=72" alt=""
                    class="d-block">
            </div>
            <div class="carousel-item mt-16">
                <img src="https://theme.hstatic.net/1000375035/1000728788/14/slideshow_2.jpg?v=72" alt=""
                    class="d-block">
            </div>
        </div>

        <!-- Left and right controls/icons -->
        <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </section>
</template>

<script setup>
import { onMounted } from 'vue';

onMounted(() => {
    setInterval(() => {
        const carousel = document.querySelector('.carousel');
        const nextButton = carousel.querySelector('.carousel-control-next');
        nextButton.click();
    }, 8000);
});
</script>

<style>
.carousel {
    margin-top: 82px;
}

.carousel-inner {
    height: 600px;
}

.carousel-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
