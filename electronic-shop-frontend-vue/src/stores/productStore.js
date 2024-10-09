import { defineStore } from 'pinia';

export const useProductStore = defineStore('product', {
    state: () => ({
        allProducts: [],
        filterList: {},
        filteredType: null,
        activeIndex: -1,
        productCount: Number,
        isShowAddFormClick: false,
        isShowAddDetailFormClick: false,
        isShowUpdateFormClick: false,
        isShowUpdateDetailFormClick: false,
        isShowDetails: false,
    }),
    getters: {

    },
    actions: {
        setAllProduct(products) {
            this.allProducts = products;
        },
        setFilterList(filters) {
            this.filterList = filters;
        },
        setFilteredType(type) {
            this.filteredType = type;
        },
        clearFilteredType() {
            this.filteredType = null; // Clear the currentProduct data
        },
        setSearchText(text) {
            this.searchText = text;
        },
        setSearchResults(results) {
            this.searchResults = results;
        },
        setActiveIndex(index) {
            this.activeIndex = index;
        },
        setProductCount(number) {
            this.productCount = number;
        },
        setIsShowAddFormClick(isShowAddFormClick) {
            this.isShowAddFormClick = isShowAddFormClick;
        },
        setIsShowAddDetailFormClick(isShowAddDetailFormClick) {
            this.isShowAddDetailFormClick = isShowAddDetailFormClick;
        },
        setIsShowUpdateFormClick(isShowUpdateFormClick) {
            this.isShowUpdateFormClick = isShowUpdateFormClick;
        },
        setIsShowUpdateDetailFormClick(isShowUpdateDetailFormClick) {
            this.isShowUpdateDetailFormClick = isShowUpdateDetailFormClick;
        },
        setIsShowDetails(isShowDetails) {
            this.isShowDetails = isShowDetails;
        },
    }
})