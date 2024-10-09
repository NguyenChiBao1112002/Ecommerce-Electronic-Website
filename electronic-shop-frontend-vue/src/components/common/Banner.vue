<script setup>
const props = defineProps({
    banner: {
        type: Object
    }
});
</script>

<template>
    <section class="banner-block">
        <div class="banner-block__wrapper">
            <a href="#" class="d-block w-100">
                <img :src="banner.src" alt="" class="w-100">
            </a>
            <div class="banner-block__content w-full">
                <div class="banner-block__heading text-3xl">
                    {{ banner.text }}
                </div>
                <div class="banner-block__heading text-5xl font-bold mb-5">
                    {{ banner.content }}
                </div>
                <div class="banner-block__button">
                    <a href="" class="button button--black">KHÁM PHÁ NGAY</a>
                </div>
            </div>
        </div>

    </section>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Prompt:wght@500&display=swap');

.banner-block {
    margin: 40px 0;
}

.banner-block__wrapper {
    position: relative;
}

.banner-block__content {
    top: 0;
    /* max-width: 1000px; */
    position: absolute;
    left: 0;
    height: 100%;
    display: flex;
    flex-flow: column;
    justify-content: center;
    /* max-width: 1000px; */
    padding: 0 0 0 2rem;
}

.banner-block__content h2 {
    text-transform: uppercase;
    position: relative;
    font-family: 'Prompt', sans-serif;
    font-weight: 500;
    font-size: 80px;
}

.banner-block__content.black {
    color: #000;
}
</style>
