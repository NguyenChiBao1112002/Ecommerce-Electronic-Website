<script setup>
import { ref, reactive } from 'vue';
import { useProductStore } from '@/stores/productStore';

const productStore = useProductStore();

const typeList = reactive([
    {
        label: "Điện thoại",
        name: "PHONE",
        isActive: false
    },
    {
        label: "Laptop",
        name: "LAPTOP",
        isActive: false
    },
    {
        label: "Tablet",
        name: "TABLET",
        isActive: false
    },
    {
        label: "Đồng hồ thông minh",
        name: "SMARTWATCH",
        isActive: false
    },
    {
        label: "Khác",
        name: "ORTHER",
        isActive: false
    },
]);

const sizeList = reactive([
    {
        size: '128GB  ',
        isActive: false
    },
    {
        size: '256GB  ',
        isActive: false
    },
    {
        size: '512GB  ',
        isActive: false
    },
    {
        size: "1TB ",
        isActive: false
    },
]);

const colorList = ref([
    {
        color: 'Đen',
        hexCode: '#000',
        isActive: false
    },
    {
        color: 'Titan Đen',
        hexCode: '#4B4845',
        isActive: false
    },
    {
        color: 'Trắng',
        hexCode: '#f6f6f6',
        isActive: false
    },
    {
        color: 'Titan Trắng',
        hexCode: '#E2E4E1',
        isActive: false
    },
    {
        color: 'Bạc',
        hexCode: '#C0C0C0',
        isActive: false
    },
    {
        color: 'Hồng',
        hexCode: '#CC338B',
        isActive: false
    },
    {
        color: 'Xanh Dương',
        hexCode: '#4e74dc',
        isActive: false
    },
    {
        color: 'Xanh Lá',
        hexCode: ' #00FF00',
        isActive: false
    },
    {
        color: 'Xám',
        hexCode: '#939393',
        isActive: false
    },
]);

const materialList = reactive([
    {
        label: "APPLE",
        name: "APPLE",
        isActive: false
    },
    {
        label: "OPPO",
        name: "OPPO",
        isActive: false
    },
    {
        label: "XIAOMI",
        name: "XIAOMI",
        isActive: false
    },
    {
        label: "LENOVO",
        name: "LENOVO",
        isActive: false
    },
    {
        label: "HP",
        name: "HP",
        isActive: false
    },
    {
        label: "ACER",
        name: "ACER",
        isActive: false
    },
    {
        label: "SAMSUNG",
        name: "SAMSUNG",
        isActive: false
    },
    {
        label: "LG",
        name: "LG",
        isActive: false
    },
    {
        label: "ASUS",
        name: "ASUS",
        isActive: false
    },

]);

const filtersList = {
    types: ref([]),
    sizes: ref([]),
    colors: ref({}),
    materials: ref([]),
};

const removeAllTypesFilter = (filtersList) => {
    filtersList.forEach((filter) => {
        filter.isActive = false;
    });
    filtersList.length = 0;
}

const removeAllFilter = (filtersList) => {
    console.log(filtersList);
    Object.keys(filtersList).forEach(key => {
        if (!Array.isArray(filtersList[key].value)) {
            console.log('Ok');
            if (colorList.value.includes(filtersList[key].value)) {
                colorList.value.forEach((item) => {
                    if (item.color === filtersList[key].value.color) {
                        item.isActive = false;
                    }
                });
            }
            filtersList[key].value.isActive = false;
            filtersList[key].value = {};

        } else {
            filtersList[key].value.forEach((filter) => {
                filter.isActive = false;
            });
            filtersList[key].value.length = 0;
        }
    })
}

const handleFilterList = (category, filter) => {
    if (!Array.isArray(filtersList[category].value)) {
        filtersList[category].value = filter;
    } else {
        let index = filtersList[category].value.indexOf(filter);
        // console.log(filtersList[category].value.indexOf(filter));
        if (index > -1) {
            filtersList[category].value.splice(index, 1);
        } else {
            filtersList[category].value.push(filter);
            // console.log(filtersList[category].value);
        }
    }
    productStore.setFilterList(filtersList);
    // console.log(productStore);
}

const toggleActive = (index, list) => {
    const item = list[index];
    item.isActive = !item.isActive;
}

const toggleActiveRadio = (index, list) => {
    const item = list[index];
    list.forEach(item => {
        item.isActive = false;
    });
    item.isActive = true;
}

productStore.setFilterList(filtersList);
</script>

<template>
    <div class="collection-left-filter__desktop">
        <div class="collection-left-filter__wrapper">
            <div class="collection-left-filter__action">
                <div class="collection-left-filter__count-item">
                    {{ productStore.productCount }} kết quả
                </div>
                <div class="collection-left-filter__empty" style="">
                    <a @click.prevent="removeAllFilter(filtersList)" href="https://www.coolmate.me/collections?sort=new"
                        id="removeAllFilterSticky">
                        Xóa lọc
                    </a>
                </div>
            </div>
            <div class="collection-left-filter__select">
                <div class="collection-left-filter__item">
                    <h5 class="collection-left-filter__heading">
                        Danh mục
                    </h5>
                    <ul class="filter-select-material">
                        <li v-for="(item, index) in typeList" :key="index" class="filter-select-material__item"
                            :class="{ selected: item.isActive }" @click="toggleActive(index, typeList)">
                            <div class="filter-select-material__checkbox">
                                <input type="checkbox" value="false" @click="handleFilterList('types', item)">
                                <label>{{ item.label }}</label>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="collection-left-filter__item">
                    <h5 class="collection-left-filter__heading">
                        Kích cỡ
                    </h5>
                    <ul class="filter-select-size">
                        <li v-for="(item, index) in sizeList" :key="index" data-type="size"
                            class="filter-select-size__item" :class="{ selected: item.isActive }"
                            @click="toggleActive(index, sizeList); handleFilterList('sizes', item)">
                            <button class="filter-select-size__button">
                                <span class="filter-select-size__label">{{ item.size }}</span>
                            </button>
                        </li>
                    </ul>
                </div>
                <!-- <div class="collection-left-filter__item">
                    <h5 class="collection-left-filter__heading">
                        Màu sắc
                    </h5>
                    <ul class="filter-select-color">
                        <li v-for="(item, index) in colorList" :key="index" :class="{ selected: item.isActive }"
                            @click="toggleActiveRadio(index, colorList); handleFilterList('colors', item)"
                            class="filter-select-color__item">
                            <div class="filter-select-color__button" :style="{ backgroundColor: item.hexCode }"></div>
                            <label class="filter-select-color__label">
                                {{ item.color }}
                            </label>
                        </li>
                    </ul>
                </div> -->
                <div class="collection-left-filter__item">
                    <h5 class="collection-left-filter__heading">
                        Hãng sản xuất
                    </h5>
                    <ul class="filter-select-material">
                        <li v-for="(item, index) in materialList" :key="index" class="filter-select-material__item"
                            :class="{ selected: item.isActive }" @click="toggleActive(index, materialList)">
                            <div class="filter-select-material__checkbox">
                                <input type="checkbox" value="false" @click="handleFilterList('materials', item)">
                                <label>{{ item.name }}</label>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>


<style>
.collection-left-filter__desktop {
    padding-left: 64px;
    position: sticky;
    top: 20px;
    transition: all .3s;
    transform: translateY(0px);
}

.collection-left-filter__wrapper {
    overflow-y: scroll;
    max-height: calc(100vh - 150px);
    min-width: 273px;
    padding-right: 15px;
}

.collection-left-filter__wrapper::-webkit-scrollbar,
.collection-right-filter-cate__wrapper::-webkit-scrollbar {
    width: 4px;
    height: 3px;
    background-color: #f5f5f5;
}

.collection-left-filter__wrapper::-webkit-scrollbar-thumb,
.collection-right-filter-cate__wrapper::-webkit-scrollbar-thumb {
    background-color: #000;
    border: 2px solid #555;
    border-radius: 10px;
}

.collection-left-filter__wrapper::-webkit-scrollbar-track,
.collection-right-filter-cate__wrapper::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
    background-color: #f5f5f5;
    border-radius: 20px;
}

.collection-left-filter__action {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #aebbc1;
    padding: 0.5rem 0;
}

.collection-left-filter__count-item {
    font-weight: 600;
}

.collection-left-filter__empty {
    padding: 0.375rem 0.75rem;
    gap: 0.5rem;
    border-radius: 1.5rem;
    border: 1px solid #000;
    font-weight: 600;
}

.collection-left-filter__empty a {
    background-color: transparent;
    text-decoration: none;
    color: inherit;
    transition: all .2s;
}

.collection-left-filter__heading {
    opacity: .5;
    font-weight: 500;
    font-size: .875rem;
    margin: 0.75rem 0;
}

.collection-left-filter__item ul {
    margin: 1em 0;
}

.filter-select-material {
    padding-left: 0;
    transition: all .4s ease;
    overflow: hidden;
    list-style: none;
}

.filter-select-material__item {
    position: relative;
    margin-bottom: 6px;
    cursor: pointer;
}

.filter-select-material__checkbox {
    display: flex;
    align-items: center;
}

input {
    line-height: 1.15;
    appearance: none;
    box-shadow: none;
    border-radius: 0;
}

.filter-select-material__checkbox input:before {
    content: "";
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 20px;
    height: 20px;
    border: 2px solid #bebebe;
    color: #2b9dd6;
    border-radius: 0.2rem;
}

.filter-select-material__item.selected input:before {
    background: #2f5acf;
}

.filter-select-material__checkbox label {
    letter-spacing: 0;
    display: flex;
    align-items: center;
    vertical-align: middle;
    font-weight: 400;
    font-size: 14px;
    line-height: 24px;
    cursor: pointer;
    padding-left: 30px;
}

.filter-select-size {
    padding-left: 0;
    transition: all .4s ease;
    overflow: hidden;
    list-style: none;
    display: flex;
    flex-wrap: wrap;
}

.filter-select-size__item {
    position: relative;
    margin-top: 8px;
}

.filter-select-size__button {
    width: 66px;
    padding: 0.375rem 1.5rem;
    margin-right: 8px;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #bebebe;
    background: #fff;
    cursor: pointer;
    border-radius: 0.375rem;
    line-height: 1.15;
}

.filter-select-size__item.selected button {
    background: #2f5acf;
    /*  */
    /* color: #d3d61c; */
}

.filter-select-size__item.selected button span {
    color: #fff;
}

.filter-select-color {
    padding-left: 0;
    transition: all .4s ease;
    overflow: hidden;
    list-style: none;
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 6px;
}

.filter-select-color__item {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: relative;
    margin-bottom: 6px;
    cursor: pointer;
    white-space: nowrap;
}

.filter-select-color__button {
    position: relative;
    margin: 4px;
    width: 26px;
    height: 26px;
    border-radius: 50%;
    border: 1px solid #bebebe;
}

.filter-select-color__button:before {
    content: "";
    position: absolute;
    top: 50%;
    left: 50%;
    width: 32px;
    height: 32px;
    transform: translate(-50%, -50%);
    border: 2px solid transparent;
    border-radius: 50%;
}

.filter-select-color__item.selected .filter-select-color__button:before {
    border: 2px solid #2f5acf;
}

.filter-select-color__label {
    font-size: .75rem;
    opacity: .5;
}
</style>
