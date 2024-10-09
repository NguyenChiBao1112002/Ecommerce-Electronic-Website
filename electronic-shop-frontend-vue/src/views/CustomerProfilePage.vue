<template>
    <Header/>
    <div class="container" id="customer-profile">
        <AccountContentDisplay/>
    </div>
    <Footer/>
</template>

<script setup lang="ts">
import Header from '@/components/common/Header.vue';
import Footer from '@/components/common/Footer.vue';
import AccountContentDisplay from '@/components/profile/AccountContentDisplay.vue';
</script>

<style scoped>

#customer-profile {
    position: relative;
    justify-content: center;
    width: inherit;
}
</style>