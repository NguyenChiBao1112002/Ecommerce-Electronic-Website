<script setup>
import { ref, computed, onBeforeMount, onMounted } from 'vue';
import Header from '@/components/common/Header.vue';
import Footer from '@/components/common/Footer.vue';
import ProductCard from '@/components/products/ProductCard.vue';
import ProductService from "@/services/product.service";
import { useProductStore } from '@/stores/productStore';
import { useRoute } from 'vue-router';

let count = 0;

const route = useRoute();

const searchQuery = computed(() => {
    return route.query.q || '';
});

const productStore = useProductStore()

const products = ref([]);

const productPerRow = 'col-2-4';

const firstSearch = ref(true);

const retrieveProducts = async () => {
    try {
        products.value = await ProductService.getAll();
    } catch (error) {
        console.log(error);
    }
};

const searchResultProducts = computed(() => {
    let regex = new RegExp('^.*' + searchQuery.value.toLowerCase().trim() + '.*$');
    let from = "àáãảạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệđùúủũụưừứửữựòóỏõọôồốổỗộơờớởỡợìíỉĩịäëïîöüûñçýỳỹỵỷ",
        to = "aaaaaaaaaaaaaaaaaeeeeeeeeeeeduuuuuuuuuuuoooooooooooooooooiiiiiaeiiouuncyyyyy";


    if (searchQuery.value !== '') {
        const result = products.value.filter((item) => {
            return regex.test(item.name.toLowerCase());
        });
        count++;
        if (count == 2) {
            firstSearch.value = false;
        }
        return result;
    }
});

const refreshList = () => {
    retrieveProducts();
};


onMounted(() => {
    refreshList();
})

</script>

<template>
    <Header />
    <main class="search-results">
        <div class="search-filter">
            <div class="search-results__container container--full">
                <div class="search-filter__wrapper">
                    <div class="search-filter__inner">
                        <h2 class="search-filter__heading">
                            Sản phẩm với từ khóa: "{{ searchQuery }}"
                        </h2>
                        <!-- <div class="filter-search">
                            <input type="text" name="search" value="" placeholder="Tìm kiếm sản phẩm..."
                                class="filter-search__control">
                        </div> -->
                    </div>
                    <!-- <div class="search-filter__selects">
                        <div class="filter-select">
                            <div class="filter-select__item">
                                <div class="custom-select">
                                    <select name="category" form="form-spotlight">
                                        <option value="">Danh mục</option>
                                        <option value="ao-tank-top">
                                            Áo Tank top
                                        </option>
                                        <option value="ao-thun-nam-gioi">
                                            Áo T-shirt
                                        </option>
                                        <option value="ao-polo-nam">
                                            Áo Polo
                                        </option>
                                        <option value="ao-so-mi-nam">
                                            Áo Sơ Mi
                                        </option>
                                        <option value="ao-the-thao-nam">
                                            Áo Thể Thao
                                        </option>
                                        <option value="ao-in-nam">
                                            Áo In Hình
                                        </option>
                                        <option value="ao-khoac">
                                            Áo khoác thể thao
                                        </option>
                                        <option value="mu-luoi-trai">
                                            Mũ (Nón)
                                        </option>
                                        <option value="tat-nam">
                                            Tất (Vớ)
                                        </option>
                                        <option value="quan-short-nam">
                                            Quần Shorts
                                        </option>
                                        <option value="quan-jeans-nam">
                                            Quần Jeans
                                        </option>
                                        <option value="quan-dai-nam">
                                            Quần Dài
                                        </option>
                                        <option value="quan-lot-nam">
                                            Quần Lót Nam
                                        </option>
                                    </select>
                                    <div class="select-selected">Danh mục</div>
                                    <div class="select-items select-hide">
                                        <div data-value="ao-tank-top"><span>
                                                Áo Tank top
                                            </span></div>
                                        <div data-value="ao-thun-nam-gioi"><span>
                                                Áo T-shirt
                                            </span></div>
                                        <div data-value="ao-polo-nam"><span>
                                                Áo Polo
                                            </span></div>
                                        <div data-value="ao-so-mi-nam"><span>
                                                Áo Sơ Mi
                                            </span></div>
                                        <div data-value="ao-the-thao-nam"><span>
                                                Áo Thể Thao
                                            </span></div>
                                        <div data-value="ao-in-nam"><span>
                                                Áo In Hình
                                            </span></div>
                                        <div data-value="ao-khoac"><span>
                                                Áo khoác thể thao
                                            </span></div>
                                        <div data-value="mu-luoi-trai"><span>
                                                Mũ (Nón)
                                            </span></div>
                                        <div data-value="tat-nam"><span>
                                                Tất (Vớ)
                                            </span></div>
                                        <div data-value="quan-short-nam"><span>
                                                Quần Shorts
                                            </span></div>
                                        <div data-value="quan-jeans-nam"><span>
                                                Quần Jeans
                                            </span></div>
                                        <div data-value="quan-dai-nam"><span>
                                                Quần Dài
                                            </span></div>
                                        <div data-value="quan-lot-nam"><span>
                                                Quần Lót Nam
                                            </span></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> -->
                </div>
            </div>
        </div>

        <section v-if="searchResultProducts.length > 0 || firstSearch" class="search-listings">
            <div class="search-results__container container--full">
                <h1 class="search-listings__heading">
                    Kết quả
                </h1>
                <div class="grid-view grid--five-columns">
                    <ProductCard v-for="product in searchResultProducts" :product="product" :gridCol="productPerRow"
                        class="grid__column" />
                </div>
            </div>
        </section>
        <div v-else
            style="display: flex; flex: 1 1 0%; justify-content: center; align-items: center; padding: 15px; text-align: center; margin-bottom: 30px">
            <div>
                <div>Không tìm thấy sản phẩm phù hợp theo yêu cầu của bạn!</div>
                <div>Vui lòng <b><u>
                            <RouterLink to="/">quay lại trang chủ</RouterLink>
                        </u></b> để tiếp tục mua sắm bạn nhé!
                </div>
            </div>
        </div>
    </main>
    <Footer />
</template>

<style>
.search-results {
    margin-top: 83px;
}

.search-filter {
    background-color: #fff;
    padding-top: 27px;
    padding-bottom: 27px;
    border-bottom: 1px solid #d9d9d9;
}

.container--full {
    max-width: 100%;
}

.search-results__container {
    max-width: 100%;
    padding-left: 16px;
    padding-right: 16px;
    max-width: 1920px;
    width: 100%;
    margin: 0 auto;
}

.search-filter__wrapper {
    display: flex;
    justify-content: flex-start;
}

.search-filter__inner {
    display: flex;
    align-items: center;
}

.search-filter__heading,
.search-listings__heading {
    font-weight: 600;
    font-size: 24px;
    line-height: 30px;
    margin-right: 15px;
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
    appearance: none;
    box-shadow: none;
}

.search-filter__selects {
    margin-left: 0 !important;
    margin-top: 0 !important;
}

.filter-select {
    display: flex;
    margin-left: -8px;
    margin-right: -8px;
}

.filter-select__item {
    padding: 0 8px;
}

.filter-select__item .custom-select {
    width: 150px;
    height: 40px;
    position: relative;
    box-sizing: border-box;
}

.custom-select select {
    display: none;
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

.select-selected.select-arrow-active {
    z-index: 4;
    background-color: #d9d9d9;
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

.select-hide {
    display: none;
}

.select-items div,
.select-items label {
    color: #000;
    padding: 8px 16px;
    cursor: pointer;
    position: relative;
}

.search-listings {
    padding-top: 25px;
}

.grid-view {
    display: flex;
    display: -webkit-flex;
    -moz-flex-direction: row;
    flex-direction: row;
    flex-wrap: wrap;
    margin-top: 16px;
    margin-left: -9px;
    margin-right: -9px;
    padding: 0;
    position: relative;
    float: none;
}

@media (min-width: 1440px) {
    .search-results__container {
        padding-left: 64px;
        padding-right: 64px;
    }
}
</style>