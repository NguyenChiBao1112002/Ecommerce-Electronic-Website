<script setup lang="ts"></script>

<template>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <div class="relative">
            <a class="link-banner wrap-flex-align flex-column" href="">
                <div class="fg-image fade-box">
                    <picture>
                        <source
                            data-srcset="//theme.hstatic.net/1000375035/1000728788/14/block_home_category3_large.jpg?v=72"
                            media="(max-width: 500px)">
                        <source
                            data-srcset="//theme.hstatic.net/1000375035/1000728788/14/block_home_category3_grande.jpg?v=72">
                        <img src="//theme.hstatic.net/1000375035/1000728788/14/block_home_category3.jpg?v=72"
                            class="lazyload" alt="ipad" loading="lazy">
                    </picture>
                </div>
                <figcaption class="caption_banners site-animation absolute bottom-0 left-0 bg-white bg-opacity-75 p-2">
                    <h2 class="text-xl font-semibold">IPAD</h2>
                    <p>MUA NGAY</p>
                </figcaption>
            </a>
        </div>
        <div class="relative">
            <a class="link-banner wrap-flex-align flex-column" href="">
                <div class="fg-image fade-box">
                    <picture>
                        <source
                            data-srcset="//theme.hstatic.net/1000375035/1000728788/14/block_home_category6_large.jpg?v=72"
                            media="(max-width: 500px)">
                        <source
                            data-srcset="//theme.hstatic.net/1000375035/1000728788/14/block_home_category6_grande.jpg?v=72">
                        <img src="//theme.hstatic.net/1000375035/1000728788/14/block_home_category6.jpg?v=72"
                            class="lazyload" alt="LOA" loading="lazy">
                    </picture>
                </div>
                <figcaption class="caption_banners site-animation absolute bottom-0 left-0 bg-white bg-opacity-75 p-2">
                    <h2 class="text-xl font-semibold">LOA BLUETOOTH</h2>
                    <p>MUA NGAY</p>
                </figcaption>
            </a>
        </div>
        <div class="relative">
            <a class="link-banner wrap-flex-align flex-column" href="">
                <div class="fg-image fade-box">
                    <picture>
                        <source
                            data-srcset="//theme.hstatic.net/1000375035/1000728788/14/block_home_category5_large.jpg?v=72"
                            media="(max-width: 500px)">
                        <source
                            data-srcset="//theme.hstatic.net/1000375035/1000728788/14/block_home_category5_grande.jpg?v=72">
                        <img src="//theme.hstatic.net/1000375035/1000728788/14/block_home_category5.jpg?v=72"
                            class="lazyload" alt="TIVI" loading="lazy">
                    </picture>
                </div>
                <figcaption class="caption_banners site-animation absolute bottom-0 left-0 bg-white bg-opacity-75 p-2">
                    <h2 class="text-xl font-semibold">TIVI</h2>
                    <p>MUA NGAY</p>
                </figcaption>
            </a>
        </div>
        <div class="relative">
            <a class="link-banner wrap-flex-align flex-column" href="">
                <div class="fg-image fade-box">
                    <picture>
                        <source
                            data-srcset="//theme.hstatic.net/1000375035/1000728788/14/block_home_category2_large.jpg?v=72"
                            media="(max-width: 500px)">
                        <source
                            data-srcset="//theme.hstatic.net/1000375035/1000728788/14/block_home_category2_grande.jpg?v=72">
                        <img src="//theme.hstatic.net/1000375035/1000728788/14/block_home_category2.jpg?v=72"
                            class="lazyload" alt="Macbook" loading="lazy">
                    </picture>
                </div>
                <figcaption class="caption_banners site-animation absolute bottom-0 left-0 bg-white bg-opacity-75 p-2">
                    <h2 class="text-xl font-semibold">Macbook</h2>
                    <p>MUA NGAY</p>
                </figcaption>
            </a>
        </div>
        <!-- Repeat similar structure for other items -->
    </div>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Prompt:wght@500&display=swap');

.category__wrapper:hover {
    filter: brightness(80%);
}

.category__image img {
    border-style: none;
    max-width: 100%;
    height: auto;
}
</style>