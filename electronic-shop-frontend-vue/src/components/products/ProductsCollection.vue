<script setup>
import { ref, reactive, computed } from 'vue';
import { useProductStore } from '@/stores/productStore';
import ProductCard from './ProductCard.vue';
import ProductService from "@/services/product.service";

const productStore = useProductStore()

const products = ref([]);

const filteredProducts = computed(() => {
    let result;
    const isInitialized = Object.values(productStore.filterList).some(value => {
        if (Array.isArray(value)) {
            return value.length > 0;
        }
        if (typeof value === 'string') {
            return value.trim() !== '';
        } else if (typeof value === 'object' && value.constructor === Object) {
            console.log((Object.keys(value)).length);
            return (Object.keys(value)).length > 0;
        }

        return value !== null && value !== undefined;
    });

    if (!isInitialized) {
        result = products.value;
    } else {
        result = products.value.filter((product) => {
            // if (activeTypes.value.length > 0 && activeSizes.value.length === 0 && (Object.keys(activeColor.value).length === 0)) {
            //     console.log(1);
            //     console.log(product)

            //     return product.details.some(detail => activeTypes.value.includes(detail.product.type));
            // }
            if (activeTypes.value.length > 0 && activeSizes.value.length === 0 && activeMaterials.value.length === 0) {
                console.log(1);
                return product.details.some(detail => activeTypes.value.includes(detail.product.type));
            } else if (activeTypes.value.length > 0 && activeSizes.value.length > 0 && activeMaterials.value.length === 0) {
                console.log(2);
                return product.details.some(detail => activeTypes.value.includes(detail.product.type) && activeSizes.value.includes(detail.size));
            } else if (activeTypes.value.length === 0 && activeSizes.value.length > 0 && activeMaterials.value.length === 0) {
                console.log(4)
                console.log(product)
                return product.details.some(detail => activeSizes.value.includes(detail.size));
            } else if (activeTypes.value.length === 0 && activeSizes.value.length === 0 && activeMaterials.value.length > 0) {
                console.log(14)
                return product.details.some(detail => activeMaterials.value.includes(detail.product.material));
            } else if (activeTypes.value.length > 0 && activeSizes.value.length > 0 && activeMaterials.value.length > 0) {
                console.log(13)
                return product.details.some(detail => activeTypes.value.includes(detail.product.type) && activeSizes.value.includes(detail.size) && activeMaterials.value.includes(detail.product.material));
            } else if (activeTypes.value.length > 0 && activeSizes.value.length === 0 && activeMaterials.value.length > 0) {
                console.log(10)
                return product.details.some(detail => activeTypes.value.includes(detail.product.type) && activeMaterials.value.includes(detail.product.material));
            } else if (activeTypes.value.length === 0 && activeSizes.value.length > 0 && activeMaterials.value.length > 0) {
                console.log(10)
                return product.details.some(detail => activeSizes.value.includes(detail.size) && activeMaterials.value.includes(detail.product.material));
            }
            console.log(15)
            return product;
        })
    }
    return result;
});


const activeTypes = computed(() => {
    return productStore.filterList.types.map((type) => (type.name));
});

const activeSizes = computed(() => {
    return productStore.filterList.sizes.map((item) => { return (item.size).trim() });
});

const activeColor = computed(() => {
    return productStore.filterList.colors;
});

const activeMaterials = computed(() => {
    return productStore.filterList.materials.map((material) => (material.name));
});

const productPerRow = 'col-3';

const productSize = computed(() => {
    let size = filteredProducts.value.length;
    productStore.setProductCount(size);
    return size;
});

const retrieveProducts = async () => {
    try {
        products.value = await ProductService.getAll();
        filteredProducts.value = [1, 2, 3, 4];
    } catch (error) {
        console.log(error);
    }
};

// const retrieveFilteredProductsByTypes = async () => {
//     try {
//         filteredProducts.value = await ProductService.findProductsByTypes(["SHIRTS", "PANTS"]);
//     } catch (error) {
//         console.log(error);
//     }
// };

const removeAllFilter = (filtersList) => {
    Object.keys(filtersList).forEach(key => {
        if (!Array.isArray(filtersList[key])) {
            filtersList[key].isActive = false;
            filtersList[key] = {};
        } else {
            filtersList[key].forEach((filter) => {
                filter.isActive = false;
            });
            filtersList[key].length = 0;
        }
    })
}

const removeTypeFilter = (filter) => {
    filter.isActive = false;
    let index = productStore.filterList.types.indexOf(filter);
    if (index > -1) {
        productStore.filterList.types.splice(index, 1);
    }
}

const mapAllDetailsToProduct = () => {
    products.value.forEach((product) => {
        retrieveAllProductDetails(product.id);
    });
}

const retrieveAllProductDetails = async (productId) => {
    try {
        const productDetails = await ProductService.getAllDetails(productId);
        const product = products.value[productId - 1];
        const detailsList = { 'details': productDetails };
        Object.keys(detailsList || {})
        Object.assign(product, detailsList);

    } catch (error) {
        console.log(error);
    }
};

const refreshList = async () => {
    await retrieveProducts();
    mapAllDetailsToProduct();
    // retrieveFilteredProductsByTypes();
};

refreshList();
</script>

<template>
    <section>
        <div class="collection-grid__container">
            <div class="collection-filter-selected">
                <div class="collection-filter-selected__wrapper">
                    <h5 class="collection-filter-selected__count">{{ productSize }} kết quả</h5>
                    <div class="collection-filter-selected__box" v-if="productStore.filterList.types.length > 0">
                        <div v-for="(item, index) in productStore.filterList.types">
                            <button v-if="item.isActive == true" :key="index" class="collection-filter-selected__item">
                                {{ item.label }}
                                <span @click="removeTypeFilter(item)">x</span>
                            </button>
                        </div>

                        <a @click.prevent="removeAllFilter(productStore.filterList)" href=""
                            id="removeAllFilterSelected" style="color: rgb(47, 90, 207); margin-left: 12px;">
                            Xóa lọc
                        </a>
                    </div>
                </div>
                <div class="filter-sortby">
                    <h5 class="filter-sortby__heading">
                        PHÂN LOẠI
                    </h5>
                    <div class="filter-sortby__item">
                        <div class="custom-select">
                            <select name="sort">
                                <option value="">Sắp xếp</option>
                                <option value="new" selected="selected">Mới nhất</option>
                                <option value="bestseller">Bán chạy</option>
                                <option value="price-asc">Giá thấp đến cao</option>
                                <option value="price-desc">Giá cao đến thấp</option>
                                <option value="percent">% giảm giá nhiều</option>
                            </select>
                            <div class="select-selected">Mới nhất</div>
                            <div class="select-items select-hide" style="display: none;">
                                <div data-value="new"><span>Mới nhất</span></div>
                                <div data-value="bestseller"><span>Bán chạy</span></div>
                                <div data-value="price-asc"><span>Giá thấp đến cao</span></div>
                                <div data-value="price-desc"><span>Giá cao đến thấp</span></div>
                                <div data-value="percent"><span>% giảm giá nhiều</span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="collection-products">
                <div class="collection-products__wrapper">
                    <div class="collection-products__content">
                        <div class="collection-products__grid row">
                            <ProductCard v-for="product in filteredProducts" :product="product"
                                :gridCol="productPerRow" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<style>
.collection-grid__container {
    padding-left: 64px;
    padding-right: 64px;
    width: 100%;
    margin: 0 auto;
}

.collection-filter-selected {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #fff;
}

.collection-filter-selected__wrapper {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    max-width: unset;
}

.collection-filter-selected__count {
    margin-bottom: 0;
    margin-right: 10px;
    font-size: 13.5px;
    color: #231f20;
    font-weight: 400;
}

.collection-filter-selected__box {
    display: flex;
    align-items: center;
    max-width: 700px;
    flex-wrap: wrap;
}

.collection-filter-selected__item {
    display: flex;
    align-items: center;
    position: relative;
    border: 1px solid #bebebe;
    border-radius: 0.375rem;
    background: #fff;
    line-height: 22px;
    text-transform: capitalize;
    white-space: nowrap;
    opacity: .6;
    padding: 1px 6px;
    margin: 3px 5px;
    font-weight: 400;
}

.collection-filter-selected__item:first-child {
    margin-left: 0;
}

.collection-filter-selected__item span {
    font-size: .7rem;
    margin-left: 8px;
    cursor: pointer;
}

.filter-sortby {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.filter-sortby__heading {
    margin-right: 10px;
    margin-bottom: 0;
    font-size: .875rem;
    opacity: .5;
}

.filter-sortby__item {
    max-width: 235px;
}

.custom-select {
    height: 40px;
    position: relative;
    box-sizing: border-box;
}

.custom-select select {
    display: none;
}

.filter-sortby__item .custom-select .select-selected {
    height: 36px;
    width: 156px;
    line-height: 36px;
    border: none;
    background: #f1f1f1;
    border-radius: 1.8125rem;
}

.select-selected {
    position: relative;
    display: block;
    width: 100%;
    height: 40px;
    line-height: 40px;
    border: 1px solid #d9d9d9;
    color: #000;
    cursor: pointer;
    padding: 0 37px 0 17px;
    z-index: 2;
    border-radius: 16px;
    background-color: #fff;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
}

.select-selected:after {
    position: absolute;
    content: "";
    top: 14px;
    right: 10px;
    width: 0;
    height: 0;
    border: 6px solid transparent;
    background-image: url(https://www.coolmate.me/images/select.svg?f982d2d6ec9d2393538facf180ac5104);
    background-repeat: no-repeat;
    background-size: 10px;
    background-position: 50%;
    transition: all .3s;
}

.select-hide {
    display: none;
}

.select-items {
    position: absolute;
    background-color: #fff;
    border: 1px solid #d9d9d9;
    top: 100%;
    left: 0;
    right: 0;
    border-bottom-left-radius: 16px;
    border-bottom-right-radius: 16px;
    padding-top: 20px;
    margin-top: -20px;
    z-index: 1;
    display: flex;
    flex-direction: column;
}

.select-items div,
.select-items label {
    color: #000;
    padding: 8px 16px;
    cursor: pointer;
    position: relative;
}
</style>