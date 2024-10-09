<template>
    <div class="account-sidebar-items my-50">
        <div class="avatar">
            <AvatarFrame/>
        </div>
        <div v-for="(item, index) in sidebarItems" :key="index" class="account-sidebar-item" @click="toggleActive(index)"
            :class="{ active: item.isActive }">
            <span class="account-option">
                <img :src="item.imageSrc" alt="Thông tin tài khoản" style="margin-right: 8px;">
                <a href="" @click.prevent>{{ item.label }}</a>
            </span>
        </div>
    </div>
</template>
  
<script lang="ts">
import AvatarFrame from './account-content/AvatarFrame.vue';
export default {
    data() {
        return {
            sidebarItems: [
                { routeName: 'userInfo', label: 'Thông tin tài khoản', imageSrc: 'https://mcdn.coolmate.me/image/September2023/mceclip6_34.png', name: 'userInfo', isActive: false },
                { routeName: 'myOrders', label: 'Lịch sử đơn hàng', imageSrc: 'https://mcdn.coolmate.me/image/September2023/mceclip4_7.png', name: 'orderHistory', isActive: false },
                { routeName: 'myCoupons', label: 'Ví voucher', imageSrc: 'https://mcdn.coolmate.me/image/September2023/mceclip1_59.png', name: 'voucherWallet', isActive: false },
                { routeName: 'myAddresses', label: 'Sổ địa chỉ', imageSrc: 'https://mcdn.coolmate.me/image/September2023/mceclip2_76.png', name: 'addressBook', isActive: false },
                { routeName: 'myReviews', label: 'Đánh giá và phản hồi', imageSrc: 'https://mcdn.coolmate.me/image/September2023/mceclip3_71.png', name: 'reviewsFeedback', isActive: false },
            ],
        };
    },
    methods: {
        toggleActive(index: number) {
            const item = this.$data.sidebarItems[index];
            this.sidebarItems.forEach((sidebarItem) => {
                sidebarItem.isActive = false;
            });
            item.isActive = true;

            this.$router.push({ name: item.routeName });
        },
    },
    components: {
        AvatarFrame
    }
}
</script>

<style scoped>
.account-sidebar-items {
    max-width: 350px;
    position: relative;
    background-color: rgb(255, 255, 255);
    width: 100%;
    box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
    padding-bottom: 1.5rem;
    border-radius: 0.5rem;
}

.account-sidebar-item {
    position: relative;
    display: flex;
    align-items: center;
    height: 55px;
    padding: 0.75rem 3rem 0.75rem 0.75rem;
    transition: all .2s;
    font-size: 1rem;
    box-sizing: border-box;
    background-color: white;
    max-width: 100%;
    border-left: 5px solid white;
    a {
        text-decoration: none;
        font-weight: 600;
        color: black;
    }
}

.account-sidebar-item:hover {
    filter: invert(1);
}

.account-sidebar-item.active:hover {
    border-left: 5px solid white;
    filter: invert(1);
}

.active {
    border-left: 5px solid rgb(0, 0, 0);
    transition: 5ms;
}

.account-option {
    display: flex;
    vertical-align: baseline;
    padding-left: 10px;
    width: 100% !important;
    img {
        vertical-align: middle;
        width: 25px;
        margin-right: 3px;
    }
}

.avatar {
    display: flex;
    justify-content: center;
}
</style>
