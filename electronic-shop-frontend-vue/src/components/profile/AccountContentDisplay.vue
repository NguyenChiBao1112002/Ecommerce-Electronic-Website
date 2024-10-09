<template>
    <div class="row mt-5">
        <div class="col-md-3"><AccountSidebar/></div>
        <div class="col-md-9"><router-view></router-view></div>
    </div>
</template>

<script setup lang="ts">
import AccountSidebar from '../profile/AccountSideBar.vue';
</script>