<script setup>
import Header from '@/components/common/Header.vue'
import Footer from '@/components/common/Footer.vue'
</script>

<template>
    <Header />
    <main class="site-news">
        <section class="news-home-banner">
            <div class="news-home-banner__heading homepage">
                <h1>BT NEWS</h1>
            </div>
            <picture style="width: 100%;">
                <img src="https://media2.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2023/mceclip0_75.png"
                    alt="banner" style="width: 100%;">
            </picture>
        </section>
        <section class="news-search">
            <div class="news-search__container container--medium">
                <div class="grid-view">
                    <div class="grid--column one-whole flex justify--center">
                        <div class="filter-search mt--10">
                            <input type="text" name="keyword" placeholder="Tìm kiếm bài viết..." autocomplete="off" class="filter-search__control">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="news-menu">
            <div class="large--visible">
                <div class="news-menu__container container--medium"></div>
            </div>
        </section>
    </main>
    <Footer />
</template>

<style>
.one-whole {
    width: 100%;
}

.justify--center {
    justify-content: center;
}

.flex {
    display: flex;
}

.mt--10 {
    margin-top: 10px;
}

.site-news {
    margin-top: 83px;
}

.news-home-banner {
    position: relative;
}

.news-home-banner__heading {
    position: absolute;
    top: 0;
    left: 10%;
    width: 500px;
    padding: 0 10px;
    height: 100%;
    display: flex;
    flex-flow: column;
    justify-content: center;
}

.news-home-banner__heading.homepage {
    display: block;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 100%;
    height: unset;
    text-align: center;
}

.news-home-banner__heading h1 {
    font-size: 50px;
    font-weight: 700;
    color: #000;
    line-height: 1em;
    margin-top: 0;
    margin-bottom: 0.5rem;
}

.news-search {
    margin: 16px;
}

.news-search__container,
.news-menu__container {
    margin: 0 auto;
    width: 100%;
}

.container--medium {
    max-width: 1280px;
}

.grid-view {
    display: flex;
    display: -webkit-flex;
    flex-direction: row;
    flex-wrap: wrap;
    margin-left: -9px;
    margin-right: -9px;
    padding: 0;
    position: relative;
    float: none;
}

.filter-search {
    position: relative;
    margin-left: 15px;
    margin-right: 15px;
}

.filter-search__control {
    height: 40px;
    padding: 0 40px 0 15px;
    border: 1px solid #d9d9d9;
    border-radius: 16px;
    max-width: 700px;
    width: 50vw;
}

@media (min-width: 1440px) {
    .container--medium {
        padding-left: 0;
        padding-right: 0;
    }

    .large--visible {
        display: block!important;;
    }
}
</style>